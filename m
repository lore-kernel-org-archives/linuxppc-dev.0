Date: Thu, 20 Feb 2003 15:05:55 -0500
From: Kent Borg <kentborg@borg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bringing up Motorola MGT5100
Message-ID: <20030220150555.G24949@borg.org>
References: <20030220142703.A24949@borg.org> <20030220193611.GB24845@ip68-0-152-218.tc.ph.cox.net> <20030220144812.D24949@borg.org> <20030220195523.GD24845@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030220195523.GD24845@ip68-0-152-218.tc.ph.cox.net>; from trini@kernel.crashing.org on Thu, Feb 20, 2003 at 12:55:23PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Feb 20, 2003 at 12:55:23PM -0700, Tom Rini wrote:
>
> On Thu, Feb 20, 2003 at 02:48:12PM -0500, Kent Borg wrote:
>
> [snip]
> > [TARGET]
> > CPUTYPE     5100        ;the CPU type
>
> Are you sure you want this?  Maybe it should be '603'..

I certainly am not sure, but as the file from Abatron has "5100" as
part of its name, I think they know of this beast.

>
> > ;MMU         XLAT	;translate effective to physical address
> > PTBASE      0x000000f0  ;here is the pointer to the page table pointers
>
> Keep the MMU line,

YES!  Looky:

  Breakpoint 1, 0xc00037a0 in start_here ()
  3: x/5i $pc
  0xc00037a0 <start_here>:	lis	r2,-16368
  0xc00037a4 <start_here+4>:	ori	r2,r2,42032
  0xc00037a8 <start_here+8>:	addis	r4,r2,16384
  0xc00037ac <start_here+12>:	addi	r4,r4,624
  0xc00037b0 <start_here+16>:	mtsprg	3,r4
  (gdb)

> comment out the PTBASE maybe?

But I want that hint to work once I get that far...and I can read
those high values without changing it, so I'm leaving it alone for
now.


Thanks a bunch,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
