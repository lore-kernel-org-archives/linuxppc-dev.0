Message-ID: <FA06AA2C99BCD511951200005A99441001E3F17F@irvexch1.sextantifs.com>
From: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 16 May 2003 14:48:03 -0700
Subject: 64260/PCI accesses cached by CPU?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am using the Artesyn PM/PPC750F PMC in conjunction with a Ramix 100BT quad
Ethernet PMC module. When the system has *low* load, the performance of the
Ethernet ports on the second module is *very* slow. (will not complete `ttcp
-t 10.10.1.1 -s`) If the system is heavily loaded, in this case generating
lots of SCSI disk activity, the same ports have very high performance.

Note:
1. SCSI is also a PCI peripheral
2. The Ethernet ports on the processor are fine

At first I thought this was a hardware, IRQ line, problem but I see the same
behavior on Ethernet ports which do not share interrupt lines. (did not see
anything funny with a scope either)

I have come to the conclusion that the processor is caching either the PCI
I/O or memory access operations. Originally I thought the problem must have
been PCI memory access. I can see from gt64260_find_bridges() the I/O space
is going through ioremap(). However I do not see any such mapping for PCI
memory operations. (nothing in <platform>_setup.c) However after review of
mptbase.c, which works, and pcnet32.c, which is slow, it appears the problem
is reverse.

Linux kernel version:
linux-pmppc750f-prerelease_1_1  (from linux_2_4_galileo)

same results using:
linuxppc_2_4_devel - 2.4.21pre5

Ideas? Suggestions?

Thanks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
