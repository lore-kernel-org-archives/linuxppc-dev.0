Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0829E1A03F1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 09:11:14 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/e6500: hw tablewalk: fix recursive tlb lock on cpu
 0
Date: Thu, 29 May 2014 18:10:34 -0500
Message-ID: <1401405034-27571-1-git-send-email-scottwood@freescale.com>
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

Commit 82d86de25b9c99db546e17c6f7ebf9a691da557e "TLB lock recursive"
introduced a bug whereby cpu 0 uses the same value for "lock held" as
is used to indicate that the lock is free.  This means that cpu 1 can
acquire the lock whenever it wants, regardless of whether cpu 0 has it
locked, which in turn means we can get duplicate TLB entries.

Add one to the CPU value to ensure we do not use zero as a "lock held"
value.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Reported-by: Ed Swarthout <ed.swarthout@freescale.com>
---
v2: The comment on r10 was wrong before (since we don't set r10
until after entry), and it's even more wrong now that we add one
to the cpu number.  Also added Reported-by.

 arch/powerpc/mm/tlb_low_64e.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 3298d10..131f1f4 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -296,7 +296,7 @@ itlb_miss_fault_bolted:
  * r14 = page table base
  * r13 = PACA
  * r11 = tlb_per_core ptr
- * r10 = cpu number
+ * r10 = crap (free to use)
  */
 tlb_miss_common_e6500:
 	/*
@@ -309,6 +309,7 @@ tlb_miss_common_e6500:
 	lhz	r10,PACAPACAINDEX(r13)
 	cmpdi	r15,0
 	cmpdi	cr1,r15,1	/* set cr1.eq = 0 for non-recursive */
+	addi	r10,r10,1
 	bne	2f
 	stbcx.	r10,0,r11
 	bne	1b
-- 
1.9.1
