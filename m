Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3E301A1A37
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 17:10:33 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2A1F0140E31
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 17:10:32 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 12:40:29 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 594D63940081
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:11 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6T7A9FT53215258
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:10 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6T7A6SL001222
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH 5/8] powerpc/slb: Add documentation to runtime patching of SLB
 encoding
Date: Wed, 29 Jul 2015 12:40:02 +0530
Message-Id: <1438153805-31828-5-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds some documentation to 'patch_slb_encoding' function
explaining about how it clears the existing immediate value in the
given instruction and inserts a new one there.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index c87d5de..1962357 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -279,7 +279,18 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 static inline void patch_slb_encoding(unsigned int *insn_addr,
 				      unsigned int immed)
 {
-	int insn = (*insn_addr & 0xffff0000) | immed;
+
+	/*
+	 * This function patches either an li or a cmpldi instruction with
+	 * a new immediate value. This relies on the fact that both li
+	 * (which is actually addi) and cmpldi both take a 16-bit immediate
+	 * value, and it is situated in the same location in the instruction,
+	 * ie. bits 16-31 (Big endian bit order) or the lower 16 bits.
+	 * To patch the value we read the existing instruction, clear the
+	 * immediate value, and or in our new value, then write the instruction
+	 * back.
+	 */
+	unsigned int insn = (*insn_addr & 0xffff0000) | immed;
 	patch_instruction(insn_addr, insn);
 }
 
-- 
2.1.0
