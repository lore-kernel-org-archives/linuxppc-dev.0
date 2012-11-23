Return-Path: <shuah.khan@hp.com>
Received: from g6t0184.atlanta.hp.com (g6t0184.atlanta.hp.com [15.193.32.61])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 185422C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2012 08:31:29 +1100 (EST)
Message-ID: <1353706269.5270.96.camel@lorien2>
Subject: [PATCH 1/9] ARM64: dma_debug: add debug_dma_mapping_error support
From: Shuah Khan <shuah.khan@hp.com>
To: Joerg Roedel <joro@8bytes.org>, a-jacquiot@ti.com, fenghua.yu@intel.com,
 catalin.marinas@arm.com, lethal@linux-sh.org, benh@kernel.crashing.org,
 ralf@linux-mips.org, tony.luck@intel.com, davem@davemloft.net,
 m.szyprowski@samsung.com, msalter@redhat.com, monstr@monstr.eu, Ming Lei
 <ming.lei@canonical.com>
Date: Fri, 23 Nov 2012 14:31:09 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
 microblaze-uclinux@itee.uq.edu.au, LKML <linux-kernel@vger.kernel.org>,
 shuahkhan@gmail.com, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Reply-To: shuah.khan@hp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add dma-debug interface debug_dma_mapping_error() to debug drivers that fail
to check dma mapping errors on addresses returned by dma_map_single() and
dma_map_page() interfaces.

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/dma-mapping.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 538f4b4..9947768 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -50,6 +50,7 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dev_addr)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
+	debug_dma_mapping_error(dev, dev_addr);
 	return ops->mapping_error(dev, dev_addr);
 }
 
-- 
1.7.9.5
