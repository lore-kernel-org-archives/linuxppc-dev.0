Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D00D679F8
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 02:45:06 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <fe487e7a8a89e65cfefd4f5dd39a982d@embeddededge.com>
References: <1116222720.5095.86.camel@gaston>
	<7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>
	<c58d28ab50872f95d4c4a751d1768513@embeddededge.com>
	<1116255938.5095.133.camel@gaston>
	<fe487e7a8a89e65cfefd4f5dd39a982d@embeddededge.com>
Content-Type: text/plain
Date: Tue, 17 May 2005 02:42:05 +1000
Message-Id: <1116261725.5095.139.camel@gaston>
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


> The PMac is only one "board" out of many we support, and I don't think
> it should be considered the default or generic configuration any more
> than any other board.  The PMac is the easiest to update because it's
> a single configuration file. 

Single ? Hrm... not so sure :) It's also the biggest (in terms of line
of code) subarch of the ppc32 architecture :) Besides, pmac is also chrp
& prep as I'm really talking about CONFIG_PPC_MULTIPLATFORM (too bad no
embedded vendor ever tried to be part of the common kernel... heh)

>  If you want that to have a 3G default task
> space, then update that one configuration file.  

Hrm... you mean the defconfig then ? Ok, right, well, I suppose we could
update pmac, prep and chrp defconfigs. It's still not the default as per
Kconfig which I find a little bit annoying. 

> As we have time we
> will update all of the others, and when we get to the point where most
> boards are of that configuration, we'll make it the default and the
> minority of boards become the special cases.

On the other hands, how many embedded boards care about getting the
latest "linus" tree ? I mean, I do have to update pmac support regulary
as new developpement occurs, and you know as well as I do that 2.6.x
series are by no mean stable. Embedded code has been rather frozen in
the rock, I don't think it's much to ask from the appropriate maintainer
to have a quick look at possibly upgrading their board support as well.
And it isn't a difficult change for most 6xx/7xx/7xxx based boards
anyway. What I'm worried about is that without some "pressure" (like
breaking them), it will simply never be fixed...

The whole io_block_mapping() was a bad idea in the first place. We
introduced that API to replace an even worse one which was to set BATs
directly in the early days of the kernel, but I for one think we should
just have killed the whole thing in the first place.

Ben.
