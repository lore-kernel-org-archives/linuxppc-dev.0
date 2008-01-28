Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5FF49DDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 06:26:41 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0SJQZCE029786
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 13:26:36 -0600
Date: Mon, 28 Jan 2008 13:24:08 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 85xx: Only invalidate TLB0 and TLB1
Message-ID: <Pine.LNX.4.64.0801281323530.25254@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All current 85xx/e500 implementations only have two TLB
arrays.  We are wasting cycles by invalidating TLB2 and TLB3.

---
 arch/powerpc/kernel/misc_32.S |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index be09f0d..5c2e253 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -275,12 +275,6 @@ _GLOBAL(_tlbia)
 	/* Invalidate all entries in TLB1 */
 	li	r3, 0x0c
 	tlbivax	0,3
-	/* Invalidate all entries in TLB2 */
-	li	r3, 0x14
-	tlbivax	0,3
-	/* Invalidate all entries in TLB3 */
-	li	r3, 0x1c
-	tlbivax	0,3
 	msync
 #ifdef CONFIG_SMP
 	tlbsync
@@ -375,12 +369,8 @@ _GLOBAL(_tlbie)
 #elif defined(CONFIG_FSL_BOOKE)
 	rlwinm	r4, r3, 0, 0, 19
 	ori	r5, r4, 0x08	/* TLBSEL = 1 */
-	ori	r6, r4, 0x10	/* TLBSEL = 2 */
-	ori	r7, r4, 0x18	/* TLBSEL = 3 */
 	tlbivax	0, r4
 	tlbivax	0, r5
-	tlbivax	0, r6
-	tlbivax	0, r7
 	msync
 #if defined(CONFIG_SMP)
 	tlbsync
-- 
1.5.3.7
