Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DEBF22C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 09:00:23 +1000 (EST)
Date: Wed, 12 Sep 2012 18:00:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: fix typo in PTRS_PER_PUD
Message-ID: <20120912230009.GA17226@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PTRS_PER_PUD should be based on PUD_INDEX_SIZE, not PMD_INDEX_SIZE.  We
got away with it because PUD and PMD had the same index size, but this is
no longer true with Aneesh's patchset to support a 46-bit user effective
address space.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/pgtable-ppc64-4k.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64-4k.h b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
index b3eccf2..12798c9 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64-4k.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
@@ -19,7 +19,7 @@
 
 #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
 #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
-#define PTRS_PER_PUD	(1 << PMD_INDEX_SIZE)
+#define PTRS_PER_PUD	(1 << PUD_INDEX_SIZE)
 #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
 
 /* PMD_SHIFT determines what a second-level page table entry can map */
-- 
1.7.9.5
