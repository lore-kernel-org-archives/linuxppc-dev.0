Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD2E21A009B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 00:03:56 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9CB371402B9
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 00:03:56 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 00:03:56 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 095823578057
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 00:03:55 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t76E3k5H24379564
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2015 00:03:55 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t76E3MKB006802
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2015 00:03:22 +1000
Date: Thu, 6 Aug 2015 22:03:04 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, aik@ozlabs.ru,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 5/6] powerpc/powernv: boundary the total vf bar size
 instead of the individual one
Message-ID: <20150806140304.GC6235@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-6-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150806052851.GA5636@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150806052851.GA5636@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 06, 2015 at 03:28:51PM +1000, Gavin Shan wrote:
>On Wed, Aug 05, 2015 at 09:25:02AM +0800, Wei Yang wrote:
>>Each VF could have 6 BARs at most. When the total BAR size exceeds the
>>gate, after expanding it will also exhaust the M64 Window.
>>
>>This patch limits the boundary by checking the total VF BAR size instead of
>>the individual BAR.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>
>Ok. I didn't look at this when giving comments to last patch. It turns
>you have the change in this patch. Please merge it with the previous
>patch.
>

Hmm... I prefer to have them in two patches. One focus on the calculation of
gate and the other focus on checking the total VF BAR size. This would help
record the change.

>>---
>> arch/powerpc/platforms/powernv/pci-ioda.c |   13 +++++++------
>> 1 file changed, 7 insertions(+), 6 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 31dcedc..4042303 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -2702,7 +2702,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>> 	struct pnv_phb *phb;
>> 	struct resource *res;
>> 	int i;
>>-	resource_size_t size, gate;
>>+	resource_size_t size, gate, total_vf_bar_sz;
>> 	struct pci_dn *pdn;
>> 	int mul, total_vfs;
>>
>>@@ -2729,6 +2729,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>> 	 * Window and limit the system flexibility.
>> 	 */
>> 	gate = phb->ioda.m64_segsize >> 1;
>>+	total_vf_bar_sz = 0;
>>
>> 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>> 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>>@@ -2741,13 +2742,13 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>> 			return;
>> 		}
>>
>>-		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>>+		total_vf_bar_sz += pci_iov_resource_size(pdev,
>>+				i + PCI_IOV_RESOURCES);
>>
>> 		/* bigger than or equal to gate */
>>-		if (size >= gate) {
>>-			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size "
>>-				"is bigger than %lld, roundup power2\n",
>>-				 i, res, gate);
>>+		if (total_vf_bar_sz >= gate) {
>>+			dev_info(&pdev->dev, "PowerNV: VF BAR Total IOV size "
>>+				"is bigger than %lld, roundup power2\n", gate);
>> 			mul = roundup_pow_of_two(total_vfs);
>> 			pdn->m64_single_mode = true;
>> 			break;
>>-- 
>>1.7.9.5
>>

-- 
Richard Yang
Help you, Help me
