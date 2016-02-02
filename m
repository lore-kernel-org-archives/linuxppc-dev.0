Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 958A31A0065
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 10:49:19 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 09:49:16 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 802113578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 10:49:10 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u12Nn23p52035756
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 10:49:10 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u12Nmbor001891
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 10:48:38 +1100
Date: Wed, 3 Feb 2016 10:48:11 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 nfont@linux.vnet.ibm.com, paulus@samba.org
Subject: Re: [PATCH 2/2] powerpc/pseries: Check if EEH is enabled on DDW
 mechanism code
Message-ID: <20160202234811.GA17911@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1453234700-27593-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1453234700-27593-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453234700-27593-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 19, 2016 at 06:18:20PM -0200, Guilherme G. Piccoli wrote:
>The Dynamic DMA Window (DDW) mechanism relies on EEH to obtain the
>configuration address of devices. For example, the functions query_ddw()
>and create_ddw() make use of eeh_dev struct. So, the dependency is
>intrinsic - DDW mechanism will fail if EEH is not enabled.
>
>Despite this dependency, no check for EEH availability is performed in DDW
>code. This patch adds a check based on eeh_enabled() function, so if EEH is
>not enabled before eeh_dev struct use, DDW will fallback to default iommu
>mechanism and won't fail.
>
>One use case for this patch is when we disable EEH globally via kernel
>command-line ("eeh=off") - without the patch, a device probe can hit a kernel
>oops because EEH is disabled but DDW will try to use it.
>
>Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>---
> arch/powerpc/platforms/pseries/iommu.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>index bd98ce2..1ff55cc 100644
>--- a/arch/powerpc/platforms/pseries/iommu.c
>+++ b/arch/powerpc/platforms/pseries/iommu.c
>@@ -1224,8 +1224,10 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
>
> 	pdev = to_pci_dev(dev);
>
>-	/* only attempt to use a new window if 64-bit DMA is requested */
>-	if (!disable_ddw && dma_mask == DMA_BIT_MASK(64)) {
>+	/* We should check if EEH is enabled here, since DDW mechanism has
>+	 * an intrinsic dependency of EEH config addr information. Also, we
>+	 * only attempt to use a new window if 64-bit DMA is requested */
>+	if (eeh_enabled() && !disable_ddw && dma_mask == DMA_BIT_MASK(64)) {
> 		dn = pci_device_to_OF_node(pdev);
> 		dev_dbg(dev, "node is %s\n", dn->full_name);
>

There are two types of addresses: (1) PCI config address (2) PE config address.
(1) is used to indentify one PCI device which is included in the PE. (2) is the
PCI config address of PE's primary bus in pHyp. Both of them can be used to identify
the PE. It means the (1) PCI config address, which is retrieved from pci_dn, can be
passed to hypervisor. Then we don't have to disable DDW when EEH is disabled.

Guilherme, did you hit the crash on pHyp or PowerKVM?

Thanks,
Gavin 

>-- 
>2.1.0
>
