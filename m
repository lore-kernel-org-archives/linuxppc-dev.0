Return-Path: <clg@fr.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 629D614008D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 17:48:19 +1000 (EST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 14 Apr 2014 08:48:15 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id C405217D804E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 08:49:08 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3E7mDsO1179916
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 07:48:13 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3E7mDuG029501
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 01:48:13 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 15/15] powerpc/boot: add support for 64bit little endian
 wrapper
Date: Mon, 14 Apr 2014 09:47:14 +0200
Message-Id: <1397461634-20949-16-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1397461634-20949-1-git-send-email-clg@fr.ibm.com>
References: <1397461634-20949-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1395651884.30488.10.camel@pasglop>
References: <1395651884.30488.10.camel@pasglop>
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

The code is only slightly modified : entry points now use the
FIXUP_ENDIAN trampoline to switch endian order. The 32bit wrapper
is kept for big endian kernels and 64bit is enforced for little
endian kernels with a PPC64_BOOT_WRAPPER config option.

The linker script is generated using the kernel preprocessor flags
to make use of the CONFIG_* definitions and the wrapper script is
modified to take into account the new elf64ppc format.

Finally, the zImage file is compiled as a position independent
executable (-pie) which makes it loadable at any address by the
firmware.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---

Changes since v1:

 - merge last 3 patches to preserve bisectability 

 arch/powerpc/boot/Makefile             |   16 +++++++++++++---
 arch/powerpc/boot/crt0.S               |    1 +
 arch/powerpc/boot/ppc_asm.h            |   12 ++++++++++++
 arch/powerpc/boot/pseries-head.S       |    3 +++
 arch/powerpc/boot/wrapper              |   15 ++++++++++++++-
 arch/powerpc/boot/zImage.lds.S         |   25 ++++++++++++++++++++++++-
 arch/powerpc/platforms/Kconfig.cputype |    5 +++++
 7 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index bed660ddf48c..a33c23308e97 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -22,8 +22,14 @@ all: $(obj)/zImage
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -Os -msoft-float -pipe \
 		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
-		 -isystem $(shell $(CROSS32CC) -print-file-name=include) \
-		 -mbig-endian
+		 -isystem $(shell $(CROSS32CC) -print-file-name=include)
+ifdef CONFIG_PPC64_BOOT_WRAPPER
+BOOTCFLAGS	+= -m64
+endif
+ifdef CONFIG_CPU_BIG_ENDIAN
+BOOTCFLAGS	+= -mbig-endian
+endif
+
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
 ifdef CONFIG_DEBUG_INFO
@@ -142,7 +148,11 @@ $(addprefix $(obj)/,$(libfdt) $(libfdtheader)): $(obj)/%: $(srctree)/scripts/dtc
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
diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index 689290561e69..14de4f8778a7 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -275,6 +275,7 @@ prom:
 	rfid
 
 1:	/* Return from OF */
+	FIXUP_ENDIAN
 
 	/* Restore registers and return. */
 	rldicl  r1,r1,0,32
diff --git a/arch/powerpc/boot/ppc_asm.h b/arch/powerpc/boot/ppc_asm.h
index eb0e98be69e0..35ea60c1f070 100644
--- a/arch/powerpc/boot/ppc_asm.h
+++ b/arch/powerpc/boot/ppc_asm.h
@@ -62,4 +62,16 @@
 #define SPRN_TBRL	268
 #define SPRN_TBRU	269
 
+#define FIXUP_ENDIAN						   \
+	tdi   0, 0, 0x48; /* Reverse endian of b . + 8		*/ \
+	b     $+36;	  /* Skip trampoline if endian is good	*/ \
+	.long 0x05009f42; /* bcl 20,31,$+4			*/ \
+	.long 0xa602487d; /* mflr r10				*/ \
+	.long 0x1c004a39; /* addi r10,r10,28			*/ \
+	.long 0xa600607d; /* mfmsr r11				*/ \
+	.long 0x01006b69; /* xori r11,r11,1			*/ \
+	.long 0xa6035a7d; /* mtsrr0 r10				*/ \
+	.long 0xa6037b7d; /* mtsrr1 r11				*/ \
+	.long 0x2400004c  /* rfid				*/
+
 #endif /* _PPC64_PPC_ASM_H */
diff --git a/arch/powerpc/boot/pseries-head.S b/arch/powerpc/boot/pseries-head.S
index 655c3d2c321b..6ef6e02e80f9 100644
--- a/arch/powerpc/boot/pseries-head.S
+++ b/arch/powerpc/boot/pseries-head.S
@@ -1,5 +1,8 @@
+#include "ppc_asm.h"
+
 	.text
 
 	.globl _zimage_start
 _zimage_start:
+	FIXUP_ENDIAN
 	b _zimage_start_lib
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 5889c440a66a..1948cf8b8a40 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -40,6 +40,7 @@ cacheit=
 binary=
 gzip=.gz
 pie=
+format=
 
 # cross-compilation prefix
 CROSS=
@@ -136,6 +137,14 @@ if [ -z "$kernel" ]; then
     kernel=vmlinux
 fi
 
+elfformat="`${CROSS}objdump -p "$kernel" | grep 'file format' | awk '{print $4}'`"
+case "$elfformat" in
+    elf64-powerpcle)	format=elf64lppc	;;
+    elf64-powerpc)	format=elf32ppc	;;
+    elf32-powerpc)	format=elf32ppc	;;
+esac
+
+
 platformo=$object/"$platform".o
 lds=$object/zImage.lds
 ext=strip
@@ -154,6 +163,10 @@ of)
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
@@ -379,7 +392,7 @@ if [ "$platform" != "miboot" ]; then
     if [ -n "$link_address" ] ; then
         text_start="-Ttext $link_address"
     fi
-    ${CROSS}ld -m elf32ppc -T $lds $text_start $pie -o "$ofile" \
+    ${CROSS}ld -m $format -T $lds $text_start $pie -o "$ofile" \
 	$platformo $tmp $object/wrapper.a
     rm $tmp
 fi
diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
index 2bd8731f1365..861e72109df2 100644
--- a/arch/powerpc/boot/zImage.lds.S
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -1,4 +1,10 @@
+#include <asm-generic/vmlinux.lds.h>
+
+#ifdef CONFIG_PPC64_BOOT_WRAPPER
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
+#ifndef CONFIG_PPC64_BOOT_WRAPPER
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
+#ifdef CONFIG_PPC64_BOOT_WRAPPER
+    __rela_dyn_start = .;
+#endif
+    *(.rela*)
+  }
 
   . = ALIGN(8);
   .kernel:dtb :
@@ -53,6 +67,15 @@ SECTIONS
     _initrd_end =  .;
   }
 
+#ifdef CONFIG_PPC64_BOOT_WRAPPER
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
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index d9e2b19b7c8d..43b65ad1970a 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -422,6 +422,7 @@ config CPU_BIG_ENDIAN
 
 config CPU_LITTLE_ENDIAN
 	bool "Build little endian kernel"
+	select PPC64_BOOT_WRAPPER
 	help
 	  Build a little endian kernel.
 
@@ -430,3 +431,7 @@ config CPU_LITTLE_ENDIAN
 	  little endian powerpc.
 
 endchoice
+
+config PPC64_BOOT_WRAPPER
+	def_bool n
+	depends on CPU_LITTLE_ENDIAN
-- 
1.7.10.4
