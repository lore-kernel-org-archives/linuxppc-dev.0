Mime-Version: 1.0
Message-Id: <p0510030bb8bd42311546@[66.26.75.241]>
Date: Tue, 19 Mar 2002 14:32:06 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: compile bug/fix, 2.4.19pre3
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Compiling today-rsynced 2.4.19pre3 (source.mvista.com::linuxppc_2_4) yields:

drivers/net/net.o: In function `bmac_set_multicast':
drivers/net/net.o(.text+0xa5e0): undefined reference to `ether_crc_le'
drivers/net/net.o(.text+0xa5e0): relocation truncated to fit:
R_PPC_REL24 ether_crc_le
make: *** [vmlinux] Error 1


I solve this by adding

	#include <linux/crc32.h>

in drivers/net/bmac.c. I don't know if this is the correct fix.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
