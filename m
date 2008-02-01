Return-Path: <lagrange@fr.oleane.com>
Received: from smtp03.msg.oleane.net (smtp03.msg.oleane.net [62.161.4.3])
	by ozlabs.org (Postfix) with ESMTP id CC405DDE3B
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 01:32:58 +1100 (EST)
Received: from GEGE6600V ([194.3.133.184]) (authenticated)
	by smtp03.msg.oleane.net (MTA) with ESMTP id m11EWtrG001474
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Feb 2008 15:32:56 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-dev@ozlabs.org>
Subject: PCI configuration with multiple PCI controllers
Date: Fri, 1 Feb 2008 15:33:03 +0100
Message-ID: <000001c864df$63b833c0$a501a8c0@GEGE6600V>
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
Laurent
