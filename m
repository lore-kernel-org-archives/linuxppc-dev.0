Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 868742BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 12:00:18 +1100 (EST)
Date: Thu, 13 Jan 2005 17:00:16 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Message-ID: <20050114010016.GA16635@gate.ebshome.net>
References: <FC6D9B81-5514-11D9-8D51-000393C30512@freescale.com>
	<A3A281FF-5525-11D9-80ED-000393C30512@freescale.com>
	<20050106070245.GA6539@gate.ebshome.net>
	<61A37C72-659C-11D9-8D70-000393C30512@freescale.com>
	<20050113212152.GA16041@gate.ebshome.net>
	<20050113215808.GA15124@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050113215808.GA15124@wohnheim.fh-wedel.de>
Cc: Netdev <netdev@oss.sgi.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
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

On Thu, Jan 13, 2005 at 10:58:08PM +0100, J?rn Engel wrote:
> On Thu, 13 January 2005 13:21:52 -0800, Eugene Surovegin wrote:
> > 
> > It's a standard, period. If there is a PHY which isn't compliant I
> > guess it will not work anyway, but in this case, yes, we can use
> > PHY-specific link detection, but only in this case. I suspect you'll
> > have a hard time finding such PHY :)
> 
> http://www.broadcom.com/collateral/pb/5325-PB05-R.pdf
> 
> With some thinking and very little code, you can use this neat chip
> almost like a normal phy.

Yeah, but why would I want to? If you connect your MAC to any 5 PHYs 
my statement still stands, if directly to MII you don't need any PHY 
stuff at all, because link is always ON and speed/duplex is fixed.

In fact, we use different switch chips connected to PPC4xx directly. 
In this situation, in my NAPI IBM EMAC driver I just have special 
"PHY-less" case which is trivial "fixed settings" one. And all this 
PHY lib is completely unneeded bloat.

--
Eugene
