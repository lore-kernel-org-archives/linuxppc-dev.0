Subject: Question about process/kernel address space
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1082616231.4760.14.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Thu, 22 Apr 2004 08:43:51 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in some elderly code for a VME-supporting 824x-board from
our company I found the following line in ppc_md.setup_io_mappings():

io_block_mapping(0x80000000, 0x80000000, 0x10000000, _PAGE_IO);

This is obviously meant to map a window of VME IO memory into
virtual address space. What puzzles me is that the mapping is
located below PAGE_OFFSET (0xc0000000), which, from my general
understanding, is bad :(

But since apparently nobody had a problem with this for years,
(and ranges above PAGE_OFFSET are tight) I'd like to know what
the actual implications are.
Ok, should a process ever access this range, it would fail
(since the BATs go first and allow only supervisor access(?)),
but a user process ever using such a high address seems highly unlikely.

What I worry more is that it might introduce some security
holes or stability problems, any thoughts?

Thanks,

--
Stefan Nickl
Kontron Modular Computers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
