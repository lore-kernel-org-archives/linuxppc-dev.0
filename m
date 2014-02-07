Return-Path: <clg@fr.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 513B02C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 02:59:57 +1100 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 7 Feb 2014 15:59:53 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id D2A252190056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 15:59:48 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s17Fxdwt62849158
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 15:59:39 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s17FxoS5013733
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 08:59:50 -0700
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [RFC PATCH 17/18] powerpc/boot: add support for 64bit little endian
 wrapper
Date: Fri,  7 Feb 2014 16:59:30 +0100
Message-Id: <1391788771-16405-18-git-send-email-clg@fr.ibm.com>
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

Compilation is changed for little endian and entry points between the
wrapper and the kernel are modified to fix endian order with the famous
FIXUP_ENDIAN trampoline. This is PowerPC magic.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/Makefile       |    7 +++++--
 arch/powerpc/boot/crt0.S         |    1 +
 arch/powerpc/boot/ppc_asm.h      |   12 ++++++++++++
 arch/powerpc/boot/pseries-head.S |    3 +++
 arch/powerpc/boot/wrapper        |    1 +
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index bedbd46273e4..de71d2a0af3b 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -22,11 +22,14 @@ all: $(obj)/zImage
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -Os -msoft-float -pipe \
 		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
-		 -isystem $(shell $(CROSS32CC) -print-file-name=include) \
-		 -mbig-endian
+		 -isystem $(shell $(CROSS32CC) -print-file-name=include)
 ifdef CONFIG_PPC64
 BOOTCFLAGS	+= -m64
 endif
+ifdef CONFIG_CPU_BIG_ENDIAN
+BOOTCFLAGS	+= -mbig-endian
+endif
+
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
 ifdef CONFIG_DEBUG_INFO
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
index 6eca1b4ecfa4..a1654b510ff3 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -139,6 +139,7 @@ fi
 
 elfformat="`${CROSS}objdump -p "$kernel" | grep 'file format' | awk '{print $4}'`"
 case "$elfformat" in
+    elf64-powerpcle)	format=elf64lppc	;;
     elf64-powerpc)	format=elf64ppc	;;
     elf32-powerpc)	format=elf32ppc	;;
 esac
-- 
1.7.10.4
