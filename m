Subject: PATCH: 2.2 series FEC driver performance improvements
To: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Date: Mon, 21 Aug 2000 18:51:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000821085110.774C2204@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi gang,

I've been profiling TCP performance over the FEC, and have come up with a
patch which improves onchip FEC receive performance on the MPC855/860T
processors, by DMAing received data for large packets directly in a kernel
socket buffer instead of using eth_copy_and_sum to copy the packets.  There
is also a small improvement from leaving the packet buffer cached and
explicitly invalidating it, instead of making it uncached.  The net effect is
around 15% - 20% speedup in raw TCP throughput on a 50 MHz 855T.

Also included are the following minor fixes/speedups:
- Correctly transmitted packets are no longer counted as having errors.

- Received packets that get dropped are no longer included in rx_packets.
  (as per drivers/net/skeleton.c).

- Receive FIFO overrun errors are now counted as such, rather than as CRC
  errors.

- Avoid reading buffer descriptor status bits multiple times, especially since
  the descriptors themselves are still uncached.

Please let me know what you think!

The patch is available at:
    http://members.xoom.com/greyhams/linux/patches/2.2/fecdmaskb.patch

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
