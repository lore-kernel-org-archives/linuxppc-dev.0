Return-Path: <clg@fr.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ACF382C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 02:10:46 +1100 (EST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 20 Mar 2014 15:10:42 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8626817D8059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:11:23 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2KFASKA56950842
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:28 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2KFAdSI016418
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 09:10:39 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 16/18] powerpc/boot: add support for 64bit big endian wrapper
Date: Thu, 20 Mar 2014 16:10:11 +0100
Message-Id: <1395328213-19206-17-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
References: <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1391788771-16405-1-git-send-email-clg@fr.ibm.com>
References: <1391788771-16405-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The boot wrapper is now compiled using -m64 for 64bit kernels.

The linker script is generated using the kernel preprocessor flags
to make use of the CONFIG_PPC64 definitions and the wrapper script is
modified to take into account the new elf64ppc format.

zImage is compiled as a position independent executable (-pie) which
makes it loadable at any address by the firmware. This is subject to
comment as I am not sure what are the requirement for the different
boot loaders.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/Makefile     |    9 ++++++++-
 arch/powerpc/boot/wrapper      |   14 +++++++++++++-
 arch/powerpc/boot/zImage.lds.S |   25 ++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 4db1c47bfe12..e0744781ba5b 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -24,6 +24,9 @@ BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
 		 -isystem $(shell $(CROSS32CC) -print-file-name=include) \
 		 -mbig-endian
+ifdef CONFIG_PPC64
+BOOTCFLAGS	+= -m64
+endif
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
 ifdef CONFIG_DEBUG_INFO
@@ -139,7 +142,11 @@ $(addprefix $(obj)/,$(libfdt) $(libfdtheader)): $(obj)/%: $(srctree)/scripts/dtc
 $(obj)/empty.c:
 	@touch $@
 
-$(obj)/zImage.lds $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds: $(obj)/%: $(srctree)/$(src)/%.S
+$(obj)/zImage.lds: $(obj)/%: $(srctree)/$(src)/%.S
+	$(CROSS32CC) $(cpp_flags) -E -Wp,-MD,$(depfile) -P -Upowerpc \
+		-D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
+
+$(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
 	@cp $< $@
 
 clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 5889c440a66a..baaad96eed7f 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -40,6 +40,7 @@ cacheit=
 binary=
 gzip=.gz
 pie=
+format=
 
 # cross-compilation prefix
 CROSS=
@@ -136,6 +137,13 @@ if [ -z "$kernel" ]; then
     kernel=vmlinux
 fi
 
+elfformat="`${CROSS}objdump -p "$kernel" | grep 'file format' | awk '{print $4}'`"
+case "$elfformat" in
+    elf64-powerpc)	format=elf64ppc	;;
+    elf32-powerpc)	format=elf32ppc	;;
+esac
+
+
 platformo=$object/"$platform".o
 lds=$object/zImage.lds
 ext=strip
@@ -154,6 +162,10 @@ of)
 pseries)
     platformo="$object/pseries-head.o $object/of.o $object/epapr.o"
     link_address='0x4000000'
+    if [ "$format" != "elf32ppc" ]; then
+	link_address=
+	pie=-pie
+    fi
     make_space=n
     ;;
 maple)
@@ -379,7 +391,7 @@ if [ "$platform" != "miboot" ]; then
     if [ -n "$link_address" ] ; then
         text_start="-Ttext $link_address"
     fi
-    ${CROSS}ld -m elf32ppc -T $lds $text_start $pie -o "$ofile" \
+    ${CROSS}ld -m $format -T $lds $text_start $pie -o "$ofile" \
 	$platformo $tmp $object/wrapper.a
     rm $tmp
 fi
diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
index 2bd8731f1365..afecab0aff5c 100644
--- a/arch/powerpc/boot/zImage.lds.S
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -1,4 +1,10 @@
+#include <asm-generic/vmlinux.lds.h>
+
+#ifdef CONFIG_PPC64
+OUTPUT_ARCH(powerpc:common64)
+#else
 OUTPUT_ARCH(powerpc:common)
+#endif
 ENTRY(_zimage_start)
 EXTERN(_zimage_start)
 SECTIONS
@@ -16,7 +22,9 @@ SECTIONS
     *(.rodata*)
     *(.data*)
     *(.sdata*)
+#ifdef CONFIG_PPC32
     *(.got2)
+#endif
   }
   .dynsym : { *(.dynsym) }
   .dynstr : { *(.dynstr) }
@@ -27,7 +35,13 @@ SECTIONS
   }
   .hash : { *(.hash) }
   .interp : { *(.interp) }
-  .rela.dyn : { *(.rela*) }
+  .rela.dyn :
+  {
+#ifdef CONFIG_PPC64
+    __rela_dyn_start = .;
+#endif
+    *(.rela*)
+  }
 
   . = ALIGN(8);
   .kernel:dtb :
@@ -53,6 +67,15 @@ SECTIONS
     _initrd_end =  .;
   }
 
+#ifdef CONFIG_PPC64
+  .got :
+  {
+    __toc_start = .;
+    *(.got)
+    *(.toc)
+  }
+#endif
+
   . = ALIGN(4096);
   .bss       :
   {
-- 
1.7.10.4
