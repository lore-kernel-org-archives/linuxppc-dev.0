Message-ID: <387F50F9.641B80EF@netx4.com>
Date: Fri, 14 Jan 2000 11:38:17 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Christer Weinigel <wingel@cendio.se>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 16kb pages on MPC850
References: <200001140318.EAA16881@dumburk.cendio.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Christer Weinigel wrote:

> Or does anybody have better ideas on how to improve the performance of
> Linux on a MPC850?

There are lots of MMU related performance enhancements on my
list.  You touched on just a couple, although 16K pages are
probably not the way to go.

The 8M mapping for the kernel is one way to go, although you
have to be careful about the dynamic VM allocator alignment, and
it presents a further problem for loadable modules.

Now that the VM changes in the 2.3.xx have settled down, I am
going to start working on two projects.  One is the larger 8M
mapping for the kernel, and the second is to further modify the
Linux generic functions so they don't assume the pgd and pmd are
pointers.  I can then significantly reduce the amount of code in
the page fault handlers.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
