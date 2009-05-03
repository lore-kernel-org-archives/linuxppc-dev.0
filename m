Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 24704DDE0F
	for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2009 08:15:14 +1000 (EST)
Subject: Re: Porting the ibm_newemac driver to use phylib (and other
	PHY/MAC questions)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <kyle@moffetthome.net>
In-Reply-To: <f73f7ab80905022126ud3225enc6409bd39b5b2eb8@mail.gmail.com>
References: <f73f7ab80904171732n41832d0hc62978e57bbcc32e@mail.gmail.com>
	<625fc13d0904200529l152b8d75g33c3f940de1b2920@mail.gmail.com>
	<f73f7ab80904201710m57472291yf7ff86760977b8e8@mail.gmail.com>
	<1240388476.17445.10.camel@pasglop>
	<f73f7ab80904300804j1f847b70ha0fe3cda07249110@mail.gmail.com>
	<1241126291.29501.41.camel@pasglop>
	<f73f7ab80904301521x16effa0ar2d4756daceada122@mail.gmail.com>
	<f73f7ab80905022126ud3225enc6409bd39b5b2eb8@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 04 May 2009 08:14:54 +1000
Message-Id: <1241388894.1781.18.camel@pasglop>
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

On Sun, 2009-05-03 at 00:26 -0400, Kyle Moffett wrote:

> Ok, I've dug through the docs on the 460EPx (the CPU I'm using), and
> I'd like some confirmation of the following:
> 
> *  The EMAC hardware itself internally has its own dedicated
> MDIO/MDClk lines, driven by the STACR register.

Yes, though not all EMACs cells have this wired to anything. For
example, the 405EP has 2 EMACs but only EMAC0 has MDIO, which is
used to control both PHYs. Later variants multiplex the MDIOs via
a programmable switch in the ZMII or RGMII though.

> *  On many/most cpus, there is only a single set of external
> MDIO/MDClk pins, driven either off the ZMII bridge or the RGMII
> bridge.

Yes, though on the very old ones, the ZMII bridge is effectively
invisible (if it exists at all) and only EMAC0 MDIO pins are wired out.

> *  Both bridge-types have their own internal register for switching
> the external MDIO/MDClk pins between the two sets of internal
> EMAC<=>bridge links.

Yes.

> *  Some SoCs have both an ZMII and an RGMII bridge, and the external
> MDIO/MDClk pins are only connected to one of the two bridges (How do I
> know which one?  Alternatively, do I just program both and hope for
> the best?).

That's been my approach so far :-)

> *  Some older SoCs simply export the MDIO/MDClk pins from one of their
> internal EMAC chips and don't bother with running it through the
> multiplexing bridge.

Yes.

> Are there any SoCs which actually export the MDIO/MDClk pins from
> both/all of their EMACs?

I don't know of such a beast.

Cheers,
Ben.

> Cheers,
> Kyle Moffett
