Return-Path: <B35336@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 873E72C04B4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 20:48:37 +1000 (EST)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 13/15] powerpc/85xx: add support for e6500 L1 cache
 operation
Date: Fri, 19 Apr 2013 18:47:46 +0800
Message-ID: <1366368468-29143-13-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1366368468-29143-1-git-send-email-chenhui.zhao@freescale.com>
References: <1366368468-29143-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Chen-Hui Zhao <chenhui.zhao@freescale.com>

The L1 Data Cache of e6500 contains no modified data, no flush
is required.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/kernel/fsl_booke_cache.S |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/fsl_booke_cache.S b/arch/powerpc/kernel/fsl_booke_cache.S
index 232c47b..24a52bb 100644
--- a/arch/powerpc/kernel/fsl_booke_cache.S
+++ b/arch/powerpc/kernel/fsl_booke_cache.S
@@ -65,13 +65,22 @@ _GLOBAL(flush_dcache_L1)
 
 	blr
 
+#define PVR_E6500	0x8040
+
 /* Flush L1 d-cache, invalidate and disable d-cache and i-cache */
 _GLOBAL(__flush_disable_L1)
+/* L1 Data Cache of e6500 contains no modified data, no flush is required */
+	mfspr	r3, SPRN_PVR
+	rlwinm	r4, r3, 16, 0xffff
+	lis	r5, 0
+	ori	r5, r5, PVR_E6500@l
+	cmpw	r4, r5
+	beq	2f
 	mflr	r10
 	bl	flush_dcache_L1	/* Flush L1 d-cache */
 	mtlr	r10
 
-	msync
+2:	msync
 	mfspr	r4, SPRN_L1CSR0	/* Invalidate and disable d-cache */
 	li	r5, 2
 	rlwimi	r4, r5, 0, 3
-- 
1.7.3
