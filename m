Mime-Version: 1.0
Message-Id: <v04210108b3d81592b0e5@[209.239.164.148]>
In-Reply-To: <199908120452.OAA30014@tango.anu.edu.au>
References: 
  <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be>
 <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch>
 <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch>
 <19990811003805.A11890@cygnus.com>
 <199908120013.KAA25039@tango.anu.edu.au>
 <v04210106b3d7d41042e2@[209.239.164.148]>
 <199908120452.OAA30014@tango.anu.edu.au>
Date: Wed, 11 Aug 1999 23:17:29 -0700
To: Paul.Mackerras@cs.anu.edu.au
From: Peter Chang <weasel@cs.stanford.edu>
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Cc: linuxppc-dev@lists.linuxppc.org, rth@cygnus.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 14:52 +1000 08.12.1999, Paul Mackerras wrote:
>Peter Chang <weasel@cs.stanford.edu> wrote:
>
> > When I did glide for the mac it definitely helped not do do an eieio
> > after every pci write. The current generations of 3dfx hw use a sw
> > managed fifo, and an eieio was only necessary when the sw layer
> > needed to do do things to insert a 'barrier' in the fifo for later
> > accounting.
>
>Interesting.  What was the magnitude of the effect?  Are we talking
>about 1%, 10%, or 100% faster?

It depended on the actual benchmark. A synthetic benchmark for a 
specific thing (flat triangles, gouraud triangls, texture download, 
etc) showed the biggest hits (~1% - 20% if memory serves). Actual 
game tests varied depending on their actual scene complexity, but had 
a similar effect.

>This would have been from user level, right?

Glide is always user level. (Well, on win32 there is a little driver 
level thing that does the mapping etc).

>Would it have been possible to use double-precision floating loads and
>stores to transfer 8 bytes at a time?  That can double the available
>bandwidth to PCI devices under some conditions.

I did not do this, but I know that Ken (the actual mac guy at 3dfx) 
did this and got some impressive improvements. I did this for texture 
downloads and stuff for 3DNow! machines (amd k6 and k7), and got 
really impressive results. (More so on the k6 because of the lack of 
write combining).

>Thinking about it, it seems to me that if your device needs to be fed
>so fast that the eieio makes a difference, you *should* be feeding it
>from user level rather than the kernel anyway, so then the behaviour
>of readl/writel is irrelevant.

That's true since the level switch will probably kill you anyway. I 
was just piping in w/ my $0.02 (a little off topic, you're right) 
that the eieio is not w/o its costs.

\p

---
Underneath this flabby exterior is an enormous lack of character.
                     -- Oscar Levant

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
