Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znD4Z20cKzF0lD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 23:22:05 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
 Christophe LEROY <christophe.leroy@c-s.fr>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5/5] powerpc/mm/32: Remove the reserved memory hack
Date: Thu, 22 Feb 2018 13:15:16 +0100
Message-Id: <20180222121516.23415-6-j.neuschaefer@gmx.net>
In-Reply-To: <20180222121516.23415-1-j.neuschaefer@gmx.net>
References: <20180222121516.23415-1-j.neuschaefer@gmx.net>
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
 arch/powerpc/mm/init_32.c    | 5 -----
 arch/powerpc/mm/mmu_decl.h   | 1 -
 arch/powerpc/mm/pgtable_32.c | 3 +--
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 6419b33ca309..326240177fa6 100644
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
index d54e1a9c1c99..a89eb3b898cd 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -146,8 +146,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using.
 	 */
-	if (page_is_ram(__phys_to_pfn(p)) &&
-	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size))) {
+	if (page_is_ram(__phys_to_pfn(p))) {
 		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
 		       (unsigned long long)p, __builtin_return_address(0));
 		return NULL;
-- 
2.16.1
