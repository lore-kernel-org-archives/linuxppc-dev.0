Return-Path: <Bart.VanAssche@sandisk.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4a::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4tWT6kNjzDqQH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 08:04:53 +1100 (AEDT)
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Doug Ledford <dledford@redhat.com>
CC: <linux-rdma@vger.kernel.org>, Bart Van Assche
 <bart.vanassche@sandisk.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Chris Metcalf <cmetcalf@mellanox.com>, "David
 Woodhouse" <dwmw2@infradead.org>, <linux-arch@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras <paulus@samba.org>, "Russell
 King" <linux@armlinux.org.uk>
Subject: [PATCH v3 03/37] treewide: Consolidate set_dma_ops() implementations
Date: Fri, 20 Jan 2017 13:04:03 -0800
Message-ID: <20170120210437.26389-4-bart.vanassche@sandisk.com>
In-Reply-To: <20170120210437.26389-1-bart.vanassche@sandisk.com>
References: <20170120210437.26389-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that all set_dma_ops() implementations are identical (ignoring
BUG_ON() statements), remove the architecture specific definitions
and add a definition in <linux/dma-mapping.h>.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/include/asm/dma-mapping.h     | 6 ------
 arch/powerpc/include/asm/dma-mapping.h | 5 -----
 arch/tile/include/asm/dma-mapping.h    | 5 -----
 include/linux/dma-mapping.h            | 5 +++++
 4 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 312f4d0564d6..c7432d647e53 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -31,12 +31,6 @@ static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 		return __generic_dma_ops(dev);
 }
 
-static inline void set_dma_ops(struct device *dev, const struct dma_map_ops *ops)
-{
-	BUG_ON(!dev);
-	dev->dma_ops = ops;
-}
-
 #define HAVE_ARCH_DMA_SUPPORTED 1
 extern int dma_supported(struct device *dev, u64 mask);
 
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 59fbd4abcbf8..8275603ba4d5 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -91,11 +91,6 @@ static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 	return dev->dma_ops;
 }
 
-static inline void set_dma_ops(struct device *dev, const struct dma_map_ops *ops)
-{
-	dev->dma_ops = ops;
-}
-
 /*
  * get_dma_offset()
  *
diff --git a/arch/tile/include/asm/dma-mapping.h b/arch/tile/include/asm/dma-mapping.h
index c0620697eaad..2562995a6ac9 100644
--- a/arch/tile/include/asm/dma-mapping.h
+++ b/arch/tile/include/asm/dma-mapping.h
@@ -59,11 +59,6 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 
 static inline void dma_mark_clean(void *addr, size_t size) {}
 
-static inline void set_dma_ops(struct device *dev, const struct dma_map_ops *ops)
-{
-	dev->dma_ops = ops;
-}
-
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 	if (!dev->dma_mask)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f1da68b82c63..e97f23e8b2d9 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -164,6 +164,11 @@ int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
 
 #ifdef CONFIG_HAS_DMA
 #include <asm/dma-mapping.h>
+static inline void set_dma_ops(struct device *dev,
+			       const struct dma_map_ops *dma_ops)
+{
+	dev->dma_ops = dma_ops;
+}
 #else
 /*
  * Define the dma api to allow compilation but not linking of
-- 
2.11.0
