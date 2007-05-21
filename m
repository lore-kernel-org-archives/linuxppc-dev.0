Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E733DDE4A
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 08:11:49 +1000 (EST)
Subject: Re: Interrupt routing broken on TiBook IV with 2.6.21.x ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian =?ISO-8859-1?Q?B=F6hme?= <monodhs@gmx.de>
In-Reply-To: <4651FC48.8000002@gmx.de>
References: <4650E27B.3020401@gmx.de>
	<1179712614.32247.597.camel@localhost.localdomain>
	<4651FC48.8000002@gmx.de>
Content-Type: text/plain; charset=utf-8
Date: Tue, 22 May 2007 08:11:41 +1000
Message-Id: <1179785502.32247.748.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-21 at 22:08 +0200, Christian Böhme wrote:
> Benjamin Herrenschmidt wrote:
> 
> > Nope... it can't be a routing problem since interrupt -is- routed (you
> > are getting it !)
> 
> Actually, these were the exact words from the ALSA developer.  For some
> reason, however, the interrupt count does not increase after some (variable)
> time.  It looks as if the ALSA code waits for but not receiving them.  After
> a restart, an audio signal does leave the jack and the interrupt count
> increases but only for about a second (sometimes more, often less).  No idea 
> whether interrupts must be routed/are routable on this very machine I have at 
> all ...

Or it could be the DMA channel going dead though I fail to see why it
would just start doing that now.

> > Which exact tipb model is this ? (cat /proc/device-tree/model)
> 
> PowerBook3,5 of the 2002-11 release variety.

Ok, I think I have access to one of these, I'll try to reproduce myself.

> I stuck to OSS up to the 2.6.19.x kernels where everything (surprisingly)
> ``just worked''.  Then came the 2.6.20.x series and <root>/sound/oss/\
> dmasound/dmasound_awacs.c started spitting out loads of ``tx-irq: xfer died -
> patching it up...'' messages with stuttering audio output but nothing
> different in their respective implementations from 2.6.19.x to 2.6.20.x.
> 
> Is there anything particular I can dive into myself to expedite finding the
> cause of the problem without learning the full details of the PPC implemen-
> tation ?

Not sure where to start :-) I'll first see if I can reproduce.

Cheers,
Ben.
