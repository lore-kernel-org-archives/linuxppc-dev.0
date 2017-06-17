Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wqNcx5QmXzDqMW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 13:53:21 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id r62so897934qkf.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 20:53:21 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com
Subject: [RFC v2 10/12] powerpc: Read AMR only if pkey-violation caused the
 exception.
Date: Fri, 16 Jun 2017 20:52:42 -0700
Message-Id: <1497671564-20030-11-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 8db9ef8..a4de1b4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -493,13 +493,15 @@ EXC_COMMON_BEGIN(data_access_common)
 	ld	r12,_MSR(r1)
 	ld	r3,PACA_EXGEN+EX_DAR(r13)
 	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
 #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	andis.  r0,r4,DSISR_KEYFAULT@h /* save AMR only if its a key fault */
+	beq+	1f
 	mfspr	r5,SPRN_AMR
 	std	r5,PACA_AMR(r13)
 #endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
-	li	r5,0x300
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
+1:	li	r5,0x300
 BEGIN_MMU_FTR_SECTION
 	b	do_hash_page		/* Try to handle as hpte fault */
 MMU_FTR_SECTION_ELSE
@@ -565,13 +567,15 @@ EXC_COMMON_BEGIN(instruction_access_common)
 	ld	r12,_MSR(r1)
 	ld	r3,_NIP(r1)
 	andis.	r4,r12,0x5820
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
 #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	andis.  r0,r4,DSISR_KEYFAULT@h /* save AMR only if its a key fault */
+	beq+	1f
 	mfspr	r5,SPRN_AMR
 	std	r5,PACA_AMR(r13)
 #endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
-	li	r5,0x400
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
+1:	li	r5,0x400
 BEGIN_MMU_FTR_SECTION
 	b	do_hash_page		/* Try to handle as hpte fault */
 MMU_FTR_SECTION_ELSE
-- 
1.8.3.1
