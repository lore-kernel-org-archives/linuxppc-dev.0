Subject: Caching in the MPC107
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Date: 09 Sep 2002 15:23:24 +0100
Message-Id: <1031581408.30396.81.camel@newt>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've just been debugging an interesting problem with a new board that
uses a MPC107 bridge with a 7445 processor. The symptoms were that the
ethernet device never saw updated transmit descriptors unless another
bus master was active in the system.

The underlying problem is that linuxppc_2_4_devel only sets the
_PAGE_COHERENT flag on memory when CONFIG_SMP is enabled. This doesn't
allow for the fact that the MPC107 contains caches. The cache causing
the problem was the PCI-to-Local-Memory-Read-Buffer (PCMRB), which can
store two 32-byte cache lines.

This wouldn't have been seen on previous boards, because the 750 had
only MEI cache states, and the 7400 required the S state to be
explicitly enabled in MSSCR0. The S state cannot be disabled on the
7450, leading to the possibility of a cache line being allocated in both
the 7450 and the MPC107.

My current thinking is to produce a patch which introduces a new option:
CONFIG_CACHING_HOSTBRIDGE which boards combining the MPC107 and the
MPC7450 can set. This will probably be needed for Motorola's Valis or
Gyrus PMCs.

Comments?

-- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
