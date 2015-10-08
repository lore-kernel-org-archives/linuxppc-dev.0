Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0EE9F1A0142
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 18:13:41 +1100 (AEDT)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1D726140D72
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 18:13:39 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 12:43:36 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E0E881258018
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 12:43:12 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t987DDKH065920
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 12:43:13 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t987DCMU023333
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 12:43:12 +0530
Date: Thu, 8 Oct 2015 15:13:11 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V4 5/6] powerpc/powernv: boundary the total VF BAR size
 instead of the individual one
Message-ID: <20151008071311.GD3309@Richards-MacBook-Pro.local>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439949704-8023-6-git-send-email-weiyang@linux.vnet.ibm.com>
 <560E5395.7080601@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <560E5395.7080601@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 02, 2015 at 07:51:17PM +1000, Alexey Kardashevskiy wrote:
>On 08/19/2015 12:01 PM, Wei Yang wrote:
>>Each VF could have 6 BARs at most. When the total BAR size exceeds the
>>gate, after expanding it will also exhaust the M64 Window.
>>
>>This patch limits the boundary by checking the total VF BAR size instead of
>>the individual BAR.
>
>The gate is the biggest segment size in PE in shared mode, right? And this is
>64MB. Also, BARs with the same number of all VFs of the same physical adapter
>will be mapper contiguously (as one huge IOV BAR), for example, 2 VFs, 2 BARs
>each, mapping will look like:
>VF0-BAR0, VF1-BAR0, VF0-BAR1, VF1-BAR1
>but not like this:
>VF0-BAR0, VF0-BAR1, VF1-BAR0, VF1-BAR1
>Is this correct?
>

Yes, your understanding is correct. It will look like:

VF0-BAR0, VF1-BAR0, VF0-BAR1, VF1-BAR1

>
>
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c |   14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index b8bc51f..4bc83b8 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -2701,7 +2701,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>  	const resource_size_t gate = phb->ioda.m64_segsize >> 2;
>>  	struct resource *res;
>>  	int i;
>>-	resource_size_t size;
>>+	resource_size_t size, total_vf_bar_sz;
>>  	struct pci_dn *pdn;
>>  	int mul, total_vfs;
>>
>>@@ -2714,6 +2714,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>
>>  	total_vfs = pci_sriov_get_totalvfs(pdev);
>>  	mul = phb->ioda.total_pe;
>>+	total_vf_bar_sz = 0;
>>
>>  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>>  		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>>@@ -2726,7 +2727,8 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>  			return;
>>  		}
>>
>>-		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>>+		total_vf_bar_sz += pci_iov_resource_size(pdev,
>>+				i + PCI_IOV_RESOURCES);
>
>
>Is @pdev a physical device in this context? I assume it is so
>pci_iov_resource_size() returns the entire IOV BAR size.
>For example, I have a Mellanox card with 16 VFs, each has a single 32MB BAR
>so total_vf_bar_sz will be 16*32=512MB and this will exceed the @gate size
>and we end up having m64_single_mode = true. What do I miss here?
>

@pdev is a PF here.

But pci_iov_resource_size() return VF BAR size instead of the entire IOV BAR
size.

The iov->barsz[] is set in sriov_init(). You could take a look at it.

>
>>
>>  		/*
>>  		 * If bigger than quarter of M64 segment size, just round up
>>@@ -2740,11 +2742,11 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>  		 * limit the system flexibility.  This is a design decision to
>>  		 * set the boundary to quarter of the M64 segment size.
>>  		 */
>>-		if (size > gate) {
>>-			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size "
>>-				"is bigger than %lld, roundup power2\n",
>>-				 i, res, gate);
>>+		if (total_vf_bar_sz > gate) {
>>  			mul = roundup_pow_of_two(total_vfs);
>>+			dev_info(&pdev->dev,
>>+				"VF BAR Total IOV size %llx > %llx, roundup to %d VFs\n",
>>+				total_vf_bar_sz, gate, mul);
>>  			pdn->m64_single_mode = true;
>>  			break;
>>  		}
>>
>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me
