Date: Fri, 11 Jul 2003 09:31:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Juergen Beisert <jbeisert@eurodsn.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcbz-instruction on PPC405GP
Message-ID: <20030711163123.GY17433@ip68-0-152-218.tc.ph.cox.net>
References: <200307111623.45470.jbeisert@eurodsn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200307111623.45470.jbeisert@eurodsn.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jul 11, 2003 at 04:23:45PM +0200, Juergen Beisert wrote:

> I want to speed up some data copy in my Linux driver and so I want to use the
> dcbz-instruction.
> I get the memory with a kmalloc()-call with GFP_KERNEL argument. After that I
> call a small assembler routine that uses dcbz to set this memory to zero. I
> am shure this memory starts at 32 byte boundary and ends at another 32 byte
> boundary. But if I call the dcbz-instruction I get an alignment exception.
> I have tried to test the "Write Trough" and "Caching Inhibit" bits for this
> TLB, but I'm not shure that I have found the right one. I have called
> get_pteptr() with the kmalloc() returned virtual address. Is this the right
> way to get informations about this TLB? The returned value seems ok (caching
> enabled and write back, if Linux uses the same bit positions like the 405GP
> manual).
> With caching enabled and write back the dcbz-instruction should work (that's
> what I have read in the manual). Right?

Why are you not calling memset on this region instead?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
