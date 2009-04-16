Return-Path: <Qingtao.Cao@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id BB5A5DE0C1
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 13:41:51 +1000 (EST)
Message-ID: <49E6A8CA.90601@windriver.com>
Date: Thu, 16 Apr 2009 11:40:58 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: + edac-cpc925-mc-platform-device-setup.patch added to -mm tree
References: <200904152227.n3FMRmdm007192@imap1.linux-foundation.org>	
	<98F905BD-B447-4FAA-A7FE-9FCD025A9079@kernel.crashing.org>	
	<49E69098.6040903@windriver.com>
	<1239848054.6572.20.camel@localhost>
In-Reply-To: <1239848054.6572.20.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: mm-commits@vger.kernel.org,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@gate.crashing.org>,
	Doug Thompson <norsk5@yahoo.com>, akpm@linux-foundation.org
Reply-To: qingtao.cao@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Thu, 2009-04-16 at 09:57 +0800, Harry Ciao wrote:
>   
>> Kumar Gala wrote:
>>     
>>> On Apr 15, 2009, at 5:27 PM, akpm@linux-foundation.org wrote:
>>>       
>>>> arch/powerpc/kernel/prom_init.c      |   33 +++++++++++++
>>>> arch/powerpc/platforms/maple/setup.c |   59 +++++++++++++++++++++++++
>>>> 2 files changed, 92 insertions(+)
>>>>
>>>> diff -puN 
>>>> arch/powerpc/kernel/prom_init.c~edac-cpc925-mc-platform-device-setup 
>>>> arch/powerpc/kernel/prom_init.c
>>>> --- 
>>>> a/arch/powerpc/kernel/prom_init.c~edac-cpc925-mc-platform-device-setup
>>>> +++ a/arch/powerpc/kernel/prom_init.c
>>>> @@ -1947,8 +1947,40 @@ static void __init fixup_device_tree_map
>>>>     prom_setprop(isa, name, "ranges",
>>>>             isa_ranges, sizeof(isa_ranges));
>>>> }
>>>> +
>>>> +#define CPC925_MC_START        0xf8000000
>>>> +#define CPC925_MC_LENGTH    0x1000000
>>>> +/* The values for memory-controller don't have right number of cells */
>>>> +static void __init fixup_device_tree_maple_memory_controller(void)
>>>> +{
>>>>         
>>> I don't see why this cant be part of the existing 
>>> fixup_device_tree_maple().
>>>
>>> I also find it odd we don't ensure we are running on a maple before we 
>>> apply this fixup.
>>>       
>
>   
>> Hi Kumar,
>>
>> Thanks a lot for your concern.
>>
>> This newly added fixup for memory controller on Maple will be placed 
>> right after fixup_device_tree_maple(), both of them will be controlled 
>> by CONFIG_PPC_MAPLE, so there is no worry that it will be applied 
>> against anything other than Maple.
>>     
>
> Hi Harry,
>
> We regularly build a single kernel with multiple platforms enabled, so
> just having it controlled by a CONFIG symbol is not sufficient. Someone
> might build a kernel for MAPLE & PSERIES & ISERIES & CELL, so the maple
> fixup needs to be careful it doesn't break the other platforms.
>
> The existing maple fixup doesn't check if it's on a maple either, but it
> is a bit more discerning about what it finds before it fixes things up.
>
> Your code already checks that "reg" is 8 bytes long to start with, I
> think if it also checks that #address-cells and #size-cells are == 2,
> then it's pretty safe. Because at that point we know we have a node with
> the right name, the reg property has a known value, and reg is short WRT
> #cells.
>
>   
Many thanks Michael!

That makes a lot of sense to me :) I will integrate the check if both 
its parent #address-cells and #size-cells equal to 2 before fixing 
anything up. The fact that the reg length == 8 bytes whereas parent's 
cells are 2 validate our fixup is necessary.

Best regards,

Harry


>> Meanwhile, it aims at fixup bad cell numbers for the memory controller, 
>> whereas the original fixup_device_tree_maple() aiming at fixing up the 
>> ISA controller on HT channel, we'd better separate them in different 
>> function IMHO.
>>     
>
> I think I agree it's better as a separate routine. We could have a
> firmware that doesn't need the original maple fixup (and so exits from
> that routine early) but does need this one.
>
> cheers
>
>   
