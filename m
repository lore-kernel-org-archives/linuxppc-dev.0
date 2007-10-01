Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8AC9EDDDE7
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 09:14:26 +1000 (EST)
Subject: Re: [PATCH 2/7] [POWERPC] Fix QEIC->MPIC cascading
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20070925143429.GB5323@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143429.GB5323@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 09:14:21 +1000
Message-Id: <1191280461.6310.37.camel@pasglop>
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


On Tue, 2007-09-25 at 18:34 +0400, Anton Vorontsov wrote:
> set_irq_chained_handler overwrites MPIC's handle_irq function
> (handle_fasteoi_irq) thus MPIC never gets eoi event from the
> cascaded IRQ. This situation hangs MPIC on MPC8568E.
> 
> Patch adds flow level "end" handler to the MPIC, and QEIC calls
> it when QEIC's interrupt processing finished.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Not sure if I already NAKed it on the list, so if I didn't here's it :-)

The proper way of doing that is to have the cascade handler perform the
EOI call to mpic. Look at how it's done for i8259 mpic cascade handlers.

Basically, when doing a cascade nowadays, you can either just do a
normal request_irq() of the cascade, in which case your handler don't
have to care about the parent controller at all, but you get various
limitations and/or overhead from being a full blown interrupt handler,
or you can use the chained handler mechanism which is a "shortcut" but
implies that your cascade handler "knows" what needs to be done to the
parent (and thus is specific to the combination parent/child).

Cheers,
Ben.
