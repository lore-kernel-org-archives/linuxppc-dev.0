Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 669F91A45F7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:52:42 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F26871402BD
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 14:52:41 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:52:40 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 93F672BB0059
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 14:52:37 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764qTbk63438888
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 14:52:37 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764q43d020419
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 14:52:04 +1000
Date: Thu, 6 Aug 2015 14:51:40 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 2/6] powerpc/powernv: simplify the calculation of iov
 resource
Message-ID: <20150806045139.GB28524@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-3-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438737903-10399-3-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 05, 2015 at 09:24:59AM +0800, Wei Yang wrote:
>The alignment of IOV BAR on PowerNV platform is the total size of the IOV
>BAR. No matter whether the IOV BAR is truncated or not, the total size
>could be calculated by (vfs_expanded * VF size).
>

s/VF size/VF BAR size

I think the changelog would be more explicit:

The alignment of IOV BAR on PowerNV platform is the total size of the
IOV BAR, no matter whether the IOV BAR is extended with number of max
VFs or number of max PE number (256). The alignment can be calculated
by (vfs_expaned * VF_BAR_size).

>This patch simplifies the pnv_pci_iov_resource_alignment() by removing the
>first case.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> arch/powerpc/platforms/powernv/pci-ioda.c |   14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 9b41dba..7192e62 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -2987,12 +2987,16 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
> 						      int resno)
> {
> 	struct pci_dn *pdn = pci_get_pdn(pdev);
>-	resource_size_t align, iov_align;
>-
>-	iov_align = resource_size(&pdev->resource[resno]);
>-	if (iov_align)
>-		return iov_align;
>+	resource_size_t align;
>
>+	/*
>+	 * On PowerNV platform, IOV BAR is mapped by M64 BAR to enable the
>+	 * SR-IOV. While from hardware perspective, the range mapped by M64
>+	 * BAR should be size aligned.
>+	 *
>+	 * This function return the total IOV BAR size if expanded or just the
>+	 * individual size if not.
>+	 */
> 	align = pci_iov_resource_size(pdev, resno);
> 	if (pdn->vfs_expanded)
> 		return pdn->vfs_expanded * align;
>-- 
>1.7.9.5
>
