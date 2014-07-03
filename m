Return-Path: <joel@jms.id.au>
Received: from mail-pd0-x232.google.com (mail-pd0-x232.google.com
 [IPv6:2607:f8b0:400e:c02::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 534851A000B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 16:12:52 +1000 (EST)
Received: by mail-pd0-f178.google.com with SMTP id r10so13367015pdi.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Jul 2014 23:12:50 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: paulus@samba.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 1/3] powerpc/kvm: Remove redundant save of SIER AND MMCR2
Date: Thu,  3 Jul 2014 15:42:34 +0930
Message-Id: <1404367956-19515-2-git-send-email-joel@jms.id.au>
In-Reply-To: <1404367956-19515-1-git-send-email-joel@jms.id.au>
References: <1404367956-19515-1-git-send-email-joel@jms.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These two registers are already saved in the block above. Aside from
being unnecessary, by the time we get down to the second save location
r8 no longer contains MMCR2, so we are clobbering the saved value with
PMC5.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/kvm/book3s_hv_interrupts.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index 8c86422..731be74 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -127,11 +127,6 @@ BEGIN_FTR_SECTION
 	stw	r10, HSTATE_PMC + 24(r13)
 	stw	r11, HSTATE_PMC + 28(r13)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
-BEGIN_FTR_SECTION
-	mfspr	r9, SPRN_SIER
-	std	r8, HSTATE_MMCR + 40(r13)
-	std	r9, HSTATE_MMCR + 48(r13)
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 31:
 
 	/*
-- 
2.0.0
