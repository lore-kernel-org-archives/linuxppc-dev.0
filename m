Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C58182C0B15
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 18:29:23 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Jul 2012 09:01:45 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6586wij21037302
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jul 2012 18:06:58 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q658EgFX026950
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jul 2012 18:14:42 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 9/9] arch/powerpc: Add 64TB support
Date: Thu,  5 Jul 2012 13:44:18 +0530
Message-Id: <1341476058-5405-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1341476058-5405-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1341476058-5405-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Increase max addressable range to 64TB. This is not tested on
real hardware yet.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h        |    8 ++++----
 arch/powerpc/include/asm/pgtable-ppc64-4k.h  |    2 +-
 arch/powerpc/include/asm/pgtable-ppc64-64k.h |    2 +-
 arch/powerpc/include/asm/processor.h         |    4 ++--
 arch/powerpc/include/asm/sparsemem.h         |    4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 52691e8..714f591 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -372,16 +372,16 @@ extern void slb_set_size(u16 size);
  */
 
 #define VSID_MULTIPLIER_256M	ASM_CONST(200730139)	/* 28-bit prime */
-#define VSID_BITS_256M		36
+#define VSID_BITS_256M		38
 #define VSID_MODULUS_256M	((1UL<<VSID_BITS_256M)-1)
 
 #define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */
-#define VSID_BITS_1T		24
+#define VSID_BITS_1T		26
 #define VSID_MODULUS_1T		((1UL<<VSID_BITS_1T)-1)
 
 #define CONTEXT_BITS		19
-#define USER_ESID_BITS		16
-#define USER_ESID_BITS_1T	4
+#define USER_ESID_BITS		18
+#define USER_ESID_BITS_1T	6
 
 #define USER_VSID_RANGE	(1UL << (USER_ESID_BITS + SID_SHIFT))
 
diff --git a/arch/powerpc/include/asm/pgtable-ppc64-4k.h b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
index 6eefdcf..b3eccf2 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64-4k.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
@@ -7,7 +7,7 @@
  */
 #define PTE_INDEX_SIZE  9
 #define PMD_INDEX_SIZE  7
-#define PUD_INDEX_SIZE  7
+#define PUD_INDEX_SIZE  9
 #define PGD_INDEX_SIZE  9
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/include/asm/pgtable-ppc64-64k.h b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
index 90533dd..be4e287 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64-64k.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
@@ -7,7 +7,7 @@
 #define PTE_INDEX_SIZE  12
 #define PMD_INDEX_SIZE  12
 #define PUD_INDEX_SIZE	0
-#define PGD_INDEX_SIZE  4
+#define PGD_INDEX_SIZE  6
 
 #ifndef __ASSEMBLY__
 #define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 413a5ea..ac3861b 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -97,8 +97,8 @@ extern struct task_struct *last_task_used_spe;
 #endif
 
 #ifdef CONFIG_PPC64
-/* 64-bit user address space is 44-bits (16TB user VM) */
-#define TASK_SIZE_USER64 (0x0000100000000000UL)
+/* 64-bit user address space is 46-bits (64TB user VM) */
+#define TASK_SIZE_USER64 (0x0000400000000000UL)
 
 /* 
  * 32-bit user address space is 4GB - 1 page 
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index 0c5fa31..f6fc0ee 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -10,8 +10,8 @@
  */
 #define SECTION_SIZE_BITS       24
 
-#define MAX_PHYSADDR_BITS       44
-#define MAX_PHYSMEM_BITS        44
+#define MAX_PHYSADDR_BITS       46
+#define MAX_PHYSMEM_BITS        46
 
 #endif /* CONFIG_SPARSEMEM */
 
-- 
1.7.10
