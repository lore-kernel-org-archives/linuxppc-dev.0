Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D4B8667A58
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 01:23:17 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cbf07e669ed84066a0bc366ca254123b@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 6 May 2005 10:23:05 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: PPC uImage build not reporting correctly
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sam,

Tom pointed me at you to look at a makefile issue with 
arch/ppc/boot/images/Makefile.  When I do the following:

$ make uImage
   CHK     include/linux/version.h
make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
   CHK     include/linux/compile.h
   CHK     usr/initramfs_list
   UIMAGE  arch/ppc/boot/images/uImage
Image Name:   Linux-2.6.12-rc3
Created:      Fri May  6 10:19:28 2005
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    993322 Bytes = 970.04 kB = 0.95 MB
Load Address: 0x00000000
Entry Point:  0x00000000
   Image: arch/ppc/boot/images/uImage not made

The issue is that the file arch/ppc/boot/images/uImage does exit (the 
'not made' is not correct).

$(obj)/uImage: $(obj)/vmlinux.gz
         $(Q)rm -f $@
         $(call if_changed,uimage)
         @echo '  Image: $@' $(if $(wildcard $@),'is ready','not made')

It seems the $(wildcard $@) expands at the start of the rule.  Any 
ideas?

- kumar 
