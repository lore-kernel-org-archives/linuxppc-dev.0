Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5EAEDDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 06:29:08 +1100 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A199@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A199@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7691A67C-C3D9-4882-9BCC-E3AA617AD11E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Exception in kernel mode
Date: Thu, 15 Mar 2007 14:28:11 -0500
To: Charles Krinke <ckrinke@istor.com>
Cc: Chris Carlson <ccarlson@istor.com>, Kevin Smith <ksmith@istor.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 15, 2007, at 1:55 PM, Charles Krinke wrote:

>
>> mtspr SPRN_SPRG0, r10
>> mtspr SPRN_SPRG1, r11
>
>> Which is, I believe, moving r10 to SPRG0 and r11 to SPRG1.
>
>> So, how do we know that r10 and r11 are always valid in an interrupt
>> context? Are we setting aside r10 and r11 somewhere else in
>
>     That doesn't matter to kernel at all -- they are just *saved* in
> SPRG regs
> to avoid being trashed by the exception handler.
>
> WBR, Sergei
>
> Well, unfortunately, now I am more confused.
>
> The original Oops was at an NIP of 00000900, which I think means it
> faulted on the first mtspr from r10. I suppose one could argue that
> pipeline issues might make it fault on the second one and appear to be
> the first.
>
> But, maybe I am confusing myself here. Would I be correct in assuming
> that some further instruction in the ISR at 0x900 is the culprit?
>
> Could there possibly be some user versus supervisor mode thing  
> going on?
>
> My key assumption is that the timer_tick (aka Decrementer) has worked
> for many hundreds of thousands of interrupts and only when running  
> some
> particular user application, like tar is there a side effect from  
> either
> a mode or some register value, race condition, or other.

Can you post the oops that you are seeing, what you need to find out  
is what instruction image that is causing the illegal instruction  
exception.  Once you have that it will be easier to figure out what's  
going on.

- k
