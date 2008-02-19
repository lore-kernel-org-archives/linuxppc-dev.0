Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D2B7DDE48
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 17:34:34 +1100 (EST)
Subject: Re: [patch 4/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <20080219044307.878416912@ldl.fc.hp.com>
References: <20080219043952.845136014@ldl.fc.hp.com>
	<20080219044307.878416912@ldl.fc.hp.com>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 17:33:50 +1100
Message-Id: <1203402830.6740.98.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> Index: work6/drivers/pci/Makefile
> ===================================================================
> --- work6.orig/drivers/pci/Makefile	2008-02-18 21:16:36.000000000 -0700
> +++ work6/drivers/pci/Makefile	2008-02-18 21:16:38.000000000 -0700
> @@ -2,7 +2,7 @@
>  # Makefile for the PCI bus specific drivers.
>  #
>  
> -obj-y		+= access.o bus.o probe.o remove.o pci.o quirks.o \
> +obj-y		+= access.o bios.o bus.o probe.o remove.o pci.o quirks.o \
>  			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o
>  obj-$(CONFIG_PROC_FS) += proc.o
>  
> Index: work6/drivers/pci/bios.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ work6/drivers/pci/bios.c	2008-02-18 21:16:38.000000000 -070
                        ^^^^^^

Yuck :-)

Please, don't call this bios ... whatever is in this file really has
nothing to do with a "BIOS" in any shape or form :-) I know we used to
call those things pcibios_* but that's really historical...

If you want to make clear it's for "utilities" that can be overriden
by the arch, maybe call it utils.c, or just stick the function in
pci.c, or setup-res.c

Ben.
