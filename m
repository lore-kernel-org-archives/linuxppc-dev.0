Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A0C99B6FBC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 07:24:46 +1000 (EST)
Message-ID: <1339449862.9220.13.camel@pasglop>
Subject: Re: PowerMac PMU programming
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Justin Hibbits <chmeeedalf@gmail.com>
Date: Tue, 12 Jun 2012 07:24:22 +1000
In-Reply-To: <20120610233127.1284fec0@narn.knownspace>
References: <20120610092932.38857c77@narn.knownspace>
 <1339369393.24838.101.camel@pasglop>
 <20120610233127.1284fec0@narn.knownspace>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-06-10 at 23:31 -0400, Justin Hibbits wrote:

> I'll settle on just getting the CPU speed change working, losing 333MHz
> on my TiBook is a few too many MHz for the poor thing to lose :)  I do
> have a desktop, but that's my development platform, so needs to be
> at least somewhat stable, so my TiBook is my guinea pig.
> 
> I've googled everything I can think of, but do you know of any
> definitive PMU documentation?  Or can you give me any hints on what's
> needed just for that simple operation?

No doco no, Darwin and Linux source code are your best bet.

It works like sleep as in: you send the switch command and the PMU will
reboot the processor with the new frequency whenever the processor
enters NAP mode.

This is tricky because there's a loss of cache coherency vs. ongoing
DMAs, hence tricky bits of code in there to deal with the various
caches.

> I noticed that you wind down the ADB queue before killing the PMU.  Is
> this necessary?  I only disable the interrupt by writing 0x10 to the
> IER, but our interrupt model for the PMU is different from the Linux
> one. 

Well that will not disable CB1 (or the external GPIO one). You need to
make sure no other communication with the PMU takes place once you've
sent the sleep command and until you're back.

>  Is it also necessary to disable the interrupt input, even though
> the register write should be disabling the PMU's asserting of the
> line?  There doesn't seem to be much more different than that, and
> setting the openpic priority, Linux sets it to 0x0f but I didn't see
> anything in OS X doing that (might that be a problem, too?)
> 
> I would love to get my TiBook using the full 1GHz.

I don't remember what openpic does in Darwin, I think interrupts are all
masked there as a side effect of the code in KeyLargo.cpp but I'm not
sure that applies to frequency changes.

Cheers,
Ben.
