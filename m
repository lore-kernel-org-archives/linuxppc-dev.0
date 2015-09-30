Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C5231A030D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 09:51:07 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 1 Oct 2015 05:21:04 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4C3F43940049
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 05:21:00 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8UNoxil11665826
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 05:20:59 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8UNowCV011375
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 05:20:58 +0530
Date: Thu, 1 Oct 2015 07:50:55 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/iommu: use iommu_num_pages() to calculate the
 number of iommu page
Message-ID: <20150930235054.GA1530@Richards-MBP.lan>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1442667867-1802-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442667867-1802-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hmm... some comments on this one? like it or not?

On Sat, Sep 19, 2015 at 09:04:27PM +0800, Wei Yang wrote:
>On PowerPC, currently we support different value of PAGE_SIZE and different
>value of IOMMU Page Size.
>
>In case the PAGE_SIZE is 4K and the IOMMU Page Size is 16M, and driver
>asked for some DMA less than 16M, the current calculation would return 0
>and the following allocation in iommu_alloc() would fail.
>
>This patch uses iommu_num_pages() to calculate it.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> arch/powerpc/kernel/iommu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>index a8e3490..9885397 100644
>--- a/arch/powerpc/kernel/iommu.c
>+++ b/arch/powerpc/kernel/iommu.c
>@@ -842,7 +842,7 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
> 	memset(ret, 0, size);
>
> 	/* Set up tces to cover the allocated range */
>-	nio_pages = size >> tbl->it_page_shift;
>+	nio_pages = iommu_num_pages(0, size, IOMMU_PAGE_SIZE(tbl));
> 	io_order = get_iommu_order(size, tbl);
> 	mapping = iommu_alloc(dev, tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
> 			      mask >> tbl->it_page_shift, io_order, NULL);
>-- 
>2.5.0

-- 
Richard Yang
Help you, Help me
