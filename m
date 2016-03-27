Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqpR1R9xzDqGl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:24:47 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:24:45 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 49C5E19D803F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:12:35 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8OfCl37290044
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:24:41 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8Ofir031738
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:24:41 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 08/65] powerpc/mm: Update _PAGE_KERNEL_RO
Date: Sun, 27 Mar 2016 13:53:16 +0530
Message-Id: <1459067053-10835-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PS3 had used PPP bit hack to implement a read only mapping in the
kernel area. Since we are bolt mapping the ioremap area, it used
the pte flags _PAGE_PRESENT | _PAGE_USER to get a PPP value of 0x3
there by resulting in a read only mapping. This means the area
can be accessed by user space, but kernel will never return such an
address to user space.

But we can do better by implementing a read only kernel mapping using
PPP bits 0b110

This also allows us to do read only kernel mapping for radix in later
patches.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h |  4 ++--
 arch/powerpc/mm/hash_utils_64.c           | 17 +++++++++++------
 arch/powerpc/platforms/ps3/spu.c          |  2 +-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index e69f84927c2d..2a80981f1b0b 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -115,10 +115,10 @@
 #endif /* CONFIG_PPC_MM_SLICES */
 
 /*
- * No separate kernel read-only, user access blocked by key
+ * user access blocked by key
  */
 #define _PAGE_KERNEL_RW		(_PAGE_PRIVILEGED | _PAGE_RW | _PAGE_DIRTY)
-#define _PAGE_KERNEL_RO		 _PAGE_KERNEL_RW
+#define _PAGE_KERNEL_RO		 (_PAGE_PRIVILEGED | _PAGE_READ)
 #define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY | \
 				 _PAGE_RW | _PAGE_EXEC)
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f0dbaa51e8da..59d4600bacd5 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -167,14 +167,19 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 	if ((pteflags & _PAGE_EXEC) == 0)
 		rflags |= HPTE_R_N;
 	/*
-	 * PP bits:
+	 * PPP bits:
 	 * Linux uses slb key 0 for kernel and 1 for user.
-	 * kernel areas are mapped with PP=00
-	 * and there is no kernel RO (_PAGE_KERNEL_RO).
-	 * User area is mapped with PP=0x2 for read/write
-	 * or PP=0x3 for read-only (including writeable but clean pages).
+	 * kernel RW areas are mapped with PPP=0b000
+	 * User area is mapped with PPP=0b010 for read/write
+	 * or PPP=0b011 for read-only (including writeable but clean pages).
 	 */
-	if (!(pteflags & _PAGE_PRIVILEGED)) {
+	if (pteflags & _PAGE_PRIVILEGED) {
+		/*
+		 * Kernel read only mapped with ppp bits 0b110
+		 */
+		if (!(pteflags & _PAGE_WRITE))
+			rflags |= (HPTE_R_PP0 | 0x2);
+	} else {
 		if (pteflags & _PAGE_RWX)
 			rflags |= 0x2;
 		if (!((pteflags & _PAGE_WRITE) && (pteflags & _PAGE_DIRTY)))
diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index a0bca05e26b0..5e8a40f9739f 100644
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -205,7 +205,7 @@ static void spu_unmap(struct spu *spu)
 static int __init setup_areas(struct spu *spu)
 {
 	struct table {char* name; unsigned long addr; unsigned long size;};
-	static const unsigned long shadow_flags = _PAGE_NO_CACHE | 3;
+	unsigned long shadow_flags = pgprot_val(pgprot_noncached_wc(PAGE_KERNEL_RO));
 
 	spu_pdata(spu)->shadow = __ioremap(spu_pdata(spu)->shadow_addr,
 					   sizeof(struct spe_shadow),
-- 
2.5.0
