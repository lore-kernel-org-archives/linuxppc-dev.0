Message-ID: <3B4F5BE9.6258498B@mvista.com>
Date: Fri, 13 Jul 2001 16:36:57 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Adam Wozniak <adam.wozniak@comdev.cc>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mmu problems
References: <3B4F412F.99A14D9E@comdev.cc>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Adam Wozniak wrote:

> I suspect there's something about the MMU that's not being configured
> properly, but I don't really know where to start.

Everyone assumes there are bugs in things they don't understand.
While there is always the possibility of something wrong, there are
lots of 8260s running Linux without trouble.  The same MMU code is
used on all 6xx platforms, which includes lots of Macs that have
been running for years.

I suspect you have a memory controller or other hardware design
problem with your board.  I have worked with many hardware engineers
debugging memory interface problems once Linux is running.  There
just aren't any diagnostics that exercise a system like Linux does.
The combination of cache, burst cycles, dma, and other simultaneous
resource uses always show design/implementation bugs you have never
seen before.  You are describing the classic symtoms some of us have
seen many times before.

Adam Wozniak wrote:

> NIP: C0005F80 XER: 00000000 LR: C000CF9C SP: C3417D30 REGS: c3417c80
> TRAP: 0700 MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11

You forgot the most important function from System.map, the one
at NIP.  Also, that MSR is bogus.  Somewhere, something was fetched
from memory that had bit 12 set.  We never do this in software, and
the hardware should always have it cleared.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
