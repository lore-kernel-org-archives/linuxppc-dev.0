Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87F2D1A039A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 00:40:07 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 06:40:05 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 266FA19D8053
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 06:27:59 -0700 (MST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u27De2GV30933048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 13:40:03 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u27DZcGH012945
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 08:35:38 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 07/14] powerpc/mm: Update _PAGE_KERNEL_RO
Date: Mon,  7 Mar 2016 19:09:27 +0530
Message-Id: <1457357974-20839-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Fix this by doing a read only kernel mapping using PPP bits 0b110

This also allows us to do read only kernel mapping for radix in later
patches.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h |  4 ++--
 arch/powerpc/mm/hash_utils_64.c           | 17 +++++++++++------
 arch/powerpc/platforms/ps3/spu.c          |  2 +-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 8ccb2970f30f..c2b567456796 100644
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
index 630603f74056..c81c08aaff0e 100644
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
