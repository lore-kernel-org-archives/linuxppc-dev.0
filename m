Return-Path: <danielhb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMJrP5YGyzDr2y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 00:40:05 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v71EdvNH053293
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Aug 2017 10:40:03 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c2tj2bfd2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 10:39:59 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <danielhb@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 11:39:48 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v71EdknB21561526
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Aug 2017 11:39:46 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v71Edkeg028086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Aug 2017 11:39:46 -0300
Subject: Re: [RFC PATCH] powerpc: Disabling MEMORY_HOTPLUG_DEFAULT_ONLINE
 option for PPC64 arch
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20170731181759.13839-1-danielhb@linux.vnet.ibm.com>
 <87y3r3sj57.fsf@concordia.ellerman.id.au>
 <9f4cbb26-f8f4-7f42-0c73-deab23bd83d6@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 1 Aug 2017 11:39:44 -0300
MIME-Version: 1.0
In-Reply-To: <9f4cbb26-f8f4-7f42-0c73-deab23bd83d6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a22a6445-528f-9070-f2f7-b981cee3878e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/01/2017 11:05 AM, Nathan Fontenot wrote:
> On 08/01/2017 04:59 AM, Michael Ellerman wrote:
>> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:
>>
>>> Commit 943db62c316c ("powerpc/pseries: Revert 'Auto-online
>>> hotplugged memory'") reverted the auto-online feature for pseries due
>>> to problems with LMB removals not updating the device struct properly.
>>> Among other things, this commit made the following change in
>>> arch/powerpc/configs/pseries_defconfig:
>>>
>>> @@ -58,7 +58,6 @@ CONFIG_KEXEC_FILE=y
>>>   CONFIG_IRQ_ALL_CPUS=y
>>>   CONFIG_MEMORY_HOTPLUG=y
>>>   CONFIG_MEMORY_HOTREMOVE=y
>>> -CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
>>>   CONFIG_KSM=y
>>>
>>> The intent was to disable the option in the defconfig of pseries, since
>>> after that the code doesn't have this support anymore.
>> It's always polite to Cc the author of a commit you're referring to, so
>> I added Nathan.
Noted. Thanks for adding Nathan in the CC.

>>
>> The intention when we merged that fix was that the auto-online code
>> would be "fixed" to mark the device online. I say "fixed" because it
>> wasn't entirely clear if that was the correct behaviour, though it
>> definitely seemed like it should be.
>>
>> I've lost track of where/if the discussion got to on whether the
>> auto-online code should do that or not. Did anything get resolved?
> I think, though I should go back and test to be sure, that everything
> works in the latest mainline code. The issue causing this to be a problem
> was in the original implementation of auto_online support. If you wanted
> to auto online memory, the code was calling memory_block_change_state().
> This worked but did not update the device struct for each of the memory
> block that was online'ed such that dev->offline == true even after the
> memory was online.
>
> I sent a patch earlier this year (commit dc18d706a436) that corrected
> this to call device_online() instead of memory_block_change_state().
> With this fix (appears to have gone into the 4.11 kernel) it should be
> possible to use auto_online on power systems.

Commit dc18d706a436 was present in the 4.11 kernels that experiences this
issue (Fedora 26 and Ubuntu 17.10 in my tests). So I am not entirely sure
that we can use auto_online on power systems, at least in those kernels.


>
> At this point I don't think we need this patch to disable auto online
> for ppc64. I would be curious if this is still broken with the latest
> mainline code though.

If the auto_online feature is already working in upstream 4.13 kernel 
then I don't see
a reason to apply this patch either. We can leave it as a FYI/reminder 
of a problem
that was happening in 4.11 and got solved later on.


Thanks,


Daniel

>
> -Nathan
>    
>>> However, this change
>>> alone isn't enough to prevent situations such as [1], where
>>> distros can enable the option unaware of the consequences of
>>> doing it (e.g. breaking LMB hotplug altogether).
>>>
>>> Instead of relying on all distros knowing that pseries can't handle
>>> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y after 943db62c316c, this patch
>>> changes mm/Kconfig to make the MEMORY_HOTPLUG_DEFAULT_ONLINE config
>>> unavailable for the PPC64 arch.
>>>
>>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1476380
>>>
>>> Fixes: 943db62c316c ("powerpc/pseries: Revert 'Auto-online hotplugged memory'")
>>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>>> ---
>>>   mm/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> I don't own that file, so we at least need an Ack from the mm folks.
>>
>> cheers
>>
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 48b1af4..a342c77 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -169,7 +169,7 @@ config MEMORY_HOTPLUG_SPARSE
>>>   config MEMORY_HOTPLUG_DEFAULT_ONLINE
>>>           bool "Online the newly added memory blocks by default"
>>>           default n
>>> -        depends on MEMORY_HOTPLUG
>>> +        depends on MEMORY_HOTPLUG && !PPC64
>>>           help
>>>   	  This option sets the default policy setting for memory hotplug
>>>   	  onlining policy (/sys/devices/system/memory/auto_online_blocks) which
>>> -- 
>>> 2.9.4
