Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LXQP1z4qzF1RM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 15:19:08 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/xive: Remove now useless pr_debug statements
Date: Wed, 11 Apr 2018 15:18:00 +1000
Message-Id: <20180411051801.30194-2-benh@kernel.crashing.org>
In-Reply-To: <20180411051801.30194-1-benh@kernel.crashing.org>
References: <20180411051801.30194-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Those overly verbose statement in the setup of the pool VP
aren't particularly useful (esp. considering we don't actually
use the pool, we configure it bcs HW requires it only). So
remove them which improves the code readability.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/xive/native.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index b48454be5b98..c7088a35eb89 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -395,7 +395,6 @@ static void xive_native_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
 
 	/* Enable the pool VP */
 	vp = xive_pool_vps + cpu;
-	pr_debug("CPU %d setting up pool VP 0x%x\n", cpu, vp);
 	for (;;) {
 		rc = opal_xive_set_vp_info(vp, OPAL_XIVE_VP_ENABLED, 0);
 		if (rc != OPAL_BUSY)
@@ -415,16 +414,9 @@ static void xive_native_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
 	}
 	vp_cam = be64_to_cpu(vp_cam_be);
 
-	pr_debug("VP CAM = %llx\n", vp_cam);
-
 	/* Push it on the CPU (set LSMFB to 0xff to skip backlog scan) */
-	pr_debug("(Old HW value: %08x)\n",
-		 in_be32(xive_tima + TM_QW2_HV_POOL + TM_WORD2));
 	out_be32(xive_tima + TM_QW2_HV_POOL + TM_WORD0, 0xff);
-	out_be32(xive_tima + TM_QW2_HV_POOL + TM_WORD2,
-		 TM_QW2W2_VP | vp_cam);
-	pr_debug("(New HW value: %08x)\n",
-		 in_be32(xive_tima + TM_QW2_HV_POOL + TM_WORD2));
+	out_be32(xive_tima + TM_QW2_HV_POOL + TM_WORD2, TM_QW2W2_VP | vp_cam);
 }
 
 static void xive_native_teardown_cpu(unsigned int cpu, struct xive_cpu *xc)
-- 
2.14.3
