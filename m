Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D9EEDDDF0
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 17:35:49 +1000 (EST)
Subject: Strange tg3 regression with UMP fw. link reporting
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mcarlson@broadcom.com
Content-Type: text/plain
Date: Fri, 08 Aug 2008 17:35:39 +1000
Message-Id: <1218180939.24157.332.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	netdev <netdev@vger.kernel.org>, Nathan Lynch <ntl@pobox.com>,
	Michael Chan <mchan@broadcom.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Matt !

The IBM PowerStation is a machine similar in design to our JS21 blades,
which uses an HT2000 bridge with it's dual 5780 TG3's.

I started investigating recently a problem where with recent kernels,
the machine will appear to "freeze" every second or two for a second
or two. The "freeze" would affect pretty much everything.

We noticed that it disappears when downing eth0, and finally bisected
it down to commit 7c5026aa9b81dd45df8d3f4e0be73e485976a8b6 "Add link
state reporting to UMP firmware".

I don't know yet for sure what happens, but a quick look at the commit
seems to show that the driver synchronously spin-waits for up to 2.5ms
with a lock held multiple times from a timer interrupt. I don't know
yet if that's where the problem comes from, or if it's an issue with
the FW going nuts and the chip hogging the machine's bus or whatever
else, I'll have to do some more experiments on monday, but in any case,
that spin is really not nice.

The relevant pieces of lspci and dmesg are:

0001:00:01.0 PCI bridge: Broadcom HT2000 PCI-X bridge (rev b0)
0001:00:02.0 PCI bridge: Broadcom HT2000 PCI-X bridge (rev b0)
0001:00:03.0 PCI bridge: Broadcom HT2000 PCI-Express bridge (rev b0)
0001:00:04.0 PCI bridge: Broadcom HT2000 PCI-Express bridge (rev b0)
0001:00:05.0 PCI bridge: Broadcom HT2000 PCI-Express bridge (rev b0)
0001:00:06.0 PCI bridge: Broadcom HT2000 PCI-Express bridge (rev b0)
0001:02:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5780 Gigabit Ethernet (rev 10)
0001:02:04.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5780 Gigabit Ethernet (rev 10)

tg3.c:v3.91 (April 18, 2008)
tg3 0001:02:04.0: enabling device (0140 -> 0142)
eth0: Tigon3 [partno(BCM95780) rev 8100 PHY(5780)] (PCIX:133MHz:64-bit) 10/100/1000Base-T Ethernet 00:14:5e:9e:01:82
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[76144000] dma_mask[40-bit]
tg3 0001:02:04.1: enabling device (0140 -> 0142)
eth1: Tigon3 [partno(BCM95780) rev 8100 PHY(5780)] (PCIX:133MHz:64-bit) 10/100/1000Base-T Ethernet 00:14:5e:9e:01:83
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
eth1: dma_rwctrl[76144000] dma_mask[40-bit]

Any help sorting that out would be much appreciated !

Cheers,
Ben.
