Date: Thu, 12 Aug 1999 00:33:18 -0700
From: Richard Henderson <rth@cygnus.com>
To: Paul.Mackerras@cs.anu.edu.au
Cc: Jes.Sorensen@cern.ch, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        Richard Henderson <rth@cygnus.com>
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Message-ID: <19990812003318.A14941@cygnus.com>
References: <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch> <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch> <19990811003805.A11890@cygnus.com> <199908120017.KAA25043@tango.anu.edu.au> <19990811214049.A14692@cygnus.com> <199908120500.PAA30022@tango.anu.edu.au> <19990811224344.A14713@cygnus.com> <199908120707.RAA30438@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199908120707.RAA30438@tango.anu.edu.au>; from Paul Mackerras on Thu, Aug 12, 1999 at 05:07:02PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 12, 1999 at 05:07:02PM +1000, Paul Mackerras wrote:
> > 10
> 
> One-cycle access to L1 cache, I guess?

No, 2 Cycles to L1 cache.  One cycle to execute the store,
which merely adds an entry to the store buffer.

> > 223
> 
> Because of i-cache misses, presumably

Presumably.  The 10 and 94 numbers are all that's interesting.

> Interesting.  Sounds like each wmb takes about 12 cycles ((94-10)/7),
> which sounds a bit like it is going all the way out to the memory bus
> and back before the cpu does the next instruction.
> 
> (Ob. nitpicking: if a wmb takes 12 cycles, how come we can do a wmb
> and 8 stores in 10 cycles? :-)

Because it doesn't work like that.  wmb adds a magic token to the
store buffer that prevents write combining and other such hw
optimizations.  Timing

	stq $31,addr
	stq $31,addr+8
vs
	stq $31,addr
	wmb
	stq $31,addr+8

shows only 1 cycle difference between the two.  I'm not quite sure
how the 12 works out.  I do know that L2 cache is 12 cycles away,
but that may just be coincidence.

Going all the way out to the memory bus would take a whole lot 
longer than 12 cycles.  More like 36.

> What numbers do you get on alpha if you point it at a framebuffer,
> just for interest?

I'll give that a try tomorrow.


r~

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
