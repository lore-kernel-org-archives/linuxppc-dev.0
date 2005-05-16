Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 366CE679F0
	for <linuxppc-dev@ozlabs.org>; Mon, 16 May 2005 16:21:20 +1000 (EST)
In-Reply-To: <1116222720.5095.86.camel@gaston>
References: <1116222720.5095.86.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 16 May 2005 01:21:13 -0500
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
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


On May 16, 2005, at 12:52 AM, Benjamin Herrenschmidt wrote:

>
>
> > >
>  > > We need to fix that too :) Though I suppose we can just switch=20
> that to
>  > >=A0 page tables, I don't really see the point of using a BAT =
here...
>  >
> > Are the embedded board ports broken because of similar
> > io_block_mapping() calls or for some other reason?
>  =A0
>  Mostly because of the above, though some embedded ports may do even=20=

> more
>  horrible things for what i know :) The problem with =
io_block_mapping()
> is that 1) it lets you put those BARs or mappings where you want, and=20=

> 2)
>  you end up with plenty of code hard-coding this virtual address here=20=

> or
>  there that need to be fixed.

I'm interested to see if Paul is aware of any other embedded port=20
issues, since he mentioned the problem there.

Agreed, the other problem that comes up from time to time due to=20
io_block_mapping() that I've see is problem with modules not working=20
because the kernel doesn't think it has any vmalloc() space left.

> > I'm in agreement that we should bump TASK_SIZE to 3GB and fix =
things,
> > how about after 2.6.12 is out?
>
> Agreed. I'll fix PReP/CHRP/pmac & defconfig. Every embedded board
>  vendor/maintainer will be responsible for fixing his/her boards=20
> support.

Agreed.  We should probably send an email to linuxppc-embedded with a=20
more proper subject line to let people know.

- kumar
