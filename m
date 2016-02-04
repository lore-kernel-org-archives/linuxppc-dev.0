Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FA531A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 22:12:22 +1100 (AEDT)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 4 Feb 2016 16:42:19 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u14BCHmW50331652
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Feb 2016 16:42:17 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u14BBDop020824
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Feb 2016 16:41:14 +0530
Message-ID: <56B331CE.5020806@linux.vnet.ibm.com>
Date: Thu, 04 Feb 2016 16:41:10 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: lvivier@redhat.com, thuth@redhat.com, aik@ozlabs.ru, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 6/9] pseries: Add hypercall wrappers for hash page table
 resizing
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-7-git-send-email-david@gibson.dropbear.id.au>
 <56AF0523.60902@linux.vnet.ibm.com> <20160202005820.GB15080@voom.fritz.box>
In-Reply-To: <20160202005820.GB15080@voom.fritz.box>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/2016 06:28 AM, David Gibson wrote:
> On Mon, Feb 01, 2016 at 12:41:31PM +0530, Anshuman Khandual wrote:
>> On 01/29/2016 10:54 AM, David Gibson wrote:
>>> This adds the hypercall numbers and wrapper functions for the hash page
>>> table resizing hypercalls.
>>>
>>> These are experimental "platform specific" values for now, until we have a
>>> formal PAPR update.
>>>
>>> It also adds a new firmware feature flat to track the presence of the
>>> HPT resizing calls.
>>
>> Its a flag   ....................... ^^^^^^^ here.
> 
> Oops, thanks.
> 
>>
>>>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>>  arch/powerpc/include/asm/firmware.h       |  5 +++--
>>>  arch/powerpc/include/asm/hvcall.h         |  2 ++
>>>  arch/powerpc/include/asm/plpar_wrappers.h | 12 ++++++++++++
>>>  arch/powerpc/platforms/pseries/firmware.c |  1 +
>>>  4 files changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
>>> index b062924..32435d2 100644
>>> --- a/arch/powerpc/include/asm/firmware.h
>>> +++ b/arch/powerpc/include/asm/firmware.h
>>> @@ -42,7 +42,7 @@
>>>  #define FW_FEATURE_SPLPAR	ASM_CONST(0x0000000000100000)
>>>  #define FW_FEATURE_LPAR		ASM_CONST(0x0000000000400000)
>>>  #define FW_FEATURE_PS3_LV1	ASM_CONST(0x0000000000800000)
>>> -/* Free				ASM_CONST(0x0000000001000000) */
>>> +#define FW_FEATURE_HPT_RESIZE	ASM_CONST(0x0000000001000000)
>>>  #define FW_FEATURE_CMO		ASM_CONST(0x0000000002000000)
>>>  #define FW_FEATURE_VPHN		ASM_CONST(0x0000000004000000)
>>>  #define FW_FEATURE_XCMO		ASM_CONST(0x0000000008000000)
>>> @@ -66,7 +66,8 @@ enum {
>>>  		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
>>>  		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
>>>  		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
>>> -		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
>>> +		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
>>> +		FW_FEATURE_HPT_RESIZE,
>>>  	FW_FEATURE_PSERIES_ALWAYS = 0,
>>>  	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
>>>  	FW_FEATURE_POWERNV_ALWAYS = 0,
>>> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
>>> index e3b54dd..195e080 100644
>>> --- a/arch/powerpc/include/asm/hvcall.h
>>> +++ b/arch/powerpc/include/asm/hvcall.h
>>> @@ -293,6 +293,8 @@
>>>  
>>>  /* Platform specific hcalls, used by KVM */
>>>  #define H_RTAS			0xf000
>>> +#define H_RESIZE_HPT_PREPARE	0xf003
>>> +#define H_RESIZE_HPT_COMMIT	0xf004
>>
>> This sound better and matches FW_FEATURE_HPT_RESIZE ?
> 
> I'm not quite sure what you're suggesting here.
> 
>> #define H_HPT_RESIZE_PREPARE	0xf003
>> #define H_HPT_RESIZE_COMMIT	0xf004

Just little bit of change of name of the macro like this


H_RESIZE_HPT_PREPARE -->  H_HPT_RESIZE_PREPARE
H_RESIZE_HPT_COMMIT -->  H_HPT_RESIZE_COMMIT
