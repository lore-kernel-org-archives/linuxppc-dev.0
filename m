Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2C62B1401A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 07:34:16 +1000 (EST)
Message-ID: <536AA51F.4040903@Freescale.com>
Date: Wed, 7 May 2014 16:26:55 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>
Subject: Re: [PATCH 2/2 v2] powerpc: Enable NO_BOOTMEM
References: <1399402084-6325-1-git-send-email-Emilian.Medve@Freescale.com>
 <1399402084-6325-2-git-send-email-Emilian.Medve@Freescale.com>
 <1399412988.15726.202.camel@snotra.buserror.net>
 <53697B5C.6090107@Freescale.com>
 <1399430673.15726.249.camel@snotra.buserror.net>
In-Reply-To: <1399430673.15726.249.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 05/06/2014 09:44 PM, Scott Wood wrote:
> On Tue, 2014-05-06 at 19:16 -0500, Emil Medve wrote:
>> Hello Scott,
>>
>>
>> On 05/06/2014 04:49 PM, Scott Wood wrote:
>>> On Tue, 2014-05-06 at 13:48 -0500, Emil Medve wrote:
>>>> Currently bootmem is just a wrapper around memblock. This gets rid of
>>>> the wrapper code just as other ARHC(es) did: x86, arm, etc.
>>>>
>>>> For now only cover !NUMA systems/builds
>>>>
>>>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
>>>> ---
>>>>
>>>> v2: Acknowledge that NUMA systems/builds are not covered by this patch
>>>>
>>>>  arch/powerpc/Kconfig  | 3 +++
>>>>  arch/powerpc/mm/mem.c | 8 ++++++++
>>>>  2 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>>> index e099899..07b164b 100644
>>>> --- a/arch/powerpc/Kconfig
>>>> +++ b/arch/powerpc/Kconfig
>>>> @@ -475,6 +475,9 @@ config SYS_SUPPORTS_HUGETLBFS
>>>>  
>>>>  source "mm/Kconfig"
>>>>  
>>>> +config NO_BOOTMEM
>>>> +	def_bool !NUMA
>>>
>>> This will allow a user to manually turn on CONFIG_NO_BOOTMEM in the
>>> presence of NUMA.  From the changelog it sounds like this is not what
>>> you intended.
>>>
>>> What are the issues with NUMA?
>>
>> Well, I don't have access to a NUMA box/board. I could enable NUMA for a
>> !NUMA board but I'd feel better if I could actually test/debug on a
>> relevant system
> 
> You could first test with NUMA on a non-NUMA board, and then if that
> works ask the list for help testing on NUMA hardware (and various
> non-Freescale non-NUMA hardware, for that matter).
> 
> Is there a specific issue that would need to be addressed to make it
> work on NUMA?

Nope. Just different code/file(s)... with NUMA specific details...

>>> As is, you're not getting rid of wrapper code -- only adding ifdefs.
>>
>> First, you're talking about the bootmem initialization wrapper code for
>> powerpc. The actual bootmem code is in include/linux/bootmem.h and
>> mm/bootmem.c. We can't remove those files as they are still used by
>> other arches. Also, the word wrapper is somewhat imprecise as in powerpc
>> land bootmem sort of runs on top of memblock
> 
> My point was just that the changelog says "This gets rid of wrapper
> code" when it actually removes no source code, and adds configuration
> complexity.

The patch gets rid of the wrapper code, bootmem itself and arch specific
initialization, from the build/kernel image. I guess I'll re-word that
so it doesn't sound so literal

>> When NO_BOOTMEM is configured the mm/nobootmem.c is used that is the
>> bootmem API actually re-implemented with memblock. The bootmem API is
>> used in various places in the arch independent code
>>
>> This patch wants to isolate for removal the bootmem initialization code
>> for powerpc and to exclude mm/bootmem.c from being built. This being the
>> first step I didn't want to actually remove the code, so it will be easy
>> to debug if some issues crop up. Also, people that want the use the
>> bootmem code for some reason can easily do that. Once this change spends
>> some time in the tree, we can actually remove the bootmem initialization
>> code
> 
> Is there a plausible reason someone would "want to use the bootmem
> code"?

Don't know, but as before it wasn't even possible to make a build with
NO_BOOTMEM I decided to err on the side of caution

> While the "ifdef it for a while" approach is sometimes sensible, usually
> it's better to just make the change rather than ifdef it.

I felt it was sensible in this case

> Consider what
> the code would look like if there were ifdefs for a ton of random
> changes, half of which nobody ever bothered to go back and clean up
> after the change got widespread testing.

Well, this is not a random change, but I certainly don't disagree with
the principle of what you're saying

> Why is this patch risky enough to warrant such an approach?

I don't think it's risky and we've been using it for months on various
SoC(s)/boards. Just didn't want to be very abrupt in removing the option
of using bootmem

> Shouldn't boot-time issues be pretty obvious?

Gross errors should be obvious. But the devil is in the details, and
even tough I've debugged/compared the memory layout/allocations with
bootmem and memblock only, I'm prepared to admit I might have missed
something (especially in the first patch of the sequence)


Cheers,
