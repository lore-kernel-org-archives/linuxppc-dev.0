Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC1D31A06FF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 May 2014 08:46:03 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/booke64: wrap tlb lock and search in htw miss with
 FTR_SMT
Date: Fri, 30 May 2014 17:45:46 -0500
Message-ID: <1401489946-12935-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>

Virtualized environments may expose a e6500 dual-threaded core
as two single-threaded e6500 cores. Take advantage of this
and get rid of the tlb lock and the trap-causing tlbsx in
the htw miss handler by guarding with CPU_FTR_SMT, as it's
already being done in the bolted tlb1 miss handler.

As seen in the results below, measurements done with lmbench
random memory access latency test running under Freescale's
Embedded Hypervisor, there is a ~34% improvement.

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
----------------------------------------------------
Host       Mhz   L1 $   L2 $    Main mem    Rand mem
---------  ---   ----   ----    --------    --------
smt       1665 1.8020   13.2    83.0         1149.7
nosmt     1665 1.8020   13.2    83.0          758.1

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
[scottwood@freescale.com: commit message tweak]
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2:
 - s/expose/may expose/ in commit message
 - rebased onto my patch queue to resolve conflict
 - resent since the original didn't make it to the list archives
   or patchwork.

 arch/powerpc/mm/tlb_low_64e.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 131f1f4..57c4d66 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -299,6 +299,7 @@ itlb_miss_fault_bolted:
  * r10 = crap (free to use)
  */
 tlb_miss_common_e6500:
+BEGIN_FTR_SECTION
 	/*
 	 * Search if we already have an indirect entry for that virtual
 	 * address, and if we do, bail out.
@@ -333,6 +334,7 @@ tlb_miss_common_e6500:
 
 	andis.	r10,r10,MAS1_VALID@h
 	bne	tlb_miss_done_e6500
+END_FTR_SECTION_IFSET(CPU_FTR_SMT)
 
 	/* Now, we need to walk the page tables. First check if we are in
 	 * range.
@@ -393,11 +395,13 @@ tlb_miss_common_e6500:
 
 tlb_miss_done_e6500:
 	.macro	tlb_unlock_e6500
+BEGIN_FTR_SECTION
 	beq	cr1,1f		/* no unlock if lock was recursively grabbed */
 	li	r15,0
 	isync
 	stb	r15,0(r11)
 1:
+END_FTR_SECTION_IFSET(CPU_FTR_SMT)
 	.endm
 
 	tlb_unlock_e6500
-- 
1.9.1
