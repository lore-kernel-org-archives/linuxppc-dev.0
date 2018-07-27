Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 41cPXw2GzHzF12T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 19:58:07 +1000 (AEST)
Date: Fri, 27 Jul 2018 10:58:05 +0100
From: Will Deacon <will.deacon@arm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, jasowang@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, mst@redhat.com,
 hch@infradead.org, linuxram@us.ibm.com, haren@linux.vnet.ibm.com,
 paulus@samba.org, srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
 jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180727095804.GA25592@arm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anshuman,

On Fri, Jul 20, 2018 at 09:29:37AM +0530, Anshuman Khandual wrote:
> This patch series is the follow up on the discussions we had before about
> the RFC titled [RFC,V2] virtio: Add platform specific DMA API translation
> for virito devices (https://patchwork.kernel.org/patch/10417371/). There
> were suggestions about doing away with two different paths of transactions
> with the host/QEMU, first being the direct GPA and the other being the DMA
> API based translations.
> 
> First patch attempts to create a direct GPA mapping based DMA operations
> structure called 'virtio_direct_dma_ops' with exact same implementation
> of the direct GPA path which virtio core currently has but just wrapped in
> a DMA API format. Virtio core must use 'virtio_direct_dma_ops' instead of
> the arch default in absence of VIRTIO_F_IOMMU_PLATFORM flag to preserve the
> existing semantics. The second patch does exactly that inside the function
> virtio_finalize_features(). The third patch removes the default direct GPA
> path from virtio core forcing it to use DMA API callbacks for all devices.
> Now with that change, every device must have a DMA operations structure
> associated with it. The fourth patch adds an additional hook which gives
> the platform an opportunity to do yet another override if required. This
> platform hook can be used on POWER Ultravisor based protected guests to
> load up SWIOTLB DMA callbacks to do the required (as discussed previously
> in the above mentioned thread how host is allowed to access only parts of
> the guest GPA range) bounce buffering into the shared memory for all I/O
> scatter gather buffers to be consumed on the host side.
> 
> Please go through these patches and review whether this approach broadly
> makes sense. I will appreciate suggestions, inputs, comments regarding
> the patches or the approach in general. Thank you.

I just wanted to say that this patch series provides a means for us to
force the coherent DMA ops for legacy virtio devices on arm64, which in turn
means that we can enable the SMMU with legacy devices in our fastmodel
emulation platform (which is slowly being upgraded to virtio 1.0) without
hanging during boot. Patch below.

So:

Acked-by: Will Deacon <will.deacon@arm.com>
Tested-by: Will Deacon <will.deacon@arm.com>

Thanks!

Will

--->8

>From 4ef39e9de2c87c97bf046816ca762832f92e39b5 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Fri, 27 Jul 2018 10:49:25 +0100
Subject: [PATCH] arm64: dma: Override DMA ops for legacy virtio devices

Virtio devices are always cache-coherent, so force use of the coherent
DMA ops for legacy virtio devices where the dma-coherent is known to
be omitted by QEMU for the MMIO transport.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/dma-mapping.h |  6 ++++++
 arch/arm64/mm/dma-mapping.c          | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index b7847eb8a7bb..30aa8fb62dc3 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -44,6 +44,12 @@ void arch_teardown_dma_ops(struct device *dev);
 #define arch_teardown_dma_ops	arch_teardown_dma_ops
 #endif
 
+#ifdef CONFIG_VIRTIO
+struct virtio_device;
+void platform_override_dma_ops(struct virtio_device *vdev);
+#define platform_override_dma_ops	platform_override_dma_ops
+#endif
+
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
 {
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 61e93f0b5482..f9ca61b1b34d 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -891,3 +891,22 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	}
 #endif
 }
+
+#ifdef CONFIG_VIRTIO
+#include <linux/virtio_config.h>
+
+void platform_override_dma_ops(struct virtio_device *vdev)
+{
+	struct device *dev = vdev->dev.parent;
+	const struct dma_map_ops *dma_ops = &arm64_swiotlb_dma_ops;
+
+	if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
+		return;
+
+	dev->archdata.dma_coherent = true;
+	if (iommu_get_domain_for_dev(dev))
+		dma_ops = &iommu_dma_ops;
+
+	set_dma_ops(dev, dma_ops);
+}
+#endif	/* CONFIG_VIRTIO */
-- 
2.1.4
