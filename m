Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (mail-va3.bigfish.com [216.32.180.10])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8F790B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 04:29:14 +1100 (EST)
Received: from mail159-va3 (localhost [127.0.0.1])	by
 mail159-va3-R.bigfish.com (Postfix) with ESMTP id 17A703E0066	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 17:30:05 +0000 (UTC)
Received: from VA3EHSMHS014.bigfish.com (unknown [10.7.14.244])	by
 mail159-va3.bigfish.com (Postfix) with ESMTP id B5207500019	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 17:30:04 +0000 (UTC)
Message-ID: <4EB966D7.2060609@freescale.com>
Date: Tue, 8 Nov 2011 11:28:55 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH 1/7] powerpc/85xx: re-enable timebase sync disabled by
 KEXEC patch
References: <1320409787-14360-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB421FD.6010805@freescale.com>
 <3F607A5180246847A760FD34122A1E052BC5F8@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <3F607A5180246847A760FD34122A1E052BC5F8@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="windows-1252"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/08/2011 03:06 AM, Li Yang-R58472 wrote:
> 
> 
>> -----Original Message-----
>> From: linuxppc-dev-bounces+leoli=freescale.com@lists.ozlabs.org
>> [mailto:linuxppc-dev-bounces+leoli=freescale.com@lists.ozlabs.org] On
>> Behalf Of Scott Wood
>> Sent: Saturday, November 05, 2011 1:34 AM
>> To: Zhao Chenhui-B35336
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Subject: Re: [PATCH 1/7] powerpc/85xx: re-enable timebase sync disabled by
>> KEXEC patch
>>
>> On 11/04/2011 07:29 AM, Zhao Chenhui wrote:
>>> From: Li Yang <leoli@freescale.com>
>>>
>>> The timebase sync is not only necessary when using KEXEC. It should also
>>> be used by normal boot up and cpu hotplug. Remove the ifdef added by
>>> the KEXEC patch.
>>
>> The KEXEC patch didn't just add the ifdef, it also added the initializers:
> 
> Yes.  But the code suggests that the timebase synchronization is only necessary for KEXEC, but it turns out that sleep/wakeup also need it.  Maybe the description of the patch need to be changed as KEXEC is not to be blamed.

It is needed when you hard reset a core.  This was something we never
did on SMP before kexec.  Now you're adding a second thing that does it,
so it'll need the sync as well, but that doesn't mean we should do it on
normal boot.

>>> @@ -105,8 +107,64 @@ smp_85xx_setup_cpu(int cpu_nr)
>>>
>>>  struct smp_ops_t smp_85xx_ops = {
>>>         .kick_cpu = smp_85xx_kick_cpu,
>>> +#ifdef CONFIG_KEXEC
>>> +       .give_timebase  = smp_generic_give_timebase,
>>> +       .take_timebase  = smp_generic_take_timebase,
>>> +#endif
>>>  };
>>
>> U-Boot synchronizes the timebase on 85xx.  With what chip and U-Boot
>> version are you seeing this not happen?
> 
> I'm curious why don't we make it happen in kernel as we are against
> adding dependency to the bootloader?

We are against adding gratuitous dependencies on the bootloader, but
some things are just a lot easier to do in that context.  Nobody
complains about Linux expecting RAM to be working on entry. :-)

While it's certainly possible to do this in Linux (and should be done
the way U-Boot does instead of the software sync, in the cases where we
need to), it's easier to do in U-Boot, before the cores are running.

It would be impossible for Linux to do this (or any other tb
modifications) when running on top of a hypervisor.

In http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-June/091321.html,
Ben Herrenschmidt said, "smp-tbsync.c is and has always been a
'workaround' for broken HW."

> Other architectures don't have this dependency, 

Which "other architectures" are you referring to?

On PPC server this is handled with a firmware call to freeze the
timebase.  On x86 this is handled by the BIOS by the time the OS starts.

-Scott
