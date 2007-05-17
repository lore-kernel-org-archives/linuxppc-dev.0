Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B80BDDE9E
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 04:18:58 +1000 (EST)
In-Reply-To: <464C99FF.8080404@ru.mvista.com>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<8E44DB06-767D-4864-8D2C-6132E4D4370B@kernel.crashing.org>
	<464C99FF.8080404@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
Date: Thu, 17 May 2007 13:17:07 -0500
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, mingo@elte.hu,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 17, 2007, at 1:07 PM, Sergei Shtylyov wrote:

> Hello.
>
> Kumar Gala wrote:
>
>>> Index: linux-2.6/arch/powerpc/kernel/time.c
>>> ===================================================================
>>> --- linux-2.6.orig/arch/powerpc/kernel/time.c
>>> +++ linux-2.6/arch/powerpc/kernel/time.c
> [...]
>>> @@ -128,6 +129,83 @@ unsigned long ppc_tb_freq;
>>>  static u64 tb_last_jiffy __cacheline_aligned_in_smp;
>>>  static DEFINE_PER_CPU(u64, last_jiffy);
>>>
>>> +#ifdef CONFIG_GENERIC_CLOCKEVENTS
>>> +
>>> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
>>> +#define DECREMENTER_MAX 0xffffffff
>>> +#else
>>> +#define DECREMENTER_MAX 0x7fffffff /* setting MSB triggers an   
>>> interrupt */
>>> +#endif
>>> +
>>> +static int decrementer_set_next_event(unsigned long evt,
>>> +                      struct clock_event_device *dev)
>>> +{
>>> +#if defined(CONFIG_40x)
>>> +    mtspr(SPRN_PIT, evt);    /* 40x has a hidden PIT auto- 
>>> reload  register */
>>> +#elif defined(CONFIG_BOOKE)
>>> +    mtspr(SPRN_DECAR, evt); /* Book E has  separate auto-reload   
>>> register */
>>> +    set_dec(evt);
>
>> what's the point of setting decar if you're just going to set_dec  
>> as  well?
>
>    Bothered to read the Book E specs? ;-)

I have :)

>    Loading DECAR doesn't auto-reload DEC. What I want is both set  
> the auto-reload value and start counting down from it at the same  
> time (if the decrementer is in auto-reload mode).

I see you're using DECAR to make it periodic.

> [big cut-off]
>
> WBR, Sergei

I haven't looked at all the new clock/timer code, is there any  
utility in having support for more than one clock source?

- k
