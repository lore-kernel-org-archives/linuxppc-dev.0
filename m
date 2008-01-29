Return-Path: <lagrange@fr.oleane.com>
Received: from smtp01.msg.oleane.net (smtp01.msg.oleane.net [62.161.4.1])
	by ozlabs.org (Postfix) with ESMTP id 82104DDF40
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 01:26:15 +1100 (EST)
Received: from GEGE6600V ([194.3.133.184]) (authenticated)
	by smtp01.msg.oleane.net (MTA) with ESMTP id m0TE4QcS003758
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 15:04:27 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-dev@ozlabs.org>
Subject: PCI configuration with multiple PCI controllers
Date: Tue, 29 Jan 2008 15:20:50 +0100
Message-ID: <000501c86282$2a5ba9e0$a501a8c0@GEGE6600V>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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
