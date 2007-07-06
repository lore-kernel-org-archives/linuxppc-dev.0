Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 57894DE076
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 07:26:39 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: PowerPC equivalent to dma_mmap_writecombine()?
Date: Fri, 6 Jul 2007 23:26:22 +0200
References: <468D1F23.6000803@freescale.com> <200707051813.53762.arnd@arndb.de>
	<468EA3DA.8070903@freescale.com>
In-Reply-To: <468EA3DA.8070903@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707062326.23808.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 06 July 2007, Timur Tabi wrote:
> Arnd Bergmann wrote:
>=20
> > Not sure exactly what arm does here, but it sounds like you want
> > to call remap_pfn_range with the _PAGE_NO_CACHE bit set in the
> > protection flags, and _PAGE_GUARDED not set.
>=20
> I always have a hard time with these mapping functions. =A0Is this right?
>=20
> vma->vm_page_prot =3D __pgprot((pgprot_val(vma->vm_page_prot) | _PAGE_NO_=
CACHE) &=20
> ~_PAGE_GUARDED));
>=20
> ret =3D remap_pfn_range(vma, vma->vm_start, runtime->dma_addr, runtime->d=
ma_bytes,=20
> vma->vm_page_prot);
>=20
> Alternatively, could I use function snd_pcm_lib_mmap_iomem() (sound/core/=
pcm_native.c)?=20
> It looks like it does the right thing, although it doesn't unset the guar=
ded bit. =A0If=20
> that's wrong, I can submit a patch to unset that bit on PowerPC, but like=
 I said, I can=20
> never quite get my head around this mapping stuff.

The guarded bit is disabled by default, so you don't need t remove it, so
the function you quoted should be alright for this purpose. Not sure if you
need the ioremap in there though.

	Arnd <><
