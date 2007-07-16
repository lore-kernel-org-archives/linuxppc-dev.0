Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 316DBDE026
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 02:28:18 +1000 (EST)
In-Reply-To: <1184569752.25235.46.camel@localhost.localdomain>
References: <200707141831.04107.jbe@pengutronix.de>
	<1184446133.6059.284.camel@localhost.localdomain>
	<20070716065144.GH1678@pengutronix.de>
	<1184569752.25235.46.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4265A830-DDA1-4114-8B74-C46510F4F492@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: How to add platform specific data to a of_device
Date: Mon, 16 Jul 2007 18:28:12 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> As I wrote a couple of times already, it's a perfectly acceptable
> approach to have "constructors" (what you call oftree-interpreter)  
> that
> generate platform devices from the OF tree.

Yes, lots of the "glue" code could be made into some
helper library.  Also, while that glue code might be
perceived as being "a lot of stuff", it isn't really,
and it is quite simple anyway; it's just a layer that
sits there to translate for the impedance mismatch of
the device tree on one hand, and the kernel interfaces
on the other.  Because we do have such a layer, interface
changes aren't a big deal; and since the device tree
interface is a way flexible, mostly text-based associative
array tree thing, we have none of the problems that
binary firmware interfaces on other platforms have.  Oh,
and the Open Firmware device tree works perfectly fine
across different architectures, too.

>> and they often contain redundant information (like names of oftree
>> nodes, which change more often than some people's panties).
>
> Well, they aren't supposed to :-) The problem at this point is more  
> due
> to the fact that for things that haven't been specified by official OF
> bindings, people are going all over trying to define their own and
> sometimes conflicting bindings and then changing them.

This is most of the "endless debate", too.


Segher
