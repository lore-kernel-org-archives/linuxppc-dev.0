Date: Sun, 18 Nov 2001 01:45:12 -0500 (EST)
From: Bill Fink <billfink@mindspring.com>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: GigE Performance Comparison of GMAC and SUNGEM Drivers
Message-ID: <Pine.LNX.4.33.0111180047090.20750-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just did a GigE performance comparison of the GMAC and SUNGEM drivers
using the latest 2.4.15-pre4-ben0 kernel.  The two test systems were
both 867 MHz G4s connected to two ports on the same Extreme 5i GigE
switch.  The test was simply to measure the sustained TCP network
throughput for a 60 second period (using memory-to-memory transfers
of 64 KB buffers with a 768 KB window size).  The test was run shortly
after both systems had been rebooted, and there was nothing else of
significance running on either system (not even X windows).

The GMAC driver had significantly better performance.  It sustained
663 Mbps for the 60 second test period, and used 63 % of the CPU on
the transmitter and 64 % of the CPU on the receiver.  By comparison,
the SUNGEM driver only achieved 588 Mbps, and utilized 100 % of the
CPU on the transmitter and 86 % of the CPU on the receiver.  Thus,
the SUNGEM driver had an 11.3 % lower network performance while
using 58.7 % more CPU (and was in fact totally CPU saturated).

I was actually somewhat disappointed even by the GMAC GigE performance.
I was expecting to achieve nearly full GigE performance, and since there
was still about 1/3 of the CPU available, the bottleneck was obviously
elsewhere.  Perhaps it is just a limitation of the actual Broadcom BCM5411
GigE chip built into the 867 MHz G4.  I am hoping that this is in fact
the case.  I will be trying more tests later using a NetGear GA620T
PCI NIC using the ACENIC driver to see if it has better performance.
This NetGear NIC is also supposed to support jumbo frames (9K MTU),
and I am very interested in determining the presumably significant
performance benefits and/or reduced CPU usage associated with using
jumbo frames.

						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
