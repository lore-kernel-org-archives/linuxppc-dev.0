Message-ID: <3A6CA6A9.7794B603@mvista.com>
Date: Mon, 22 Jan 2001 16:31:21 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Jeff Hartmann <jhartmann@valinux.com>
CC: Roman Zippel <zippel@fh-brandenburg.de>, michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <Pine.GSO.4.10.10101221945230.19978-100000@zeus.fh-brandenburg.de> <3A6C8C6E.3C19F151@mvista.com> <3A6C9852.4090201@valinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jeff Hartmann wrote:

> Okay let me try and explain things a little better.

Got it.  That is what I was guessing, only surprised you are holding
page structs, but that makes sense.

> ......  Currently there is no kernel function to do
> this explicitly

I'm working on that.  The PowerPC port cheated by using BATs and
trivial macros, but this doesn't work on some of the newer processors
and more complex applications.  Other architectures did the same, and
I am surprised there aren't generic kernel functions to track down this
information.  In fact, these functions are already present for 4xx and
8xx processors, so don't write anything new.

> Another thing that happens later is that we need the bus address of each
> of these pages to program the card to do scatter gather dma from this
> region.

That's where this is going to fall apart on PowerPC.

> .....  We do virt_to_bus(pagelist[i]->virtual) to accomplish this
> translation.

I have to write some code (or actually remove some #ifdefs) before
this will work for you.

> I know on the ia32 a pgd/pmd can actually point to 4MB pages rather then
> a real pte.  Does the PowerPC have anything like this?

Not yet.  It's on the way....

> ....  I would doubt
> that I would encounter anything like this from a vmalloc'ed area of
> memory (since vmalloc is arch independent and it would call alloc_page
> for each individual pte.)  Am I correct in this assumption?

Yes.

> Just FYI, the code I posted works fine on the ia32 platform (only tested
> with the i386 classic 2-level page tables.)

What you are doing so far should work too on PowerPC.

> Another thing we might be running into here is that vmalloc does not
> guarantee a virtually contiguous area of memory (or so I am told.)

Ummm...of course it is virtually contiguous.  How could it be
different?  You request a size, and it returns a base virtual address.
If there were holes in it, how would you know?

> .....  I've
> NEVER seen this in practice on an ia32 platform.

It can't happen on any platform (or I don't understand something about
the comment, which could very well be the case today).



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
