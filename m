Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F3CD679F0
	for <linuxppc-dev@ozlabs.org>; Mon, 16 May 2005 15:54:43 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <5833cd030098e5fc4600f691cab4f36c@freescale.com>
References: <1116200069.5095.51.camel@gaston>
	<5833cd030098e5fc4600f691cab4f36c@freescale.com>
Content-Type: text/plain
Date: Mon, 16 May 2005 15:52:00 +1000
Message-Id: <1116222720.5095.86.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >
> > We need to fix that too :) Though I suppose we can just switch that to
> >  page tables, I don't really see the point of using a BAT here...
> 
> Are the embedded board ports broken because of similar 
> io_block_mapping() calls or for some other reason?
 
Mostly because of the above, though some embedded ports may do even more
horrible things for what i know :) The problem with io_block_mapping()
is that 1) it lets you put those BARs or mappings where you want, and 2)
you end up with plenty of code hard-coding this virtual address here or
there that need to be fixed.

> I'm in agreement that we should bump TASK_SIZE to 3GB and fix things, 
> how about after 2.6.12 is out?

Agreed. I'll fix PReP/CHRP/pmac & defconfig. Every embedded board
vendor/maintainer will be responsible for fixing his/her boards support.

Ben.
