Return-Path: <clg@fr.ibm.com>
Received: from e06smtp18.uk.ibm.com (e06smtp18.uk.ibm.com [195.75.94.114])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 533C02C083F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 02:20:46 +1100 (EST)
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 20 Mar 2014 15:10:42 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 286882190041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:35 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2KFASNO2752844
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:28 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2KFAdXx016433
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 09:10:39 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 18/18] powerpc/boot: add PPC64_BOOT_WRAPPER config option
Date: Thu, 20 Mar 2014 16:10:13 +0100
Message-Id: <1395328213-19206-19-git-send-email-clg@fr.ibm.com>
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

The previous patch broke compatibility for 64bit big endian kernel.

This patch adds a config option to compile the boot wrapper in 64bit
only when CPU_LITTLE_ENDIAN is selected. It restores 32bit compilation
and linking for the big endian kernel.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/Makefile             |    2 +-
 arch/powerpc/boot/wrapper              |    2 +-
 arch/powerpc/boot/zImage.lds.S         |    8 ++++----
 arch/powerpc/platforms/Kconfig.cputype |    5 +++++
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index b7e640028711..35189540b699 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -23,7 +23,7 @@ BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -Os -msoft-float -pipe \
 		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
 		 -isystem $(shell $(CROSS32CC) -print-file-name=include)
-ifdef CONFIG_PPC64
+ifdef CONFIG_PPC64_BOOT_WRAPPER
 BOOTCFLAGS	+= -m64
 endif
 ifdef CONFIG_CPU_BIG_ENDIAN
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 3270e2a5c901..1948cf8b8a40 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -140,7 +140,7 @@ fi
 elfformat="`${CROSS}objdump -p "$kernel" | grep 'file format' | awk '{print $4}'`"
 case "$elfformat" in
     elf64-powerpcle)	format=elf64lppc	;;
-    elf64-powerpc)	format=elf64ppc	;;
+    elf64-powerpc)	format=elf32ppc	;;
     elf32-powerpc)	format=elf32ppc	;;
 esac
 
diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
index afecab0aff5c..861e72109df2 100644
--- a/arch/powerpc/boot/zImage.lds.S
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -1,6 +1,6 @@
 #include <asm-generic/vmlinux.lds.h>
 
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC64_BOOT_WRAPPER
 OUTPUT_ARCH(powerpc:common64)
 #else
 OUTPUT_ARCH(powerpc:common)
@@ -22,7 +22,7 @@ SECTIONS
     *(.rodata*)
     *(.data*)
     *(.sdata*)
-#ifdef CONFIG_PPC32
+#ifndef CONFIG_PPC64_BOOT_WRAPPER
     *(.got2)
 #endif
   }
@@ -37,7 +37,7 @@ SECTIONS
   .interp : { *(.interp) }
   .rela.dyn :
   {
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC64_BOOT_WRAPPER
     __rela_dyn_start = .;
 #endif
     *(.rela*)
@@ -67,7 +67,7 @@ SECTIONS
     _initrd_end =  .;
   }
 
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC64_BOOT_WRAPPER
   .got :
   {
     __toc_start = .;
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 434fda39bf8b..a4aadb091a1e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -421,6 +421,7 @@ config CPU_BIG_ENDIAN
 
 config CPU_LITTLE_ENDIAN
 	bool "Build little endian kernel"
+	select PPC64_BOOT_WRAPPER
 	help
 	  Build a little endian kernel.
 
@@ -429,3 +430,7 @@ config CPU_LITTLE_ENDIAN
 	  little endian powerpc.
 
 endchoice
+
+config PPC64_BOOT_WRAPPER
+	def_bool n
+	depends on CPU_LITTLE_ENDIAN
-- 
1.7.10.4
