Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDHB6ry3zDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:36:22 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YELG074942
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:21 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2448qmtjcq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:21 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:36:20 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 08/12] powerpc/mm/radix: Update PID switch sequence
Date: Wed, 13 Jul 2016 15:05:27 +0530
In-Reply-To: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1468402531-4914-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the PID switch as per ISA doc. slbia is needed in radix to
invalidate any implementation specific lookaside information.
We use the .long format due to build errors with the below compiler
version.

gcc (Ubuntu 5.3.1-14ubuntu2.1) 5.3.1 20160413
GNU assembler (GNU Binutils for Ubuntu) 2.26

CC      arch/powerpc/mm//mmu_context_book3s64.o
{standard input}: Assembler messages:
{standard input}:506: Error: junk at end of line: `0x7'
scripts/Makefile.build:291: recipe for target 'arch/powerpc/mm//mmu_context_book3s64.o' failed
make[1]: *** [arch/powerpc/mm//mmu_context_book3s64.o] Error 1
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h  | 3 +++
 arch/powerpc/mm/mmu_context_book3s64.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 1c9b1d4386ba..27b81302fb36 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -181,6 +181,7 @@
 #define PPC_INST_MTSPR_DSCR_USER	0x7c0303a6
 #define PPC_INST_MTSPR_DSCR_USER_MASK	0xfc1fffff
 #define PPC_INST_SLBFEE			0x7c0007a7
+#define PPC_INST_SLBIA			0x7c0003e4
 
 #define PPC_INST_STRING			0x7c00042a
 #define PPC_INST_STRING_MASK		0xfc0007fe
@@ -438,5 +439,7 @@
 					       ___PPC_RA(a) |		\
 					       ___PPC_RB(b))
 
+#define PPC_SLBIA(IH)	stringify_in_c(.long PPC_INST_SLBIA | \
+				       ((IH & 0x7) << 21))
 
 #endif /* _ASM_POWERPC_PPC_OPCODE_H */
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 196222227e82..b114f8b93ec9 100644
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
+		     PPC_SLBIA(0x7)
+		     : : :"memory");
 }
 #endif
-- 
2.7.4
