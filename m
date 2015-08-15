Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B3BC1A009B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 20:21:40 +1000 (AEST)
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C08691401AF
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2015 20:21:38 +1000 (AEST)
Received: by pabyb7 with SMTP id yb7so75063796pab.0
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2015 03:21:36 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] powerpc/powernv: boundary the total VF BAR size
 instead of the individual one
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439475071-7001-6-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150814005735.GB18334@gwshan>
Cc: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55CF12AA.4070602@ozlabs.ru>
Date: Sat, 15 Aug 2015 20:21:30 +1000
MIME-Version: 1.0
In-Reply-To: <20150814005735.GB18334@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/14/2015 10:57 AM, Gavin Shan wrote:
> On Thu, Aug 13, 2015 at 10:11:10PM +0800, Wei Yang wrote:
>> Each VF could have 6 BARs at most. When the total BAR size exceeds the
>> gate, after expanding it will also exhaust the M64 Window.
>>
>> This patch limits the boundary by checking the total VF BAR size instead of
>> the individual BAR.
>>
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>> ---
>> arch/powerpc/platforms/powernv/pci-ioda.c |   13 +++++++------
>> 1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 3e8c0b4..1e6ac86 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -2688,7 +2688,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>> 	struct pnv_phb *phb;
>> 	struct resource *res;
>> 	int i;
>> -	resource_size_t size, gate;
>> +	resource_size_t size, gate, total_vf_bar_sz;
>> 	struct pci_dn *pdn;
>> 	int mul, total_vfs;
>>
>> @@ -2715,6 +2715,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>> 	 * which will exhaust the M64 Space and limit the system flexibility.
>> 	 */
>> 	gate = phb->ioda.m64_segsize >> 1;
>> +	total_vf_bar_sz = 0;
>>
>> 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>> 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>> @@ -2727,13 +2728,13 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>> 			return;
>> 		}
>>
>> -		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>> +		total_vf_bar_sz += pci_iov_resource_size(pdev,
>> +				i + PCI_IOV_RESOURCES);
>>
>> 		/* bigger than or equal to gate */
>> -		if (size >= gate) {
>> -			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size "
>> -				"is bigger than %lld, roundup power2\n",
>> -				 i, res, gate);
>> +		if (total_vf_bar_sz >= gate) {
>> +			dev_info(&pdev->dev, "PowerNV: VF BAR Total IOV size "
>> +				"is bigger than %lld, roundup power2\n", gate);
>
> 			dev_info(&pdev->dev, "PowerNV: Total VF BAR size %lld "
> 				 "is bigger than %lld, roundup power2\n",
> 				 total_vf_bar_sz, gate);

Please do not split user visible lines, the 80 chars rule does not apply 
for string constants. But since we are still better not to go too far from 
80 symbols, remove ", roundup power2" or make the message shorter somehow 
else. Like:

dev_info(&pdev->dev,
	"PowerNV: Total VF BAR size %lld > %lld, roundup to %lld\n",
	total_vf_bar_sz, gate, mul);

and move it after roundup_pow_of_two() call.
And "PowerNV" prefix does not seem necessary either (it is not used very 
often and even without the prefix it is quite obvious that this is powernv 
and you could still grep for this message in the kernel source tree).


>
>> 			mul = roundup_pow_of_two(total_vfs);
>> 			pdn->m64_single_mode = true;
>> 			break;
>> --
>> 1.7.9.5
>>
>


-- 
Alexey
