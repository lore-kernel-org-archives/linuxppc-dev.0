Message-ID: <BE1C564723B3D21191FD0000F840E39801D81505@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: interference between scc serial and ethernet: more information
Date: Fri, 5 May 2000 10:17:25 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The target is a custom board similar to the EST8XX configuration, with an
860 and an LXT908 PHY.  I ultimately need to run PPP on SCC3.  When ethernet
receives data, it messes up SCC3's configuration somehow.  I briefly tested
with SCC2 and saw the same thing, but I have concentrated on SCC3.

It's a 50MHz MPC860, identified by 8xxrom as XPC860xxZPnnC1 and actually
stamped as XPC860ENCZP50C1.  Running at 50MHz.

Three nodes on the ethernet: the target, the Abatron BDI2000, and the
development host.

Case 1) Linux boots with default parameters, no IP address.  I use SCC3
serial, no problem.  Then, on the development host, I ping a non-existent
address (causing an ARP request broadcast).  After that, the SCC3 serial is
not working.  Sometimes, when I write to SCC3, garbled characters come out
(like it's the wrong baud rate).  Other times, nothing comes out at all.

Case 2) Linux boots with IP address parameters.  I use SCC3 serial, no
problem.  Then, on the target, I ping a non-existent address.  Serial still
works fine.  I get "neighbour table overflow" messages.

Case 3) In enet.c, in cpm_enet_rx(), I commented out code so that all
received frames get tossed.  Again, SCC3 serial stops working when the
development host pings an unknown address.

I tried activating kgdb to debug this, but kgdb stops working as soon as the
init shell starts.  It seems to be a fight over which process gets the input
data.  I'm looking at it with BDM, but that's quite slow since I have to
translate memory references.

I see four potential possibilities.
a) A bug in the enet or serial driver.  Not likely, since others report that
Ethernet and SCC serial ports work simultaneously for them.
b) A hardware problem on my board.  My co-worker says that's unlikely, since
his low-level test software exercises Ethernet RX and uses SCC3 as the
console.
c) A blatant configuration error in my setup of Linux.  Not likely, since
Ethernet and Serial each work independently.
d) My board violates some assumptions made by Linux and/or the drivers.
That seems to me to be the most probable, but I can't think of what it might
be.

Please feel free to throw out random ideas as to what I should look for.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
