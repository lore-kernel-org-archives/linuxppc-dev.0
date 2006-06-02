Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id A3A7967A58
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Jun 2006 03:33:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC85xx PCI transfer disconnect
Date: Fri, 2 Jun 2006 10:33:45 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE48710538852E@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

More information...

> > Did you enable Memory Read Multiple command of your PCI master?
>=20
> Thanks for the clue.  I'm trying to figure out how to do this.  The
PCI
> master is a Tundra TSI148 VME-PCI bridge.  The documentation says it
> supports the PCI read multiple cycle, but so far I haven't found a
> register to specifically configure it.  I'll check the C/BE lines to
see
> if a PCI read multiple cycle is being issued.
>=20

After grepping through the Tundra documentation more closely, I found
this tidbit:

"Memory read multiple: The memory read multiple command is used when the
requested byte count is greater than 32 bytes."


> I have confirmed that 64 bytes are being transferred before the
MPC85xx
> disconnects the transfer.  If the PCI master initiates a 32 byte or 64
> byte read, the MPC85xx does not disconnect the transfer.
>=20

After scaning more logic analyzer captures, I noticed that occasionally
the MPC85xx inserts additional wait states (by deasserting TRDY#) after
only 32 bytes have been transferred.  So it definitely appears that (the
way I have things configured now) there's a 20-80ns delay after 1 cache
line is read, and the MPC85xx disconnects transfers that are larger than
2 cache lines.

Tim
