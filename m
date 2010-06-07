Return-Path: <sfbest@us.ibm.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 5A53FB7D1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Jun 2010 06:49:54 +1000 (EST)
Date: Mon, 7 Jun 2010 16:49:52 -0400
From: Steve Best <sfbest@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, sfbest@us.ibm.com
Message-Id: <20100607203957.23695.97675.sendpatchset@squad5-lp1.lab.bos.redhat.com>
Subject: [PATCH] powerpc: Fix integer constant warning
Cc: Steve Best <sfbest@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix ppc arch/powerpc/boot/addRamDisk.c:277: warning: integer constant
is too large for 'long' type

Signed-off-by: Steve Best <sfbest@us.ibm.com>

diff -purN linux.2.6.orig/arch/powerpc/boot/addRamDisk.c linux.2.6/arch/powerpc/boot/addRamDisk.c
--- linux.2.6.orig/arch/powerpc/boot/addRamDisk.c	2010-06-07 15:20:41.763844095 -0400
+++ linux.2.6/arch/powerpc/boot/addRamDisk.c	2010-06-07 15:27:15.165100339 -0400
@@ -9,7 +9,7 @@
 
 #define ElfHeaderSize  (64 * 1024)
 #define ElfPages  (ElfHeaderSize / 4096)
-#define KERNELBASE (0xc000000000000000)
+#define KERNELBASE (0xc000000000000000ULL)
 #define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
 
 struct addr_range {
