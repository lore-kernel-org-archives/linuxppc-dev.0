Date: Thu, 12 Aug 1999 14:52:24 +1000
Message-Id: <199908120452.OAA30014@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: weasel@cs.stanford.edu
CC: linuxppc-dev@lists.linuxppc.org, rth@cygnus.com
In-reply-to: <v04210106b3d7d41042e2@[209.239.164.148]> (message from Peter
	Chang on Wed, 11 Aug 1999 18:39:11 -0700)
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: 
 <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be>
 <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch>
 <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch>
 <19990811003805.A11890@cygnus.com>
 <199908120013.KAA25039@tango.anu.edu.au> <v04210106b3d7d41042e2@[209.239.164.148]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Peter Chang <weasel@cs.stanford.edu> wrote:

> When I did glide for the mac it definitely helped not do do an eieio 
> after every pci write. The current generations of 3dfx hw use a sw 
> managed fifo, and an eieio was only necessary when the sw layer 
> needed to do do things to insert a 'barrier' in the fifo for later 
> accounting.

Interesting.  What was the magnitude of the effect?  Are we talking
about 1%, 10%, or 100% faster?

This would have been from user level, right?  Driving a 3D card
through a kernel device driver would seem to be a bit painful.

Would it have been possible to use double-precision floating loads and
stores to transfer 8 bytes at a time?  That can double the available
bandwidth to PCI devices under some conditions.

Thinking about it, it seems to me that if your device needs to be fed
so fast that the eieio makes a difference, you *should* be feeding it
from user level rather than the kernel anyway, so then the behaviour
of readl/writel is irrelevant.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
