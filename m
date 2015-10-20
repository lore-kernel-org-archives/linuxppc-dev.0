Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B48AA1A02B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 07:12:50 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 01:42:47 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 27C95E0058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:49 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9KKCj2g41353298
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:45 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9KKCjUS006415
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:45 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 3/7] powerpc/nohash: Update 64K nohash config to have 32
 pte fragement
Date: Wed, 21 Oct 2015 01:42:29 +0530
Message-Id: <1445371953-9627-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

They don't need to track 4k subpage slot details and hence don't need
second half of pgtable_t.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
index 1d8e26e8167b..dbd9de9264c2 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
@@ -10,14 +10,14 @@
 #define PGD_INDEX_SIZE  12
 
 /*
- * we support 8 fragments per PTE page of 64K size
+ * we support 32 fragments per PTE page of 64K size
  */
-#define PTE_FRAG_NR	8
+#define PTE_FRAG_NR	32
 /*
  * We use a 2K PTE page fragment and another 4K for storing
  * real_pte_t hash index. Rounding the entire thing to 8K
  */
-#define PTE_FRAG_SIZE_SHIFT  13
+#define PTE_FRAG_SIZE_SHIFT  11
 #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
 
 
-- 
2.5.0
