Return-Path: <clg@fr.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A4A39140158
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:24:01 +1000 (EST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 24 Apr 2014 08:23:58 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0C5011B08051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 08:24:02 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7Nu0f2359764
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 07:23:56 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O7NtXp025217
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 01:23:56 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 14/15] powerpc/boot: add a global entry point for pseries
Date: Thu, 24 Apr 2014 09:23:38 +0200
Message-Id: <1398324219-8919-15-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1398324219-8919-1-git-send-email-clg@fr.ibm.com>
References: <1398324219-8919-1-git-send-email-clg@fr.ibm.com>
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

When entering the boot wrapper in little endian, we will need to fix
the endian order using a fixup trampoline like in the kernel. This
patch overrides the _zimage_start entry point for this purpose.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---

Changes since v1:

 - pseries is not the only platform generating a zImage.pseries boot 
   wrapper. Fixed Makefile for these. 

 arch/powerpc/boot/Makefile       |    5 +++++
 arch/powerpc/boot/pseries-head.S |    5 +++++
 arch/powerpc/boot/wrapper        |    2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/boot/pseries-head.S

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index a1f8c7f1ec60..bed660ddf48c 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -99,6 +99,11 @@ src-plat-$(CONFIG_EMBEDDED6xx) += cuboot-pq2.c cuboot-mpc7448hpc2.c \
 src-plat-$(CONFIG_AMIGAONE) += cuboot-amigaone.c
 src-plat-$(CONFIG_PPC_PS3) += ps3-head.S ps3-hvcall.S ps3.c
 src-plat-$(CONFIG_EPAPR_BOOT) += epapr.c epapr-wrapper.c
+src-plat-$(CONFIG_PPC_PSERIES) += pseries-head.S
+src-plat-$(CONFIG_PPC_POWERNV) += pseries-head.S
+src-plat-$(CONFIG_PPC_IBM_CELL_BLADE) += pseries-head.S
+src-plat-$(CONFIG_PPC_CELLEB) += pseries-head.S
+src-plat-$(CONFIG_PPC_CELL_QPACE) += pseries-head.S
 
 src-wlib := $(sort $(src-wlib-y))
 src-plat := $(sort $(src-plat-y))
diff --git a/arch/powerpc/boot/pseries-head.S b/arch/powerpc/boot/pseries-head.S
new file mode 100644
index 000000000000..655c3d2c321b
--- /dev/null
+++ b/arch/powerpc/boot/pseries-head.S
@@ -0,0 +1,5 @@
+	.text
+
+	.globl _zimage_start
+_zimage_start:
+	b _zimage_start_lib
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index d27a25518b01..5889c440a66a 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -152,7 +152,7 @@ of)
     make_space=n
     ;;
 pseries)
-    platformo="$object/of.o $object/epapr.o"
+    platformo="$object/pseries-head.o $object/of.o $object/epapr.o"
     link_address='0x4000000'
     make_space=n
     ;;
-- 
1.7.10.4
