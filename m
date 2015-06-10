Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DAF661A1903
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 17:33:07 +1000 (AEST)
In-Reply-To: <1433486126-23551-18-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel, v12,
 17/34] powerpc/spapr: vfio: Switch from iommu_table to new
 iommu_table_group
Message-Id: <20150610073307.948391402AE@ozlabs.org>
Date: Wed, 10 Jun 2015 17:33:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-05-06 at 06:35:09 UTC, Alexey Kardashevskiy wrote:
> So far one TCE table could only be used by one IOMMU group. However
> IODA2 hardware allows programming the same TCE table address to
> multiple PE allowing sharing tables.

...

> +	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
> +	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
> +		pnv_pci_link_table_and_group(phb->hose->node, 0,
> +				tbl, &phb->p5ioc2.table_group);

> +long pnv_pci_link_table_and_group(int node, int num,
> +		struct iommu_table *tbl,
> +		struct iommu_table_group *table_group)
> +{
> +	struct iommu_table_group_link *tgl = NULL;
> +
> +	BUG_ON(!tbl);
> +	BUG_ON(!table_group);
> +	BUG_ON(!table_group->group);
> +
> +	tgl = kzalloc_node(sizeof(struct iommu_table_group_link), GFP_KERNEL,
> +			node);
> +	if (!tgl)
> +		return -ENOMEM;
> +
> +	tgl->table_group = table_group;
> +	list_add_rcu(&tgl->next, &tbl->it_group_list);
> +
> +	table_group->tables[num] = tbl;
> +
> +	return 0;

I'm not a fan of the BUG_ONs here.

This routine is so important that you have to BUG_ON three times at the start,
yet you never check the return code if it fails? That doesn't make sense to me.

If anything this should be sufficient:

	if (WARN_ON(!tbl || !table_group))
		return -EINVAL;

cheers
