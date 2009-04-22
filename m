Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3754CDDED5
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 10:11:41 +1000 (EST)
Subject: Re: Porting the ibm_newemac driver to use phylib (and other
	PHY/MAC questions)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <kyle@moffetthome.net>
In-Reply-To: <f73f7ab80904201710m57472291yf7ff86760977b8e8@mail.gmail.com>
References: <f73f7ab80904171732n41832d0hc62978e57bbcc32e@mail.gmail.com>
	<625fc13d0904200529l152b8d75g33c3f940de1b2920@mail.gmail.com>
	<f73f7ab80904201710m57472291yf7ff86760977b8e8@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 22 Apr 2009 10:21:16 +0200
Message-Id: <1240388476.17445.10.camel@pasglop>
Mime-Version: 1.0
Cc: netdev <netdev@vger.kernel.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-04-20 at 20:10 -0400, Kyle Moffett wrote:
> > IIRC, Ben had some issues with how phylib and the EMAC would need to
> > interact.  Not sure if he has those written down somewhere or not.
> > (CC'd).
> 
> Hmm, yeah, I'd be interested to see those.  There's enough similar
> between phylib and the EMAC and sungem drivers that I'm considering a
> series of somewhat-mechanical patches to make EMAC and sungem use the
> "struct phy_device" and "struct mii_bus" from phylib, possibly
> abstracting out some helper functions along the way.

Yup, emac and sungem predate phylib.

I had a quick look at what it would take to port at least emac over, the
main issue was that I want to be able to sleep (ie, take a mutex) in my
mdio read/write functions, and back then, phylib wouldn't let me do that
due to spinlock and timer/softirq usage.

Ben.
