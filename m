Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1742CB704D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 02:23:54 +1000 (EST)
Message-ID: <4F8EEA92.3020509@freescale.com>
Date: Wed, 18 Apr 2012 11:23:46 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: Add back condition for smp
References: <1334698746-11529-1-git-send-email-yorksun@freescale.com>
 <4F8DEC0E.4060700@freescale.com>
 <15110B63-4B9B-4457-B127-65C82C377D3E@kernel.crashing.org>
In-Reply-To: <15110B63-4B9B-4457-B127-65C82C377D3E@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: PPC list <linuxppc-dev@lists.ozlabs.org>, York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/18/2012 09:15 AM, Kumar Gala wrote:
> 
> On Apr 17, 2012, at 5:17 PM, Scott Wood wrote:
> 
>> On 04/17/2012 04:39 PM, York Sun wrote:
>>> The timebase synchronization is only necessary if we need to reset a
>>> separate core.  Currently only KEXEC and CPU hotplug require resetting
>>> a single core. The following code should be in the condition of
>>> CONFIG_KEXEC or CONFIG_HOTPLUG_CPU
>>>
>>>        .give_timebase  = smp_generic_give_timebase,
>>>        .take_timebase  = smp_generic_take_timebase,
>>>
>>> Signed-off-by: York Sun <yorksun@freescale.com>
>>> Acked-by: Li Yang <leoli@freescale.com>
>>> ---
>>> arch/powerpc/platforms/85xx/smp.c |    2 ++
>>> 1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
>>> index 56942af..868c6d7 100644
>>> --- a/arch/powerpc/platforms/85xx/smp.c
>>> +++ b/arch/powerpc/platforms/85xx/smp.c
>>> @@ -192,8 +192,10 @@ struct smp_ops_t smp_85xx_ops = {
>>> 	.cpu_disable	= generic_cpu_disable,
>>> 	.cpu_die	= generic_cpu_die,
>>> #endif
>>> +#if defined(CONFIG_KEXEC) || defined(CONFIG_HOTPLUG_CPU)
>>> 	.give_timebase	= smp_generic_give_timebase,
>>> 	.take_timebase	= smp_generic_take_timebase,
>>> +#endif
>>> };
>>>
>>> #ifdef CONFIG_KEXEC
>>
>> Note that this is only a temporary fix, that assumes the environments
>> where tbsync is problematic[1] (virtualization and simulation) do not
>> enable CONFIG_KEXEC or CONFIG_HOTPLUG_CPU.  Eventually the sync should
>> be done via CCSR like in U-Boot, and the decision on whether to do it
>> should be runtime.
> 
> Is the thinking with the CCSR like u-boot sync after boot would resync to some non-zero TB value?

Yes, while all timebases are stopped, the core coming out of reset will
be set to the timebase value of the other cores.

> I'm guessing the idea is doing such a rsync w/TB stopped in the
> system is quick enough that the freezing of it will not be noticed.

Quick enough is relative, but remember that the context is things like
kexec and deep sleep, which are already quite timing-intrusive.

> One should measure this and see what it looks like in core cycles and
> how it scales based on # of cores.  (could use alternate TB as a
> counter to measure).

I have a hard time imagining it being slower than the generic tbsync,
but in any case it's really the only sane option we have in cases where
we must reset individual cores -- I'm not sure how relevant such
benchmarking would be, other than "nice to know".

-Scott
