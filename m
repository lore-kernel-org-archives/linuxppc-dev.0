Message-ID: <382877B4.F5CCF2FA@jlc.net>
Date: Tue, 09 Nov 1999 14:36:20 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Nicolas Pohland <pohland@snom.de>
CC: linuxppc-dev@lists.linuxppc.org, devel@gate.crashing.org
Subject: Re: MMU Initialization Problem
References: <38281D7F.CC9914C@snom.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nicolas Pohland wrote:

> 
> I can unzip the kernel at location 0 and then this space is mapped to
> 0xc0000000 in 1 8Mb page.

What do you mean?  You have to load zImage at or above 0x200000, then
jump to that location.  The boot code on the front of zImage has to
perform the uncompress of the kernel, and it further initializes the
board information sturcture for the rest of the Linux kernel.

> This is what I found strange:

You can't use the "standard" chip select and IMMR mappings that
most debuggers set for the FADS board.  The IMMR has to be well
into the kernel virtual space, something like 0xf0000000.

If you are using mpc8bug, you have to disable all debug and exception
traps, effectively removing the debugger capability.  You can't
debug Linux once the MMU is enabled, which happens within the first
few instructions.


> Have I missed something here ?

You should really get on the linuxppc-embedded mailing list.  All of
this was recently discussed, along with many other things that would
be helpful toward what you are doing.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
