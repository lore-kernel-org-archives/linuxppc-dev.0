Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32E622BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 01:55:21 +1100 (EST)
Date: Fri, 14 Jan 2005 15:55:18 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andy Fleming <afleming@freescale.com>,
	Kumar Gala <kumar.gala@freescale.com>, Netdev <netdev@oss.sgi.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <20050114145518.GA21418@wohnheim.fh-wedel.de>
References: <FC6D9B81-5514-11D9-8D51-000393C30512@freescale.com>
	<A3A281FF-5525-11D9-80ED-000393C30512@freescale.com>
	<20050106070245.GA6539@gate.ebshome.net>
	<61A37C72-659C-11D9-8D70-000393C30512@freescale.com>
	<20050113212152.GA16041@gate.ebshome.net>
	<20050113215808.GA15124@wohnheim.fh-wedel.de>
	<20050114010016.GA16635@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050114010016.GA16635@gate.ebshome.net>
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

On Thu, 13 January 2005 17:00:16 -0800, Eugene Surovegin wrote:
> On Thu, Jan 13, 2005 at 10:58:08PM +0100, J?rn Engel wrote:
> > 
> > http://www.broadcom.com/collateral/pb/5325-PB05-R.pdf
> > 
> > With some thinking and very little code, you can use this neat chip
> > almost like a normal phy.
> 
> Yeah, but why would I want to? If you connect your MAC to any 5 PHYs 
> my statement still stands, if directly to MII you don't need any PHY 
> stuff at all, because link is always ON and speed/duplex is fixed.
> 
> In fact, we use different switch chips connected to PPC4xx directly. 
> In this situation, in my NAPI IBM EMAC driver I just have special 
> "PHY-less" case which is trivial "fixed settings" one. And all this 
> PHY lib is completely unneeded bloat.

Wrt. the proposed PHY lib, I agree.  Didn't even bother to look at the
code, it's mere size said enough.

But an abstraction different from drivers/net/mii.c is needed to
handle the 5325 chip.  Or, you could have the special cases all over
in your code, but that's a) ugly and b) more code.  I used to have
such a mess and after doing the proper abstraction, it line count went
down.

Jörn

-- 
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt
