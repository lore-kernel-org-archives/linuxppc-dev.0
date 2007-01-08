Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EB45DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 10:27:09 +1100 (EST)
In-Reply-To: <1168296460.22458.232.camel@localhost.localdomain>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1168288352.22458.198.camel@localhost.localdomain>
	<5f992368c65d3d53003b0e9f2955ae79@kernel.crashing.org>
	<1168296460.22458.232.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <27d6554d600437ed39853784c0cf96fd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: EMAC OF binding....
Date: Tue, 9 Jan 2007 00:27:26 +0100
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>, Murali N Iyer <mniyer@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> So this is for accessing some shared SoC registers?  The emac
>> node has no business with that, you should have a separate
>> node for that (and you probably do already, you can use the
>> parent bus node in most such cases).
>
> If I needed a separate node for every shared SoC bit, I would have a
>> 2MB device-tree :-)
>
> There are just a few places where I need to call some platform code and
> tell it what EMAC in the chip it is so it can go tweak the right magic
> bits, best is a property for that.

Oh you misunderstand what I mean.  I'm just saying the
registers that are shared are in some other node (having
the same regs in two nodes can't happen).

Let's hope the hardware is sane enough that you can
describe it in a sane way.

You would probably end up with properties in the SoC
node like "emac-#0" containing the phandle of the first
emac, or something like that -- the number of the emac
on the SoC is not a property of the emac, but of the SoC
itself.

I don't know the exact programming interface so I'm not
completely sure of course, but please consider.

>> MTU is dynamic, max-frame-size isn't.  max-frame-size is just
>> the maximum packet size you can tell the network controller to
>> put on the wire, not counting protocol overhead etc.
>
> Ah ok.

It sounds like max-frame-size is exactly what you wanted
this new max-mtu property for, right?  [Oh and btw, max-mtu
is a really bad name -- "max-max-tu" heh].


Segher
