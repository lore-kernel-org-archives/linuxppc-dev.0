Date: Sat, 18 Dec 1999 16:29:51 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "Jens Ch. Restemeier" <jrestemeier@currantbun.com>
cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Update - Re: Open Sourced Glide on Linux PPC
In-Reply-To: <385ACAED.F1058039@currantbun.com>
Message-ID: <Pine.LNX.4.21.9912181510001.9036-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 17 Dec 1999, Jens Ch. Restemeier wrote:

> 
> 
> Okay, a small update:
> 
> I decided to go the /dev/3dfx way, and got everything to compile. That
> was last weekend.
> 
> Status:
> - /dev/3dfx detects the card correctly. It uses the kernel's PCI
> functions to detect the card, mmap's it when it is requested and
> provides ioctls to access the PCI configuration registers.
> 
> - Glide compiles, after disabling the assembler triangle setup code.
> >From the documentation I think that P6FENCE should avoid instruction
> reordering between I/O accesses. From the information here I think 
> eieio (sp?) it the PPC instruction to use.

  Yes if you look at the macos defines you see that they use eieio there
they seem to do lots of read/writes without ever doing an eieio but since
it is working in macos i am not too worried.

> 
> - Problems: E - N - D - I - A - N. sigh... /dev/3dfx returns several
> values through a memory buffer. Guess... That's currently the point
> where glide fails.

  They do all memory access through the GETxx SETxx defines you can 
do the byteswapping there, the linux specific code doesn't use this 
though so you'll have to change this too.

> 
> Maybe I can free a few minutes this weekend to look deeper into it, but
> I plan to checkout the sourceforge version, too. Maybe there are already
> changes... I'd be happy if they fixed the build-system.
>
> Jens
> 

  I managed to get glide (v3) running a couple of days ago in my voodoo3
its far from ready yet though, especially the autobump stuff is beyond my
understanding yet, i get fifo lockups there :( in the macos side they 
seem to do call dcbf/dcbz to clear/flush the fifo but in our side the fb
memory is uncached......


Jens maybe we should work together over this ? send my an email if you are
intrested.


 Kostas Gewrgiou
 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
