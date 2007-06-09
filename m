Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8461ADDF84
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Jun 2007 07:03:35 +1000 (EST)
In-Reply-To: <alpine.DEB.0.99.0706092110060.8312@foobar-g4>
References: <Pine.LNX.4.64.0705282025250.6275@sheep.housecafe.de>
	<alpine.DEB.0.99.0706092110060.8312@foobar-g4>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <981f558c34d946fcb2683a9731f8d5ad@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: zImage.miboot and vmlinux.lds
Date: Sat, 9 Jun 2007 23:03:26 +0200
To: Christian Kujau <lists@nerdbynature.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hm, the files are still there. Is there any reason for "mrproper" not 
> to
> remove these files? Otherwise, would the following be appropriate?
>
> --- linux-2.6-dev/arch/powerpc/Makefile.orig	2007-05-28 
> 21:24:39.000000000 +0200
> +++ linux-2.6-dev/arch/powerpc/Makefile	2007-05-28 21:23:25.000000000 
> +0200
> @@ -174,6 +174,7 @@ archclean:
>
>   archmrproper:
>   	$(Q)rm -rf arch/$(ARCH)/include
> +	$(Q)rm  -f arch/$(ARCH)/boot/zImage.miboot 
> arch/$(ARCH)/kernel/vmlinux.lds

vmlinux.lds should be cleaned from the main (non-arch)
Makefile; I could swear I've sent a patch for that some
time ago.

zImage.miboot should be added to $(clean-files) in
arch/powerpc/boot/Makefile; the $(image-) in there
should catch it except for the ifeq in

ifeq ($(CONFIG_PPC32),y)
image-$(CONFIG_PPC_PMAC)        += zImage.coff zImage.miboot
endif

Maybe it should be added to $(image-) unconditionally?
Or get rid of the ifeq, preferably.


Segher
