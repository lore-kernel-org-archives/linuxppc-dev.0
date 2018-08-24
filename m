Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xQyT4wHkzDqrT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 13:00:49 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7O2wxrp040146
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 23:00:47 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m26k5nx47-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 23:00:47 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Thu, 23 Aug 2018 23:00:46 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Anshuman Khandual <anshuman.linux@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Mike Anderson <andmike@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 11/11] powerpc/svm: Increase SWIOTLB buffer size
Date: Thu, 23 Aug 2018 23:59:33 -0300
In-Reply-To: <20180824025933.24319-1-bauerman@linux.ibm.com>
References: <20180824025933.24319-1-bauerman@linux.ibm.com>
Message-Id: <20180824025933.24319-12-bauerman@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

SWIOTLB buffer default size (64MB) is not enough for large sequential write
operations which eventually leads to kernel crash like here.

virtio-pci 0000:00:05.0: swiotlb buffer is full (sz: 327680 bytes)
virtio-pci 0000:00:05.0: DMA: Out of SW-IOMMU space for 327680 bytes
Kernel panic - not syncing: DMA: Random memory could be DMA read
CPU: 12 PID: 3985 Comm: mkfs.ext4 Not tainted 4.18.0-rc4+ #285
Call Trace:
[c0000007d2a27020] [c000000000cfdffc] dump_stack+0xb0/0xf4 (unreliable)
[c0000007d2a27060] [c000000000112a98] panic+0x140/0x328
[c0000007d2a270f0] [c0000000001b4f88] swiotlb_full+0x108/0x130
[c0000007d2a27180] [c0000000001b5f6c] swiotlb_map_page+0x25c/0x2c0
[c0000007d2a271e0] [c0000000007bfaf8] vring_map_one_sg.isra.0+0x58/0x70
[c0000007d2a27200] [c0000000007c08dc] virtqueue_add_sgs+0x1bc/0x690
[c0000007d2a272f0] [d0000000042a1280] virtio_queue_rq+0x358/0x4a0 [virtio_blk]
[c0000007d2a273d0] [c0000000006b5d68] blk_mq_dispatch_rq_list+0x1f8/0x6d0
..................

Increase the SWIOTLB size to 1GB on Ultravisor based secure guests.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/Kconfig | 5 +++++
 kernel/dma/swiotlb.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1466d1234723..fee7194ce9e4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -457,6 +457,11 @@ config PPC_SVM
 
 	 If unsure, say "N".
 
+config SWIOTLB_DEFAULT_SIZE
+       int "Size of Software I/O TLB buffer (in MiB)"
+       default "1024"
+       depends on PPC_SVM
+
 config PPC_TRANSACTIONAL_MEM
        bool "Transactional Memory support for POWERPC"
        depends on PPC_BOOK3S_64
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 04b68d9dffac..32dc67422d8a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -146,8 +146,13 @@ void swiotlb_set_max_segment(unsigned int val)
 		max_segment = rounddown(val, PAGE_SIZE);
 }
 
+#ifdef CONFIG_SWIOTLB_DEFAULT_SIZE
+#define IO_TLB_DEFAULT_SIZE ((unsigned long) CONFIG_SWIOTLB_DEFAULT_SIZE << 20)
+#else
 /* default to 64MB */
 #define IO_TLB_DEFAULT_SIZE (64UL<<20)
+#endif
+
 unsigned long swiotlb_size_or_default(void)
 {
 	unsigned long size;
