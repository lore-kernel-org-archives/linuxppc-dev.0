Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9Ndd48j6zDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 17:55:01 +1000 (AEST)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:24:54 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7A9731258066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:27:02 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J7sm3021692522
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:24:48 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J7sjxs031576
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:24:47 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/6] powerpc/mm/radix: Update PID switch sequence
Date: Thu, 19 May 2016 13:24:28 +0530
Message-Id: <1463644472-10158-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1463644472-10158-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1463644472-10158-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the PID switch as per ISA doc. slbia is needed in radix to
invalidate any implementation specific lookaside information

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mmu_context_book3s64.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 227b2a6c4544..565f1b1da33b 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -181,7 +181,10 @@ void destroy_context(struct mm_struct *mm)
 #ifdef CONFIG_PPC_RADIX_MMU
 void radix__switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 {
-	mtspr(SPRN_PID, next->context.id);
 	asm volatile("isync": : :"memory");
+	mtspr(SPRN_PID, next->context.id);
+	asm volatile("isync \n"
+		     "slbia 0x7 \n"
+		     : : :"memory");
 }
 #endif
-- 
2.7.4
