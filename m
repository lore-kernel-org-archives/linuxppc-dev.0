Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1238E1A086B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 13:46:42 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E4166140FDB
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 13:46:41 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 12:46:40 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 983E13578055
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 13:46:37 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9D2kOHB36962476
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 13:46:32 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9D2k4KL007066
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 13:46:04 +1100
Date: Tue, 13 Oct 2015 10:45:45 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, aik@ozlabs.ru,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH V5 2/6] powerpc/powernv: simplify the calculation of iov
 resource alignment
Message-ID: <20151013024545.GC1437@Richards-MacBook-Pro.local>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1444358816-8163-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1444358816-8163-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <20151013001350.GA21778@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151013001350.GA21778@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2015 at 11:13:50AM +1100, Gavin Shan wrote:
>On Fri, Oct 09, 2015 at 10:46:52AM +0800, Wei Yang wrote:
>>The alignment of IOV BAR on PowerNV platform is the total size of the IOV
>>BAR. No matter whether the IOV BAR is extended with number of
>>roundup_pow_of_two(total_vfs) or number of max PE number (256), the total
>>size could be calculated by (vfs_expanded * VF_BAR_size).
>>
>>This patch simplifies the pnv_pci_iov_resource_alignment() by removing the
>>first case.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>---
>> arch/powerpc/platforms/powernv/pci-ioda.c | 20 ++++++++++++--------
>> 1 file changed, 12 insertions(+), 8 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 8c031b5..7da476b 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -2988,17 +2988,21 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
>> 						      int resno)
>> {
>> 	struct pci_dn *pdn = pci_get_pdn(pdev);
>>-	resource_size_t align, iov_align;
>>-
>>-	iov_align = resource_size(&pdev->resource[resno]);
>>-	if (iov_align)
>>-		return iov_align;
>>+	resource_size_t align;
>>
>>+	/*
>>+	 * On PowerNV platform, IOV BAR is mapped by M64 BAR to enable the
>>+	 * SR-IOV. While from hardware perspective, the range mapped by M64
>>+	 * BAR should be size aligned.
>>+	 *
>>+	 * This function returns the total IOV BAR size if M64 BAR is in
>>+	 * Shared PE mode or just the individual size if not.
>>+	 */
>
>s/the invidial size/VF BAR size
>
>> 	align = pci_iov_resource_size(pdev, resno);
>>-	if (pdn->vfs_expanded)
>>-		return pdn->vfs_expanded * align;
>>+	if (!pdn->vfs_expanded)
>>+		return align;
>>
>>-	return align;
>>+	return pdn->vfs_expanded * align;
>
>There is no difference before/after the changes. why this change is needed?
>

After change the logic is more clear.

Alignment equals to the total size when IOV BAR is expanded or equals to the
VF BAR size. We don't need to check whether IOV BAR is truncated.

>> }
>> #endif /* CONFIG_PCI_IOV */
>>
>>-- 
>>2.5.0
>>

-- 
Richard Yang
Help you, Help me
