Return-Path: <shuah.khan@hp.com>
Received: from g1t0027.austin.hp.com (g1t0027.austin.hp.com [15.216.28.34])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79B062C0156
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2012 08:43:00 +1100 (EST)
Message-ID: <1353706422.5270.99.camel@lorien2>
Subject: [PATCH 4/9] microblaze: dma-mapping: support debug_dma_mapping_error
From: Shuah Khan <shuah.khan@hp.com>
To: Joerg Roedel <joro@8bytes.org>, a-jacquiot@ti.com, fenghua.yu@intel.com,
 catalin.marinas@arm.com, lethal@linux-sh.org, benh@kernel.crashing.org,
 ralf@linux-mips.org, tony.luck@intel.com, davem@davemloft.net,
 m.szyprowski@samsung.com, msalter@redhat.com, monstr@monstr.eu, Ming Lei
 <ming.lei@canonical.com>
Date: Fri, 23 Nov 2012 14:33:42 -0700
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

Add support for debug_dma_mapping_error() call to avoid warning from
debug_dma_unmap() interface when it checks for mapping error checked
status. Without this patch, device driver failed to check map error
warning is generated.

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
Acked-by: Michal Simek <monstr@monstr.eu>
---

This patch is already in linux-next. Including it in this series for
completeness. linux-next commit f229605441030bcd315c21d97b25889d63ed0130

-- shuah
---
 arch/microblaze/include/asm/dma-mapping.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/microblaze/include/asm/dma-mapping.h b/arch/microblaze/include/asm/dma-mapping.h
index 01d2282..46460f1 100644
--- a/arch/microblaze/include/asm/dma-mapping.h
+++ b/arch/microblaze/include/asm/dma-mapping.h
@@ -114,6 +114,8 @@ static inline void __dma_sync(unsigned long paddr,
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	debug_dma_mapping_error(dev, dma_addr);
 	if (ops->mapping_error)
 		return ops->mapping_error(dev, dma_addr);
 
-- 
1.7.9.5
