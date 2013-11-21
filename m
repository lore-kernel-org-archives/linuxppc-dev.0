Return-Path: <kernelfans@gmail.com>
Received: from mail-ob0-x22c.google.com (mail-ob0-x22c.google.com
 [IPv6:2607:f8b0:4003:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 46B262C0399
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 13:17:22 +1100 (EST)
Received: by mail-ob0-f172.google.com with SMTP id gq1so6133547obb.31
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 18:17:18 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: mm: change pgtable index size for 64K page
Date: Thu, 21 Nov 2013 10:17:55 +0800
Message-Id: <1385000275-5988-2-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1385000275-5988-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1385000275-5988-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For 64K page, we waste half of the pte_t page. With this patch, after
changing PGD_INDEX_SIZE from 12 to 11, PTE_INDEX_SIZE from 8 to 9,
we can improve the usage of pte_t page and shrink the continuous phys
size for pgd_t.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64-64k.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64-64k.h b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
index a56b82f..f6955ff 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64-64k.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
@@ -4,10 +4,10 @@
 #include <asm-generic/pgtable-nopud.h>
 
 
-#define PTE_INDEX_SIZE  8
+#define PTE_INDEX_SIZE  9
 #define PMD_INDEX_SIZE  10
 #define PUD_INDEX_SIZE	0
-#define PGD_INDEX_SIZE  12
+#define PGD_INDEX_SIZE  11
 
 #ifndef __ASSEMBLY__
 #define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
-- 
1.8.1.4
