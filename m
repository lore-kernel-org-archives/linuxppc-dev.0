Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id C64D8680E1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Aug 2005 02:30:30 +1000 (EST)
Message-ID: <42FCCEA4.2030409@ru.mvista.com>
Date: Fri, 12 Aug 2005 20:30:28 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42FCC234.8070008@ru.mvista.com>
	<12EA7634-C020-4B0A-BCF0-80B11E4E55D2@freescale.com>
In-Reply-To: <12EA7634-C020-4B0A-BCF0-80B11E4E55D2@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] identify_ppc_sys_by_name_and_id function implementation
 final
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Can you do a sizeof instead?
> 
> #define num_ele sizeof(ppc_sys_specs[])/sizeof(struct ppc_sys_spec)
> 
> Something like matchted[num_ele] ??
> 

That's what the first I tried actually :)
gcc is not happy with it:

arch/ppc/syslib/ppc_sys.c: In function `find_chip_by_name_and_id':
arch/ppc/syslib/ppc_sys.c:54: error: parse error before ']' token

and if I remove [] from the ppc_sys_specs, it outputs:

arch/ppc/syslib/ppc_sys.c: In function `find_chip_by_name_and_id':
arch/ppc/syslib/ppc_sys.c:54: error: invalid application of `sizeof' to 
incomplete type `({anonymous})'

So I cannot use sizeof this case, I think...
> - kumar
> 
> On Aug 12, 2005, at 10:37 AM, Vitaly Bordug wrote:
> 
>> Marcelo Tosatti wrote:
>>
>>> On Thu, Aug 11, 2005 at 07:25:20PM +0400, Vitaly Bordug wrote:
>>>
>>>
>>>> Marcelo Tosatti wrote:
>>>>
>>>>
>>>>> On Wed, Aug 10, 2005 at 02:16:57PM -0500, Kumar Gala wrote:
>>>>>
>>>>>
>>>>>
>>>>>> +static int __init find_chip_by_name_and_id(char *name, u32 id)
>>>>>> +{
>>>>>> +    int ret = -1;
>>>>>> +    unsigned int i = 0;
>>>>>> +    unsigned int j = 0;
>>>>>> +    unsigned int dups = 0;
>>>>>> +
>>>>>> +    unsigned int matched[count_sys_specs()];
>>>>>>
>>>>>> Is is legit in the kernel to use dynamically sized array?
>>>>>>
>>>>>
>>>>>
>>>>> kmalloc() is certainly safer - why not use it?
>>>>>
>>>>
>>>> Practically , version with kmalloc works, but  setup_arch and  thus 
>>>> this
>>>> function is called before mem_init, so I just wonder if kmalloc can
>>>> handle this case. On the other hand, I don't like to deal with
>>>> alloc_bootmem() if mem_init_done!=1 and kmalloc otherwise (like ocp
>>>> does) just for the temporary buffer.
>>>>
>>>> But it's the only _right_ way (or I 've missed something) - sure  I'll
>>>> follow it.
>>>>
>>>
>>>
>>> I dont see any problem with dynamic array usage on the kernel  (maybe 
>>> someone
>>> else has good argumentation against it).
>>>
>>> Just that you have a 4kb stack. Does count_sys_specs() have an  
>>> appropriate
>>> maximum?
>>>
>>>
>>>
>> Yes it does, but there is no define for it. The ppc_sys_specs array
>> should always end at the "default match" - element with name field set
>> to "" and value=0 (without it every existing ppc_sys identify will  fall
>> into infinite loop). This array is defined in syslib/<board>_sys.c end
>> is finite of course. Its size depends on amount of supported boards.
>>
>> So, if the dynamic array is ok with conditions, it will be great.
>> But now I'm inclined to implement the same using kmalloc/alloc_bootmem
>> to prevent flame when it will proceed. BTW, will free_bootmem properly
>> release the memory allocated by alloc_bootmem()? I haven't encountered
>> examples of this so far...
>>
>>
>> -- 
>> Sincerely,
>> Vitaly
>>
> 
> 


-- 
Sincerely,
Vitaly
