Return-Path: <kpoole@mrv.com>
Received: from chmailqsrv.int.mrv.com (mx2.lb.mrv.com [66.43.110.200])
	by ozlabs.org (Postfix) with ESMTP id DEC0ADDF4B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 01:48:25 +1100 (EST)
Received: from chmailqsrv.int.mrv.com (127.0.0.1) by chmailqsrv.int.mrv.com
	(MlfMTA v3.2r1b3) id hpcs1e0171sc for <linuxppc-embedded@ozlabs.org>;
	Thu, 8 Feb 2007 06:42:48 -0800 (envelope-from <kpoole@mrv.com>)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Mpc875 Ethernet does not work under linux
Date: Thu, 8 Feb 2007 09:43:10 -0500
Message-ID: <4D8794260B62C940BBA7150CC5EB3BD49A7E5C@bosmail.BOS.int.mrv.com>
From: "Kenneth Poole" <kpoole@mrv.com>
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


Looking at your printout from IFCONFIG, your link is receiving but not
transmitting. It attempted to send one packet, but got a carrier sense
lost error (error=3D1, carrier=3D1). This can be caused by a mismatch in
duplex setting between the FEC and the PHY. If the FEC is in half
duplex, it will expect to see carrier during its own transmissions. If
the PHY is in full duplex, the carrier will be absent causing the error.

Make sure that the DRT bit in the R_CNTRL register and the FDEN bit in
the X_CNTRL register are set correctly according to the duplex mode
under which the PHY is operating.=20

Ken Poole
MRV Communications, Inc.

kpoole@bos.mrv.com
