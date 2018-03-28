Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409pcH5w53zF2H7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 11:27:27 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Mathieu Malaterre <malat@debian.org>, Balbir Singh <bsingharora@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 5/5] powerpc/mm/32: Remove the reserved memory hack
Date: Wed, 28 Mar 2018 02:25:44 +0200
Message-Id: <20180328002544.18526-6-j.neuschaefer@gmx.net>
In-Reply-To: <20180328002544.18526-1-j.neuschaefer@gmx.net>
References: <20180328002544.18526-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This hack, introduced in commit c5df7f775148 ("powerpc: allow ioremap
within reserved memory regions") is now unnecessary.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2: no changes
---
 arch/powerpc/mm/init_32.c    | 5 -----
 arch/powerpc/mm/mmu_decl.h   | 1 -
 arch/powerpc/mm/pgtable_32.c | 3 +--
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index a2bf6965d04f..3e59e5d64b01 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -88,11 +88,6 @@ void MMU_init(void);
 int __map_without_bats;
 int __map_without_ltlbs;
 
-/*
- * This tells the system to allow ioremapping memory marked as reserved.
- */
-int __allow_ioremap_reserved;
-
 /* max amount of low RAM to map in */
 unsigned long __max_low_memory = MAX_LOW_MEM;
 
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 57fbc554c785..c4c0a09a7775 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -98,7 +98,6 @@ extern void setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, pgprot_t prot);
 
 extern int __map_without_bats;
-extern int __allow_ioremap_reserved;
 extern unsigned int rtas_data, rtas_size;
 
 struct hash_pte;
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 6668ecc041ad..120a49bfb9c6 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -148,8 +148,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	 * mem_init() sets high_memory so only do the check after that.
 	 */
 	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
-	    page_is_ram(__phys_to_pfn(p)) &&
-	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size))) {
+	    page_is_ram(__phys_to_pfn(p))) {
 		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
 		       (unsigned long long)p, __builtin_return_address(0));
 		return NULL;
-- 
2.16.2
