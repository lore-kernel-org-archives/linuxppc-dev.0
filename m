Return-Path: <mazsi@imrek.org>
Received: from mail.imrek.org (mail.imrek.org [67.207.130.102])
	by ozlabs.org (Postfix) with ESMTP id 1BF7BDDE01
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 04:40:21 +1000 (EST)
Date: Tue, 9 Sep 2008 20:40:12 +0200 (CEST)
From: jozsef imrek <mazsi@imrek.org>
To: linuxppc-embedded@ozlabs.org
Subject: RE: EDK10.1 and emaclite
In-Reply-To: <20080909152313.1CE1C17B8057@mail25-va3.bigfish.com>
Message-ID: <Pine.LNX.4.64.0809092004200.10180@mail.imrek.org>
References: <48C5F6ED.4000804@cdac.in> <48C62603.7080606@team-ctech.de>
	<20080909152313.1CE1C17B8057@mail25-va3.bigfish.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Georg Schardt <schardt@team-ctech.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


dear george,


On Tue, 9 Sep 2008, John Linn wrote:

> There is no way to configure the PHY using the EMAC lite as that's part
> of what makes it "lite".
>
> So the PHY on the board has to be configured correctly by strapping it
> on the board.

as john pointed out you can not access the PHY using only the EMAC
lite core. connect the MDIO and MDC lines of the PHY to a GPIO core.

then and use the bit banging driver of u-boot (start with #define CONFIG_MII
and #define CONFIG_BITBANGMII) or linux (search for CONFIG_MDIO_BITBANG,
i've not used it before).

fyi, on our minimodule boards the PHY is located at address #4, u-boot's
"mii info" command says:

 	PHY 0x04: OUI = 0x0818, Model = 0x0C, Rev = 0x01, 100baseT, FDX


for the inital setup you might want to connect the RJ45 of your
minimodule directly to your host pc, probably that's the easiest way
for you to see exactly what packets are travelling on the wire.

make sure that the negotiated speed is not 1000baseT, as the EMAC
lite can not handle that.



-- 
mazsi

----------------------------------------------------------------
strawberry fields forever!                       mazsi@imrek.org
----------------------------------------------------------------
