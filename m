Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 73EAC1A1D0D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 12:25:49 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A721014027F
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 12:25:48 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 07:55:46 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id A9EEAE0059
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 07:59:59 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t772PhZR64356392
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2015 07:55:43 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t772PgvA000479
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2015 07:55:43 +0530
Date: Fri, 7 Aug 2015 10:25:41 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, aik@ozlabs.ru,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 5/6] powerpc/powernv: boundary the total vf bar size
 instead of the individual one
Message-ID: <20150807022541.GG8292@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-6-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150806052851.GA5636@gwshan> <20150806140304.GC6235@richard>
 <20150807012354.GA20794@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150807012354.GA20794@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 07, 2015 at 11:23:54AM +1000, Gavin Shan wrote:
>On Thu, Aug 06, 2015 at 10:03:04PM +0800, Wei Yang wrote:
>>On Thu, Aug 06, 2015 at 03:28:51PM +1000, Gavin Shan wrote:
>>>On Wed, Aug 05, 2015 at 09:25:02AM +0800, Wei Yang wrote:
>>>>Each VF could have 6 BARs at most. When the total BAR size exceeds the
>>>>gate, after expanding it will also exhaust the M64 Window.
>>>>
>>>>This patch limits the boundary by checking the total VF BAR size instead of
>>>>the individual BAR.
>>>>
>>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>
>>>Ok. I didn't look at this when giving comments to last patch. It turns
>>>you have the change in this patch. Please merge it with the previous
>>>patch.
>>>
>>
>>Hmm... I prefer to have them in two patches. One focus on the calculation of
>>gate and the other focus on checking the total VF BAR size. This would help
>>record the change.
>>
>
>It's fine to me as well. I'll take close look on your next revision since
>you have to refresh the whole series. Is that fine to you?
>

Fine and thanks for your comments.

>>>>---
>>>> arch/powerpc/platforms/powernv/pci-ioda.c |   13 +++++++------
>>>> 1 file changed, 7 insertions(+), 6 deletions(-)
>>>>
>>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>index 31dcedc..4042303 100644
>>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>@@ -2702,7 +2702,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>>> 	struct pnv_phb *phb;
>>>> 	struct resource *res;
>>>> 	int i;
>>>>-	resource_size_t size, gate;
>>>>+	resource_size_t size, gate, total_vf_bar_sz;
>>>> 	struct pci_dn *pdn;
>>>> 	int mul, total_vfs;
>>>>
>>>>@@ -2729,6 +2729,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>>> 	 * Window and limit the system flexibility.
>>>> 	 */
>>>> 	gate = phb->ioda.m64_segsize >> 1;
>>>>+	total_vf_bar_sz = 0;
>>>>
>>>> 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>>>> 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>>>>@@ -2741,13 +2742,13 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>>> 			return;
>>>> 		}
>>>>
>>>>-		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>>>>+		total_vf_bar_sz += pci_iov_resource_size(pdev,
>>>>+				i + PCI_IOV_RESOURCES);
>>>>
>>>> 		/* bigger than or equal to gate */
>>>>-		if (size >= gate) {
>>>>-			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size "
>>>>-				"is bigger than %lld, roundup power2\n",
>>>>-				 i, res, gate);
>>>>+		if (total_vf_bar_sz >= gate) {
>>>>+			dev_info(&pdev->dev, "PowerNV: VF BAR Total IOV size "
>>>>+				"is bigger than %lld, roundup power2\n", gate);
>>>> 			mul = roundup_pow_of_two(total_vfs);
>>>> 			pdn->m64_single_mode = true;
>>>> 			break;
>>>>-- 
>>>>1.7.9.5
>>>>
>>
>>-- 
>>Richard Yang
>>Help you, Help me

-- 
Richard Yang
Help you, Help me
