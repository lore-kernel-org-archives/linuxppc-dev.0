Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D43CFDE0A5
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 02:47:28 +1000 (EST)
In-Reply-To: <20070716071936.GK1678@pengutronix.de>
References: <200707141831.04107.jbe@pengutronix.de>
	<1184446133.6059.284.camel@localhost.localdomain>
	<20070716065144.GH1678@pengutronix.de>
	<1184569752.25235.46.camel@localhost.localdomain>
	<20070716071936.GK1678@pengutronix.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F04D3251-C890-4F64-867D-DCD706F2B91B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: How to add platform specific data to a of_device
Date: Mon, 16 Jul 2007 18:47:21 +0200
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Well, they aren't supposed to :-) The problem at this point is  
>> more due
>> to the fact that for things that haven't been specified by  
>> official OF
>> bindings, people are going all over trying to define their own and
>> sometimes conflicting bindings and then changing them.
>
> I think it is a fundamental thing: the "we just have to wait long
> enough, until oftree definitions have settled" proposal just isn't
> right.

The big problem here is that lots of people got the _basic_
stuff wrong.  I feel that this is getting much better the
last few months though :-)

> It may be right for big irons, being well defined.

OF is being successfully used on many many more systems
than just "big iron"; and many of those do have really weird
quirks.  arch/powerpc also deals with many systems that don't
get their device trees quite right (*cough* powermac *cough*)
and that is doable just fine.  The quirks should be separated
more from the normal code though, in the Linux OF layer.

> But for the
> embedded processors, too less people are working on it, plus we  
> have too
> much things which could be defined.

For embedded, too often the whole bloody thing is dropped
onto the "bigger Linux community" after it has been developed
in-house for many many months.  And usually, lots of core
things are very wrong.  This is a problem with "embedded"
in general, nothing new for OF.

> Speaking of the MPC5200, look at how
> often device tree names change, e.g. for mpc5200 vs. mpc52xx vs.
> whatever. As long as things change, you have to keep the three  
> locations
> in sync manually, and that's bad.

No, you *do not* have to keep them in synch, that's part of
the beauty of the device tree definition.  Sure, you have to
make sure the consumer is at least as new as the producer,
unless people took pains to try to create wrong-way-around
compatibility.  Nothing new there.


Segher
