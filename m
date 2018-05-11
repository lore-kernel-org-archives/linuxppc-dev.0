Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40j2fH1QyZzF2Fd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 18:03:32 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH] powerpc/xive: Remove (almost) unused macros
Date: Fri, 11 May 2018 18:03:13 +1000
Message-Id: <20180511080313.29815-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The GETFIELD and SETFIELD macros in xive-regs.h aren't used except for a
single instance of GETFIELD, so replace that and remove them.

These macros are also defined in vas.h, so either those should be
eventually replaced or the macros moved into bitops.h.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/include/asm/xive-regs.h | 6 ------
 arch/powerpc/sysdev/xive/native.c    | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/xive-regs.h b/arch/powerpc/include/asm/xive-regs.h
index fa4288822b68..6de989f8defd 100644
--- a/arch/powerpc/include/asm/xive-regs.h
+++ b/arch/powerpc/include/asm/xive-regs.h
@@ -123,10 +123,4 @@
 #define TM_QW3_NSR_I		PPC_BIT8(2)
 #define TM_QW3_NSR_GRP_LVL	PPC_BIT8(3,7)
 
-/* Utilities to manipulate these (originaly from OPAL) */
-#define MASK_TO_LSH(m)		(__builtin_ffsl(m) - 1)
-#define GETFIELD(m, v)		(((v) & (m)) >> MASK_TO_LSH(m))
-#define SETFIELD(m, v, val)				\
-	(((v) & ~(m)) |	((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
-
 #endif /* _ASM_POWERPC_XIVE_REGS_H */
diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index b48454be5b98..3b471c0193ca 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -341,7 +341,7 @@ static void xive_native_update_pending(struct xive_cpu *xc)
 	 * of the hypervisor interrupt (if any)
 	 */
 	cppr = ack & 0xff;
-	he = GETFIELD(TM_QW3_NSR_HE, (ack >> 8));
+	he = ((ack >> 8) & TM_QW3_NSR_HE) >> (ffs(TM_QW3_NSR_HE) - 1);
 	switch(he) {
 	case TM_QW3_NSR_HE_NONE: /* Nothing to see here */
 		break;
-- 
2.17.0
