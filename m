From: jtm@smoothsmoothie.com
Date: Tue, 10 Apr 2001 11:41:30 -0500
To: linuxppc-embedded@lists.linuxppc.org
Subject: Ethernet Bridging on 8260
Message-ID: <20010410114130.A32656@shamus.smoothsmoothie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We're trying to enable ethernet bridging between FCC2 and FCC3 on an
8260 (EST's SBC8260 eval board), and running into problems.

Our test is to send it continuous 1500 byte ethernet packets from
a SmartBits traffic generator. Transmitting on one port, everything
is fine until we send more than about 7500 packets back to back.

Below that value, all of the values reported by ifconfig are correct,
and memory use (reported by free) is constant. Above that value,
the 'TX packets' value reported from ifconfig does not match what
the SmartBits says it received, and according to free, we start using
more memory that never gets released. If we send 3-5 bursts of 8000
packets, we start getting output like:
	Out of Memory: Killed process 16 (sh)
	Out of Memory: Killed process 18 (inetd)
	__alloc_pages: 0 - order allocation failed.
	eth2: Memory squeeze, dropping packet

And so on.

Another test that we have tried is sending traffic on both ports. As
long as we send on both ports, we can generate traffic all the way
up to 100 Mbps without killing the kernel. (It can't keep up, but it
doesn't die). Above 95 Mbps, if we stop transmitting on one of the
ports, the system dies with error messages like those above.

We are using kernel 2.4.3, with a modified driver from bitkeeper's 2.5
kernel. The differences are:
	mii_discover_phy_poll() is commented out, and
		cep->phy_speed is set to 100,
		cep->phy_duplex is set to 1
	fcc->fcc_fgmr has the TCI bit cleared

We are running the 8260 core at 133 MHz and the CPM at 133 MHz


--
Jay Monkman	    The truth knocks on the door and you say "Go away, I'm
monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
		     - from _Zen_and_the_Art_of_Motorcycle_Maintenance_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
