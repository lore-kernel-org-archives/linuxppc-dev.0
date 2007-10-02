Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4BFD6DDE35
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 16:24:23 +1000 (EST)
Subject: Re: [PATCH 3/4] Simplify rtas_change_msi() error semantics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1191304690.6593.8.camel@concordia>
References: <3034ec8fd939bd5cfcdb7ac65206ae2771dc9b2c.1190270165.git.michael@ellerman.id.au>
	<fbd88f287ba9d9ca41b5c8da734afd595ae25922.1190270165.git.michael@ellerman.id.au>
	<1191302603.6310.88.camel@pasglop> <1191304690.6593.8.camel@concordia>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 16:24:13 +1000
Message-Id: <1191306253.6310.106.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-02 at 15:58 +1000, Michael Ellerman wrote:
> > Looks allright, just a question tho... what do we do if it fails ?
> Do we
> > try to fallback to a lower number of MSIs ? Or what ? Dead device ?
> 
> That's all up to the device driver. In theory the driver could try again
> with a lower count - but that might require extra logic in the driver to
> handle shared irq handlers etc. In practice I think the current drivers
> will just fail.

Question is badly phrased.. I meant something more like... what do we do
if RTAS returns a lower count ?

That is, we end up with that device with that lower count of MSIs
enabled, we fail at the driver level, do we still somewhat keep track ?
Drivers might assume that means it can use LSIs no ? which may not be
the case... Shouldn't we try to switch back to LSI mode (or does the
RTAS interface doesnt allow it ?)

Ben.
