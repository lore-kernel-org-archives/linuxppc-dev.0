Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0804AB7D1D
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 11:01:35 +1100 (EST)
Date: Wed, 3 Mar 2010 08:54:45 +0900
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: remove IOMMU_VMERGE config option
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20100303085404R.fujita.tomonori@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.or, arnd@arndb.de,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Seems that IOMMU_VMERGE option description gives the false
information:

http://marc.info/?l=linux-sparc&m=126753808727669&w=2
http://marc.info/?l=linux-sparc&m=126753880528825&w=2

IOMMU_VMERGE is unnecessary nowadays so how about removing it?

=
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH] powerpc: remove IOMMU_VMERGE config option

The description says:

 Cause IO segments sent to a device for DMA to be merged virtually
 by the IOMMU when they happen to have been allocated contiguously.
 This doesn't add pressure to the IOMMU allocator. However, some
 drivers don't support getting large merged segments coming back
 from *_map_sg().

 Most drivers don't have this problem; it is safe to say Y here.

It's out of date. Long ago, drivers didn't have a way to tell IOMMUs
about their segment length limit (that is, the maximum segment length
that they can handle). So IOMMUs merged as many segments as possible
and gave too large segments to drivers.

dma_get_max_seg_size() was introduced to solve the above
problem. Device drives can use the API to tell IOMMU about the maximum
segment length that they can handle. The powerpc IOMMU supports
dma_get_max_seg_size() properly. In addition, the default limit (64K)
should be safe for everyone.

So this config option seems to be unnecessary.

Note that this config option just enables users to disable the virtual
merging by default (powerpc enables it by default). Users can still
disable the virtual merging by the boot parameter.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/powerpc/Kconfig |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 155d571..2dfa83b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -314,17 +314,8 @@ config 8XX_MINIMAL_FPEMU
 	  It is recommended that you build a soft-float userspace instead.
 
 config IOMMU_VMERGE
-	bool "Enable IOMMU virtual merging"
+	def_bool y
 	depends on PPC64
-	default y
-	help
-	  Cause IO segments sent to a device for DMA to be merged virtually
-	  by the IOMMU when they happen to have been allocated contiguously.
-	  This doesn't add pressure to the IOMMU allocator. However, some
-	  drivers don't support getting large merged segments coming back
-	  from *_map_sg().
-
-	  Most drivers don't have this problem; it is safe to say Y here.
 
 config IOMMU_HELPER
 	def_bool PPC64
-- 
1.6.5
