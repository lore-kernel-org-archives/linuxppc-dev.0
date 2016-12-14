Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tf1wp3zWPzDw1T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 03:19:06 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBEGEEeY009858
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 11:19:04 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27b5w17nhn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 11:19:03 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Thu, 15 Dec 2016 02:19:00 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 13A832BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 03:18:59 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBEGIwAF52232270
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 03:18:58 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBEGIw1x031467
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 03:18:58 +1100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com, mhiramat@kernel.org,
 anju@linux.vnet.ibm.com
Subject: [PATCH V2 2/4] powerpc: add helper to check if offset is within rel
 branch range
Date: Wed, 14 Dec 2016 21:48:30 +0530
In-Reply-To: <1481732310-7779-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1481732310-7779-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1481732310-7779-5-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/code-patching.h |  1 +
 arch/powerpc/lib/code-patching.c         | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 2015b07..75ee4f4 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -22,6 +22,7 @@
 #define BRANCH_SET_LINK	0x1
 #define BRANCH_ABSOLUTE	0x2
 
+bool is_offset_in_branch_range(long offset);
 unsigned int create_branch(const unsigned int *addr,
 			   unsigned long target, int flags);
 unsigned int create_cond_branch(const unsigned int *addr,
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index d5edbeb..f643451 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -32,6 +32,28 @@ int patch_branch(unsigned int *addr, unsigned long target, int flags)
 	return patch_instruction(addr, create_branch(addr, target, flags));
 }
 
+bool is_offset_in_branch_range(long offset)
+{
+	/*
+	 * Powerpc branch instruction is :
+	 *
+	 *  0         6                 30   31
+	 *  +---------+----------------+---+---+
+	 *  | opcode  |     LI         |AA |LK |
+	 *  +---------+----------------+---+---+
+	 *  Where AA = 0 and LK = 0
+	 *
+	 * LI is a signed 24 bits integer. The real branch offset is computed
+	 * by: imm32 = SignExtend(LI:'0b00', 32);
+	 *
+	 * So the maximum forward branch should be:
+	 *   (0x007fffff << 2) = 0x01fffffc =  0x1fffffc
+	 * The maximum backward branch should be:
+	 *   (0xff800000 << 2) = 0xfe000000 = -0x2000000
+	 */
+	return (offset >= -0x2000000 && offset <= 0x1fffffc && !(offset & 0x3));
+}
+
 unsigned int create_branch(const unsigned int *addr,
 			   unsigned long target, int flags)
 {
@@ -43,7 +65,7 @@ unsigned int create_branch(const unsigned int *addr,
 		offset = offset - (unsigned long)addr;
 
 	/* Check we can represent the target in the instruction format */
-	if (offset < -0x2000000 || offset > 0x1fffffc || offset & 0x3)
+	if (!is_offset_in_branch_range(offset))
 		return 0;
 
 	/* Mask out the flags and target, so they don't step on each other. */
-- 
2.7.4
