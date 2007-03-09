Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id CEC29DDEB6
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 14:08:05 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l2937xJ2003277
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 20:08:00 -0700 (MST)
Received: from ld2052 (ld2052.am.freescale.net [10.82.18.5])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with SMTP id l2937xLh017552
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 21:07:59 -0600 (CST)
Date: Thu, 8 Mar 2007 21:07:59 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] (re)describing the PHY interface property
Message-Id: <20070308210759.59738f6d.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

we need to fix the interface property of the PHY nodes in the device
trees.  currently, we see things such as:

	interface = <6>; //ENET_1000_GMII

in mpc836x_mds.dts, which is bad because the speed and interface type
are conjoined.  I found a spec proposal based on response to a similar
matter on this list:

	http://playground.sun.com/1275/proposals/Closed/Accepted/378-it.txt

So do we go with proposal #378, and add the interface type to the end of
its comma-separated list, like this:

	supported-network-type = "ethernet,1000,,full,gmii";

or forget about proposal #378, and do something like:

	max-speed = <d#1000>;
	interface-type = "gmii";

?

Kim
