Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 73A47DDE05
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Nov 2007 00:30:20 +1100 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1IsenI-0003Mh-2c
	for linuxppc-embedded@ozlabs.org; Thu, 15 Nov 2007 14:30:16 +0100
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 15 Nov 2007 14:30:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200711151430.05943.jbe@pengutronix.de>
Subject: MPC5200B: Linux does not recognise the external PCI card
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

currently I'm trying to activate the PCI bus of my MPC5200B based card. U-Boot 
outputs:

[...]
PCI:   Bus Dev VenId DevId Class Int
        00  18  1033  0035  0c03  00
        00  18  1033  0035  0c03  00
        00  18  1033  00e0  00e0  00
        00  1a  1057  5809  0680  00
[...]

When I start Linux it outputs:

[...]
PCI: Probing PCI hardware
PCI: device 0000:00:18.0 has unknown header type 7f, ignoring.
mpc52xx_pci_fixup_resources() 1057:5809
[...]

and does not show the external card:

# lspci -v
00:1a.0 Bridge: Motorola Unknown device 5809
        Flags: bus master, 66MHz, medium devsel, latency 248
        Memory at a0000000 (32-bit, non-prefetchable) [size=256K]
        Memory at <unassigned> (32-bit, prefetchable)

Any idea what could cause this behavior?
Could this be an oftree related issue? Or something hardware only related?
The external slot is of 3.3V only type, running at 33 1/3 MHz.

If it is an oftree issue, can someone point me to some kind of documentation, 
what data I must provide in the
	pci@0d00 {
		....
	}
section?

Juergen
