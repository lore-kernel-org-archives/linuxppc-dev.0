Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 83C01B70D2
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 17:28:49 +1000 (EST)
Message-ID: <4C91C77B.8080501@windriver.com>
Date: Thu, 16 Sep 2010 15:30:03 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: cuImage and multi image?
References: <AANLkTinhvh+G1Q8yU0y5bMDVi5Sc=pYqSfAbXCeuHvBH@mail.gmail.com>
In-Reply-To: <AANLkTinhvh+G1Q8yU0y5bMDVi5Sc=pYqSfAbXCeuHvBH@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: ppcdev <linuxppc-dev@ozlabs.org>, uboot <u-boot@lists.denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shawn Jin wrote:
> Hi,
> 
> I have a cuImage kernel in order to support legacy u-boot and a
> ramdisk image. Kernel boots fine if these two images are separate and
> "bootm $kernel $ramdisk" is used. But I can not make it to work using
> a single multi image that contains the kernel and ramdisk images. Is
> it even technically possible to boot a multi-image with cuboot
> wrapper?

Try the following steps:
------
1. cp <your ramdisk.gz> arch/powerpc/boot/ramdisk.image.gz
2. make cuImage.initrd.<your target>

You can get one Image, cuImage.initrd.<your target>, including kernel and ramdisk.

Cheers
Tiejun

> 
> On the cuImage kernel I have load address set to 0x400000 and the
> entry address set to 0x400554 due to the cuboot wrapper. But to make a
> multi image, both the load and the entry addresses should be set to
> zero. And u-boot (1.1.2) bootm takes the entry address of the multi
> image (i.e. 0x0) as the kernel entry address. 0x0 is certainly not the
> entry address for a cuImage kernel.
> 
> Is there a possible workaround other than using two separate images?
> 
> Thanks,
> -Shawn.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
