Date: Sun, 27 Apr 2003 12:42:36 -0700
From: Fred Gray <fegray@socrates.berkeley.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: ppc_irq_dispatch_handler dominating profile?
Message-ID: <20030427194236.GC25907@socrates.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear linuxppc-dev,

I'm trying to get a gigabit Ethernet card (SBS Technologies PMC-Gigabit-ST3;
it uses the Intel 82545EM chipset and therefore the Linux e1000 driver) to
work with a MVME2600 board (a PReP board with a 200 MHz PowerPC 604e CPU).
I'm getting surprisingly poor performance and trying to understand why.

I'm running a simple benchmark program that was passed along to me by a kind
soul on the linux-net@vger.kernel.org mailing list.  It has two modes, one
that uses the ordinary socket interface, and one that uses the sendfile()
system call for zero-copy transmission.  In either case, it simply floods the
destination with TCP data for a fixed amount of time.  The results in
non-zero-copy mode agree with standard benchmarks like netperf and iperf,
which I have also tried.  In any event, the maximum bandwidth that I have
been able to obtain is about 15 MByte/s, and that level of performance required
16000 byte jumbo frames and zero-copy mode.  Transmission was clearly CPU-bound.

I used the kernel profiling interface (kernel version 2.4.21-pre6 from the
linuxppc_2_4_devel tree) to determine where the hot spot is.  Using ordinary
socket calls, these are the leading entries:

  5838 total                                      0.0059
  3263 ppc_irq_dispatch_handler                   5.7855
  1645 csum_partial_copy_generic                  7.4773
   133 e1000_intr                                 0.8750
    89 do_softirq                                 0.3477
    69 tcp_sendmsg                                0.0149

In zero-copy mode, this is the situation (notice that the copy and checksum
have been successfully offloaded to the gigabit interface):

  5983 total                                      0.0061
  4740 ppc_irq_dispatch_handler                   8.4043
   614 e1000_intr                                 4.0395
    61 e1000_clean_tx_irq                         0.1113
    52 do_tcp_sendpages                           0.0179
    51 do_softirq                                 0.1992

In both cases, ppc_irq_dispatch_handler is the "winner."  I'm not very familiar
with the kernel profiler, especially on the PowerPC, so I don't know whether
or not this is likely to be an artifact of piled-up timer interrupts.
Otherwise, it suggests that something dramatically inefficient is
happening in the interrupt handling chain, since it spends twice as much
time here as it does touching all of the outgoing data for the copy and
checksum.

I would appreciate suggestions of what I might check next.

Thanks very much for your help,

-- Fred

-- Fred Gray / Visiting Postdoctoral Researcher                         --
-- Department of Physics / University of California, Berkeley           --
-- fegray@socrates.berkeley.edu / phone 510-642-4057 / fax 510-642-9811 --

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
