Return-Path: <sfr@canb.auug.org.au>
Received: from calzone.tip.net.au (calzone.tip.net.au
 [IPv6:2402:b800:7003:1::15])
 by ozlabs.org (Postfix) with ESMTP id 80D441007DA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 11:55:34 +1100 (EST)
Date: Fri, 25 Nov 2011 11:54:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH-RFC 02/10] lib: add GENERIC_PCI_IOMAP
Message-Id: <20111125115455.9d5e18da6e683586d84ed9c8@canb.auug.org.au>
In-Reply-To: <b5a1327dd8bb38f87cba7ae10b308ec3b63de66a.1322163031.git.mst@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
 <b5a1327dd8bb38f87cba7ae10b308ec3b63de66a.1322163031.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__25_Nov_2011_11_54_55_+1100_Ear09Vzvz+xx6qEm"
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org,
 linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, linux@openrisc.net,
 Jesse Barnes <jbarnes@virtuousgeek.org>, Chen Liqin <liqin.chen@sunplusct.com>,
 Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>,
 Jonas Bonn <jonas@southpole.se>, Jesper Nilsson <jesper.nilsson@axis.com>,
 Russell King <linux@arm.linux.org.uk>, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Arend van Spriel <arend@broadcom.com>, Matt Turner <mattst88@gmail.com>,
 linux-arch@vger.kernel.org, Lasse Collin <lasse.collin@tukaani.org>,
 Arnd Bergmann <arnd@arndb.de>, Lucas De Marchi <lucas.demarchi@profusion.mobi>,
 microblaze-uclinux@itee.uq.edu.au, Michal Simek <monstr@monstr.eu>,
 Rob Herring <rob.herring@calxeda.com>, Mikael Starvik <starvik@axis.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Franky Lin <frankyl@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Michael Ellerman <michael@ellerman.id.au>, Paul Bolle <pebolle@tiscali.nl>,
 Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
 linux-parisc@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Richard Kuo <rkuo@codeaurora.org>, Kyle McMartin <kyle@mcmartin.ca>,
 Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, Fabio Baltieri <fabio.baltieri@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__25_Nov_2011_11_54_55_+1100_Ear09Vzvz+xx6qEm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Thu, 24 Nov 2011 22:17:02 +0200 "Michael S. Tsirkin" <mst@redhat.com> wr=
ote:
>
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 9120887..c8a67345 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -19,6 +19,8 @@
>  #include <asm-generic/iomap.h>
>  #endif
> =20
> +#include <asm-generic/pci_iomap.h>
> +
>  #ifndef mmiowb
>  #define mmiowb() do {} while (0)
>  #endif
> @@ -283,9 +285,6 @@ static inline void writesb(const void __iomem *addr, =
const void *buf, int len)
>  #define __io_virt(x) ((void __force *) (x))
> =20
>  #ifndef CONFIG_GENERIC_IOMAP
> -/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
> -struct pci_dev;
> -extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned lo=
ng max);
>  static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
>  {
>  }

Just wondering why you move pci_iomap but not pic_iounmap.  And also if
pci_iounmap is meant to stay here, then the "struct pci_dev" should
probably stay as well.

> diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
> index 98dcd76..fdcddcb 100644
> --- a/include/asm-generic/iomap.h
> +++ b/include/asm-generic/iomap.h
> @@ -69,16 +69,13 @@ extern void ioport_unmap(void __iomem *);
>  #ifdef CONFIG_PCI
>  /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
>  struct pci_dev;
> -extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned lo=
ng max);
>  extern void pci_iounmap(struct pci_dev *dev, void __iomem *);

Ditto with pci_iounmap.  Also the comment above really belongs with pci_iom=
ap.

> diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_io=
map.h
> new file mode 100644
> index 0000000..e08b3bd
> --- /dev/null
> +++ b/include/asm-generic/pci_iomap.h
> @@ -0,0 +1,26 @@
> +/* Generic I/O port emulation, based on MN10300 code
> + *
> + * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public Licence
> + * as published by the Free Software Foundation; either version
> + * 2 of the Licence, or (at your option) any later version.
> + */
> +#ifndef __ASM_GENERIC_PCI_IOMAP_H
> +#define __ASM_GENERIC_PCI_IOMAP_H
> +
> +#ifdef CONFIG_PCI
> +/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
> +struct pci_dev;

You could move this struct declaration above the ifdef and remove the
duplicate below.

