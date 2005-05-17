Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED9B4679FC
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 10:57:50 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <22b73f109d1c4a95b565f1007d76b8bf@embeddededge.com>
References: <1116222720.5095.86.camel@gaston>
	<7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>
	<c58d28ab50872f95d4c4a751d1768513@embeddededge.com>
	<1116255938.5095.133.camel@gaston>
	<fe487e7a8a89e65cfefd4f5dd39a982d@embeddededge.com>
	<1116261725.5095.139.camel@gaston>
	<22b73f109d1c4a95b565f1007d76b8bf@embeddededge.com>
Content-Type: text/plain
Date: Tue, 17 May 2005 10:54:47 +1000
Message-Id: <1116291287.5095.147.camel@gaston>
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


> Who cares?  We have the ability to support the memory map flexibility
> for everyone.  If you need it, use it, and fix it if necessary.  There 
> are
> too many other things that need attention.  Again, you are taking one
> of the features we added for embedded boards a long time ago, and
> demanding everyone support it.

Gack ? None of this was 'added for embedded boards'. The initial 2G/2G
split was Cort's decision afaik for the PReP port, and it was PReP and
pmac that introduced the use of BATs for IO mappings, which then got
turned into io_block_mapping() for clarity. Those platorms predate by
far any embedded involvement in the ppc kernel.

>   That's not necessary.   If you want
> to use this feature on a PMac, then use it, but please don't demand
> everyone else do so.  We didn't do that when the feature was added.

It's more than a "feature", it's the way it should have been done in the
first place on 6xx/7xx/7xxx CPUs and wasn't done because of a cheap hack
for IO mapping. I have no problem with other CPU family maintainers
deciding to restrict TASK_SIZE for the sake of saving a couple of
instructions (on 4xx, it's really replacing andis.;beq with
rlwinm;cmpl;bne or something like that, so one instruction, to support
any TASK_SIZE).

> > The whole io_block_mapping() was a bad idea in the first place.
> 
> All of the ideas in 2.6 are going to look like bad ideas in the future 
> :-)

Hrm... If you say so ...

> It's what worked and was necessary given the lack of any other
> APIs at the time. 

ioremap and variants was available at this time and has always been.

>  We are working on removing these in the embedded
> boards, and it has to be done on the PMac as well if you want to
> take advantage of something other than a 2G task space.

Well, you know what ? I've removed them from pmac a long time ago :) And
you know what also ? what you just stated above is _exactly_ what this
thread is all about ... so what are you complaining about ? :)

> As time permits, I will make whatever changes to the board ports
> I'm aware of so they will accommodate a 3G task space, or fix up
> the configuration files so the default is 2G.  At some point, we can
> make it the configuration default.

Good, I'm not asking for anything else here.

Ben.
