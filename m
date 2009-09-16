Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79655B7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Sep 2009 07:31:35 +1000 (EST)
Subject: Re: RFC: delete UART current-speed from 4xx DTS?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090916131943.GA14261@zod.rchland.ibm.com>
References: <20090915143135.GA7015@windriver.com>
	<20090915153220.GG12372@zod.rchland.ibm.com>
	<1253051047.8375.232.camel@pasglop>
	<20090916131943.GA14261@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 17 Sep 2009 07:31:06 +1000
Message-Id: <1253136666.8375.288.camel@pasglop>
Mime-Version: 1.0
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Ok, so I think that is related to what I originally hit.
> 
> I played around with removing the current-speed property on canyonlands today,
> and noticed that I would get no console output at all unless I specified a
> baudrate with console=ttyS0,115200.  That was sort of contrary to what I found
> with bamboo, so I diffed the configs to see why.  Bamboo has udbg enabled and
> hence has legacy_serial builtin, whereas canyonlands just has of_serial.
> 
> So on boards where of_serial is the only serial driver, we need either an
> accurate current-speed property, or a specific baudrate on the command line.
> That makes a bit more tenuous to remove the properties entirely, because if
> people disable udbg and are relying on that behavior they get no more console
> output.  Need to think on that a bit I guess.
> 
> Alternatively, we could try patching of_serial.c to do the baudrate probe
> as well.

Well, I've always wondered why we just don't put the probe in the 8250
driver... I proposed it on the list a while back and there was no
serious objection, but then forgot about it :-)

We should do it, and check if the result is sane (looks like a standard
speed). If it is, we should then just used it.

Ben.
