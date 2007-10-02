Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 23223DDF55
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 02:10:02 +1000 (EST)
Message-ID: <47026D5C.4050308@freescale.com>
Date: Tue, 02 Oct 2007 11:10:04 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 2 6/7] Uartlite: Add of-platform-bus binding
References: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>	<20070930224208.1871.2913.stgit@trillian.cg.shawcable.net>	<1191304386.6310.92.camel@pasglop>	<fa686aa40710020726s330d586p6ece70ae378f1206@mail.gmail.com>
	<871wcd33ux.fsf@macbook.be.48ers.dk>
In-Reply-To: <871wcd33ux.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:
>  Grant> What advantages do you see with the constructor approach?
> 
> One advantage is that it keeps the of stuff out of the drivers. There
> already is one bus for platform stuff in the kernel, so from a device
> driver writer POV the of stuff is just extra fluff. Imagine the ARM or
> MIPS people coming up with 2 other incompatible ways of doing this and
> you'll see the drivers bloat.

OTOH, it's nice to keep everything relating to a certain device in one 
spot, rather than scattering some bits in arch.  Plus, the device tree 
is not just powerpc; it's also used on sparc ond OLPC.

> E.G. I use the smsc911x.c network driver on powerpc which is written
> by an ARM guy. Why should he need to care about of stuff in his driver?

Just because an ARM guy wrote it doesn't mean powerpc guys can't stuff 
things in there. :-)

It would be nice, though, to merge platform and of_platform to some 
extent, so that things which don't need to check "special" device tree 
properties wouldn't have to make any changes other than maybe adding an 
extra match table entry.

-Scott
