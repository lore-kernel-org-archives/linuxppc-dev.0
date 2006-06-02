Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 74A4F67AC7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Jun 2006 13:21:45 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC85xx PCI transfer disconnect
Date: Thu, 1 Jun 2006 20:09:40 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE487105387EC8@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I know this is probably a question for Freescale directly, but I thought
I would post here to see if anyone else has seen similar issues with the
MPC85xx PCI under Linux.

I'm using a Freescale MPC85xx (8541) processor and seeing an extreme
slowness to the PCI bus.

I'm attemping to do 2048 byte PCI burst reads from an external PCI
master.  So an external chip is the PCI master ("initiator") and the
MPC85xx is the PCI slave ("target")

When initiating the PCI burst read, there is a 270 ns delay from the
MPC85xx claiming the transaction (DEVSEL# going low) to being ready
(TRDY# going low).  Then 64 bytes (a single cacheline) are transferred,
and TRDY# goes inactive.  Next, STOP# goes low, terminating the
transfer.  I believe this is considered a PCI DISCONNECT type 1 since
IRDY# is active the entire time.

What I would expect is that the entire 2048 bytes are transferred in one
PCI bus mastership, but instead there are several re-arbitrations and
long delays in between several 64 byte transfers.

Additional info:
The PCI bus is 64bit running at 66 MHz.
I'm running a modified Linux 2.6.9 kernel (elinos-111).
The PCI CCSR piwar1 =3D 0xa0f4401d.

Freescale has an FAQ 21021 that describes having a PCI DISCONNECT 2,
which sounds similar to my problem, but I've already confirmed I'm doing
what the FAQ suggests (enable prefetching in the piwar register)
(http://www.freescale.com/webapp/sps/utils/SingleFaq.jsp?FAQ-21021.xml)

Any thoughts/suggestions would be appreciated,
Tim
