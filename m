Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwPQ3f1VzDqZq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:38:02 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2M3T7Em076053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:38:01 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vrtcjk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:38:00 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 21:38:00 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 11/17] powerpc/mm/hash: Increase VA range to 128TB
Date: Wed, 22 Mar 2017 09:06:57 +0530
In-Reply-To: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1490153823-29241-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We update the hash linux page table layout such that we can support 512TB. But
we limit the TASK_SIZE to 128TB. We can switch to 128TB by default without
conditional because that is the max virtual address supported by other
architectures. We will later add a mechanism to on-demand increase the
application's effective address range to 512TB.

Having the page table layout changed to accommodate 512TB  makes testing large
memory configuration easier with less code changes to kernel

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  2 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  2 +-
 arch/powerpc/include/asm/processor.h          | 22 ++++++++++++++++++----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 0c4e470571ca..b4b5e6b671ca 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -8,7 +8,7 @@
 #define H_PTE_INDEX_SIZE  9
 #define H_PMD_INDEX_SIZE  7
 #define H_PUD_INDEX_SIZE  9
-#define H_PGD_INDEX_SIZE  9
+#define H_PGD_INDEX_SIZE  12
 
 #ifndef __ASSEMBLY__
 #define H_PTE_TABLE_SIZE	(sizeof(pte_t) << H_PTE_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 7be54f9590a3..214219dff87c 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -4,7 +4,7 @@
 #define H_PTE_INDEX_SIZE  8
 #define H_PMD_INDEX_SIZE  5
 #define H_PUD_INDEX_SIZE  5
-#define H_PGD_INDEX_SIZE  12
+#define H_PGD_INDEX_SIZE  15
 
 /*
  * 64k aligned address free up few of the lower bits of RPN for us
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index e0fecbcea2a2..146c3a91d89f 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -102,11 +102,25 @@ void release_thread(struct task_struct *);
 #endif
 
 #ifdef CONFIG_PPC64
-/* 64-bit user address space is 46-bits (64TB user VM) */
-#define TASK_SIZE_USER64 (0x0000400000000000UL)
+/*
+ * 64-bit user address space can have multiple limits
+ * For now supported values are:
+ */
+#define TASK_SIZE_64TB  (0x0000400000000000UL)
+#define TASK_SIZE_128TB (0x0000800000000000UL)
+#define TASK_SIZE_512TB (0x0002000000000000UL)
 
-/* 
- * 32-bit user address space is 4GB - 1 page 
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * MAx value currently used:
+ */
+#define TASK_SIZE_USER64 TASK_SIZE_128TB
+#else
+#define TASK_SIZE_USER64 TASK_SIZE_64TB
+#endif
+
+/*
+ * 32-bit user address space is 4GB - 1 page
  * (this 1 page is needed so referencing of 0xFFFFFFFF generates EFAULT
  */
 #define TASK_SIZE_USER32 (0x0000000100000000UL - (1*PAGE_SIZE))
-- 
2.7.4
