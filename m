Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F51CB755D
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 08:38:26 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 12/13] 8xx: Optimize ITLBMiss handler.
Date: Mon, 10 Jan 2011 22:37:58 +0100
Message-Id: <1294695479-344-13-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Don't check for kernel space if no modules.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 43bccb1..5dbbdb4 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -347,12 +347,17 @@ InstructionTLBMiss:
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
+#ifdef CONFIG_MODULES
+	/* Since we PIN the first 8MB text, we only get ITLB misses
+	 * for modules
+	 */
 	andi.	r21, r20, 0x0800	/* Address >= 0x80000000 */
 	beq	3f
 	lis	r21, swapper_pg_dir@h
 	ori	r21, r21, swapper_pg_dir@l
 	rlwimi	r20, r21, 0, 2, 19
 3:
+#endif
 	lwz	r21, 0(r20)	/* Get the level 1 entry */
 	rlwinm.	r20, r21,0,0,19	/* Extract page descriptor page address */
 
-- 
1.7.3.4
