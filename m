Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F32A1B735E
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 08:38:17 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 06/13] 8xx: Always pin kernel instruction TLB
Date: Mon, 10 Jan 2011 22:37:52 +0100
Message-Id: <1294695479-344-7-git-send-email-Joakim.Tjernlund@transmode.se>
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

Various kernel asm modifies SRR0/SRR1 just before executing
a rfi. If such code crosses a page boundary you risk a TLB miss
which will clobber SRR0/SRR1. Avoid this by always pinning
kernel instruction TLB space.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 9eb383b..d992c24 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -777,12 +777,13 @@ start_here:
  */
 initial_mmu:
 	tlbia			/* Invalidate all TLB entries */
-#ifdef CONFIG_PIN_TLB
+
+/* Always pin the first 8 MB ITLB to prevent ITLB
+   misses while mucking around with SRR0/SRR1 in asm
+*/
 	lis	r8, MI_RSV4I@h
 	ori	r8, r8, 0x1c00
-#else
-	li	r8, 0
-#endif
+
 	mtspr	MI_CTR, r8	/* Set instruction MMU control */
 
 #ifdef CONFIG_PIN_TLB
-- 
1.7.3.4
