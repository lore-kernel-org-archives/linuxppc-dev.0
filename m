Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF4501A0372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 12:21:38 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 48B961402A0
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2015 12:21:38 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 17 Aug 2015 07:51:35 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5A06A3940060
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2015 07:51:33 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7H2LVtf62587062
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2015 07:51:31 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7H2LViR030422
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2015 07:51:31 +0530
Date: Mon, 17 Aug 2015 10:21:29 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 4/6] powerpc/powernv: replace the hard coded boundary
 with gate
Message-ID: <20150817022129.GA6748@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439475071-7001-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <55CF13F8.2070906@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55CF13F8.2070906@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 15, 2015 at 08:27:04PM +1000, Alexey Kardashevskiy wrote:
>On 08/14/2015 12:11 AM, Wei Yang wrote:
>>At the moment 64bit-prefetchable window can be maximum 64GB, which is
>>currently got from device tree. This means that in shared mode the maximum
>>supported VF BAR size is 64GB/256=256MB. While this size could exhaust the
>>whole 64bit-prefetchable window. This is a design decision to set a
>>boundary to 64MB of the VF BAR size. Since VF BAR size with 64MB would
>>occupy a quarter of the 64bit-prefetchable window, this is affordable.
>>
>>This patch replaces magic limit of 64MB with (m64_segsize >> 1) and adds
>>comment to explain the reason for it.
>
>
>Having m64_segsize divided in _halves_ is also magic (or is it a
>"design decision"?).
>

Hmm... as the last sentence in previous paragraph said, 64MB VF BAR would
occupy a quarter of the 64bit-prefetchable window which is affordable.

Maybe I could change to this:

   This patch replaces magic limit of 64MB with "gate", which is 1/4 of the
   M64 Segment Size(m64_segsize >> 2) and adds comment to explain the reason
   for it.

This time I use (m64_segsize >> 2) instead of (m64_segsize >> 1), since I
decide to still use ">" instead of ">=". By doing so, the explanation in
commit log is consistent with the code. 

>
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c |   22 +++++++++++++++++-----
>>  1 file changed, 17 insertions(+), 5 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 4da0f50..3e8c0b4 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -2688,7 +2688,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>  	struct pnv_phb *phb;
>>  	struct resource *res;
>>  	int i;
>>-	resource_size_t size;
>>+	resource_size_t size, gate;
>
>It should be:
>const resource_size_t gate = phb->ioda.m64_segsize >> 1;
>
>as it never changes in the function.

Good.

>
>
>>  	struct pci_dn *pdn;
>>  	int mul, total_vfs;
>>
>>@@ -2704,6 +2704,17 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>
>>  	total_vfs = pci_sriov_get_totalvfs(pdev);
>>  	mul = phb->ioda.total_pe;
>>+	/*
>>+	 * If bigger than or equal to half of M64 segment size, just round up
>>+	 * power of two.
>>+	 *
>>+	 * Generally, one M64 BAR maps one IOV BAR. To avoid conflict with
>>+	 * other devices, IOV BAR size is expanded to be (total_pe *
>>+	 * VF_BAR_size).  When VF_BAR_size is half of M64 segment size , the
>>+	 * expanded size would equal to half of the whole M64 Space size,
>>+	 * which will exhaust the M64 Space and limit the system flexibility.
>>+	 */
>>+	gate = phb->ioda.m64_segsize >> 1;
>>
>>  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>>  		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>>@@ -2718,10 +2729,11 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>
>>  		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>>
>>-		/* bigger than 64M */
>>-		if (size > (1 << 26)) {
>>-			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size is bigger than 64M, roundup power2\n",
>>-				 i, res);
>>+		/* bigger than or equal to gate */
>
>
>That multiline comment is better to be here, I think.
>

As you wish.

>
>>+		if (size >= gate) {
>>+			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size "
>>+				"is bigger than %lld, roundup power2\n",
>>+				 i, res, gate);
>>  			mul = roundup_pow_of_two(total_vfs);
>>  			pdn->m64_single_mode = true;
>>  			break;
>>
>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me
