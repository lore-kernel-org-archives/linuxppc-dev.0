Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2296B71FF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 16:42:24 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 14 Nov 2011 11:12:20 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAE5gIj74427878
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 11:12:18 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAE5gHo5028665
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 16:42:18 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v3 3/8] [44x] Enable DYNAMIC_MEMSTART for 440x
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 14 Nov 2011 11:12:17 +0530
Message-ID: <20111114054200.23410.54075.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
References: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DYNAMIC_MEMSTART(old RELOCATABLE) was restricted only to PPC_47x variants
of 44x. This patch enables DYNAMIC_MEMSTART for 440x based chipsets.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Cc:	Josh Boyer <jwboyer@gmail.com>
Cc:	Kumar Gala <galak@kernel.crashing.org>
Cc:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:	linux ppc dev <linuxppc-dev@lists.ozlabs.org>
---

 arch/powerpc/Kconfig           |    2 +-
 arch/powerpc/kernel/head_44x.S |   12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8d4f789..076782d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -844,7 +844,7 @@ config LOWMEM_CAM_NUM
 
 config DYNAMIC_MEMSTART
 	bool "Enable page aligned dynamic load address for kernel (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && (FSL_BOOKE || PPC_47x)
+	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && (FSL_BOOKE || 44x)
 	help
 	  This option enables the kernel to be loaded at any page aligned
 	  physical address. The kernel creates a mapping from KERNELBASE to 
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index d5f787d..62a4cd5 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -802,12 +802,24 @@ skpinv:	addi	r4,r4,1				/* Increment */
 /*
  * Configure and load pinned entry into TLB slot 63.
  */
+#ifdef CONFIG_DYNAMIC_MEMSTART
+
+	/* Read the XLAT entry for our current mapping */
+	tlbre	r25,r23,PPC44x_TLB_XLAT
+
+	lis	r3,KERNELBASE@h
+	ori	r3,r3,KERNELBASE@l
+
+	/* Use our current RPN entry */
+	mr	r4,r25
+#else
 
 	lis	r3,PAGE_OFFSET@h
 	ori	r3,r3,PAGE_OFFSET@l
 
 	/* Kernel is at the base of RAM */
 	li r4, 0			/* Load the kernel physical address */
+#endif
 
 	/* Load the kernel PID = 0 */
 	li	r0,0
