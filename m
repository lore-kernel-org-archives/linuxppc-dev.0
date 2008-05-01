Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8877CDDE9E
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 00:35:23 +1000 (EST)
Message-Id: <DD9304A4-328E-4952-B0F1-3C963A332D20@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: jwboyer@linux.vnet.ibm.com
In-Reply-To: <1209652012.2946.124.camel@vader.jdub.homelinux.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
Date: Thu, 1 May 2008 09:31:30 -0500
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<18457.1279.401197.763726@cargo.ozlabs.ibm.com>
	<A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
	<1209628423.18023.286.camel@pasglop>
	<CF55CEE2-CAF5-4728-947E-C1C37E262EDB@kernel.crashing.org>
	<1209652012.2946.124.camel@vader.jdub.homelinux.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2008, at 9:26 AM, Josh Boyer wrote:

> On Thu, 2008-05-01 at 08:22 -0500, Kumar Gala wrote:
>>>> So we have 4 actual exceptions:
>>>> * CriticalInput (some external device signaled this.  There are two
>>>> concepts of critical.  One is error the other is high priority)
>>>> However this would have the same caveats as any ExternalInput
>>>> handler.
>>>
>>> No, it's worse. It can interrupt code that normally has
>>> local_irq_disabled() and thus doesn't expect to be interrupted. That
>>> means that everything becomes unsafe including locks etc....
>>
>> Fair.  Should local_irq_disable() clear MSR_SE & MSR_BE on classic
>> parts?
>>
>>> Note that driver that want to make active use of that probably want
>>> some
>>> explicit local_crit_irq_disable/enable functions to be able to
>>> implement
>>> some sort of synchronization.
>>
>> Or we could just have local_irq_disable -- clear MSR_EE and MSR_CE
>
> That sort of defeats the purpose of using critical interrupts in the
> "higher priority" sense, doesn't it?  Seems it would effectively
> eliminate that level altogether.  And it would also mask off the
> watchdog interrupt, which I don't think you want to do.
>
> Ben suggested local_crit_irq_disable.  That would suffice for drivers
> that know they are configured as CE and need to do locking primitives,
> but that isn't very common.  On 4xx there isn't even an interface  
> for a
> driver to request it's interrupts be set to CE and we init all UICs to
> have UIC_CR be 0.
>
> So for 4xx at least, most of this discussion is theoretical for now.
> However, I can see value in having CEs being used for certain devices,
> etc so it would be nice to figure it out in the long run.

I agree.  my first priority is to get debug interrupts cleaned up so  
we can kprobe and do other debug things in the kernel.

I'm only aware of one case of someone asking for critical inputs on  
our parts w/linux.

- k

- k
