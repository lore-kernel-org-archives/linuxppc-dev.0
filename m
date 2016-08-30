Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNh6d6gDkzDrhS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 18:11:05 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id g202so785625pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 01:11:05 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 2/6] powerpc/boot: Use CONFIG_KERNEL_GZIP
Date: Tue, 30 Aug 2016 18:10:32 +1000
Message-Id: <1472544636-7837-3-git-send-email-oohall@gmail.com>
In-Reply-To: <1472544636-7837-1-git-send-email-oohall@gmail.com>
References: <1472544636-7837-1-git-send-email-oohall@gmail.com>
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
 arch/powerpc/boot/Makefile | 31 +++++++++++++++++++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 927d2ab2ce08..9f0568852ecf 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -167,6 +167,7 @@ config PPC
 	select GENERIC_CPU_AUTOPROBE
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_ARCH_HARDENED_USERCOPY
+	select HAVE_KERNEL_GZIP
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index f98e42ee2534..5a99a485d80a 100644
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
@@ -59,13 +63,16 @@ $(obj)/treeboot-currituck.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-akebono.o: BOOTCFLAGS += -mcpu=405
 $(obj)/virtex405-head.o: BOOTAFLAGS += -mcpu=405
 
+# the kernel's version of zlib pulls in a lot of other kernel headers
+# which we don't provide inside the wrapper.
+zlib-$(CONFIG_KERNEL_GZIP) := inffast.c inflate.c inftrees.c
+zlibheaders-$(CONFIG_KERNEL_GZIP) := inffast.h inffixed.h inflate.h inftrees.h infutil.h
+zliblinuxheader-$(CONFIG_KERNEL_GZIP) := zlib.h zconf.h zutil.h
 
-zlib       := inffast.c inflate.c inftrees.c
-zlibheader := inffast.h inffixed.h inflate.h inftrees.h infutil.h
-zliblinuxheader := zlib.h zconf.h zutil.h
-
-$(addprefix $(obj)/,$(zlib) cuboot-c2k.o gunzip_util.o main.o): \
-	$(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
+$(addprefix $(obj)/,$(zlib-y) cuboot-c2k.o gunzip_util.o main.o): \
+	$(addprefix $(obj)/,$(zliblinuxheader-y)) \
+	$(addprefix $(obj)/,$(zlibheaders-y)) \
+	$(addprefix $(obj)/,$(zlib-decomp-y))
 
 libfdt       := fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 libfdtheader := fdt.h libfdt.h libfdt_internal.h
@@ -76,7 +83,7 @@ $(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o): \
 src-wlib-y := string.S crt0.S crtsavres.S stdio.c main.c \
 		$(libfdt) libfdt-wrapper.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
-		gunzip_util.c elf_util.c $(zlib) devtree.c stdlib.c \
+		gunzip_util.c elf_util.c $(zlib-y) devtree.c stdlib.c \
 		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
 		uartlite.c mpc52xx-psc.c opal.c opal-calls.S
 src-wlib-$(CONFIG_40x) += 4xx.c planetcore.c
@@ -128,13 +135,13 @@ obj-plat: $(libfdt)
 quiet_cmd_copy_kern_src = COPY    $@
       cmd_copy_kern_src = sed -f $(srctree)/arch/powerpc/boot/fixup-headers.sed $< > $@
 
-$(addprefix $(obj)/,$(zlib)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
+$(addprefix $(obj)/,$(zlib-y)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
 	$(call cmd,copy_kern_src)
 
-$(addprefix $(obj)/,$(zlibheaders)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
+$(addprefix $(obj)/,$(zlibheaders-y)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
 	$(call cmd,copy_kern_src)
 
-$(addprefix $(obj)/,$(zliblinuxheader)): $(obj)/%: $(srctree)/include/linux/%
+$(addprefix $(obj)/,$(zliblinuxheader-y)): $(obj)/%: $(srctree)/include/linux/%
 	$(call cmd,copy_kern_src)
 
 quiet_cmd_copy_libfdt = COPY    $@
@@ -153,7 +160,7 @@ $(obj)/zImage.lds: $(obj)/%: $(srctree)/$(src)/%.S
 $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
 	@cp $< $@
 
-clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
+clean-files := $(zlib-y) $(zlibheaders-y) $(zliblinuxheader-y) \
 		$(libfdt) $(libfdtheader) \
 		empty.c zImage.coff.lds zImage.ps3.lds zImage.lds
 
-- 
2.5.5
