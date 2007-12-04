Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B4CACDDE23
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 00:13:55 +1100 (EST)
Date: Tue, 4 Dec 2007 07:13:59 -0600
From: Scott Wood <scottwood@freescale.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Add IPIC MSI interrupt support
Message-ID: <20071204131359.GA5784@loki.buserror.net>
References: <1196394519.29683.8.camel@Guyver>
	<1196654521.13554.32.camel@concordia>
	<1196672870.14353.21.camel@Guyver>
	<1196746689.20158.4.camel@concordia>
	<995B09A8299C2C44B59866F6391D2635D75588@zch01exm21.fsl.freescale.net>
	<1196769858.32524.8.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196769858.32524.8.camel@concordia>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Gala Kumar <kumar.gala@freescale.com>, Li Tony <Tony.Li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 11:04:18PM +1100, Michael Ellerman wrote:
> On Tue, 2007-12-04 at 18:34 +0800, Li Tony wrote:
> > I am not very sure about spin_lock influence.
> > But maybe somebody will change the virq_to_hw implementation.
> > I will take virq_to_hw instead. 
> 
> I mean the time to take the function call should be pretty small
> compared to taking and releasing a spinlock - but if you have
> performance numbers to prove otherwise let me know :)

I don't think the IPIC is used on any SMP platforms at the moment, so
there's no spinlock overhead other than disabling interrupts...

That said, it's not worth reimplementing to avoid a function call.

-Scott
