Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BDCE26872B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2005 21:29:58 +1100 (EST)
Date: Sat, 19 Nov 2005 11:29:52 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051119102952.GA32273@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
	<20051118075158.GB14865@suse.de> <20051118221309.GA12724@suse.de>
	<17278.40894.898159.724090@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17278.40894.898159.724090@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generate COFF zImage in arch/powerpc/boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sat, Nov 19, Paul Mackeras wrote:

> Olaf Hering writes:
> 
> > So we either need a ld script for coff with kernel and initrd in the
> > .data section. Or we write a tool to extract the vmlinux.gz and initrd
> > based on nm or readelf -a output.
> 
> Here's a new version that does the first of those...
> 
> The zImage base address could go back to 4MB now.  In fact one could
> argue that if OF is based at 12MB and load-base is near zero, linking
> it at 6MB would be best.
> 
> There is still something I haven't got right: if you do make -j3, it
> does this sort of thing:
> 
>   STRIP   vmlinux.strip
>   STRIP   vmlinux.strip
>   GZIP    arch/powerpc/boot/kernel-vmlinux.strip.gz
>   GZIP    arch/powerpc/boot/kernel-vmlinux.strip.gz
>   BOOTCC  arch/powerpc/boot/kernel-vmlinux.strip.o
>   BOOTCC  arch/powerpc/boot/kernel-vmlinux.strip.o
> mv: cannot stat `arch/powerpc/boot/.kernel-vmlinux.strip.o.tmp': No such file or directory
> make[2]: *** [arch/powerpc/boot/kernel-vmlinux.strip.o] Error 1
> make[1]: *** [zImage] Error 2
> 
> I have no idea why it tries to make those things twice in parallel.
> It doesn't do that for vmlinux.

This patch on top of yours fixes it for me.

All members of $(BOOT_TARGETS) will be built in parallel.

make zImage.vmode doesnt work right now, without your patch.
And all it gains is one less host prog and one less zImage file.
Same for zImage.coff. Is it worth the trouble?

 arch/powerpc/Makefile      |    5 ++---
 arch/powerpc/boot/Makefile |   10 +++++-----
 2 files changed, 7 insertions(+), 8 deletions(-)

Index: linux-2.6.15-rc1-olh/arch/powerpc/boot/Makefile
===================================================================
--- linux-2.6.15-rc1-olh.orig/arch/powerpc/boot/Makefile
+++ linux-2.6.15-rc1-olh/arch/powerpc/boot/Makefile
@@ -89,7 +89,7 @@ gz-sec  = $(foreach section, $(1), $(pat
 
 hostprogs-y		:= addnote addRamDisk hack-coff
 
-targets += zImage.vmode zImage.initrd.vmode zImage zImage.initrd \
+targets += zImage zImage.initrd \
 	   $(patsubst $(obj)/%,%, $(call obj-sec, $(required) $(initrd))) \
 	   $(patsubst $(obj)/%,%, $(call src-sec, $(required) $(initrd))) \
 	   $(patsubst $(obj)/%,%, $(call gz-sec, $(required) $(initrd))) \
@@ -132,19 +132,19 @@ $(call obj-sec, $(required) $(initrd)): 
 	$(call if_changed_dep,bootcc)
 	$(call cmd,addsection)
 
-$(obj)/zImage.vmode $(obj)/zImage.coff: obj-boot += $(call obj-sec, $(required))
+$(obj)/zImage.vmode: obj-boot += $(call obj-sec, $(required))
 $(obj)/zImage.vmode: $(call obj-sec, $(required)) $(obj-boot) $(srctree)/$(src)/zImage.lds
 	$(call cmd,bootld,$(obj-boot),zImage.lds)
 
-$(obj)/zImage.initrd.vmode $(obj)/zImage.initrd.coff: obj-boot += $(call obj-sec, $(required) $(initrd))
+$(obj)/zImage.initrd.vmode: obj-boot += $(call obj-sec, $(required) $(initrd))
 $(obj)/zImage.initrd.vmode: $(call obj-sec, $(required) $(initrd)) $(obj-boot) $(srctree)/$(src)/zImage.lds
 	$(call cmd,bootld,$(obj-boot),zImage.lds)
 
-$(obj)/zImage: $(obj)/zImage.vmode $(obj)/addnote
+$(obj)/zImage: $(obj)/zImage.vmode $(obj)/zImage.coff $(obj)/addnote
 	@cp -f $< $@
 	$(call if_changed,addnote)
 
-$(obj)/zImage.initrd: $(obj)/zImage.initrd.vmode $(obj)/addnote
+$(obj)/zImage.initrd: $(obj)/zImage.initrd.vmode $(obj)/zImage.initrd.coff $(obj)/addnote
 	@cp -f $< $@
 	$(call if_changed,addnote)
 
Index: linux-2.6.15-rc1-olh/arch/powerpc/Makefile
===================================================================
--- linux-2.6.15-rc1-olh.orig/arch/powerpc/Makefile
+++ linux-2.6.15-rc1-olh/arch/powerpc/Makefile
@@ -138,7 +138,7 @@ drivers-$(CONFIG_CPM2)		+= arch/ppc/8260
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
-defaultimage-$(CONFIG_PPC32)	:= zImage zImage.coff
+defaultimage-$(CONFIG_PPC32)	:= zImage
 defaultimage-$(CONFIG_PPC_ISERIES) := vmlinux
 defaultimage-$(CONFIG_PPC_PSERIES) := zImage
 KBUILD_IMAGE := $(defaultimage-y)
@@ -149,8 +149,7 @@ CPPFLAGS_vmlinux.lds	:= -Upowerpc
 # All the instructions talk about "make bzImage".
 bzImage: zImage
 
-BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm \
-	       zImage.vmode zImage.initrd.vmode zImage.coff zImage.initrd.coff
+BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
 
 .PHONY: $(BOOT_TARGETS)
 

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
