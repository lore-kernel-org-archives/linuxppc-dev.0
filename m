Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3D29DE378
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 08:02:12 +1000 (EST)
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Dooks <ben-linux@fluff.org>
In-Reply-To: <20080811163648.GI26082@trinity.fluff.org>
References: <48A05152.7020508@harris.com>
	<20080811151913.GA14690@oksana.dev.rtsoft.ru>
	<20080811163648.GI26082@trinity.fluff.org>
Content-Type: text/plain
Date: Tue, 12 Aug 2008 08:02:01 +1000
Message-Id: <1218492121.8041.14.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	linux-ide@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-11 at 17:36 +0100, Ben Dooks wrote:
> On Mon, Aug 11, 2008 at 07:19:13PM +0400, Anton Vorontsov wrote:
> > When no irq specified, pata_of_platform fills irq_res with -1,
> > which is wrong to do for two reasons:
> > 
> > 1. By definition, 'no irq' should be IRQ 0, not some negative integer;

> interesting, IRQ 0 is actually valid on some ARM systems.

It never is on powerpc (anymore). Linus several times said he believed
that was the right thing to do, so when I make the whole IRQ handling
using virtual IRQ numbers on ppc, I made 0 reserved (and 1..15 only ever
assigned to a 8259 if there's one).

ARM, with their collections of cascaded fancy PICs all over the place
should probably look into using a similar remapping scheme :-)
 
Ben.
