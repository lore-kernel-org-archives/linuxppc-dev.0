Message-ID: <3A7D8C19.B829A8D0@mvista.com>
Date: Sun, 04 Feb 2001 12:06:33 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Fast Altivec
References: <3A7AE117.628B22A6@mvista.com> <20010202125143.D31120@altus.drgw.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes wrote:

> Heheheh, I have to ask.. is it really running that fast, and do you have all
> the neat features turned on?


It's really running that fast, in fact I may try to push it up to 800
MHz
just to see.  There are switches on the board to select up to 16
different
speeds in 50 MHz increments.  I have version 2.02 of the silicon now,
and you certainly don't want to use anything older than that (and in
fact you probably won't ever see any).

I have L1/L2 caches working.  I started on the L3 stuff but ran out of
time for the demo.  I discovered someone "fixed" my original Media-Q
graphics driver by removing all of the PowerPC big endian fixes (and did
other things like ioremap and then in/out).  I spent too long sorting
this out instead of working on processor specific things.

There are a few little details that have to be fixed up on the code,
lots of PVR things and a few new bits in some registers.

I also think the POWER3/POWER4 changes are not being done correctly.
There is too much overlap between the processor and the platform.  The
POWERx ifdefs should only be related to the processor, not how the
platform maps stuff to PCI or other things.  Since the 7450 has a 36-bit
addressing capability, I wanted to use some of the changes along the
POWERx
path to help out.  More on that later..........


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
