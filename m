Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E777D1A0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 07:45:27 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/e6500: hw tablewalk: fix recursive tlb lock on
 cpu 0
Date: Thu, 22 May 2014 16:45:01 -0500
Message-ID: <1400795101-8737-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1400795101-8737-1-git-send-email-scottwood@freescale.com>
References: <1400795101-8737-1-git-send-email-scottwood@freescale.com>
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
---
 arch/powerpc/mm/tlb_low_64e.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 3298d10..ba3ba3c 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
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
