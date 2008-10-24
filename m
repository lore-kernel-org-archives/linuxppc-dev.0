Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8A6CDDDD4
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 16:52:46 +1100 (EST)
Date: Fri, 24 Oct 2008 14:41:09 +0900
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: remove dead BIO_VMERGE_BOUNDARY definition
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20081024144036K.fujita.tomonori@lab.ntt.co.jp>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The block layer dropped the virtual merge feature
(b8b3e16cfe6435d961f6aaebcfd52a1ff2a988c5). BIO_VMERGE_BOUNDARY
definition is meaningless now (For POWER, BIO_VMERGE_BOUNDARY has been
meaningless for a long time since POWER disables the virtual merge
feature).

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/powerpc/include/asm/io.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 08266d2..494cd8b 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -713,13 +713,6 @@ static inline void * phys_to_virt(unsigned long address)
  */
 #define page_to_phys(page)	((phys_addr_t)page_to_pfn(page) << PAGE_SHIFT)
 
-/* We do NOT want virtual merging, it would put too much pressure on
- * our iommu allocator. Instead, we want drivers to be smart enough
- * to coalesce sglists that happen to have been mapped in a contiguous
- * way by the iommu
- */
-#define BIO_VMERGE_BOUNDARY	0
-
 /*
  * 32 bits still uses virt_to_bus() for it's implementation of DMA
  * mappings se we have to keep it defined here. We also have some old
-- 
1.5.4.2
