Return-Path: <moilanen@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D4AF267C64
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 07:53:40 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k93LrZiP029656
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 17:53:35 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k93LrZIB528176
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 15:53:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k93LrYZX019111
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 15:53:35 -0600
Subject: Re: [RFC/PATCH 6/7] RTAS MSI implementation
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20060928215346.CE92067C6D@ozlabs.org>
References: <20060928215346.CE92067C6D@ozlabs.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 16:53:28 -0500
Message-Id: <1159912408.4997.255.camel@goblue>
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
> Powerpc MSI support via RTAS. Based on Jake's code.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> 
>  arch/powerpc/kernel/Makefile   |    1 
>  arch/powerpc/kernel/msi-rtas.c |  246 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 247 insertions(+)
> 
> Index: to-merge/arch/powerpc/kernel/Makefile
> ===================================================================
> --- to-merge.orig/arch/powerpc/kernel/Makefile
> +++ to-merge/arch/powerpc/kernel/Makefile
> @@ -69,6 +69,7 @@ pci32-$(CONFIG_PPC32)		:= pci_32.o
>  obj-$(CONFIG_PCI)		+= $(pci64-y) $(pci32-y)
>  
>  msiobj-y			:= msi.o
> +msiobj-$(CONFIG_PPC_PSERIES)	+= msi-rtas.o
>  obj-$(CONFIG_PCI_MSI)		+= $(msiobj-y)
>  
>  kexec-$(CONFIG_PPC64)		:= machine_kexec_64.o
> Index: to-merge/arch/powerpc/kernel/msi-rtas.c
> ===================================================================
> --- /dev/null
> +++ to-merge/arch/powerpc/kernel/msi-rtas.c
> @@ -0,0 +1,246 @@
> +/*
> + * Copyright (C) 2006 Jake Moilanen <moilanen@austin.ibm.com>, IBM Corp.
> + * Copyright (C) 2006 Michael Ellerman, IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2 of the
> + * License.
> + *
> + */
> +
> +#define DEBUG 1
> +
> +#include <linux/irq.h>
> +#include <asm/msi.h>
> +#include <asm/rtas.h>
> +#include <asm/hw_irq.h>
> +#include <asm/ppc-pci.h>
> +
> +static int query_token, change_token;
> +
> +#define RTAS_QUERY_MSI_FN	0
> +#define RTAS_CHANGE_MSI_FN	1
> +#define RTAS_RESET_MSI_FN	2
> +
> +
> +/* RTAS Helpers */
> +
> +static int rtas_change_msi(struct pci_dn *pdn, u32 function, u32 num_irqs)
> +{
> +	u32 addr, seq_num, rtas_ret[2];
> +	unsigned long buid;
> +	int rc;
> +
> +	addr = rtas_config_addr(pdn->busno, pdn->devfn, 0);
> +	buid = pdn->phb->buid;
> +
> +	seq_num = 1;
> +	do {
> +		rc = rtas_call(change_token, 6, 3, rtas_ret, addr,
> +				BUID_HI(buid), BUID_LO(buid),
> +				function, num_irqs, seq_num);

This call is still currently broken in firmware.  Hopefully we'll have a
resolution soon.

> +
> +		seq_num = rtas_ret[1];
> +	} while (rtas_busy_delay(rc));
> +
> +	if (rc) {
> +		printk(KERN_WARNING "Error[%d]: getting the number of"
> +			" MSI interrupts for %s\n", rc, pci_name(pdn->pcidev));
> +		return rc;
> +	}
> +
> +	return rtas_ret[0];
> +}
> +
> +static int rtas_query_irq_number(struct pci_dn *pdn, int offset)
> +{
> +	u32 addr, rtas_ret[2];
> +	unsigned long buid;
> +	int rc;
> +
> +	addr = rtas_config_addr(pdn->busno, pdn->devfn, 0);
> +	buid = pdn->phb->buid;
> +
> +	do {
> +		rc = rtas_call(query_token, 4, 3, rtas_ret, addr,
> +			       BUID_HI(buid), BUID_LO(buid), offset);
> +	} while (rtas_busy_delay(rc));
> +
> +	if (rc) {
> +		printk(KERN_WARNING "Error[%d]: Querying irq source number "
> +				"for %s\n", rc, pci_name(pdn->pcidev));
> +		return rc;
> +	}
> +
> +	return rtas_ret[0];
> +}
> +
> +/*
> + * The spec gives firmware the option to enable either MSI or MSI-X,
> + * this doesn't wash with the Linux API. For the time beinging, we
> + * kludge around that by checking ourselves the right type is enabled.
> + */
> +static int check_msi_type(struct pci_dev *pdev, int type)
> +{
> +	int pos, msi_enabled, msix_enabled;
> +	u16 reg;
> +
> +	pos = pci_find_capability(pdev, PCI_CAP_ID_MSI);
> +	if (!pos)
> +		return -1;
> +
> +	pci_read_config_word(pdev, pos + PCI_MSI_FLAGS, &reg);
> +
> +	msi_enabled = msix_enabled = 0;
> +
> +	if (reg & PCI_MSI_FLAGS_ENABLE)
> +		msi_enabled = 1;
> +

This is not being set correctly by firmware either. I have them looking
into the problem.

> +	if (reg & PCI_MSIX_FLAGS_ENABLE)
> +		msix_enabled = 1;
> +
> +	if (type == PCI_CAP_ID_MSI && (msix_enabled || !msi_enabled)) {
> +		pr_debug("check_msi_type: Expected MSI but got %s.\n",
> +			msix_enabled ? "MSI-X" : "none");
> +		return -1;
> +	}
> +
> +	if (type == PCI_CAP_ID_MSIX && (msi_enabled || !msix_enabled)) {
> +		pr_debug("check_msi_type: Expected MSI-X but got %s.\n",
> +			msi_enabled ? "MSI" : "none");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void msi_rtas_free(struct pci_dev *pdev, int num,
> +			struct msix_entry *entries, int type)
> +{
> +	struct device_node *dn;
> +	struct pci_dn *pdn;
> +	int i;
> +
> +	dn = pci_device_to_OF_node(pdev);
> +	if (!dn) {
> +		pr_debug("msi_rtas_free: No OF device node for %s\n",
> +				pci_name(pdev));
> +		return;
> +	}
> +
> +	pdn = PCI_DN(dn);
> +	if (!pdn) {
> +		pr_debug("msi_rtas_free: No PCI DN for %s\n",
> +				pci_name(pdev));
> +		return;
> +	}
> +
> +	for (i = 0; i < num; i++) {
> +		irq_dispose_mapping(entries[i].vector);
> +	}
> +
> +	/* XXX can we do anything sane if this fails? */
> +	rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 0);
> +}
> +
> +static int msi_rtas_check(struct pci_dev *pdev, int num,
> +			struct msix_entry *entries, int type)
> +{
> +	struct device_node *dn;
> +	int i;
> +
> +	dn = pci_device_to_OF_node(pdev);
> +
> +	if (!of_find_property(dn, "ibm,req#msi", NULL)) {
> +		pr_debug("msi_rtas_check: No ibm,req#msi for %s\n",
> +				pci_name(pdev));
> +		return -1;
> +	}
> +
> +	/*
> +	 * Firmware gives us no control over which entries are allocated
> +	 * for MSI-X, it seems to assume we want 0 - n. For now just insist
> +	 * that the entries array entry members are 0 - n.
> +	 */
> +	for (i = 0; i < num; i++) {
> +		if (entries[i].entry != i) {
> +			pr_debug("msi_rtas_check: entries[i].entry != i\n");
> +			return -1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int msi_rtas_alloc(struct pci_dev *pdev, int num,
> +			struct msix_entry *entries, int type)
> +{
> +	struct pci_dn *pdn;
> +	int hwirq, virq, i;
> +
> +	pdn = PCI_DN(pci_device_to_OF_node(pdev));
> +
> +	/*
> +	 * In the case of an error it's not clear whether the device is left
> +	 * with MSI enabled or not, I think we should explicitly disable.
> +	 */
> +	if (rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, num) != num)
> +		goto out_free;
> +
> +	if (check_msi_type(pdev, type))
> +		goto out_free;
> +
> +	for (i = 0; i < num; i++) {
> +		hwirq = rtas_query_irq_number(pdn, i);
> +		if (hwirq < 0)
> +			goto out_free;
> +
> +		virq = irq_create_mapping(NULL, hwirq);
> +
> +		if (virq == NO_IRQ) {
> +			pr_debug("msi_rtas_alloc: Failed mapping hwirq %d\n",
> +				hwirq);
> +			goto out_free;
> +		}
> +
> +		entries[i].vector = virq;
> +	}
> +
> +	return 0;
> +
> + out_free:
> +	msi_rtas_free(pdev, num, entries, type);

Shouldn't this be:

	msi_rtas_free(pdev, i,.......

Otherwise you'll try freeing unallocated entries.


> +	return -1;
> +}
> +
> +static struct ppc_msi_ops rtas_msi_ops = {
> +	.check = msi_rtas_check,
> +	.alloc = msi_rtas_alloc,
> +	.free  = msi_rtas_free
> +};
> +
> +static struct ppc_msi_ops *rtas_get_msi_ops(struct pci_dev *pdev)
> +{
> +	return &rtas_msi_ops;
> +}
> +
> +static int msi_rtas_init(void)
> +{
> +	query_token  = rtas_token("ibm,query-interrupt-source-number");
> +	change_token = rtas_token("ibm,change-msi");
> +
> +	if ((query_token == RTAS_UNKNOWN_SERVICE) ||
> +			(change_token == RTAS_UNKNOWN_SERVICE)) {
> +		pr_debug("rtas_msi_init: Couldn't find RTAS tokens, no "
> +				"MSI support available.\n");
> +		return 0;
> +	}
> +
> +	pr_debug("rtas_msi_init: Registering RTAS MSI ops.\n");
> +
> +	ppc_md.get_msi_ops = rtas_get_msi_ops;
> +
> +	return 0;
> +}
> +__initcall(msi_rtas_init);
