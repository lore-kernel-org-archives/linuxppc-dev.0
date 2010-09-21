Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id C9A85B70CD
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 03:52:57 +1000 (EST)
Received: from mail55-va3 (localhost.localdomain [127.0.0.1])	by
	mail55-va3-R.bigfish.com (Postfix) with ESMTP id 1655A41817D	for
	<linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 17:52:53 +0000 (UTC)
Received: from VA3EHSMHS016.bigfish.com (unknown [10.7.14.248])	by
	mail55-va3.bigfish.com (Postfix) with ESMTP id 70DFE18B004C	for
	<linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 17:52:52 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8LHqn0g019944	for <linuxppc-dev@ozlabs.org>;
	Tue, 21 Sep 2010 10:52:49 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8LHqtn6014463	for <linuxppc-dev@ozlabs.org>;
	Tue, 21 Sep 2010 12:52:55 -0500 (CDT)
Date: Tue, 21 Sep 2010 12:52:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
Subject: Re: [U-Boot] cuImage and multi image?
Message-ID: <20100921125247.49f8d101@udp111988uds.am.freescale.net>
In-Reply-To: <52CF90264091A14888078A031D780F4306C8BD30@ism-mail03.corp.ad.wrs.com>
References: <AANLkTinhvh+G1Q8yU0y5bMDVi5Sc=pYqSfAbXCeuHvBH@mail.gmail.com>
	<4C91C77B.8080501@windriver.com>
	<AANLkTikrYdi=V6jM4HS3V4XzMutGdkPA2qHRBgviKHM8@mail.gmail.com>
	<52CF90264091A14888078A031D780F4306C8BD30@ism-mail03.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: ppcdev <linuxppc-dev@ozlabs.org>, uboot <u-boot@lists.denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Sep 2010 03:03:22 +0200
"Chen, Tiejun" <Tiejun.Chen@windriver.com> wrote:

> > -----Original Message-----
> > From: Shawn Jin [mailto:shawnxjin@gmail.com] 
> > Sent: Tuesday, September 21, 2010 1:53 AM
> > To: Chen, Tiejun
> > Cc: ppcdev; uboot
> > Subject: Re: cuImage and multi image?
> > 
> > >> I have a cuImage kernel in order to support legacy u-boot and a 
> > >> ramdisk image. Kernel boots fine if these two images are 
> > separate and 
> > >> "bootm $kernel $ramdisk" is used. But I can not make it to 
> > work using 
> > >> a single multi image that contains the kernel and ramdisk 
> > images. Is 
> > >> it even technically possible to boot a multi-image with cuboot 
> > >> wrapper?
> > >
> > > Try the following steps:
> > > ------
> > > 1. cp <your ramdisk.gz> arch/powerpc/boot/ramdisk.image.gz
> > > 2. make cuImage.initrd.<your target>
> > >
> > > You can get one Image, cuImage.initrd.<your target>, 
> > including kernel and ramdisk.
> > 
> > A follow up question. With this method, the total image size
> > (uncompressed) is limited to the 4MB (the link address of the 
> > boot wrapper)?
> 
> No.

Yes, unless you change the link address, or provide a vmlinux_alloc
callback (which currently only happens on true OF, not cuImage).

Unless you're talking about the "(uncompressed)"?  The limit applies to
the uncompressed boot image -- anything that the bootwrapper itself is
decompressing.  It does not apply to any further uncompression of the
ramdisk itself.

-Scott
