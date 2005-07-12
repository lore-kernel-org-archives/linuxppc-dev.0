Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 423C467C12
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2005 07:29:33 +1000 (EST)
Date: Tue, 12 Jul 2005 23:29:28 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@osdl.org>
Message-ID: <20050712212928.GA6717@suse.de>
References: <20050206124014.GA5880@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050206124014.GA5880@suse.de>
Subject: [PATCH] make -j12 all fails in uImage target
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Feb 06, Olaf Hering wrote:

> 
> this is what I got with 2.6.11rc3:
> 
> make ARCH=ppc O=../O-2.6.11-rc3-b50-SMP -j12 all
> ...
>   LD      vmlinux
>   SYSMAP  System.map
>   SYSMAP  .tmp_System.map
>   OBJCOPY arch/ppc/boot/images/vmlinux.bin
>   HOSTCC  arch/ppc/boot/utils/addnote
>   HOSTCC  arch/ppc/boot/utils/mknote
>   HOSTCC  arch/ppc/boot/utils/mkprep
>   LD      arch/ppc/boot/lib/built-in.o
>   HOSTCC  arch/ppc/boot/utils/hack-coff
>   HOSTCC  arch/ppc/boot/utils/mkbugboot
>   OBJCOPY arch/ppc/boot/images/vmlinux.bin
>   GZIP    arch/ppc/boot/images/vmlinux.gz
> /bin/sh: line 1: arch/ppc/boot/images/vmlinux.bin: No such file or directory
> make[2]: *** [arch/ppc/boot/images/vmlinux.gz] Error 1
> make[1]: *** [uImage] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 
> also, one time that zImage.chrp was only 570K instead of the expected
> 1.4M, so netboot failed. But I got no build error.


make -j zImage may call if_changed twice at the same time,
the result is a corrupted vmlinux.gz
write to a temporary file for the time being until someone with
make skills fix the serialization properly.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/ppc/boot/images/Makefile |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.13-rc2-olh/arch/ppc/boot/images/Makefile
===================================================================
--- linux-2.6.13-rc2-olh.orig/arch/ppc/boot/images/Makefile
+++ linux-2.6.13-rc2-olh/arch/ppc/boot/images/Makefile
@@ -6,12 +6,17 @@ MKIMAGE		:= $(srctree)/scripts/mkuboot.s
 
 extra-y		:= vmlinux.bin vmlinux.gz
 
+# two make processes may write to vmlinux.gz at the same time with make -j
+quiet_cmd_mygzip = GZIP    $@
+cmd_mygzip = gzip -f -9 < $< > $@.$$$$ && mv $@.$$$$ $@
+
+
 OBJCOPYFLAGS_vmlinux.bin := -O binary
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
 $(obj)/vmlinux.gz: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,gzip)
+	$(call if_changed,mygzip)
 
 quiet_cmd_uimage = UIMAGE  $@
       cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A ppc -O linux -T kernel \
