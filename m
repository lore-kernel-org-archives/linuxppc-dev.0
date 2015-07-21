Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 921131A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 16:59:08 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D39D5140E1E
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 16:59:07 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 12:29:05 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 53B44E0061
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:33:00 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6L6wwad21823730
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6L6wwAC007408
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:58 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, mpe@ellerman.id.au
Subject: [RFC 5/8] powerpc/slb: Add documentation to runtime patching of SLB
 encoding
Date: Tue, 21 Jul 2015 12:28:43 +0530
Message-Id: <1437461926-8908-5-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1437461926-8908-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1437461926-8908-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>

This patch adds some documentation to 'patch_slb_encoding' function
explaining about how it clears the existing immediate value in the
given instruction and inserts a new one there.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index dcba4c2..8083a9e 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -278,7 +278,13 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 static inline void patch_slb_encoding(unsigned int *insn_addr,
 				      unsigned int immed)
 {
-	int insn = (*insn_addr & 0xffff0000) | immed;
+	/*
+	 * Currently this patches only "li" and "cmpldi"
+	 * instructions with an immediate value. Here it
+	 * just clears the existing immediate value from
+	 * the instruction and inserts a new one there.
+	 */
+	unsigned int insn = (*insn_addr & 0xffff0000) | immed;
 	patch_instruction(insn_addr, insn);
 }
 
-- 
2.1.0
