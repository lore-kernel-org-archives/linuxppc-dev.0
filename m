Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x231.google.com (mail-yk0-x231.google.com
 [IPv6:2607:f8b0:4002:c07::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 025171A1D59
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 21:51:54 +1000 (AEST)
Received: by ykay144 with SMTP id y144so38542628yka.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 04:51:51 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/e6500: hw tablewalk: optimize a bit for tcd lock
 acquiring codes
Date: Thu, 13 Aug 2015 19:51:36 +0800
Message-Id: <1439466697-18989-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1439466697-18989-1-git-send-email-haokexin@gmail.com>
References: <1439466697-18989-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It makes no sense to put the instructions for calculating the lock
value (cpu number + 1) and the clearing of eq bit of cr1 in lbarx/stbcx
loop. And when the lock is acquired by the other thread, the current
lock value has no chance to equal with the lock value used by current
cpu. So we can skip the comparing for these two lock values in the
lbz/bne loop.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/mm/tlb_low_64e.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 765b419883f2..e4185581c5a7 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -308,11 +308,11 @@ BEGIN_FTR_SECTION		/* CPU_FTR_SMT */
 	 *
 	 * MAS6:IND should be already set based on MAS4
 	 */
-1:	lbarx	r15,0,r11
 	lhz	r10,PACAPACAINDEX(r13)
-	cmpdi	r15,0
-	cmpdi	cr1,r15,1	/* set cr1.eq = 0 for non-recursive */
 	addi	r10,r10,1
+	crclr	cr1*4+eq	/* set cr1.eq = 0 for non-recursive */
+1:	lbarx	r15,0,r11
+	cmpdi	r15,0
 	bne	2f
 	stbcx.	r10,0,r11
 	bne	1b
@@ -320,9 +320,9 @@ BEGIN_FTR_SECTION		/* CPU_FTR_SMT */
 	.subsection 1
 2:	cmpd	cr1,r15,r10	/* recursive lock due to mcheck/crit/etc? */
 	beq	cr1,3b		/* unlock will happen if cr1.eq = 0 */
-	lbz	r15,0(r11)
+10:	lbz	r15,0(r11)
 	cmpdi	r15,0
-	bne	2b
+	bne	10b
 	b	1b
 	.previous
 
-- 
2.1.0
