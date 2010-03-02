Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06EC3B7D42
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 02:37:22 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
Subject: [PATCH 2/4] 8xx: Avoid testing for kernel space in ITLB Miss.
Date: Tue, 2 Mar 2010 16:37:10 +0100
Message-Id: <1267544232-14784-3-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1267544232-14784-2-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1267544232-14784-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267544232-14784-2-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only modules will cause ITLB Misses as we always pin
the first 8MB of kernel memory.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/kernel/head_8xx.S |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index ecc4a02..84ca1d9 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -318,12 +318,16 @@ InstructionTLBMiss:
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
+#ifdef CONFIG_MODULES
+	/* Only modules will cause ITLB Misses as we always
+	 * pin the first 8MB of kernel memory */
 	andi.	r11, r10, 0x0800	/* Address >= 0x80000000 */
 	beq	3f
 	lis	r11, swapper_pg_dir@h
 	ori	r11, r11, swapper_pg_dir@l
 	rlwimi	r10, r11, 0, 2, 19
 3:
+#endif
 	lwz	r11, 0(r10)	/* Get the level 1 entry */
 	rlwinm.	r10, r11,0,0,19	/* Extract page descriptor page address */
 	beq	2f		/* If zero, don't try to find a pte */
-- 
1.6.4.4
