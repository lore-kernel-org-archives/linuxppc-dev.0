Return-Path: <lagrange@fr.oleane.com>
Received: from smtp03.msg.oleane.net (smtp03.msg.oleane.net [62.161.4.3])
	by ozlabs.org (Postfix) with ESMTP id 06EA7DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 19:54:48 +1100 (EST)
Received: from GEGE6600V ([194.3.133.184]) (authenticated)
	by smtp03.msg.oleane.net (MTA) with ESMTP id m0U8WqQk026615
	for <linuxppc-embedded@ozlabs.org>; Wed, 30 Jan 2008 09:32:53 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: PCI configuration with multiple PCI controllers
Date: Wed, 30 Jan 2008 09:37:14 +0100
Message-ID: <001f01c8631b$54872930$a501a8c0@GEGE6600V>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

I have a MPC8641 based board. I try to use the two PCIe controllers. My
firmware configures (physically) the PCI buses as follow:

------------------+
MPC8641 PCIe 1	|	bus 1		+--------------+
			| --------------> | PCI device 0 |
	BUS 0		|			+--------------+
- - - - - - - - - +
MPC8641 PCIe 2	|	bus 3		+--------------+
			| --------------> | PCI device 1 |
	BUS 2		|			+--------------+
------------------+

I launch the Linux image (2.6.23.9). During the Kernel PCI configuration,
buses behind the 2nd MPC8641 PCIe are skipped because its primary bus don't
start at bus number 0. The kernel reconfigure the primary bus number of the
MPC8641 PCIe 2 controller from 2 to 0.

I can patch the kernel to work with my firmware but I don't know if my PCI
configuration is the good one.

What is the common way to configure the PCI for Linux when a new controller
is found: start the bus number to 0 or to the last bus number + 1?

Regards
Laurent
