Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47C0A67BD4
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 08:40:13 +1000 (EST)
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200610180022.24631.arnd@arndb.de>
References: <4534BE9D.7030908@bplan-gmbh.de> <20061017132243.GA6773@lst.de>
	<200610180022.24631.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 08:39:55 +1000
Message-Id: <1161211195.10524.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-18 at 00:22 +0200, Arnd Bergmann wrote:
> On Tuesday 17 October 2006 15:22, Christoph Hellwig wrote:
> > >       rtas_node = of_find_node_by_name(NULL, "rtas");
> > >       if (rtas_node == NULL)
> > >               return -ENODEV;
> > 
> > And given this check I wonder why we need the platform check at all.  It
> > should be safe to just remove it.
> > 
> 
> One difference would be that it triggers on machines running SLOF (QS20, 
> some JS20/JS21) and maybe some older Macs, which is probably a good
> thing.

Older macs may have bits of RTAS, but it doesn't work. I'd rather still
blacklist machine_is(powermac).

> I wonder if it should be a little stricter though:
> 
> > 	rtas_node = of_find_node_by_path("/rtas");
> >	if (!rtas_node)
> >		return -ENODEV;
> 
> In case there is a node called "rtas" somewhere else.

Yeah, just in case...

Ben.
