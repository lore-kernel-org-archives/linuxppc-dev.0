Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CECF167C0D
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Jul 2005 01:40:25 +1000 (EST)
Date: Fri, 8 Jul 2005 08:40:20 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: David Grab <d.grab@hima.com>
Message-ID: <20050708154020.GC3734@gate.ebshome.net>
References: <001501c583ae$44cc3930$f201a8c0@SN7606>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001501c583ae$44cc3930$f201a8c0@SN7606>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC440GX IBM EMAC2/3 RGMII mode selection
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jul 08, 2005 at 01:14:54PM +0200, David Grab wrote:
> I solved the PHY assertion with my board specific function. Thanks to Travis
> B. Sawyer for this hint.
> 
> 		if (i < 2) {
> 			emacdata->phy_map = 0xffffffff;
> 			emacdata->phy_mode = PHY_MODE_NA;
> 		}
> 		else {
> 			emacdata->phy_map = 0x00000001;
> 			emacdata->phy_mode = PHY_MODE_RGMII;
> 		}
> 
> But now i have a new problem. As you can see my PHY is detected and working
> properly. It respond on link down and link up by (un)connecting ethernet
> cable. Also i get RX Stuff from ethernet. But if i ping after setting
> network, then it results in No response and even i can?t measure an TX
> Enable or TX Clock signal from PPC440 to my PHY. I debugged a litte bit and
> i think it?s becaus my ethernet is set up with zmii0: input 0 in SMII mode
> and rgmii0: input 0 in RGMII mode. Is it possible that eth0 uses SMII mode
> instead of RGMII so that no TX CLK / Enable is generated from PPC?

[snip]

> mal0: Initialized, 4 tx channels, 4 rx channels
> emac: IBM EMAC Ethernet driver, version 2.0
> Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
> zmii0: input 0 in SMII mode
> emac0: Can't find PHY.
> zmii0: input 1 in SMII mode
> emac1: Can't find PHY.
> zmii0: input 2 in SMII mode
> rgmii0: input 0 in RGMII mode
> eth0: IBM emac, MAC 00:04:ac:e3:28:8c
> eth0: Found Generic MII PHY (0x05)
> zmii0: input 3 in SMII mode
> rgmii0: input 1 in RGMII mode
> eth1: IBM emac, MAC 00:04:ac:e3:28:8d
> eth1: Found Generic MII PHY (0x06)

Are you using gigabit connection or ordinary fast ethernet (100 Mbps)?
If gige, then you have to add your gig PHY definition. Generic MII PHY 
in the current driver doesn't support GigE (my version supports it).

Another question, is ethernet on your board working in U-Boot?

There is alternative EMAC driver I wrote, which fixed numerous 
problems with current driver version (http://kernel.ebshome.net). You 
can try it and I can help you getting it working on your board, 
unfortunately I cannot help you much with the current driver, because 
it's known to be buggy and IMHO fighting it is a waste of time.

-- 
Eugene
