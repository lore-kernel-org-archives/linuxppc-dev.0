Return-Path: <anton@samba.org>
Date: Sun, 9 Feb 2014 08:20:34 +1100
From: Anton Blanchard <anton@samba.org>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/powernv: Platform dump interface
Message-ID: <20140209082034.0329833d@kryten>
In-Reply-To: <20140116121411.624.55662.stgit@hegdevasant.in.ibm.com>
References: <20140116121411.624.55662.stgit@hegdevasant.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Vasant,

> +static void free_dump_sg_list(struct opal_sg_list *list)
> +{
> +	struct opal_sg_list *sg1;
> +	while (list) {
> +		sg1 = list->next;
> +		kfree(list);
> +		list = sg1;
> +	}
> +	list = NULL;
> +}
> +
> +/*
> + * Build dump buffer scatter gather list
> + */
> +static struct opal_sg_list *dump_data_to_sglist(void)
> +{
> +	struct opal_sg_list *sg1, *list = NULL;
> +	void *addr;
> +	int64_t size;
> +
> +	addr = dump_record.buffer;
> +	size = dump_record.size;
> +
> +	sg1 = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!sg1)
> +		goto nomem;
> +
> +	list = sg1;
> +	sg1->num_entries = 0;
> +	while (size > 0) {
> +		/* Translate virtual address to physical address */
> +		sg1->entry[sg1->num_entries].data =
> +			(void *)(vmalloc_to_pfn(addr) << PAGE_SHIFT);
> +
> +		if (size > PAGE_SIZE)
> +			sg1->entry[sg1->num_entries].length =
> PAGE_SIZE;
> +		else
> +			sg1->entry[sg1->num_entries].length = size;
> +
> +		sg1->num_entries++;
> +		if (sg1->num_entries >= SG_ENTRIES_PER_NODE) {
> +			sg1->next = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +			if (!sg1->next)
> +				goto nomem;
> +
> +			sg1 = sg1->next;
> +			sg1->num_entries = 0;
> +		}
> +		addr += PAGE_SIZE;
> +		size -= PAGE_SIZE;
> +	}
> +	return list;
> +
> +nomem:
> +	pr_err("%s : Failed to allocate memory\n", __func__);
> +	free_dump_sg_list(list);
> +	return NULL;
> +}
> +
> +/*
> + * Translate sg list address to absolute
> + */
> +static void sglist_to_phy_addr(struct opal_sg_list *list)
> +{
> +	struct opal_sg_list *sg, *next;
> +
> +	for (sg = list; sg; sg = next) {
> +		next = sg->next;
> +		/* Don't translate NULL pointer for last entry */
> +		if (sg->next)
> +			sg->next = (struct opal_sg_list
> *)__pa(sg->next);
> +		else
> +			sg->next = NULL;
> +
> +		/* Convert num_entries to length */
> +		sg->num_entries =
> +			sg->num_entries * sizeof(struct
> opal_sg_entry) + 16;
> +	}
> +}
> +
> +static void free_dump_data_buf(void)
> +{
> +	vfree(dump_record.buffer);
> +	dump_record.size = 0;
> +}

This looks identical to the code in opal-flash.c. Considering how
complicated it is, can we put it somewhere common?

Anton
