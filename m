Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D8C8100850
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 04:10:03 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
Subject: [PATCH 04/10] 8xx: Always pin kernel instruction TLB
Date: Sun, 15 Nov 2009 18:09:31 +0100
Message-Id: <1258304977-11760-5-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1258304977-11760-4-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1258304977-11760-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258304977-11760-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258304977-11760-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258304977-11760-4-git-send-email-Joakim.Tjernlund@transmode.se>
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
 arch/powerpc/kernel/head_8xx.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index a9f1ace..e70503d 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -705,7 +705,7 @@ start_here:
  */
 initial_mmu:
 	tlbia			/* Invalidate all TLB entries */
-#ifdef CONFIG_PIN_TLB
+#if 1 /* CONFIG_PIN_TLB */
 	lis	r8, MI_RSV4I@h
 	ori	r8, r8, 0x1c00
 #else
-- 
1.6.4.4
