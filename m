Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40E9F2C009B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 18:13:35 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 16 Dec 2013 12:43:13 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A6C0F394005C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 12:43:07 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBG7D5UC52953138
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 12:43:05 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBG7D6YK019352
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 12:43:07 +0530
Date: Mon, 16 Dec 2013 15:13:05 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH 6/9] powerpc/pci: Use dev_is_pci() to check whether it is
 pci device
Message-ID: <20131216071305.GA16842@weiyang.vnet.ibm.com>
References: <1386244880-22300-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386244880-22300-1-git-send-email-wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 Hanjun Guo <guohanjun@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yijing,

This one looks good.

While I take a look at the source code, there are around 20 places with
similar style. Do you think it would be good to change all these places
in one patch?

On Thu, Dec 05, 2013 at 08:01:20PM +0800, Yijing Wang wrote:
>Use PCI standard marco dev_is_pci() instead of directly compare
>pci_bus_type to check whether it is pci device.
>
>Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>---
> arch/powerpc/sysdev/fsl_pci.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
>index 4dfd61d..7066e52 100644
>--- a/arch/powerpc/sysdev/fsl_pci.c
>+++ b/arch/powerpc/sysdev/fsl_pci.c
>@@ -122,7 +122,7 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
> 	 * address width of the SoC such that we can address any internal
> 	 * SoC address from across PCI if needed
> 	 */
>-	if ((dev->bus == &pci_bus_type) &&
>+	if ((dev_is_pci(dev)) &&
> 	    dma_mask >= DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)) {
> 		set_dma_ops(dev, &dma_direct_ops);
> 		set_dma_offset(dev, pci64_dma_offset);
>-- 
>1.7.1
>
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Richard Yang
Help you, Help me
