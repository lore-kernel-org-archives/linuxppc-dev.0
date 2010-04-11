Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D34E6B7D19
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Apr 2010 17:16:02 +1000 (EST)
Subject: Re: A better way to sequence driver initialization?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Gatliff <bgat@billgatliff.com>
In-Reply-To: <4BC07EAD.9020307@billgatliff.com>
References: <4BBF7E9C.80604@billgatliff.com>
	<1270889597.6865.107.camel@pasglop> <4BC07EAD.9020307@billgatliff.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 11 Apr 2010 17:15:53 +1000
Message-ID: <1270970153.6865.116.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-embedded <linux-embedded@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The general problem with your approach is that the module in question
> might not know what services it needs to wait for.

The device-tree could provide a lot of help here, by providing a way to
wait for a service attached to a given device-node since -that- at least
contains the linkage we need.

In fact, I could use something like that with the ibm_newemac driver
where I have various bits and pieces probed separately (MAL - aka DMA
engine, MII interface, core MAC, etc...) and right now I go through
horrible hacks to ensure all the drivers have called home. I do have
explicit links in the device-tree, so what I really want is for a driver
attached to a device node to be able to say "I'm now operational" and
for other drivers to wait on that.

In fact, we don't necessarily need to use threads for that. We could
have a way for a device to return something like -EAGAIN from probe(),
maybe having called some kind of request_service(node,...) on all the
dependencies, if any of them isn't satisfied. The core would then be
able to finally call probe() again when they are.

That has the advantage of leaving the amount of threading required to
the core, rather than making it a driver decision, since we don't want
-too- many probing threads in parallel.

> Specific to my situation, the gpio-led code doesn't have any way of
> knowing that it needs to wait until my pca953x i2c devices have all been
> installed so that the gpio pin I have specified even exists.

It could know that via the device-tree. Or on more paleolithic
architectures, via a GPIO number though that sucks. Note that my
wait_for_service() example takes a string. That string in my mind can be
a compound, such as "gpio:#5" for example.

>  And short
> of setting up some kind of table in the board-specific code (or device
> tree, actually), I don't know how to communicate such a dependency
> without touching the generic gpio-led code--- which I'm trying to avoid.
> 
> I just want gpio-led to try again if the gpio pin it has been provided
> can't be requested yet.  And I can see the need for similar behavior in
> several other of my drivers, hence the desire to generalize things a
> bit.  I'm pretty sure my approach is only half-baked, but it does seem
> to avoid the need to touch a bunch of existing code--- especially to add
> board-specific dependencies.  It just give the system a tool to sort
> things out on its own.
> 
> I do think your overall criticism is valid, though.

Cheers,
Ben.
