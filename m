Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Wxwr3qnHzDqCF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 13:59:56 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6K3xWMA134750
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 23:59:54 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kb2mvt91s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 23:59:53 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 20 Jul 2018 04:59:51 +0100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, jasowang@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, mst@redhat.com,
 hch@infradead.org, khandual@linux.vnet.ibm.com, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com
Subject: [RFC 0/4] Virtio uses DMA API for all devices
Date: Fri, 20 Jul 2018 09:29:37 +0530
Message-Id: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series is the follow up on the discussions we had before about
the RFC titled [RFC,V2] virtio: Add platform specific DMA API translation
for virito devices (https://patchwork.kernel.org/patch/10417371/). There
were suggestions about doing away with two different paths of transactions
with the host/QEMU, first being the direct GPA and the other being the DMA
API based translations.

First patch attempts to create a direct GPA mapping based DMA operations
structure called 'virtio_direct_dma_ops' with exact same implementation
of the direct GPA path which virtio core currently has but just wrapped in
a DMA API format. Virtio core must use 'virtio_direct_dma_ops' instead of
the arch default in absence of VIRTIO_F_IOMMU_PLATFORM flag to preserve the
existing semantics. The second patch does exactly that inside the function
virtio_finalize_features(). The third patch removes the default direct GPA
path from virtio core forcing it to use DMA API callbacks for all devices.
Now with that change, every device must have a DMA operations structure
associated with it. The fourth patch adds an additional hook which gives
the platform an opportunity to do yet another override if required. This
platform hook can be used on POWER Ultravisor based protected guests to
load up SWIOTLB DMA callbacks to do the required (as discussed previously
in the above mentioned thread how host is allowed to access only parts of
the guest GPA range) bounce buffering into the shared memory for all I/O
scatter gather buffers to be consumed on the host side.

Please go through these patches and review whether this approach broadly
makes sense. I will appreciate suggestions, inputs, comments regarding
the patches or the approach in general. Thank you.

Anshuman Khandual (4):
  virtio: Define virtio_direct_dma_ops structure
  virtio: Override device's DMA OPS with virtio_direct_dma_ops selectively
  virtio: Force virtio core to use DMA API callbacks for all virtio devices
  virtio: Add platform specific DMA API translation for virito devices

 arch/powerpc/include/asm/dma-mapping.h |  6 +++
 arch/powerpc/platforms/pseries/iommu.c |  6 +++
 drivers/virtio/virtio.c                | 72 ++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.h     |  3 ++
 drivers/virtio/virtio_ring.c           | 65 +-----------------------------
 5 files changed, 89 insertions(+), 63 deletions(-)

-- 
2.9.3
