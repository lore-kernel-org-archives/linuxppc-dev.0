Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF7A31A0D56
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 07:18:32 +1100 (AEDT)
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 19 Jan 2016 18:18:29 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 196B41DC0074
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 15:18:21 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0JKGDNI2097640
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 18:16:13 -0200
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0JKIO29000575
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 18:18:24 -0200
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 nfont@linux.vnet.ibm.com, paulus@samba.org,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/pseries: Check if EEH is enabled on DDW mechanism
 code
Date: Tue, 19 Jan 2016 18:18:20 -0200
Message-Id: <1453234700-27593-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
In-Reply-To: <1453234700-27593-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1453234700-27593-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Dynamic DMA Window (DDW) mechanism relies on EEH to obtain the
configuration address of devices. For example, the functions query_ddw()
and create_ddw() make use of eeh_dev struct. So, the dependency is
intrinsic - DDW mechanism will fail if EEH is not enabled.

Despite this dependency, no check for EEH availability is performed in DDW
code. This patch adds a check based on eeh_enabled() function, so if EEH is
not enabled before eeh_dev struct use, DDW will fallback to default iommu
mechanism and won't fail.

One use case for this patch is when we disable EEH globally via kernel
command-line ("eeh=off") - without the patch, a device probe can hit a kernel
oops because EEH is disabled but DDW will try to use it.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index bd98ce2..1ff55cc 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1224,8 +1224,10 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
 
 	pdev = to_pci_dev(dev);
 
-	/* only attempt to use a new window if 64-bit DMA is requested */
-	if (!disable_ddw && dma_mask == DMA_BIT_MASK(64)) {
+	/* We should check if EEH is enabled here, since DDW mechanism has
+	 * an intrinsic dependency of EEH config addr information. Also, we
+	 * only attempt to use a new window if 64-bit DMA is requested */
+	if (eeh_enabled() && !disable_ddw && dma_mask == DMA_BIT_MASK(64)) {
 		dn = pci_device_to_OF_node(pdev);
 		dev_dbg(dev, "node is %s\n", dn->full_name);
 
-- 
2.1.0
