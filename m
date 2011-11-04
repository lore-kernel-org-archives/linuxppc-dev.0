Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BB1B4B6FA0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2011 06:38:56 +1100 (EST)
Message-ID: <4EB43F47.3050109@freescale.com>
Date: Fri, 4 Nov 2011 14:38:47 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/7] powerpc/85xx: re-enable timebase sync disabled by
 KEXEC patch
References: <1320409787-14360-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB421FD.6010805@freescale.com>
 <51CCC521-0A2C-4940-98F0-BA0075D6F122@kernel.crashing.org>
In-Reply-To: <51CCC521-0A2C-4940-98F0-BA0075D6F122@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/2011 02:33 PM, Kumar Gala wrote:
> 
> On Nov 4, 2011, at 12:33 PM, Scott Wood wrote:
> 
>> On 11/04/2011 07:29 AM, Zhao Chenhui wrote:
>>> From: Li Yang <leoli@freescale.com>
>>>
>>> The timebase sync is not only necessary when using KEXEC. It should also
>>> be used by normal boot up and cpu hotplug. Remove the ifdef added by
>>> the KEXEC patch.
>>
>> The KEXEC patch didn't just add the ifdef, it also added the initializers:
>>
>>> @@ -105,8 +107,64 @@ smp_85xx_setup_cpu(int cpu_nr)
>>>
>>> struct smp_ops_t smp_85xx_ops = {
>>>        .kick_cpu = smp_85xx_kick_cpu,
>>> +#ifdef CONFIG_KEXEC
>>> +       .give_timebase  = smp_generic_give_timebase,
>>> +       .take_timebase  = smp_generic_take_timebase,
>>> +#endif
>>> };
>>
>> U-Boot synchronizes the timebase on 85xx.  With what chip and U-Boot
>> version are you seeing this not happen?
>>
>> If you are seeing only a small (around one tick) difference, make sure
>> you're running a U-Boot that has this commit:
[snip]
> 
> Scott,
> 
> Aren't we going to need this when a core is woken back up w/o any state?

We'll need some form of timebase resync if a core is individually
hard-reset -- I was responding to the "should also be used by normal
boot up" bit.

For kexec/hotplug, if we must reset the core (for deep sleep we must),
any reason not to do the sync the same way U-Boot does?

-Scott
