Date: Fri, 06 Jun 2003 12:50:20 -0700
From: Ron Bianco <ronb@lcsaudio.com>
Subject: Has anyone made the 8240 do burst reads from PCI memory?
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Message-id: <000401c32c64$dc6a4690$4d00a8c0@warp-speed>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

We have a custom 8240 board running a linux 2.2.x kernel variant with some dual
port SRAM mapped into PCI memory space using a custom CPLD.  We use a modified
version of the sandpoint setup in the ppc linux kernel initialization code.

In the ISR of a custom device driver we read and write to the PCI mem
successfully.

FYI, although not a PCI expert, I'm trying to determine if we need to upgrade
our CPLD code in order to successfully support memory read cycles with more than
one data phase.

Even with sequential reads in groups of 8 words, ( or writes for that matter )
we are unable to get the 8240 to do other than single (beat) word read PCI
cycles.  One 'strange' thing in particular is that the 8240 as PCI initiator is
keeping !FRAME asserted only very briefly.
It also de-asserts !IRDY very soon after the first data phase completes.  It may
be that the 8240 is just indicating a wait and we need to handle that better.

Anyway, according to the 8240 user's manual it supports burst ordering of the
linear incrementing type for memory accesses when the 2 low order bits of the
address are 0, as we are doing.

So I was just wondering if anyone has actually gotten an 8240 to access PCI
memory with multiple beat, memory read cmds.?

regards, Ron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
