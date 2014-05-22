Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21AE71A0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 07:45:26 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/e6500: hw tablewalk: clear TID in kernel indirect
 entries
Date: Thu, 22 May 2014 16:45:00 -0500
Message-ID: <1400795101-8737-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously TID was being cleared before the tlbsx, but not after.  This
can lead to a multiway hit between a TLB entry with TID=0 (previously
inserted when PID=0) and a TLB entry with TID!=0 that matches PID.
This can theoretically result in undefined behavior, though we probably
get lucky due to the details of the overlap.  It also results in the
inability to use multihit detection to detect other conflicting TLB
entries, as well as poorer TLB utilization due to duplicating kernel
TLB entries.

Rather than try to patch up MAS1 after tlbsx, the entire value is
saved/restored as with MAS2.

I observed a slight improvement in TLB miss performance with this patch
applied.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Reported-by: Ed Swarthout <ed.swarthout@freescale.com>
---
 arch/powerpc/mm/tlb_low_64e.S | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 356e8b4..3298d10 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -322,19 +322,17 @@ tlb_miss_common_e6500:
 	b	1b
 	.previous
 
-	mfspr	r15,SPRN_MAS2
+	mfspr	r15,SPRN_MAS1
+	mfspr	r10,SPRN_MAS2
 
 	tlbsx	0,r16
+	mtspr	SPRN_MAS2,r10
 	mfspr	r10,SPRN_MAS1
+	mtspr	SPRN_MAS1,r15
+
 	andis.	r10,r10,MAS1_VALID@h
 	bne	tlb_miss_done_e6500
 
-	/* Undo MAS-damage from the tlbsx */
-	mfspr	r10,SPRN_MAS1
-	oris	r10,r10,MAS1_VALID@h
-	mtspr	SPRN_MAS1,r10
-	mtspr	SPRN_MAS2,r15
-
 	/* Now, we need to walk the page tables. First check if we are in
 	 * range.
 	 */
-- 
1.9.1
