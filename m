Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39E1B1A06D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 19:13:47 +1000 (EST)
Message-ID: <53884BC6.8030904@suse.de>
Date: Fri, 30 May 2014 11:13:42 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/pseries: Use new defines when calling h_set_mode
References: <1401106626-13130-1-git-send-email-paulus@samba.org>	
 <1401106626-13130-4-git-send-email-paulus@samba.org>	
 <5385E620.5090703@suse.de> <1401342462.4116.4.camel@ale.ozlabs.ibm.com>	
 <1401344549.4116.8.camel@ale.ozlabs.ibm.com>	
 <BD1CF085-FEBC-4208-AD3F-C55DB002097F@suse.de>	
 <1401349547.4116.19.camel@ale.ozlabs.ibm.com>	
 <1401440207.29324.10.camel@concordia>
 <1401441046.13479.2.camel@ale.ozlabs.ibm.com>
In-Reply-To: <1401441046.13479.2.camel@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 30.05.14 11:10, Michael Neuling wrote:
> On Fri, 2014-05-30 at 18:56 +1000, Michael Ellerman wrote:
>> On Thu, 2014-05-29 at 17:45 +1000, Michael Neuling wrote:
>>>>> +/* Values for 2nd argument to H_SET_MODE */
>>>>> +#define H_SET_MODE_RESOURCE_SET_CIABR        1
>>>>> +#define H_SET_MODE_RESOURCE_SET_DAWR        2
>>>>> +#define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE    3
>>>>> +#define H_SET_MODE_RESOURCE_LE            4
>>>> Much better, but I think you want to make use of these in non-kvm code too,
>>>> no? At least the LE one is definitely already implemented as call :)
>>> powerpc/pseries: Use new defines when calling h_set_mode
>>>
>>> Now that we define these in the KVM code, use these defines when we call
>>> h_set_mode.  No functional change.
>>>
>>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>>> --
>>> This depends on the KVM h_set_mode patches.
>>>
>>> diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
>>> index 12c32c5..67859ed 100644
>>> --- a/arch/powerpc/include/asm/plpar_wrappers.h
>>> +++ b/arch/powerpc/include/asm/plpar_wrappers.h
>>> @@ -273,7 +273,7 @@ static inline long plpar_set_mode(unsigned long mflags, unsigned long resource,
>>>   static inline long enable_reloc_on_exceptions(void)
>>>   {
>>>   	/* mflags = 3: Exceptions at 0xC000000000004000 */
>>> -	return plpar_set_mode(3, 3, 0, 0);
>>> +	return plpar_set_mode(3, H_SET_MODE_RESOURCE_ADDR_TRANS_MODE, 0, 0);
>>>   }
>> Which header are these coming from, and why aren't we including it? And is it
>> going to still build with CONFIG_KVM=n?
>  From include/asm/hvcall.h in the h_set_mode patch set I sent before.
>
> And yes it compiles with CONFIG_KVM=n fine.

Please split that patch into one that adds the definitions and one that 
changes the KVM code to use those definitions. Both Ben and me can then 
apply the definition patch and our respective tree patch.


Alex