> +extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned lo=
ng max);
> +#else
> +struct pci_dev;
> +static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsi=
gned long max)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +#endif /* __ASM_GENERIC_IO_H */
> diff --git a/lib/iomap.c b/lib/iomap.c
> index 5dbcb4b..ada922a 100644
> --- a/lib/iomap.c
> +++ b/lib/iomap.c
> @@ -242,45 +242,11 @@ EXPORT_SYMBOL(ioport_unmap);
>  #endif /* CONFIG_HAS_IOPORT */
> =20
>  #ifdef CONFIG_PCI
> -/**
> - * pci_iomap - create a virtual mapping cookie for a PCI BAR
> - * @dev: PCI device that owns the BAR
> - * @bar: BAR number
> - * @maxlen: length of the memory to map
> - *
> - * Using this function you will get a __iomem address to your device BAR.
> - * You can access it using ioread*() and iowrite*(). These functions hide
> - * the details if this is a MMIO or PIO address space and will just do w=
hat
> - * you expect from them in the correct way.
> - *
> - * @maxlen specifies the maximum length to map. If you want to get acces=
s to
> - * the complete BAR without checking for its length first, pass %0 here.
> - * */
> -void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxl=
en)
> -{
> -	resource_size_t start =3D pci_resource_start(dev, bar);
> -	resource_size_t len =3D pci_resource_len(dev, bar);
> -	unsigned long flags =3D pci_resource_flags(dev, bar);
> -
> -	if (!len || !start)
> -		return NULL;
> -	if (maxlen && len > maxlen)
> -		len =3D maxlen;
> -	if (flags & IORESOURCE_IO)
> -		return ioport_map(start, len);
> -	if (flags & IORESOURCE_MEM) {
> -		if (flags & IORESOURCE_CACHEABLE)
> -			return ioremap(start, len);
> -		return ioremap_nocache(start, len);
> -	}
> -	/* What? */
> -	return NULL;
> -}
> -
> +/* Hide the details if this is a MMIO or PIO address space and just do w=
hat
> + * you expect in the correct way. */
>  void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
>  {
>  	IO_COND(addr, /* nothing */, iounmap(addr));
>  }
> -EXPORT_SYMBOL(pci_iomap);
>  EXPORT_SYMBOL(pci_iounmap);

Ditto with pci_iounmap

> diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> new file mode 100644
> index 0000000..40b26cb
> --- /dev/null
> +++ b/lib/pci_iomap.c
> @@ -0,0 +1,48 @@
> +/*
> + * Implement the default iomap interfaces
> + *
> + * (C) Copyright 2004 Linus Torvalds
> + */
> +#include <linux/pci.h>
> +#include <linux/io.h>
> +
> +#include <linux/module.h>

If this is relative to (at least) v3.2-rc1, then you should use export.h
instead of module.h

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__25_Nov_2011_11_54_55_+1100_Ear09Vzvz+xx6qEm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOzudfAAoJEECxmPOUX5FE1/UP/0l4JcZxOiuNYsRtnb07C7hk
Ue3iusoFy8ai5W839MsxANElduJ7bF/IEHXmpFbpTovxkxiHivHJ1JFxs7lyAeWL
U7clx8Es4oRnSiWr6EbHSUXroLNw1zdHusF/XuM+xQvMXwZfUduE8KE866+XSV0h
1kBawlJm/+4xUY/jpPdxKy4Ci4lCJ7oniqE22hWq4AGHMneU7/WbSBRL3r3oQcBp
2f6IHg0BWjVUavic5bBD9EFDFLxnGZpZZhBh0ndbhqAmchrKAHeKqaLNp/uaYjtt
5YZifhE6xLLZfoHYbZgcbT0ogWPKwKJsg433k3MdlTbpfMzeLXk4R3MbPo1ZsnR4
Kx6lo+jTIMbugmWrU9z/BgA2NCLemrC/GKplPhhh+/G0jFfxfkYURO6PGP/hHkIx
OksYjLKTf3PGs2hAn4Oyw2DsX1qHecCH2Ge7mTWf4q8ysb5reYZuwRhs6ykh4wEZ
NMQonnmZ/OXuzXeRz5I+SwD4zn/k7zBz45y8zE6kKFee9JtentG/CA2YWPoj2fnw
iDxc2gImfyd6r00YkldbmNMFeTsF0Ou2CaV+oNd2/ocDvnIhbz64mWWNPKQnoKEv
wpja4BYLqwHXcv2yDQtlWsXIFeCtpEHHHd8Wi/OBLqZ8+TcTpB3eLHEtW5wWwihC
Hhqalk75Y0o2tyHL4X1M
=dkd1
-----END PGP SIGNATURE-----

--Signature=_Fri__25_Nov_2011_11_54_55_+1100_Ear09Vzvz+xx6qEm--
