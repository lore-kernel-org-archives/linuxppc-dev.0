Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-15.arcor-online.net
	[151.189.21.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 99CBADE059
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 01:28:47 +1000 (EST)
In-Reply-To: <1180532899.3360.79.camel@zod.rchland.ibm.com>
References: <20070529060541.GG30266@localhost.localdomain>
	<c7c131c3a7fdf7727d9ea1e40775017a@kernel.crashing.org>
	<1180448346.3360.49.camel@zod.rchland.ibm.com>
	<a5c459df2eefeb9261e65c551870f7f5@kernel.crashing.org>
	<1180466979.3360.69.camel@zod.rchland.ibm.com>
	<8b93622a41f822c7b8444d42deb9e5ac@kernel.crashing.org>
	<1180532899.3360.79.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7de7540fb1ee0aedd1b4f600607b677e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Date: Wed, 30 May 2007 17:28:38 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	David Gibson <dwg@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Not that there's anything wrong with your
>>> reasoning.  Just seems like we're trying really hard to define
>>> something
>>> "correctly" when we control what's on both sides :).
>>
>> Right now, and in your case, you do.  OTOH, the
>> goal is to have the DTS be a well-established
>> stable interface between the firmware/bootloader/
>> bootwrapper and the kernel; there is no room for
>> either side of that interface playing dirty tricks,
>> not on any board ;-)
>>
>> Also, the DTS files in the kernel source tree should
>> server as a best-of-breed example for people doing
>> custom device trees for their own boards.  We better
>> whip them into good shape or we'll all look foolish...
>
> Yeah, I know.  Ignore my earlier email.  I blame it on lack of sleep.
>
> The only issue we might have in the future is if DT capable firmware 
> for
> these boards shows up and does something completely different.

Yeah, that's exactly the same problem as we would have
if we would code our device trees without trying to at
least create an informal binding for the nodes in question:
total chaos.

> Hopefully that won't happen.

Hopefully, indeed.

If a third party constructs a board with some weird
device tree, then they probably have a big set of Linux
patches to go with that.  Now either they work with the
kernel community to get that integrated into mainline
(which means they need to do a lot of changes to the DTS
as well if it indeed is weird / wrong, so they better
start doing that *before* selling the boards); or they
can happily maintain their own kernel fork, like so many
companies already do.

I don't see a problem here :-)


Segher
