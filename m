Mime-Version: 1.0
Message-Id: <v04210106b3d7d41042e2@[209.239.164.148]>
In-Reply-To: <199908120013.KAA25039@tango.anu.edu.au>
References: 
 <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be>
 <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch>
 <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch>
 <19990811003805.A11890@cygnus.com>
 <199908120013.KAA25039@tango.anu.edu.au>
Date: Wed, 11 Aug 1999 18:39:11 -0700
To: linuxppc-dev@lists.linuxppc.org, rth@cygnus.com
From: Peter Chang <weasel@cs.stanford.edu>
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I may have sent this too early during editing. Sorry if you've seen 
an incomplete one already.

At 10:13 +1000 08.12.1999, Paul Mackerras wrote:
>Richard Henderson <rth@cygnus.com> wrote:
>
> > There are a great many cards that do memory mapped i/o that don't care
> > about the ordering and write combining of the data setup, only that the
> > data setup all be done before receiving the "go code".  In these drivers,
> > we need only one wmb insn, not one between each and every writel.
> >
> > This benefit is marked enough that there is zero chance you can convince
>
>I'm curious to see the numbers.  What sort of driver do you see this
>much of an effect in?

When I did glide for the mac it definitely helped not do do an eieio 
after every pci write. The current generations of 3dfx hw use a sw 
managed fifo, and an eieio was only necessary when the sw layer 
needed to do do things to insert a 'barrier' in the fifo for later 
accounting.

>The only exceptions I can think of would be 3D graphics cards (and possibly
>also gigabit ethernet cards, although they should be doing most stuff
>by DMA).

Hmmm.... well the fifo in the 3dfx case lives on the board so there 
is a tradeoff of doing a lot of bus io and trying to make the 
rasterization responsive. Also the hw did not do dma, so this was 
sort of beside the point. :-)

\p

---
Underneath this flabby exterior is an enormous lack of character.
                     -- Oscar Levant

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
