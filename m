Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 72A7BB71E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 11:20:50 +1000 (EST)
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 200CDDDDD4
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 11:20:49 +1000 (EST)
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] x86, IA64, powerpc: add phys_to_dma() and dma_to_phys()
Date: Fri, 10 Jul 2009 10:05:01 +0900
Message-Id: <1247187904-31999-13-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1247187904-31999-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1247187904-31999-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, x86@kernel.org,
	fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds two functions, phys_to_dma() and dma_to_phys() to x86, IA64
and powerpc. swiotlb uses them. phys_to_dma() converts a physical
address to a dma address. dma_to_phys() does the opposite.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/ia64/include/asm/dma-mapping.h    |   10 ++++++++++
 arch/powerpc/include/asm/dma-mapping.h |   10 ++++++++++
 arch/x86/include/asm/dma-mapping.h     |   10 ++++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index 88d0f86..f91829d 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -77,6 +77,16 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return addr + size <= *dev->dma_mask;
 }
 
+static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return paddr;
+}
+
+static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	return daddr;
+}
+
 extern int dma_get_cache_alignment(void);
 
 static inline void
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 6ff1f85..0c34371 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -437,6 +437,16 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return addr + size <= *dev->dma_mask;
 }
 
+static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return paddr + get_dma_direct_offset(dev);
+}
+
+static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	return daddr - get_dma_direct_offset(dev);
+}
+
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 #ifdef CONFIG_NOT_COHERENT_CACHE
diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index adac59c..0ee770d 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -63,6 +63,16 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return addr + size <= *dev->dma_mask;
 }
 
+static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return paddr;
+}
+
+static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	return daddr;
+}
+
 static inline void
 dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	enum dma_data_direction dir)
-- 
1.6.0.6
