Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id C27C5DDEC6
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 08:18:49 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: make ioport_map() handle already mapped ranges
Date: Sun, 13 May 2007 00:18:42 +0200
References: <20070512143221.GB12890@lixom.net>
In-Reply-To: <20070512143221.GB12890@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705130018.42612.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 12 May 2007, Olof Johansson wrote:
> Make ioport_map() handle already mapped port range without trying
> to add _IO_BASE to them.
>=20
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>
>=20
> Index: 2.6.21/arch/powerpc/kernel/iomap.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- 2.6.21.orig/arch/powerpc/kernel/iomap.c
> +++ 2.6.21/arch/powerpc/kernel/iomap.c
> @@ -106,7 +106,13 @@ EXPORT_SYMBOL(iowrite32_rep);
> =A0
> =A0void __iomem *ioport_map(unsigned long port, unsigned int len)
> =A0{
> -=A0=A0=A0=A0=A0=A0=A0return (void __iomem *) (port + _IO_BASE);
> +=A0=A0=A0=A0=A0=A0=A0/* Do nothing if we're being asked to map an already
> +=A0=A0=A0=A0=A0=A0=A0 * ioremapped() address
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0if (port >=3D IMALLOC_BASE && (port+len) < IMALLOC_=
END)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return (void __iomem *) por=
t;
> +=A0=A0=A0=A0=A0=A0=A0else
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return (void __iomem *) (po=
rt + _IO_BASE);
> =A0}

This patch looks wrong to me, it's an indication that either a driver
is confusing ioport and __iomem addresses, or that something went
wrong during the initialization of the primary PCI bus.

We have a bug on cell that would be fixed with this patch, so it
might be the same problem, see the patch that I suggested for
this at http://patchwork.ozlabs.org/linuxppc/patch?id=3D10840 .

	Arnd <><
