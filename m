Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9E80@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Peter Desnoyers'" <pdesnoyers@chinook.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Kernel oops while routing
Date: Wed, 5 Dec 2001 13:38:42 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>     NETDEV WATCHDOG: eth0: transmit timed out
> Could this be related to a problem we've been seeing on the 860T,

I don't think so, the driver on the 860T is really stable under heavy
traffic and transmission errors. I was not able to kill it. The FEC itself
is relatively simple to manage, compared to the complex FCC on the 8260.

Your problem seems to be related to a bug I've found in the past, in the
ethernet driver. It appeared when filling the transmit ring buffer. It was
easy to reproduce when connected to a 10baseT. On a 100baseT, I should use
the packet sockets :-E. The fix has been incorporated in version 2.4.11. The
tx_full flag was not set to 1.


--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
