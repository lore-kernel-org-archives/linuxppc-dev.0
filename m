Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EEC0DDE23D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 07:02:50 +1000 (EST)
Subject: Re: Get new_emac driver running on 405EP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: M B <super.firetwister@googlemail.com>
In-Reply-To: <6a6049b80804141038k77ac361cl11f50bc9d890c6a2@mail.gmail.com>
References: <6a6049b80804141038k77ac361cl11f50bc9d890c6a2@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 15 Apr 2008 07:02:41 +1000
Message-Id: <1208206961.6958.180.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-04-14 at 19:38 +0200, M B wrote:
> Hi,
> I'm trying to get the new_emac driver (linux 2.6.25-rc8) running on my
> 405EP board with a KSZ8721BT Micrel/Kendin PHY.
> I've already found 2 problems/missing features:
> 1) 100 retries in __emac_mdio_read for the read to complete are
> slightly too less. 101 seem to be enough. But we could add a bit more,
> because there is no negative effect for faster chips.
> 2) On the 405EP only the MDIO pin of the emac0 is pinned out, so both
> phys have to be accessed through this one. This affectes the mdio
> read/write functions.

The later can easily be described in the device-tree as it's a fairly
common setup.

> I've already hacked around this problems, but ethernet is still not working.
> After bringing up the device dmesg is flooded with this section.
> emac/plb/opb/ethernet@ef600800: link timer
> emac/plb/opb/ethernet@ef600800: mdio_read(00,01)
> emac/plb/opb/ethernet@ef600800: mdio_read -> 786d
> emac/plb/opb/ethernet@ef600800: mdio_read(00,01)
> emac/plb/opb/ethernet@ef600800: mdio_read -> 786d
> 
> 
> Any ideas where I should start looking?

The above is the timer polling the link, you may want to remove that
debug once it looks sane.

Ben.
