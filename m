Return-Path: <galak@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id A302867B59
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Jun 2005 09:56:50 +1000 (EST)
Date: Fri, 3 Jun 2005 18:56:35 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Linus Torvalds <torvalds@osdl.org>
Message-ID: <Pine.LNX.4.61.0506031850590.13301@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Fix incorrect CPU_FTR fixup usage for unified caches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(This fixes a bug and should go into 2.6.12 if possible.)

ppc32: Fix incorrect CPU_FTR fixup usage for unified caches

Runtime feature support for unified caches was testing a userland feature
flag (PPC_FEATURE_UNIFIED_CACHE) instead of a cpu feature flag
(CPU_FTR_SPLIT_ID_CACHE).  Luckily the current defined bit mask for cpu
features and userland features do not overlap so this only causes an issue on
machines with a unified cache, which is extremely rare on PPC today.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 5366c2d4a4190a10bd39f383647c933db5d3a090
tree cd28d190cf8742bb01c13c02f4199db217298ca4
parent 22774efc1bef9f9a0fd9b34d44bf10da787e3d91
author Kumar K. Gala <kumar.gala@freescale.com> Fri, 03 Jun 2005 18:45:19 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 03 Jun 2005 18:45:19 -0500

 arch/ppc/kernel/misc.S |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -619,7 +619,7 @@ _GLOBAL(flush_instruction_cache)
 _GLOBAL(flush_icache_range)
 BEGIN_FTR_SECTION
 	blr				/* for 601, do nothing */
-END_FTR_SECTION_IFSET(PPC_FEATURE_UNIFIED_CACHE)
+END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
 	li	r5,L1_CACHE_LINE_SIZE-1
 	andc	r3,r3,r5
 	subf	r4,r3,r4
@@ -736,7 +736,7 @@ _GLOBAL(flush_dcache_all)
 _GLOBAL(__flush_dcache_icache)
 BEGIN_FTR_SECTION
 	blr					/* for 601, do nothing */
-END_FTR_SECTION_IFSET(PPC_FEATURE_UNIFIED_CACHE)
+END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
 	rlwinm	r3,r3,0,0,19			/* Get page base address */
 	li	r4,4096/L1_CACHE_LINE_SIZE	/* Number of lines in a page */
 	mtctr	r4
@@ -764,7 +764,7 @@ END_FTR_SECTION_IFSET(PPC_FEATURE_UNIFIE
 _GLOBAL(__flush_dcache_icache_phys)
 BEGIN_FTR_SECTION
 	blr					/* for 601, do nothing */
-END_FTR_SECTION_IFSET(PPC_FEATURE_UNIFIED_CACHE)
+END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
 	mfmsr	r10
 	rlwinm	r0,r10,0,28,26			/* clear DR */
 	mtmsr	r0
