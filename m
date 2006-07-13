Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 37D4167B6A
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 05:43:13 +1000 (EST)
Subject: Re: Maple platform - adding graphics to IBM PIBS firmware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jf simon <jfaslist@yahoo.fr>
In-Reply-To: <44B4D2A4.7090204@yahoo.fr>
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DE5E@ismail.innsys.innovsys.com>
	<20060710214158.1d8dcf2c@vitb.ru.mvista.com>
	<Pine.LNX.4.60.0607102135330.10561@poirot.grange>
	<1152567817.1576.114.camel@localhost.localdomain>
	<44B3A772.3000101@yahoo.fr>
	<1152658938.6346.76.camel@localhost.localdomain>
	<44B4D2A4.7090204@yahoo.fr>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 05:43:06 +1000
Message-Id: <1152819786.23037.12.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I was (naively) thinking that if I could access the legacy VGA register 
> set, I could set the graphic card to text mode and use the graphic 
> screen as a alphanumeric console, until linux soft boots the graphic 
> card . Do you think this is doable? I haven't been able to locate that 
> VGA register set yet.

The legacy VGA operations also require the card to be fully initialized
by the BIOS. In addition to that, there is an issue with using VGA text
mode on machines using the CPC925 bridge as it doesn't have a legacy
memory window: It doesn't have a facility to generate PCI or HT memory
cycles in the low addresses required for VGA.

You can still hack-around in a somewhat card-specific way using the main
memory apperture and doing your onw interleaving of characters and
attributes but it's dodgy.

In any case, you still need the card to be initialized.

Ben.
