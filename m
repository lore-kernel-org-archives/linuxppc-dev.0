Return-Path: <anton@samba.org>
Date: Wed, 31 Aug 2011 14:11:34 +1000
From: Anton Blanchard <anton@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 02/10] fadump: Reserve the memory for firmware
	assisted dump.
Message-ID: <20110831141134.590c4f4e@kryten>
In-Reply-To: <20110713180648.6210.39530.stgit@mars.in.ibm.com>
References: <20110713180252.6210.34810.stgit@mars.in.ibm.com>
	<20110713180648.6210.39530.stgit@mars.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Milton Miller <miltonm@bga.com>, Michael Ellerman <michael@ellerman.id.au>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Mahesh,

Just a few comments.

> +#define RMR_START	0x0
> +#define RMR_END		(0x1UL << 28)	/* 256 MB */

What if the RMO is bigger than 256MB? Should we be using ppc64_rma_size?

> +#ifdef DEBUG
> +#define PREFIX		"fadump: "
> +#define DBG(fmt...)	printk(KERN_ERR PREFIX fmt)
> +#else
> +#define DBG(fmt...)
> +#endif

We should use the standard debug macros (pr_debug etc).

> +/* Global variable to hold firmware assisted dump configuration info. */
> +static struct fw_dump fw_dump;

You can remove this comment, especially because the variable isn't global :)

> +	sections = of_get_flat_dt_prop(node, "ibm,configure-kernel-dump-sizes",
> +					NULL);
> +
> +	if (!sections)
> +		return 0;
> +
> +	for (i = 0; i < FW_DUMP_NUM_SECTIONS; i++) {
> +		switch (sections[i].dump_section) {
> +		case FADUMP_CPU_STATE_DATA:
> +			fw_dump.cpu_state_data_size =
> sections[i].section_size;
> +			break;
> +		case FADUMP_HPTE_REGION:
> +			fw_dump.hpte_region_size =
> sections[i].section_size;
> +			break;
> +		}
> +	}
> +	return 1;
> +}

This makes me a bit nervous. We should really get the size of the property
and use it to iterate through the array. I saw no requirement in the PAPR
that the array had to be 2 entries long.

> +static inline unsigned long calculate_reserve_size(void)
> +{
> +	unsigned long size;
> +
> +	/* divide by 20 to get 5% of value */
> +	size = memblock_end_of_DRAM();
> +	do_div(size, 20);
> +
> +	/* round it down in multiples of 256 */
> +	size = size & ~0x0FFFFFFFUL;
> +
> +	/* Truncate to memory_limit. We don't want to over reserve
> the memory.*/
> +	if (memory_limit && size > memory_limit)
> +		size = memory_limit;
> +
> +	return (size > RMR_END ? size : RMR_END);
> +}

5% is pretty aribitrary, that's 400GB on an 8TB box. Also our experience
with kdump is that 256MB is too small. Is there any reason to scale it
with memory size? Can we do what kdump does and set it to a single
value (eg 512MB)?

We could override the default with a boot option, which is similar to
how kdump specifies the region to reserve.

Anton
