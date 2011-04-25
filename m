Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 72D67B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Apr 2011 06:28:10 +1000 (EST)
Message-ID: <4DB5D548.7020303@harris.com>
Date: Mon, 25 Apr 2011 16:10:48 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: device not available because of BAR 0 collisions
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm getting an error message when trying to talk to some custom hardware:

dx83xx 0001:43:00.0: device not available because of BAR 0 [0xa1000000-0xa1ffffff] collisions

I see in setup-res.c that this message comes out when there is no parent for
a device resource.

I've been digging around in the code, and I confess that I cannot figure out
where the parent member is assigned.  Can someone please give me a hint as to
where the assignment happens?

The hardware consists of a pair of ASICs attached to a PPC405EX via a PCIe switch.
The device tree is based on the Kilauea evaluation board.  The device tree does not
specify the PCIe switch or ASICs.

Do I need to add something to the device tree to represent the PCIe switch, or
should it be automatically discovered and configured?

U-Boot reports the PCI hardware as:

PCIE0: successfully set as root-complex
        01  00  1172  0004  ff00  00
PCIE1: successfully set as root-complex
        05  00  1b03  7000  0000  ff
        04  01  10b5  8613  0604  00
        06  00  1b03  7000  0000  ff
        04  02  10b5  8613  0604  00
        03  00  10b5  8613  0604  00

The PCIe switch shows up as 03:00, 04:01, and 04:02.  The ASICs show up as 05:00 and
06:00, so there is no problem with config-space that I can see.

Similar hardware (an evaluation board for the ASICs) works ok on an x86 PC.  The
PCIe switch is recognized, and the ASIC driver probes and enables the device
without any problems.  Sadly, I cannot plug it into the Kilauea because it needs a
PCIe x16 slot.

Guidance gratefully accepted!

	Steve


-- 
A: Because it makes the logic of the discussion difficult to follow.
Q: Why shouldn't I top post?
A: No.
Q: Should I top post?
