Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id EA18767B59
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 22:50:44 +1000 (EST)
Message-ID: <1119967149.42c157ad7a74e@webmail.televes.com:443>
Date: Tue, 28 Jun 2005 15:59:09 +0200
From: Alex BASTOS <alebas@televes.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Subject: CPM2 reports CRC errors in FCC2 for good packets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi guys,

I am working with a MPC8248 custom board. On this, we have mixed
interfaces, with Ethernet on FCC1 working in Full Duplex 100Mbps,
and MII-generic on FCC2, working in Half-Duplex 100Mbps.

On FCC2, CPM2 reports CRC error for each received packet, but
ignoring it, packets arrive correctly. We have tested it with
a known packet (ARP broadcast) through both interfaces, and this
packet reports and CRC error on FCC2, but not in FCC1 ... but the
received packet is the same in both cases !!! (taken from buffer
pointed by RxBD):

# FCC2 : Generic-mii Half Duplex
# ARP Broadcast Packet received on board!!!
FF FF FF FF FF FF 00 10 5A A7 8A F3 08 06 00 01 08 00 06 04 00 01
00 10 5A A7 8A F3 0A 00 00 03 00 00 00 00 00 00 0A 00 00 01 00 00
00 00 00 00 00 00 00 00 00 0000 00 00 00 00 00 E7 E0 E9 46
... len: 64
CBD_SC = 1C84 (crc_error)


# FCC1 : ETHERNET Full Duplex
# ARP Broadcast Packet received on board!!!
FF FF FF FF FF FF 00 10 5A A7 8A F3 08 06 00 01 08 00 06 04 00 01
00 10 5A A7 8A F3 0A 00 00 03 00 00 00 00 00 00 0A 00 00 01 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 E7 E0 E9 46
... len: 64


So, packet is received ok, but CRC error is reported.
Any idea? May it be a Hardware problem, even if packets are received
OK by the driver?


Thanks,

Alexandre BASTOS
