Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C3991A0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 20:00:47 +1000 (AEST)
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 27B95140280
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 20:00:45 +1000 (AEST)
Received: by pdrg1 with SMTP id g1so43816055pdr.2
 for <linuxppc-dev@ozlabs.org>; Fri, 07 Aug 2015 03:00:43 -0700 (PDT)
Subject: Re: [PATCH V2 6/6] powerpc/powernv: allocate discrete PE# when using
 M64 BAR in Single PE mode
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150806053601.GB5636@gwshan> <20150806134141.GA6235@richard>
 <20150807013656.GB20794@gwshan> <20150807023333.GH8292@richard>
 <20150807034301.GA8624@gwshan> <20150807054433.GA7971@richard>
 <20150807055448.GA26338@gwshan>
Cc: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C481C6.2080106@ozlabs.ru>
Date: Fri, 7 Aug 2015 20:00:38 +1000
MIME-Version: 1.0
In-Reply-To: <20150807055448.GA26338@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/07/2015 03:54 PM, Gavin Shan wrote:
> On Fri, Aug 07, 2015 at 01:44:33PM +0800, Wei Yang wrote:
>> On Fri, Aug 07, 2015 at 01:43:01PM +1000, Gavin Shan wrote:
>>> On Fri, Aug 07, 2015 at 10:33:33AM +0800, Wei Yang wrote:
>>>> On Fri, Aug 07, 2015 at 11:36:56AM +1000, Gavin Shan wrote:
>>>>> On Thu, Aug 06, 2015 at 09:41:41PM +0800, Wei Yang wrote:
>>>>>> On Thu, Aug 06, 2015 at 03:36:01PM +1000, Gavin Shan wrote:
>>>>>>> On Wed, Aug 05, 2015 at 09:25:03AM +0800, Wei Yang wrote:
>>>>>>>> When M64 BAR is set to Single PE mode, the PE# assigned to VF could be
>>>>>>>> discrete.

s/discrete/sparse/ may be?


>>>>>>>>
>>>>>>>> This patch restructures the patch to allocate discrete PE# for VFs when M64
>>>>>>>> BAR is set to Single PE mode.
>>>>>>>>
>>>>>>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>>>>>> ---
>>>>>>>> arch/powerpc/include/asm/pci-bridge.h     |    2 +-
>>>>>>>> arch/powerpc/platforms/powernv/pci-ioda.c |   69 +++++++++++++++++++++--------
>>>>>>>> 2 files changed, 51 insertions(+), 20 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>>>>>>> index 8aeba4c..72415c7 100644
>>>>>>>> --- a/arch/powerpc/include/asm/pci-bridge.h
>>>>>>>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>>>>>>>> @@ -213,7 +213,7 @@ struct pci_dn {
>>>>>>>> #ifdef CONFIG_PCI_IOV
>>>>>>>> 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>>>>>>>> 	u16     num_vfs;		/* number of VFs enabled*/
>>>>>>>> -	int     offset;			/* PE# for the first VF PE */
>>>>>>>> +	int     *offset;		/* PE# for the first VF PE or array */
>>>>>>>> 	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
>>>>>>>> #define IODA_INVALID_M64        (-1)
>>>>>>>> 	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
>>>>>>>
>>>>>>> how about renaming "offset" to "pe_num_map", or "pe_map" ? Similar to the comments
>>>>>>> I gave to the "m64_bar_map", num_of_max_vfs entries can be allocated. Though not
>>>>>>> all of them will be used, not too much memory will be wasted.
>>>>>>>
>>>>>>
>>>>>> Thanks for your comment.
>>>>>>
>>>>>> I have thought about change the name to make it more self explain. While
>>>>>> another fact I want to take in is this field is also used to be reflect the
>>>>>> shift offset when M64 BAR is used in the Shared Mode. So I maintain the name.
>>>>>>
>>>>>> How about use "enum", one maintain the name "offset", and another one rename to
>>>>>> "pe_num_map". And use the meaningful name at proper place?
>>>>>>
>>>>
>>>> So I suppose you agree with my naming proposal.
>>>>
>>>
>>> No, I dislike the "enum" things.
>>>
>>
>> OK, then you suggest to rename it pe_num_map or keep it as offset?
>>
>
> pe_num_map would be better.


+1. @offset is very confusing.

It could be a linked list actually, "struct list_head pe_list" in pci_dn 
and "struct list_head next" in struct pnv_ioda_pe.  I could not quickly 
spot places where you would access this array outside a loop 
for(i=0;i<num_vfs;++i).



-- 
Alexey
