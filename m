Return-Path: <stefan.nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id 19E2F2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Oct 2004 03:32:33 +1000 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Thu, 28 Oct 2004 19:20:03 +0200
Message-Id: <1098984003.11434.12.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Subject: All-ones problem with FCC1 on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm trying to port my version of linuxppc-2.4 from 8540 to 8541.
The point I'm stuck at right now is the FCC that replaces the FEC.

I checked port configuration and clock routing registers in
cpm2_io/fcc_enet.c again and again, but all I get in and out is ones.

The packet sizes I receive look reasonable, but the buffers are
filled only with 0xff. The same goes for sending, the contents
of the buffers are OK (dhcp discover...), but when capturing
the output on the other side with ethereal, the packet is again
all 0xff.

We just discovered that apparently preamble, frame delimiter and FCS go
out over the MII (at least TxD[0:3] change state), so I don't suspect a
hardware bug.

Any ideas?

-- 
Stefan Nickl
Kontron Modular Computers
