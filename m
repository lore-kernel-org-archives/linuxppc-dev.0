Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 196001A06A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 15:48:53 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 21:48:52 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E3D9219D8042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:36:43 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N4mkV025624744
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:48:46 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N4mkbD019473
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:48:46 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 07/18] powerpc/mm: Update masked bits for linux page table
Date: Tue, 23 Feb 2016 10:18:09 +0530
Message-Id: <1456202900-5454-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We now use physical address in upper page table tree levels. Even though
they are aligned to their size, for the masked bits we use the
overloaded bit positions as per PowerISA 3.0. We keep the bad bits check
as it is, and will use conditional there when adding radix. Bad bits
check also check for reserved bits and we oveload some of the reserved
fields of radix in hash config.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index f0f5f91d7909..60c2c912c3a7 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -60,15 +60,12 @@
 #define PTE_FRAG_SIZE_SHIFT  12
 #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
 
-/*
- * Bits to mask out from a PMD to get to the PTE page
- * PMDs point to PTE table fragments which are PTE_FRAG_SIZE aligned.
- */
-#define PMD_MASKED_BITS		(PTE_FRAG_SIZE - 1)
-/* Bits to mask out from a PGD/PUD to get to the PMD page */
-#define PUD_MASKED_BITS		0x1ff
-/* FIXME!! Will be fixed in next patch */
-#define PGD_MASKED_BITS		0
+/* Bits to mask out from a PMD to get to the PTE page */
+#define PMD_MASKED_BITS		0xc0000000000000ffUL
+/* Bits to mask out from a PUD to get to the PMD page */
+#define PUD_MASKED_BITS		0xc0000000000000ffUL
+/* Bits to mask out from a PGD to get to the PUD page */
+#define PGD_MASKED_BITS		0xc0000000000000ffUL
 
 #ifndef __ASSEMBLY__
 
-- 
2.5.0
