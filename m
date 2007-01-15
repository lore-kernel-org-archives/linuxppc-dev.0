Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E26EDDDECF
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 05:31:26 +1100 (EST)
In-Reply-To: <528646bc0701150906o253c898dobe3b55ffb91add70@mail.gmail.com>
References: <528646bc0701131555n3249b503i3b6e8c37db41dd52@mail.gmail.com>
	<45AA098C.70101@246tNt.com>
	<6189b01379f62aa4516484872f4ef86f@kernel.crashing.org>
	<1168810790.4803.11.camel@localhost.localdomain>
	<ccc8fbc935d8f8d3e30870d43959f6c7@kernel.crashing.org>
	<1168817449.4803.28.camel@localhost.localdomain>
	<ef64a4198a02929a00c28abb5f0934b5@kernel.crashing.org>
	<1168818533.4803.37.camel@localhost.localdomain>
	<a1af25147ea7308c394d243511b96f69@kernel.crashing.org>
	<45ABA20E.30008@genesi-usa.com>
	<528646bc0701150906o253c898dobe3b55ffb91add70@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0c74c52b3ba6dd16f47fb393da58d53a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Discussion on SOC device tree bindings
Date: Mon, 15 Jan 2007 19:31:50 +0100
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sven Luther <sven@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Can someone summarise why we are talking about exposing clock 
>> controllers
>> for anything more than informational purposes?
>
> Isn't the whole device tree all about "informational purposes?"  :-)

It is.

> 1. We all agree that the device tree is about how best to describe the
> hardware; not how Linux or anyone else intends to use it.  (ie.
> provide as much relevant information as possible without building an
> insanely large tree and regardless of whether or not Linux uses the
> info.)

It seems *not* everyone has got this firmly into his/her
head yet.  It is not something people have the "agree"
with at all though; it is just the way it is.

> 4. I think that the general consensus is that the device tree should
> have a node for shared SoC registers and a node for each on chip
> device.  One will point to the other (phandle?) to indicate which node
> device drivers should look to for twiddling the shared bits.

Erm, the way you state this, you're violating (1.) already ;-)

Implicit from the type of SoC control thing, we know what
registers control what devices; the only thing the device
tree needs to express what those devices (from the viewpoint
of the control device) are in the device tree.  i.e., like
you said, there need to be some links set up between the
controlled devices' nodes and the control node.

> 5. The contentious issue is which direction those links should be
> constructed.  Does the device node describe where to find it's SoC
> parent node and what the device index is?  Or does the SoC node
> describe which device nodes it provides shared register service for?
> 6. Paramount in this discussion is making sure that the device tree is
> detailed enough that if any of the above information is missing
> (because firmware is never going to have everything we want), the
> information can still be determined and filled in.  For example, as
> long as we know the processor is a mpc5200b; then the shared register
> bindings can be filled in at fixup time.

Much more importantly, a big consideration is making the
binding so simple and so close to the actual hardware
relations, that it becomes as future-proof as possible.
Requiring properties in many different device nodes that
cannot have those properties required by their own binding,
is not the way to go; having the same information wholly
self-contained in the device node that the binding is all
about, in only one property even, is so obviously a much
cleaner much simpler way to go about it that I don't know,
why the heck are we still talking about this?

We should never violate (1.), period.


Segher
