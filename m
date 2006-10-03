Return-Path: <moilanen@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D4E167C9A
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 07:55:01 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k93LswhO031030
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 17:54:58 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k93LswH6543012
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 15:54:58 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k93LswAU016107
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 15:54:58 -0600
Subject: Re: [RFC/PATCH 3/7] Powerpc MSI ops layer
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20060928215339.D911C67BFA@ozlabs.org>
References: <20060928215339.D911C67BFA@ozlabs.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 16:54:52 -0500
Message-Id: <1159912492.4997.257.camel@goblue>
Mime-Version: 1.0
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-09-29 at 07:53 +1000, Michael Ellerman wrote:
> Powerpc MSI ops layer.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> 
>  arch/powerpc/kernel/msi.c        |  347 +++++++++++++++++++++++++++++++++++++++
>  include/asm-powerpc/machdep.h    |    6 
>  include/asm-powerpc/msi.h        |  175 +++++++++++++++++++
>  include/asm-powerpc/pci-bridge.h |    4 
>  4 files changed, 532 insertions(+)
> 
> Index: to-merge/arch/powerpc/kernel/msi.c
> ===================================================================
> --- /dev/null
> +++ to-merge/arch/powerpc/kernel/msi.c
> @@ -0,0 +1,347 @@
> +/*
> + * Copyright 2006 (C), Michael Ellerman, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#undef DEBUG
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <asm/msi.h>
> +#include <asm/machdep.h>
> +
> +static struct ppc_msi_ops *get_msi_ops(struct pci_dev *pdev)
> +{
> +	if (ppc_md.get_msi_ops)
> +		return ppc_md.get_msi_ops(pdev);
> +	return NULL;
> +}
> +
> +/* Activated by pci=nomsi on the command line. */
> +static int no_msi;
> +
> +void pci_no_msi(void)
> +{
> +	no_msi = 1;
> +}
> +
> +
> +/* msi_info helpers */
> +
> +static struct pci_dn *get_pdn(struct pci_dev *pdev)
> +{
> +	struct device_node *dn;
> +	struct pci_dn *pdn;
> +
> +	dn = pci_device_to_OF_node(pdev);
> +	if (!dn) {
> +		pr_debug("get_pdn: no dn found for %s\n", pci_name(pdev));
> +		return NULL;
> +	}
> +
> +	pdn = PCI_DN(dn);
> +	if (!pdn) {
> +		pr_debug("get_pdn: no pci_dn found for %s\n", pci_name(pdev));
> +		return NULL;
> +	}
> +
> +	return pdn;
> +}
> +
> +static int alloc_msi_info(struct pci_dev *pdev, int num,
> +			struct msix_entry *entries, int type)
> +{
> +	struct msi_info *info;
> +	unsigned int entries_size;
> +	struct pci_dn *pdn;
> +
> +	entries_size = sizeof(struct msix_entry) * num;
> +
> +	info = kzalloc(sizeof(struct msi_info) + entries_size, GFP_KERNEL);

Shouldn't you do a second kzalloc for info->entries, and not just add on
the size to the end?

> +	if (!info) {
> +		pr_debug("alloc_msi_info: kzalloc failed for %s\n",
> +				pci_name(pdev));
> +		return -ENOMEM;
> +	}
> +
> +	info->type = type;
> +	info->num = num;
> +	memcpy(info->entries, entries, entries_size);
> +
> +	pdn = get_pdn(pdev);
> +	if (!pdn || pdn->msi_info)	/* don't leak info structs */
> +		BUG();
> +
> +	pdn->msi_info = info;
> +
> +	return 0;
> +}
> +
