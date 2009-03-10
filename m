Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 86832DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 09:59:06 +1100 (EST)
Message-ID: <49B6F0B2.70102@freescale.com>
Date: Tue, 10 Mar 2009 17:58:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
References: <1236723118-3577-1-git-send-email-timur@freescale.com>
	<49B6EAA4.9000803@freescale.com>
	<20090310223753.GB26415@zod.rchland.ibm.com>
In-Reply-To: <20090310223753.GB26415@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Tue, Mar 10, 2009 at 05:33:08PM -0500, Scott Wood wrote:
>> Timur Tabi wrote:
>>> The macro spin_event_timeout() takes a condition and timeout value
>>> (in microseconds) as parameters.  It spins until either the condition is true
>>> or the timeout expires.  It returns zero if the timeout expires first, non-zero
>>> otherwise.
>>>
>>> This primary purpose of this macro is to poll on a hardware register until a
>>> status bit changes.  The timeout ensures that the loop still terminates if the
>>> bit doesn't change as expected.  This macro makes it easier for driver
>>> developers to perform this kind of operation properly.
>>>
>>> Signed-off-by: Timur Tabi <timur@freescale.com>
>>> ---
>>>
>>> v5: ported to arch/powerpc, made it powerpc-specific, eliminated udelay
>> Why make it powerpc-specific?  This would be nice to have in  
>> arch-independent code.
> 
> That's just mean.  He already posted it to lkml and was told to make it
> powerpc specific by Alan.

Well, that's what happens when a discussion hops mailing lists with no 
backreference. :-P

I don't see anywhere where he says it should be architecture dependent, 
but rather a general "I don't like this, get off my lawn!" response.

I cannot agree with the "we shouldn't be encouraging this" sentiment; 
people don't generally do spin loops because they're lazy[1], but rather 
because the hardware demands it -- and it's hardly only on powerpc (much 
less just "some Freescale drivers") that I've encountered hardware that 
demands it, typiclally during reset/initialization or similarly non-hot 
paths.  Why not provide something less likely to have bugs (the timeout 
case is unlikely to be well tested), more easily seen when reviewing a 
patch, and more likely to result in spin loops *with* a timeout rather 
than without?

-Scott

[1] Or rather, those that do should be smacked down during patch review.
