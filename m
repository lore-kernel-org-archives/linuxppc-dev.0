Message-ID: <396AF1B8.6FB1401C@agelectronics.co.uk>
Date: Tue, 11 Jul 2000 11:06:48 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help with string.S
References: <3967B1E3.80CAC746@embeddededge.com> <396969E1.A7256E4A@lightning.ch> <396A5162.411F49EF@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
> > What gives me trouble is the fact that dcbz instruction in function
> > arch/ppc/lib/string.S:__copy_tofrom_user does not seem to work for me.
> These are becoming a pain in the ass instructions.  Has anyone ever
> done some performance analysis to see what we really gain here in
> real life?  Sure, locally and logically you can make an intuitive
> argument, but we are sure fetching lots of instructions just to get
> this aligned, and further to actually move the data.

The 7xx(x) processors don't have the alignment handler set up to cover
this problem in 2.2, so they just get an oops when somebody writes to
uncached memory, like a framebuffer device. This could probably be
solved by starting the function with a test of the address, and using a
version without cache operations for target addresses above the kernel
image of memory.

Or by removing the cache operations. Even if they stay, could they be a
compilation time optimisation for particular processors?

> You know, we could make this even faster by using the Altivec and the
> new cache streaming modes on the 7400 processors :-).  I've tested this
> in applications.  It really works.

The 7400 certainly doesn't need the dcbz, as it will perform an implicit
allocation if the entire cache line is written by store instructions.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
