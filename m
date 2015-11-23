Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17AB31A2CEB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:58 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:34:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AA2732CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:54 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANAYUmm7930074
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:38 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANAYLu7028082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:22 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 03/10] powerpc/nohash: Update 64K nohash config to have 32
 pte fragement
Date: Mon, 23 Nov 2015 16:03:38 +0530
Message-Id: <1448274825-30289-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
