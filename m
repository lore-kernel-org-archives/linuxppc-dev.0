Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 61B73679E9
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 07:57:12 +1000 (EST)
In-Reply-To: <33091.80.160.117.125.1115415913.squirrel@80.160.117.125>
References: <33091.80.160.117.125.1115415913.squirrel@80.160.117.125>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <4bbf50644ea82dacac17b057628f55de@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 6 May 2005 16:57:10 -0500
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: PPC uImage build not reporting correctly
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 6, 2005, at 4:45 PM, Sam Ravnborg wrote:

> > Sam,
>  >
>  > Tom pointed me at you to look at a makefile issue with
>  > arch/ppc/boot/images/Makefile.=A0 When I do the following:
>  >
>  > $ make uImage
>  >=A0=A0=A0 CHK=A0=A0=A0=A0 include/linux/version.h
> > make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
>  >=A0=A0=A0 CHK=A0=A0=A0=A0 include/linux/compile.h
> >=A0=A0=A0 CHK=A0=A0=A0=A0 usr/initramfs_list
> >=A0=A0=A0 UIMAGE=A0 arch/ppc/boot/images/uImage
> > Image Name:=A0=A0 Linux-2.6.12-rc3
>  > Created:=A0=A0=A0=A0=A0 Fri May=A0 6 10:19:28 2005
> > Image Type:=A0=A0 PowerPC Linux Kernel Image (gzip compressed)
>  > Data Size:=A0=A0=A0 993322 Bytes =3D 970.04 kB =3D 0.95 MB
>  > Load Address: 0x00000000
>  > Entry Point:=A0 0x00000000
>  >=A0=A0=A0 Image: arch/ppc/boot/images/uImage not made
>  >
>  > The issue is that the file arch/ppc/boot/images/uImage does exit=20
> (the
>  > 'not made' is not correct).
>  >
>  > $(obj)/uImage: $(obj)/vmlinux.gz
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0 $(Q)rm -f $@
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0 $(call if_changed,uimage)
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0 @echo '=A0 Image: $@' $(if $(wildcard =
$@),'is ready','not=20
> made')
>  >
>  > It seems the $(wildcard $@) expands at the start of the rule.=A0 =
Any
>  > ideas?
>
> It probarly uses the build-in cache in make - and I see no easy way to
>  tell make not to use the cache in this case.
>  Could you try to replace "$(wildcard $@)" with something like:
> $(shell if -f $@ echo Y; fi)
>
> Untested - I'm not on a Linux box right now.

I tried the following w/o success:

$(obj)/uImage: $(obj)/vmlinux.gz
         $(Q)rm -f $@
         $(call if_changed,uimage)
         @echo '  Image: $@' $(shell if [ -f $@ ]; then echo 'is ready';=20=

else echo 'not made'; fi)

- kumar=
