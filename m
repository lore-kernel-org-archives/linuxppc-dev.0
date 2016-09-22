Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfnLB40ZszDshk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 16:54:58 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id hi10so3256030pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 23:54:58 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 2/6] powerpc/boot: Use CONFIG_KERNEL_GZIP
Date: Thu, 22 Sep 2016 16:54:30 +1000
Message-Id: <1474527274-10897-3-git-send-email-oohall@gmail.com>
In-Reply-To: <1474527274-10897-1-git-send-email-oohall@gmail.com>
References: <1474527274-10897-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most architectures allow the compression algorithm used to produced the
vmlinuz image to be selected as a kernel config option. In preperation
for supporting algorithms other than gzip in the powerpc boot wrapper
the makefile needs to be modified to use these config options.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/Kconfig       |  1 +
 arch/powerpc/boot/Makefile | 30 ++++++++++++++++++------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5c295830e8c7..59e53f4552ae 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -161,6 +161,7 @@ config PPC
 	select GENERIC_CPU_AUTOPROBE
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_ARCH_HARDENED_USERCOPY
+	select HAVE_KERNEL_GZIP
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 7d6768253caa..bede555d78cf 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -19,10 +19,14 @@
 
 all: $(obj)/zImage
 
+compress-$(CONFIG_KERNEL_GZIP) := CONFIG_KERNEL_GZIP
+
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -Os -msoft-float -pipe \
 		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
-		 -isystem $(shell $(CROSS32CC) -print-file-name=include)
+		 -isystem $(shell $(CROSS32CC) -print-file-name=include) \
+		 -D$(compress-y)
+
 ifdef CONFIG_PPC64_BOOT_WRAPPER
 BOOTCFLAGS	+= -m64
 endif
@@ -59,13 +63,15 @@ $(obj)/treeboot-currituck.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-akebono.o: BOOTCFLAGS += -mcpu=405
 $(obj)/virtex405-head.o: BOOTAFLAGS += -mcpu=405
 
+# the kernel's version of zlib pulls in a lot of other kernel headers
+# which we don't provide inside the wrapper.
+zlib-$(CONFIG_KERNEL_GZIP) := inffast.c inflate.c inftrees.c
+zlibheader-$(CONFIG_KERNEL_GZIP) := inffast.h inffixed.h inflate.h inftrees.h infutil.h
+zliblinuxheader-$(CONFIG_KERNEL_GZIP) := zlib.h zconf.h zutil.h
 
-zlib       := inffast.c inflate.c inftrees.c
-zlibheader := inffast.h inffixed.h inflate.h inftrees.h infutil.h
-zliblinuxheader := zlib.h zconf.h zutil.h
-
-$(addprefix $(obj)/,$(zlib) cuboot-c2k.o gunzip_util.o main.o): \
-	$(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
+$(addprefix $(obj)/,$(zlib-y) cuboot-c2k.o gunzip_util.o main.o): \
+	$(addprefix $(obj)/,$(zliblinuxheader-y)) \
+	$(addprefix $(obj)/,$(zlibheader-y))
 
 libfdt       := fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 libfdtheader := fdt.h libfdt.h libfdt_internal.h
@@ -76,7 +82,7 @@ $(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o): \
 src-wlib-y := string.S crt0.S crtsavres.S stdio.c main.c \
 		$(libfdt) libfdt-wrapper.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
-		gunzip_util.c elf_util.c $(zlib) devtree.c stdlib.c \
+		gunzip_util.c elf_util.c $(zlib-y) devtree.c stdlib.c \
 		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
 		uartlite.c mpc52xx-psc.c opal.c opal-calls.S
 src-wlib-$(CONFIG_40x) += 4xx.c planetcore.c
@@ -128,13 +134,13 @@ obj-plat: $(libfdt)
 quiet_cmd_copy_kern_src = COPY    $@
       cmd_copy_kern_src = sed -f $(srctree)/arch/powerpc/boot/fixup-headers.sed $< > $@
 
-$(addprefix $(obj)/,$(zlib)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
+$(addprefix $(obj)/,$(zlib-y)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
 	$(call cmd,copy_kern_src)
 
-$(addprefix $(obj)/,$(zlibheader)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
+$(addprefix $(obj)/,$(zlibheader-y)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
 	$(call cmd,copy_kern_src)
 
-$(addprefix $(obj)/,$(zliblinuxheader)): $(obj)/%: $(srctree)/include/linux/%
+$(addprefix $(obj)/,$(zliblinuxheader-y)): $(obj)/%: $(srctree)/include/linux/%
 	$(call cmd,copy_kern_src)
 
 quiet_cmd_copy_libfdt = COPY    $@
@@ -153,7 +159,7 @@ $(obj)/zImage.lds: $(obj)/%: $(srctree)/$(src)/%.S
 $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
 	$(Q)cp $< $@
 
-clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
+clean-files := $(zlib-) $(zlibheader-) $(zliblinuxheader-) \
 		$(libfdt) $(libfdtheader) \
 		empty.c zImage.coff.lds zImage.ps3.lds zImage.lds
 
-- 
2.5.5
