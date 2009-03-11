Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9262DDF33
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 08:00:19 +1100 (EST)
Message-ID: <49B82657.9050709@freescale.com>
Date: Wed, 11 Mar 2009 16:00:07 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
References: <1236723118-3577-1-git-send-email-timur@freescale.com>	
	<49B6EAA4.9000803@freescale.com>	
	<20090310223753.GB26415@zod.rchland.ibm.com>	
	<1236729551.7086.26.camel@pasglop>	
	<ed82fe3e0903101722i610638e8le1f2e925095c8ba6@mail.gmail.com>	
	<adaiqmgbq6w.fsf@cisco.com>	
	<ed82fe3e0903110931y62e23a02yf2a9719e5a69bd2@mail.gmail.com>	
	<49B7EC27.3030305@freescale.com>	
	<ed82fe3e0903111214j2072319pe985e6bbecdd1665@mail.gmail.com>	
	<49B80F7F.30705@freescale.com>
	<ed82fe3e0903111345m2962f5b5wdfc9e2efae1c33ae@mail.gmail.com>
In-Reply-To: <ed82fe3e0903111345m2962f5b5wdfc9e2efae1c33ae@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Roland Dreier <rdreier@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> On Wed, Mar 11, 2009 at 2:22 PM, Scott Wood <scottwood@freescale.com> wrote:
> 
>> I was under the impression that we were only talking about timeouts, and
>> that the common case was significantly shorter than that.
> 
> I think one of the concerns that Alan Cox raised is that the existence
> of this macro would encourage people to spin for long durations.

Yes, and I've already stated my response to that line of thinking.  I 
just don't see anyone who would have done something better than a spin 
loop changing their mind because doing a spin loop becomes a little 
easier -- the spin loop is *already* easier than the alternatives.

What if another variant were added that did msleep between iterations, 
for longer expected completion times?  Or if we want to be really fancy, 
combine them into one function that starts with small udelays, then 
switches to msleep of progressively larger intervals up to some maximum?

>> If it's atomic because preemption was disabled, yes -- but even a rare
>> extended spin in such a context would be bad for hard realtime.  If
>> interrupts are disabled, or the code is executing from a timer interrupt (or
>> possibly other interrupts depending on the hardware and its priority
>> scheme), no.
> 
> So in that case, I can't rely on jiffies.  

Or you can say that atomic context is outside the scope of this macro.

-Scott
