Message-ID: <3A6C933D.E952FB30@relog.ch>
Date: Mon, 22 Jan 2001 21:08:29 +0100
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: michdaen@iiic.ethz.ch
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: Roman Zippel <zippel@fh-brandenburg.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <Pine.GSO.4.10.10101221945230.19978-100000@zeus.fh-brandenburg.de> <3A6C8C6E.3C19F151@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> ...I don't know who wrote:
> >
> > > > There is no pte table and so there is nothing mapped at that address,
>
> No, there is a pte table there, you just didn't get to printing
> anything from it......

Why? Why does pte_offset yield a bogus pointer?


> > It depends what you what you want to do.
>
> I am really bad at guessing today....someone is going to have to
> tell me what you are trying to do.  From the few lines of code I have
> see posted, you are doing:
>
>         1. Allocating some kernel virtual address and backing that
>                 with pages in real memory.
>
>         2. Trying to find something in the kernel page tables, that I
>                 guessed wrong was a physical address of the pages.

We want the struct page for each page of the allocated virtual region. The
code apparently works on i386 (and alpha?).


> Then, Jeff mentioned something about mapping user space pages, but
> virt_to_bus/bus_to_virt aren't going to do that on PowerPC. I'm working
> on some functions that will, but they aren't there for all systems yet.

Hmm, hopefully this doesn't keep the PCI GART from working on PPC...


I've tried catching NULL pointers and *_present(), still the same problem. But
I'm not sure if I used them correctly.


Michel


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
