Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6DC28B70F6
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 09:45:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [U-Boot] cuImage and multi image?
Date: Wed, 22 Sep 2010 01:45:24 +0200
Message-ID: <52CF90264091A14888078A031D780F4306C8C0A0@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <20100921125247.49f8d101@udp111988uds.am.freescale.net>
References: <AANLkTinhvh+G1Q8yU0y5bMDVi5Sc=pYqSfAbXCeuHvBH@mail.gmail.com><4C91C77B.8080501@windriver.com><AANLkTikrYdi=V6jM4HS3V4XzMutGdkPA2qHRBgviKHM8@mail.gmail.com><52CF90264091A14888078A031D780F4306C8BD30@ism-mail03.corp.ad.wrs.com>
	<20100921125247.49f8d101@udp111988uds.am.freescale.net>
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, uboot <u-boot@lists.denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.ozlabs.or
> g=20
> [mailto:linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.o
zlabs.org] On Behalf Of Scott Wood
> Sent: Wednesday, September 22, 2010 1:53 AM
> To: Chen, Tiejun
> Cc: ppcdev; uboot
> Subject: Re: [U-Boot] cuImage and multi image?
>=20
> On Tue, 21 Sep 2010 03:03:22 +0200
> "Chen, Tiejun" <Tiejun.Chen@windriver.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Shawn Jin [mailto:shawnxjin@gmail.com]
> > > Sent: Tuesday, September 21, 2010 1:53 AM
> > > To: Chen, Tiejun
> > > Cc: ppcdev; uboot
> > > Subject: Re: cuImage and multi image?
> > >=20
> > > >> I have a cuImage kernel in order to support legacy=20
> u-boot and a=20
> > > >> ramdisk image. Kernel boots fine if these two images are
> > > separate and
> > > >> "bootm $kernel $ramdisk" is used. But I can not make it to
> > > work using
> > > >> a single multi image that contains the kernel and ramdisk
> > > images. Is
> > > >> it even technically possible to boot a multi-image with cuboot=20
> > > >> wrapper?
> > > >
> > > > Try the following steps:
> > > > ------
> > > > 1. cp <your ramdisk.gz> arch/powerpc/boot/ramdisk.image.gz
> > > > 2. make cuImage.initrd.<your target>
> > > >
> > > > You can get one Image, cuImage.initrd.<your target>,
> > > including kernel and ramdisk.
> > >=20
> > > A follow up question. With this method, the total image size
> > > (uncompressed) is limited to the 4MB (the link address of=20
> the boot=20
> > > wrapper)?
> >=20
> > No.
>=20
> Yes, unless you change the link address, or provide a=20
> vmlinux_alloc callback (which currently only happens on true=20
> OF, not cuImage).
>=20
> Unless you're talking about the "(uncompressed)"?  The limit=20
> applies to the uncompressed boot image -- anything that the=20
> bootwrapper itself is decompressing.  It does not apply to=20
> any further uncompression of the ramdisk itself.
>=20

He should point the latter, "the total image size", including ramdisk.
But the link address should be limited for the boot Image, not for the
attached ramdisk.

Tiejun

> -Scott
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
