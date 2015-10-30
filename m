Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A13481A0CCF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2015 00:08:00 +1100 (AEDT)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 39865140B0F
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2015 00:07:59 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org,
 imunsie@au1.ibm.com, dja@axtens.net
Subject: Re: [PATCH] cxl: sparse: add __iomem annotations in vphb.c
Date: Fri, 30 Oct 2015 14:07:51 +0100
Message-ID: <6848216.pocJKKsE8F@wuerfel>
In-Reply-To: <1446002979-29728-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1446002979-29728-1-git-send-email-andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 28 October 2015 14:29:39 Andrew Donnellan wrote:
> --- a/drivers/misc/cxl/vphb.c
> +++ b/drivers/misc/cxl/vphb.c
> @@ -128,7 +128,7 @@ static int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
>                 return PCIBIOS_BAD_REGISTER_NUMBER;
>         addr = cxl_pcie_cfg_addr(phb, bus->number, devfn, offset);
>  
> -       *ioaddr = (void *)(addr & ~0x3ULL);
> +       *ioaddr = (void __iomem *)(addr & ~0x3ULL);
>         *shift = ((addr & 0x3) * 8);
>         switch (len) {
>         case 1:

It would be nice to change the return value of cxl_pcie_cfg_addr to
'void __iomem *' as well, and only do the cast (back and forth) inside 
the calculation, to make it clear that the input type is the same as the
output. Perhaps use a static inline function to wrap it.

> @@ -249,7 +249,7 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
>         /* Setup the PHB using arch provided callback */
>         phb->ops = &cxl_pcie_pci_ops;
>         phb->cfg_addr = afu->afu_desc_mmio + afu->crs_offset;
> -       phb->cfg_data = (void *)(u64)afu->crs_len;
> +       phb->cfg_data = (void __iomem *)afu->crs_len;
>         phb->private_data = afu;
>         phb->controller_ops = cxl_pci_controller_ops;


This needs a comment to explain why this is correct. I've tried to find it
out by reading the code and could not find any explanation. Also, you
need to cast to an intermediate (uintptr_t) type, as directly converting
a u64 to a pointer of any sort is nonportable, and it would be good to
at least allow compile-testing this code on other architectures.

I suspect that 'phb->cfg_data' is used in this driver in a way that is
incompatible with the other uses of the same variable. Maybe you can
replace it with something like

	union {
		void __iomem *cfg_data;
		u64 cxl_cfg_offset;
	};

to make it clear that in this driver it is used as an offset rather than
a pointer.

	Arnd
