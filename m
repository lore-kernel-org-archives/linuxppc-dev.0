Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 945DBDE2F0
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 08:53:28 +1100 (EST)
Date: Thu, 25 Jan 2007 13:52:09 -0800
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 5/16] Ops based MSI implementation
Message-ID: <20070125215209.GA3126@kroah.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083411.5D935DE2FD@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070125083411.5D935DE2FD@ozlabs.org>
Cc: Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2007 at 07:34:09PM +1100, Michael Ellerman wrote:
> --- /dev/null
> +++ msi/include/linux/msi-ops.h
> @@ -0,0 +1,168 @@
> +/*
> + * Copyright 2006-2007, Michael Ellerman, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.

Are you sure of the "any later version" part?

> + */
> +
> +#ifndef LINUX_MSI_OPS_H
> +#define LINUX_MSI_OPS_H
> +
> +#ifdef __KERNEL__
> +#ifndef __ASSEMBLY__

These two ifdefs aren't needed.

> +
> +#include <linux/pci.h>
> +#include <linux/msi.h>

Why not just put this structure in the msi.h file?

> +
> +/*
> + * MSI and MSI-X although different in some details, are also similar in
> + * many respects, and ultimately achieve the same end. Given that, this code
> + * tries as far as possible to implement both MSI and MSI-X with a minimum
> + * of code duplication. We will use "MSI" to refer to both MSI and MSI-X,
> + * except where it is important to differentiate between the two.
> + *
> + * Enabling MSI for a device can be broken down into:
> + *  1) Checking the device can support the type/number of MSIs requested.
> + *  2) Allocating irqs for the MSIs and setting up the irq_descs.
> + *  3) Writing the appropriate configuration to the device and enabling MSIs.
> + *
> + * To implement that we have the following callbacks:
> + *  1) check(pdev, num, msix_entries, type)
> + *  2) alloc(pdev, num, msix_entries, type)
> + *  3) enable(pdev, num, msix_entries, type)
> + *	a) setup_msi_msg(pdev, msix_entry, msi_msg, type)
> + *
> + * We give platforms full control over the enable step. However many
> + * platforms will simply want to program the device using standard PCI
> + * accessors. These platforms can use a generic enable callback and define
> + * a setup_msi_msg() callback which simply fills in the "magic" address and
> + * data values. Other platforms may leave setup_msi_msg() empty.
> + *
> + * Disabling MSI requires:
> + *  1) Disabling MSI on the device.
> + *  2) Freeing the irqs and any associated accounting information.
> + *
> + * Which maps directly to the two callbacks:
> + *  1) disable(pdev, num, msix_entries, type)
> + *  2) free(pdev, num, msix_entries, type)
> + */


Please use the proper kernel-doc format so the tools pick up this
documentation automatically.

> +#define msi_debug(fmt, args...)	\
> +	pr_debug("MSI:%s:%d: " fmt, __FUNCTION__, __LINE__, ## args)

Please use dev_dbg(), it makes it easier to track which device is being
referenced.

thanks,

greg k-h
