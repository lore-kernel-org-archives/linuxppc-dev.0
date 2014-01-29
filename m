Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:6])
 by ozlabs.org (Postfix) with ESMTP id 596FD2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 15:20:42 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/iommu: Fix initialisation of DART iommu table
Date: Wed, 29 Jan 2014 15:20:12 +1100
Message-Id: <1390969212-20758-1-git-send-email-alistair@popple.id.au>
Cc: olaf@aepfle.de, linux-kernel@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit d084775738b746648d4102337163a04534a02982 switched the generic
powerpc iommu backend code to use the it_page_shift field to determine
page size. Commit 3a553170d35d69bea3877bffa508489dfa6f133d should have
initiliased this field for all platforms, however the DART iommu table
code was not updated.

This commit initialises the it_page_shift field to 4K for the DART
iommu.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/sysdev/dart_iommu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index bd968a4..62c47bb 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -292,6 +292,7 @@ static void iommu_table_dart_setup(void)
 	iommu_table_dart.it_offset = 0;
 	/* it_size is in number of entries */
 	iommu_table_dart.it_size = dart_tablesize / sizeof(u32);
+	iommu_table_dart.it_page_shift = IOMMU_PAGE_SHIFT_4K;
 
 	/* Initialize the common IOMMU code */
 	iommu_table_dart.it_base = (unsigned long)dart_vbase;
-- 
1.7.10.4
