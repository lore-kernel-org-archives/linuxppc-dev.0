Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E69CDDE1E
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 12:24:07 +1100 (EST)
Subject: Re: [RFC][PATCH 0/3] OF-platform PATA driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20071123175229.GA27143@localhost.localdomain>
References: <20071123175229.GA27143@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 24 Nov 2007 12:23:56 +1100
Message-Id: <1195867436.7195.37.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-23 at 20:52 +0300, Anton Vorontsov wrote:

> As an alternative approach we can use plain pata_platform
> driver, but I'm not sure how Linux OF bindings' ideologists will
> or will not like it.
> 
> So, these patches are strongly Request For Comments. Feel free
> to train your nitpicking skills ;-), and/or vote for the option
> you most pleased about (or suggest another?).
> 
> 
> Thanks.
> 
> ---
> Down here is "alternative approach".
> 
> Probably board-neutral version may be placed somewhere in
> the drivers/of/...? But who will call it: board file, or
> device_initcall for all boards?

 .../...

I'm fine with either approaches in fact. I think it's fair enough when
there is existing platform devices to avoid duplicating the whole thing
for an of_platform_device (unless you find a nice way to split to a
library like you just did) and instead, have a "constructor" that
constructs the platform device based on the OF node.

Now, as you pointed out, the question is where to call it... the
initcall has the problem of potentially being called for the wrong board
and the thing having duplicate OF device and platform device created for
it...

One of the thing I've been brewing in my mind is the idea of reworking
the current code that create OF platform devices when walking busses
down, and have it instead call registered constructor functions. The
default ones would then create OF platform devices but one could
override that with constructors creating something else (such as a
platform device).

Now, it's not trivial, as there is a bit of a mixup on whether a "bus"
should create all children and thus define their type (PCI would do such
a thing) or whether the type is defined by the device object itself
which typically would be the case for "generic" busses such as SoCs or
PLBs when creating platform devices. I haven't quite found out a nice
way to enable both possibilities... if you have ideas, please share.

In the meantime, maybe it's best to merge the of_platform_device
approach since Jeff agrees with it.

Cheers,
Ben.
