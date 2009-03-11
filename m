Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3928CDE1F3
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 06:22:52 +1100 (EST)
Message-ID: <49B80F7F.30705@freescale.com>
Date: Wed, 11 Mar 2009 14:22:39 -0500
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
In-Reply-To: <ed82fe3e0903111214j2072319pe985e6bbecdd1665@mail.gmail.com>
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
> On Wed, Mar 11, 2009 at 11:51 AM, Scott Wood <scottwood@freescale.com> wrote:
> 
>> One jiffy is fine, but two is just too long?
> 
> Any number of jiffies is *not* too long if a timeout occurs.  However,
> I think even one jiffy is too long if that's the normal condition.

I was under the impression that we were only talking about timeouts, and 
that the common case was significantly shorter than that.

> Unfortunately, the driver may not have any choice in some
> circumstances.  If the hardware is just too slow to respond, and it
> doesn't provide interrupts, but the code is running in atomic context,
> and the function what else can it do?

Rework the driver to poll from a periodic timer (like we do with PHYs).

However, that's overkill when the hardware is supposed to respond in a 
handful of clocks, and preemption is enabled in case the timeout path 
does happen.

>> Disallow that, enforced with a call to might_sleep().
> 
> I think we need to be able to allow this function to work in atomic
> context.  Is jiffies updated in atomic context?

If it's atomic because preemption was disabled, yes -- but even a rare 
extended spin in such a context would be bad for hard realtime.  If 
interrupts are disabled, or the code is executing from a timer interrupt 
(or possibly other interrupts depending on the hardware and its priority 
scheme), no.

>> Alternatively, do something with get_cycles(), and have some sort of #define
>> by which arches can say if get_cycles actually works.  In the absence of a
>> working get_cycles() or equivalent, timeouts with interrupts disabled aren't
>> going to happen whether we abstract it with a macro or not.
> 
> I think I can live with that.

Another option is to use udelay() on platforms without a working 
get_cycles().

-Scott
