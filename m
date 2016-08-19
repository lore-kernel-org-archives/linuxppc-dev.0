Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFxYz0ZX2zDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 18:52:54 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7J8nB2P015401
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 04:52:53 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24wpddg1mr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 04:52:52 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 04:52:51 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 1/5] powerpc/64/kexec: NULL check "clear_all" in
 kexec_sequence
Date: Fri, 19 Aug 2016 14:22:35 +0530
In-Reply-To: <1471596759-3396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1471596759-3396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1471596759-3396-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

With Radix, it can be NULL even on !BOOKE these days so replace
the ifdef with a NULL check which is cleaner anyway.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/misc_64.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index cb195157b318..7902f4b12d3f 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -659,7 +659,9 @@ _GLOBAL(kexec_sequence)
 	li	r6,1
 	stw	r6,kexec_flag-1b(5)
 
-#ifndef CONFIG_PPC_BOOK3E
+	cmpdi	r27,0
+	beq	1f
+
 	/* clear out hardware hash page table and tlb */
 #ifdef PPC64_ELF_ABI_v1
 	ld	r12,0(r27)		/* deref function descriptor */
@@ -668,7 +670,6 @@ _GLOBAL(kexec_sequence)
 #endif
 	mtctr	r12
 	bctrl				/* mmu_hash_ops.hpte_clear_all(void); */
-#endif /* !CONFIG_PPC_BOOK3E */
 
 /*
  *   kexec image calling is:
@@ -695,7 +696,7 @@ _GLOBAL(kexec_sequence)
  *    are the boot cpu ?????
  *    other device tree differences (prop sizes, va vs pa, etc)...
  */
-	mr	r3,r25	# my phys cpu
+1:	mr	r3,r25	# my phys cpu
 	mr	r4,r30	# start, aka phys mem offset
 	mtlr	4
 	li	r5,0
-- 
2.7.4
