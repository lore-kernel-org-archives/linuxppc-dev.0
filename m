Message-ID: <3A6C8C6E.3C19F151@mvista.com>
Date: Mon, 22 Jan 2001 14:39:26 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: michdaen@iiic.ethz.ch, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <Pine.GSO.4.10.10101221945230.19978-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


...I don't know who wrote:
>
> > > There is no pte table and so there is nothing mapped at that address,

No, there is a pte table there, you just didn't get to printing
anything from it......

Roman Zipple wrote:

> It depends what you what you want to do.

I am really bad at guessing today....someone is going to have to
tell me what you are trying to do.  From the few lines of code I have
see posted, you are doing:

	1. Allocating some kernel virtual address and backing that
		with pages in real memory.

	2. Trying to find something in the kernel page tables, that I
		guessed wrong was a physical address of the pages.

Then, Jeff mentioned something about mapping user space pages, but
virt_to_bus/bus_to_virt aren't going to do that on PowerPC. I'm working
on some functions that will, but they aren't there for all systems yet.


> But you can also map something at that address, then you had to use
> *_alloc(), but leave that better to ioremap/vmalloc. (Look for map_page in
> arch/ppc/mm/init.c for how it can be done.)

Err...ahhhh...I don't know if I would go looking in that file for
examples.  I would prefer to understand the problem we are trying to
solve, and perhaps write some functions to call if necessary.  Scattering
code from functions in this file into other places may not be a good
thing.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
