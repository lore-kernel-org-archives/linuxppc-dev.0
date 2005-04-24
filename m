Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB65B67B21
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Apr 2005 07:31:00 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1DPogx-0004ji-Nj@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Sun, 24 Apr 2005 22:31:03 +0100
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc trivial iomem annotations: pmac_smp.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc3-pmac_time/arch/ppc/platforms/pmac_smp.c RC12-rc3-pmac_smp/arch/ppc/platforms/pmac_smp.c
--- RC12-rc3-pmac_time/arch/ppc/platforms/pmac_smp.c	Wed Apr 20 21:25:28 2005
+++ RC12-rc3-pmac_smp/arch/ppc/platforms/pmac_smp.c	Sun Apr 24 16:20:04 2005
@@ -91,11 +91,11 @@
 #define PSURGE_QUAD_BIC(r, v)	(PSURGE_QUAD_OUT((r), PSURGE_QUAD_IN(r) & ~(v)))
 
 /* virtual addresses for the above */
-static volatile u8 *hhead_base;
-static volatile u8 *quad_base;
-static volatile u32 *psurge_pri_intr;
-static volatile u8 *psurge_sec_intr;
-static volatile u32 *psurge_start;
+static volatile u8 __iomem *hhead_base;
+static volatile u8 __iomem *quad_base;
+static volatile u32 __iomem *psurge_pri_intr;
+static volatile u8 __iomem *psurge_sec_intr;
+static volatile u32 __iomem *psurge_start;
 
 /* values for psurge_type */
 #define PSURGE_NONE		-1
@@ -322,10 +322,10 @@
 		/* All released cards using this HW design have 4 CPUs */
 		ncpus = 4;
 	} else {
-		iounmap((void *) quad_base);
+		iounmap(quad_base);
 		if ((in_8(hhead_base + HHEAD_CONFIG) & 0x02) == 0) {
 			/* not a dual-cpu card */
-			iounmap((void *) hhead_base);
+			iounmap(hhead_base);
 			psurge_type = PSURGE_NONE;
 			return 1;
 		}
