Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22a.google.com (mail-yk0-x22a.google.com
 [IPv6:2607:f8b0:4002:c07::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8E9E1A1D67
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 21:51:55 +1000 (AEST)
Received: by ykay144 with SMTP id y144so38543303yka.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 04:51:54 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/e6500: hw tablewalk: order the memory access when
 acquire/release tcd lock
Date: Thu, 13 Aug 2015 19:51:37 +0800
Message-Id: <1439466697-18989-3-git-send-email-haokexin@gmail.com>
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

I didn't find anything unusual. But I think we do need to order the
load/store of esel_next when acquire/release tcd lock. For acquire,
add a data dependency to order the loads of lock and esel_next.
For release, even there already have a "isync" here, but it doesn't
guarantee any memory access order. So we still need "lwsync" for
the two stores for lock and esel_next.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/mm/tlb_low_64e.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index e4185581c5a7..964754911987 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -334,6 +334,8 @@ BEGIN_FTR_SECTION		/* CPU_FTR_SMT */
 	 * with tlbilx before overwriting.
 	 */
 
+	andi	r15,r15,0	/* add a data dependency to order the loards */
+	add	r11,r11,r15	/* between the lock and esel_next */
 	lbz	r15,TCD_ESEL_NEXT(r11)
 	rlwinm	r10,r15,16,0xff0000
 	oris	r10,r10,MAS0_TLBSEL(1)@h
@@ -447,6 +449,7 @@ BEGIN_FTR_SECTION
 	beq	cr1,1f		/* no unlock if lock was recursively grabbed */
 	li	r15,0
 	isync
+	lwsync
 	stb	r15,0(r11)
 1:
 END_FTR_SECTION_IFSET(CPU_FTR_SMT)
-- 
2.1.0
