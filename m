Message-ID: <39B37AD2.120E2DE7@agelectronics.co.uk>
Date: Mon, 04 Sep 2000 11:34:58 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: PATCH: improved processor config for G3s
References: <Pine.HPX.4.10.10009041137010.15978-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:

> A rule of thumb is the following: fully SMP capable processors broadcast
> eieio (and tlbie for that matter), others do not at least by default. On
> an UP 750 (SMP 750 are an aberration in any case because of TLB issues),
> I'd bet that it is more efficient to let the processor perform store
> gathering when it can (an eieio between both stores will prevent it) and
> to disable both ABE in the processor and store gathering in the bridge.
> This will result in lower processor bus utilization.

Remember that the processor store gathering is only capable of turning
two 32-bit writes to uncached, nonguarded space into one 64-bit write.
The bridge store gathering converts an arbitrary sequence of sequential
writes into a PCI burst.

The bridge store gathering should be able to produce far more IO
improvement, and still works if the guard bit is set on the address
space.

I should have done a set of MPC107 experiments by the start of October,
and I'll know for sure then.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
