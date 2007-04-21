Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 735BFDDEBD
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Apr 2007 09:15:48 +1000 (EST)
In-Reply-To: <20070419073553.5F2ABDDE3C@ozlabs.org>
References: <20070419073553.5F2ABDDE3C@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5978bcffcf3b9348ebd4349ba8c2730a@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/7] Powerpc MSI infrastructure
Date: Sat, 21 Apr 2007 18:15:25 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Apr 19, 2007, Michael Ellerman wrote:
> This patch provides the architecture specific hooks to support MSI on
> powerpc. We implement the newly added arch_setup_msi_irqs() and
> arch_teardown_msi_irqs(), and then delegate to ppc_md routines.
>

> Index: msi-new/arch/powerpc/kernel/msi.c
> ===================================================================
> --- /dev/null
> +++ msi-new/arch/powerpc/kernel/msi.c
> @@ -0,0 +1,38 @@
> +/*
> + * Copyright 2006-2007, Michael Ellerman, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/msi.h>
> +
> +#include <asm/machdep.h>
> +
> +int arch_msi_check_device(struct pci_dev* dev, int nvec, int type)
> +{
> +	if (ppc_md.msi_check_device) {
> +		pr_debug("msi: Using platform check routine.\n");
> +		return ppc_md.msi_check_device(dev, nvec, type);
> +	}
> +
> +	if (!ppc_md.setup_msi_irqs || !ppc_md.teardown_msi_irqs) {
> +		pr_debug("msi: Platform doesn't provide MSI callbacks.\n");
> +		return -ENOSYS;
> +	}

Should we not do this check first?  Or do you expect some platform
to fill out these hooks in the check call above?  Othewise we will
branch to function pointer NULL.

> +
> +        return 0;
> +}
> +
> +int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +{
> +	return ppc_md.setup_msi_irqs(dev, nvec, type);
> +}
> +
> +void arch_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	return ppc_md.teardown_msi_irqs(dev);
> +}


> Index: msi-new/arch/powerpc/kernel/Makefile
> ===================================================================
> --- msi-new.orig/arch/powerpc/kernel/Makefile
> +++ msi-new/arch/powerpc/kernel/Makefile

> +obj-$(CONFIG_PCI_MSI)		+= msi.o


Do we really need a new file for these simple hooks?  It doesn't look
like anthing else is going to be added to it either.   I'd prefer to
just do an ifdef in pci.c.   Hmmm, we don't seem to have that, but
these are soo small I'd include machdep.h and put them inline in
asm-powerpc/pci.h.

milton
