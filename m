Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E72B9DDED9
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 07:18:12 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc: add 16K/64K pages support for the 44x
	PPC32 architectures.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081103062612.023c24fc@zod.rchland.ibm.com>
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
	<1224123753-20907-2-git-send-email-yanok@emcraft.com>
	<48FF3889.2030304@linux.vnet.ibm.com>
	<fb412d760810311623i2b0f93a3r5aa0eb297e154b4a@mail.gmail.com>
	<20081101113018.GA13646@zod.rchland.ibm.com>
	<1225576502.8004.222.camel@pasglop>
	<20081102134153.GA1029@zod.rchland.ibm.com>
	<1225661596.8004.226.camel@pasglop>
	<20081102193307.32d17e62@zod.rchland.ibm.com>
	<1225673034.8004.239.camel@pasglop>
	<20081103062612.023c24fc@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 04 Nov 2008 07:17:42 +1100
Message-Id: <1225743462.8004.255.camel@pasglop>
Mime-Version: 1.0
Cc: Wolfgang Denk <wd@denx.de>, Ilya Yanok <yanok@emcraft.com>,
	Hollis Blanchard <hollisb@us.ibm.com>, linuxppc-dev@ozlabs.org,
	pvr@emcraft.com, dzu@denx.de, Hollis Blanchard <hollis@penguinppc.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-11-03 at 06:26 -0500, Josh Boyer wrote:
> On Mon, 03 Nov 2008 11:43:54 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > 
> > > Cropping the size of the memory node.  That was simplest to do from the
> > > cuboot wrapper at the time.  If marking it reserved via a reserve map
> > > is more elegant and correct, we could do that.
> > > 
> > > But I will still like to know what about the other way is hairy please.
> > 
> > I don't like it :-) Bad feeling ... don't like having a memory
> > node entry that isn't aligned to some large power of two typically.
> 
> Erm, ok.  And does your heebie-geebies extend to people using the mem=
> parameter in a similar fashion?

Nah, not really. It's not that it won't work, I suppose it does, though
I would have preferred a way to "reserve" that memory rather than take
it off. In fact, that last page could be used for other things, for
example it could be used as a dummy page to point stale DMA to or
whatever else.

Ben.
