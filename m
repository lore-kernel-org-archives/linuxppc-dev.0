Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7EECF2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 02:49:55 +1100 (EST)
Date: Fri, 14 Jan 2005 16:49:51 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andy Fleming <afleming@freescale.com>,
	Kumar Gala <kumar.gala@freescale.com>, Netdev <netdev@oss.sgi.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <20050114154951.GC21418@wohnheim.fh-wedel.de>
References: <FC6D9B81-5514-11D9-8D51-000393C30512@freescale.com>
	<A3A281FF-5525-11D9-80ED-000393C30512@freescale.com>
	<20050106070245.GA6539@gate.ebshome.net>
	<61A37C72-659C-11D9-8D70-000393C30512@freescale.com>
	<20050113212152.GA16041@gate.ebshome.net>
	<20050113215808.GA15124@wohnheim.fh-wedel.de>
	<20050114010016.GA16635@gate.ebshome.net>
	<20050114145518.GA21418@wohnheim.fh-wedel.de>
	<20050114152518.GB23768@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050114152518.GB23768@gate.ebshome.net>
Subject: Re: [RFC] Patch to Abstract Ethernet PHY support (using driver
	model)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 14 January 2005 07:25:18 -0800, Eugene Surovegin wrote:
> On Fri, Jan 14, 2005 at 03:55:18PM +0100, J?rn Engel wrote:
> > Wrt. the proposed PHY lib, I agree.  Didn't even bother to look at the
> > code, it's mere size said enough.
> > 
> > But an abstraction different from drivers/net/mii.c is needed to
> > handle the 5325 chip.  Or, you could have the special cases all over
> > in your code, but that's a) ugly and b) more code.  I used to have
> > such a mess and after doing the proper abstraction, it line count went
> > down.
> 
> Well, I still fail to see what is so _special_ about this chip that it 
> needs "proper abstraction". Could you elaborate, please?
> 
> The way I handled this in my drivers was clean and simple - 
> "there-is-no-PHY". And this wasn't in any case chip-specific and was 
> set up through OCP in board support code. So I'm kinda puzzled what 
> "ugliness and more code" you are talking about.
> 
> We can also make a fake PHY which will always indicate link, will have 
> fixed speed/duplex capabilities and will not support autoneg. If you 
> think this is more elegant, OK, I might even agree with you :).

Exactly.  You need link status, speed and duplex status at the least.
Put query functions for those three into a struct phy_ops or whatever
it may be called and you're done.

Depending on your hardware, you may also need something more
complicated for various fixups, etc.  But it's mostly those three
functions.

> Please, note that wrt current discussion we are interested only in CPU 
> port, not other 5 ports which aren't connected to the CPU at all. This 
> is completely different stuff and yes, if we want to expose them in 
> some way we need another abstraction. But abstraction of switch chips 
> is a big and complex thing - they are very different, and frankly this 
> one you mentioned is quite "feature-challenged" and will not make 
> a good "model" chip IMHO :).

Well, it's one of the few I've had to worry about so far.  I'm a big
non-believer in abstractions I just don't need yet.  The one outlined
above I already needed.

Jörn

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
-- Theodore Roosevelt, Kansas City Star, 1918
