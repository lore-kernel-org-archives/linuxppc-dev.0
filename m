Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id E921867BBB
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 08:59:06 +1000 (EST)
Date: Wed, 7 Jun 2006 17:58:43 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH 3/3] RTAS MSI
Message-ID: <20060607225843.GW8934@localdomain>
References: <20060607160212.1203d9ea.moilanen@austin.ibm.com>
	<20060607162540.f53bc270.moilanen@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060607162540.f53bc270.moilanen@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jake, some comments below:

Jake Moilanen wrote:
> Index: 2.6/drivers/pci/msi-rtas.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ 2.6/drivers/pci/msi-rtas.c	2006-06-07 15:59:59.000000000 -0500
> @@ -0,0 +1,162 @@
> +/*
> + * Jake Moilanen <moilanen@austin.ibm.com>
> + * Copyright (C) 2006 IBM
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2 of the
> + * License.
> + *
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <asm/rtas.h>
> +#include <asm/hw_irq.h>
> +
> +int rtas_enable_msi(struct pci_dev* pdev)
> +{
> +	static int seq_num = 1;
> +	int i;
> +	int rc;
> +	int query_token = rtas_token("ibm,query-interrupt-source-number");
> +	int devfn;
> +	int busno;
> +	u32 *reg;
> +	int reglen;
> +	int ret[3];
> +	int dummy;
> +	unsigned int virq;
> +	unsigned int addr;
> +	unsigned long buid = -1;
> +	unsigned long wait_time;
> +	struct device_node * dn;
> +
> +	BUG_ON(!pdev);
> +
> +	dn = pci_device_to_OF_node(pdev);
> +
> +	if (!of_find_property(dn, "ibm,req#msi", &dummy))
> +		return -ENOENT;
> +
> +	reg = (u32 *) get_property(dn, "reg", &reglen);
> +	if (reg == NULL || reglen < 20)
> +		return -ENXIO;
> +
> +	devfn = (reg[0] >> 8) & 0xff;
> +	busno = (reg[0] >> 16) & 0xff;
> +
> +	buid = get_phb_buid(dn->parent);
> +	addr = (busno << 16) | (devfn << 8);
> +
> +	while (1) {
> +		rc = rtas_call(rtas_token("ibm,change-msi"), 6, 3, ret, addr,
> +			       buid >> 32, buid & 0xffffffff,
> +			       0, 0, seq_num);
> +
> +		if (!rc)
> +			break;
> +		else if (rc == RTAS_BUSY)
> +			udelay(1);
> +		else if (rtas_is_extended_busy(rc)) {
> +			wait_time = rtas_extended_busy_delay_time(rc);
> +			udelay(wait_time * 1000);
> +		} else {
> +			printk(KERN_WARNING "error[%d]: getting the number of "
> +			       "MSI interrupts for %s\n", rc, dn->name);
> +			return -EIO;
> +		}
> +
> +		seq_num = ret[1];
> +	}

Please see John Rose's patch from a few days ago for handling RTAS
delays with msleep instead of udelay.  As written, this loop could tie
up the cpu for an arbitrary amount of time, and it is this kind of
situation John's patch is intended to address.


> +
> +	/* Return if there's no MSI interrupts */
> +	if (!ret[0])
> +		return -ENOENT;
> +
> +	dn->n_intrs = ret[0];
> +
> +	dn->intrs = kmalloc(dn->n_intrs * sizeof(*(dn->intrs)), GFP_KERNEL);
> +	if (!dn->intrs) {
> +		printk(KERN_WARNING "rtas_enable_msi: can't allocate space\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < dn->n_intrs; i++) {
> +		rc = rtas_call(query_token, 4, 3, ret, addr,
> +			       buid >> 32, buid & 0xffffffff, i);
> +
> +		if (!rc) {
> +			virq = virt_irq_create_mapping(ret[0]);
> +
> +			dn->intrs[i].line = irq_offset_up(virq);
> +			dn->intrs[i].sense = ret[1];
> +		} else {
> +			printk(KERN_WARNING "error[%d]: query-interrupt-source-number for %s\n",
> +			       rc, dn->name);
> +		}
> +	}
> +
> +	/* Just give the first vector out for now */
> +	pdev->irq = dn->intrs[0].line;
> +
> +	return 0;
> +}
> +
> +void rtas_disable_msi(struct pci_dev* pdev)
> +{
> +	static int seq_num = 1;
> +	struct device_node * dn;
> +	int rc;
> +	int devfn;
> +	int busno;
> +	u32 *reg;
> +	int reglen;
> +	int ret[3];
> +	int dummy;
> +	unsigned int addr;
> +	unsigned long buid = -1;
> +	unsigned long wait_time;
> +
> +	BUG_ON(!pdev);
> +
> +	dn = pci_device_to_OF_node(pdev);
> +
> +	if (!of_find_property(dn, "ibm,req#msi", &dummy))
> +		return;
> +
> +	reg = (u32 *) get_property(dn, "reg", &reglen);
> +	if (reg == NULL || reglen < 20)
> +		return;
> +
> +	devfn = (reg[0] >> 8) & 0xff;
> +	busno = (reg[0] >> 16) & 0xff;
> +
> +	buid = get_phb_buid(dn->parent);
> +	addr = (busno << 16) | (devfn << 8);
> +
> +	while (1) {
> +		rc = rtas_call(rtas_token("ibm,change-msi"), 6, 3, ret, addr,
> +			       buid >> 32, buid & 0xffffffff,
> +			       2, 0, seq_num);
> +
> +		if (!rc)
> +			break;
> +		else if (rc == RTAS_BUSY)
> +			udelay(1);
> +		else if (rtas_is_extended_busy(rc)) {
> +			wait_time = rtas_extended_busy_delay_time(rc);
> +			udelay(wait_time * 1000);
> +		} else {
> +			printk(KERN_WARNING "error[%d]: setting the number of "
> +			       "MSI interrupts for %s\n", rc, dn->name);
> +			return;
> +		}
> +
> +		seq_num = ret[1];
> +	}


Same as above applies here.

> +
> +	dn->n_intrs = 0;
> +
> +	kfree(dn->intrs);
> +}
> Index: 2.6/drivers/pci/Kconfig
> ===================================================================
> --- 2.6.orig/drivers/pci/Kconfig	2006-06-07 15:29:55.000000000 -0500
> +++ 2.6/drivers/pci/Kconfig	2006-06-07 15:59:28.000000000 -0500
> @@ -4,7 +4,7 @@
>  config PCI_MSI
>  	bool "Message Signaled Interrupts (MSI and MSI-X)"
>  	depends on PCI
> -	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64
> +	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64 || PPC_PSERIES
>  	help
>  	   This allows device drivers to enable MSI (Message Signaled
>  	   Interrupts).  Message Signaled Interrupts enable a device to
> Index: 2.6/arch/powerpc/platforms/pseries/setup.c
> ===================================================================
> --- 2.6.orig/arch/powerpc/platforms/pseries/setup.c	2006-06-07 15:29:55.000000000 -0500
> +++ 2.6/arch/powerpc/platforms/pseries/setup.c	2006-06-07 15:59:28.000000000 -0500
> @@ -78,6 +78,8 @@
>  #endif
>  
>  extern void find_udbg_vterm(void);
> +extern int rtas_enable_msi(struct pci_dev* pdev);
> +extern void rtas_disable_msi(struct pci_dev * pdev);

These belong in a header.
