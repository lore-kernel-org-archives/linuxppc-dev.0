Date: Thu, 12 Aug 1999 10:13:28 +1000
Message-Id: <199908120013.KAA25039@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: rth@cygnus.com
CC: Jes.Sorensen@cern.ch, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        rth@cygnus.com
In-reply-to: <19990811003805.A11890@cygnus.com> (message from Richard
	Henderson on Wed, 11 Aug 1999 00:38:05 -0700)
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be> <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch> <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch> <19990811003805.A11890@cygnus.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Richard Henderson <rth@cygnus.com> wrote:

> There are a great many cards that do memory mapped i/o that don't care
> about the ordering and write combining of the data setup, only that the
> data setup all be done before receiving the "go code".  In these drivers,
> we need only one wmb insn, not one between each and every writel.
> 
> This benefit is marked enough that there is zero chance you can convince

I'm curious to see the numbers.  What sort of driver do you see this
much of an effect in?

For most things, the CPU spends an absolutely insignificant fraction
of its time doing accesses to I/O device registers.  The only
exceptions I can think of would be 3D graphics cards (and possibly
also gigabit ethernet cards, although they should be doing most stuff
by DMA).

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
