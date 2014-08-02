Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95AC61A073A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Aug 2014 13:07:59 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/64e: Add __ref to early_alloc_pgtable()
Date: Fri, 1 Aug 2014 22:07:40 -0500
Message-ID: <1406948861-11322-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This silences a section mismatch warning.  early_alloc_pgtable() is
called from map_kernel_page() which cannot be __init, but only when
slab_is_available() returns false which can only happen during early
boot.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/mm/pgtable_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index f6ce1f1..3b3c4d3 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -68,7 +68,7 @@
 unsigned long ioremap_bot = IOREMAP_BASE;
 
 #ifdef CONFIG_PPC_MMU_NOHASH
-static void *early_alloc_pgtable(unsigned long size)
+static __ref void *early_alloc_pgtable(unsigned long size)
 {
 	void *pt;
 
-- 
1.9.1
