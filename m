Return-Path: <nacc@us.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0149B6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Jun 2011 05:06:00 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5OIpJhK025078
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2011 12:51:19 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5OJ5bwn039912
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2011 13:05:38 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5OD5VTj016754
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2011 07:05:33 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: [PATCH 2/4] dma-mapping: add get_required_mask if arch overrides
	default
Date: Fri, 24 Jun 2011 12:05:23 -0700
Message-Id: <1308942325-4813-3-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1308942325-4813-1-git-send-email-nacc@us.ibm.com>
References: <1308942325-4813-1-git-send-email-nacc@us.ibm.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Milton Miller <miltonm@bga.com>

If an architecture sets ARCH_HAS_DMA_GET_REQUIRED_MASK and has settable
dma_map_ops, the required mask may change by the ops implementation.
For example, a system that always has an mmu inline may only require 32
bits while a swiotlb would desire bits to cover all of memory.

Therefore add the field if the architecture does not use the generic
definition of dma_get_required_mask. The first use will by by powerpc.
Note that this does add some dependency on the order in which files are
visible here.

Signed-off-by:  Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org
---
 include/linux/dma-mapping.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ba8319a..d0e023b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -49,6 +49,9 @@ struct dma_map_ops {
 	int (*mapping_error)(struct device *dev, dma_addr_t dma_addr);
 	int (*dma_supported)(struct device *dev, u64 mask);
 	int (*set_dma_mask)(struct device *dev, u64 mask);
+#ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
+	u64 (*get_required_mask)(struct device *dev);
+#endif
 	int is_phys;
 };
 
-- 
1.7.4.1
