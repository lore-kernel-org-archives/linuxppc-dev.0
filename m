Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD5B3DE107
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 03:52:10 +1100 (EST)
Message-ID: <49B7EC27.3030305@freescale.com>
Date: Wed, 11 Mar 2009 11:51:51 -0500
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
In-Reply-To: <ed82fe3e0903110931y62e23a02yf2a9719e5a69bd2@mail.gmail.com>
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
> On Wed, Mar 11, 2009 at 12:09 AM, Roland Dreier <rdreier@cisco.com> wrote:
> 
>> Are there really cases where spinning for 1 jiffy is too long of a
>> timeout?
> 
> If the result is a timeout, then I say no.  A timeout is an error
> condition, and the code will usually terminate.
[snip]
> Two jiffies can be a very long time.

One jiffy is fine, but two is just too long?

Given that it only happens in cases of malfunctioning hardware (or a 
buggy driver), it seems reasonable as long as preemption isn't disabled 
(I'm assuming anyone that cares about a rare latency of a couple jiffies 
is using a preemptible kernel).

> Besides, if this function is
> used when interrupts are disabled, I believe that on some platforms,
> jiffies never increments.  If so, we can't use the actual 'jiffies'
> variable.

Disallow that, enforced with a call to might_sleep().

Alternatively, do something with get_cycles(), and have some sort of 
#define by which arches can say if get_cycles actually works.  In the 
absence of a working get_cycles() or equivalent, timeouts with 
interrupts disabled aren't going to happen whether we abstract it with a 
macro or not.

-Scott
