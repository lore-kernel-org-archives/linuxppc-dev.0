Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E81A21A0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 18:13:22 +1000 (AEST)
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3C189140280
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 18:13:22 +1000 (AEST)
Received: by pabxd6 with SMTP id xd6so64774734pab.2
 for <linuxppc-dev@ozlabs.org>; Fri, 07 Aug 2015 01:13:20 -0700 (PDT)
Subject: Re: [PATCH V2 3/6] powerpc/powernv: use one M64 BAR in Single PE mode
 for one VF BAR
To: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150806052025.GC28524@gwshan> <20150806093602.GA13055@richard>
 <20150806100701.GA5988@gwshan> <20150807014818.GC8292@richard>
Cc: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C4689A.6020805@ozlabs.ru>
Date: Fri, 7 Aug 2015 18:13:14 +1000
MIME-Version: 1.0
In-Reply-To: <20150807014818.GC8292@richard>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/07/2015 11:48 AM, Wei Yang wrote:
> On Thu, Aug 06, 2015 at 08:07:01PM +1000, Gavin Shan wrote:
>> On Thu, Aug 06, 2015 at 05:36:02PM +0800, Wei Yang wrote:
>>> On Thu, Aug 06, 2015 at 03:20:25PM +1000, Gavin Shan wrote:
>>>> On Wed, Aug 05, 2015 at 09:25:00AM +0800, Wei Yang wrote:
>>>>> In current implementation, when VF BAR is bigger than 64MB, it uses 4 M64
>>>>> BAR in Single PE mode to cover the number of VFs required to be enabled.
>>>>> By doing so, several VFs would be in one VF Group and leads to interference
>>>>> between VFs in the same group.
>>>>>
>>>>> This patch changes the design by using one M64 BAR in Single PE mode for
>>>>> one VF BAR. This gives absolute isolation for VFs.
>>>>>
>>>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>>> ---
>>>>> arch/powerpc/include/asm/pci-bridge.h     |    5 +-
>>>>> arch/powerpc/platforms/powernv/pci-ioda.c |  180 ++++++++++++-----------------
>>>>> 2 files changed, 76 insertions(+), 109 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>>>> index 712add5..8aeba4c 100644
>>>>> --- a/arch/powerpc/include/asm/pci-bridge.h
>>>>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>>>>> @@ -214,10 +214,9 @@ struct pci_dn {
>>>>> 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>>>>> 	u16     num_vfs;		/* number of VFs enabled*/
>>>>> 	int     offset;			/* PE# for the first VF PE */
>>>>> -#define M64_PER_IOV 4
>>>>> -	int     m64_per_iov;
>>>>> +	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
>>>>> #define IODA_INVALID_M64        (-1)
>>>>> -	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
>>>>> +	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
>>>>
>>>> It can be explicit? For example:
>>>>
>>>> 	int	*m64_map;
>>>>
>>>> 	/* Initialization */
>>>> 	size_t size = sizeof(*pdn->m64_map) * PCI_SRIOV_NUM_BARS * num_of_max_VFs;
>>>> 	pdn->m64_map = kmalloc(size, GFP_KERNEL);
>>>> 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
>>>> 		for (j = 0; j < num_of_max_VFs; j++)
>>>> 			pdn->m64_map[i * PCI_SRIOV_NUM_BARS + j] = PNV_INVALID_M64;
>>>>
>>>> 	/* Destroy */
>>>> 	int step = 1;
>>>>
>>>> 	if (!pdn->m64_single_mode)
>>>> 		step = phb->ioda.total_pe;
>>>> 	for (i = 0; i < PCI_SRIOV_NUM_BARS * num_of_max_VFs; i += step)
>>>> 		if (pdn->m64_map[i] == PNV_INVALID_M64)
>>>> 			continue;
>>>>
>>>> 		/* Unmap the window */
>>>> 	
>>>
>>> The m64_map is a pointer to an array with 6 elements, which represents the 6
>>> M64 BAR index for the 6 VF BARs.
>>>
>>>     When we use Shared Mode, one array is allocated. The six elements
>>>     represents the six M64 BAR(at most) used to map the whole IOV BAR.
>>>
>>>     When we use Single Mode, num_vfs array is allocate. Each array represents
>>>     the map between one VF's BAR and M64 BAR index.
>>>
>>> During the map and un-map, M64 BAR is assigned one by one in VF BAR's order.
>>> So I think the code is explicit.
>>>
>>> In your code, you allocate a big one dimension array to hold the M64 BAR
>>> index. It works, while I don't think this is more explicit than original code.
>>>
>>
>> When M64 is in Single Mode, array with (num_vfs * 6) entries is allocated
>> because every VF BAR (6 at most) will have one corresponding PHB M64 BAR.
>> Anything I missed?
>>
>> The point in my code is you needn't worry about the mode (single vs shared)
>> As I said, not too much memory wasted. However, it's up to you.
>>
>
> If we don't want to save some memory, how about just define them static
> instead of dynamically allocate?


I like static and you can make it uint8_t[][] (or char[][]) as these 
indexes are not going to be bigger than 255 anyway.



>> I'm not fan of "int (*m64_map)[PCI_SRIOV_NUM_BARS]". Instead, you can replace
>> it with "int *m64_map" and calculate its size using following formula:
>>
>> 	sizeof(*pdn->m64_map) * PCI_SRIOV_NUM_BARS;
>>
>> 	sizeof(*pdn->m64_map) * PCI_SRIOV_NUM_BARS * num_vfs;




-- 
Alexey
