From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14827.39263.212734.807452@argo.linuxcare.com.au>
Date: Tue, 17 Oct 2000 11:12:15 +1100 (EST)
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <Pine.HPX.4.10.10010121719150.16113-100000@gra-ux1.iram.es>
References: <19340906084536.29942@192.168.1.2>
	<Pine.HPX.4.10.10010121719150.16113-100000@gra-ux1.iram.es>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert writes:

> On Thu, 12 Oct 2000, Benjamin Herrenschmidt wrote:
>
> > On the kernel side, one of the PCI IO busses will be mapped to ISA. What
> > I'll do is basically to change the kernel inb/outb functions to do
> > something like
> >
> > if (addr < 64k)
> >   do_io(isa_io_base + addr)
> > else
> >   do_io(addr)
>
> No please, is there anybody bloat-conscious on this damned list ? Burying
> more and more code inside each {in,out}[bwl] is not the solution.

I agree that doing that in inb/outb is a bad idea.

> Just define a macro ISA_PORT or something like this and update the kernel
> to replace all the in/out to fixed ports to do in/out(ISA_PORT(n)). If you

You mean everywhere in all the generic code?  I confidently predict
that that wouldn't be accepted into the official kernel sources (and
nor should it be accepted).

> Advantages:
> - no iobase added in the PCI case: add iobase to all the
> pci_resource_start and the driver code shrinks. Have you ever counted
> the lwz instructions to access iobase, I have seen sequences where it
> represented 1/4 to 1/3 of the instructions!

I think iobase should be a constant, and we should set up our virt ->
phys mapping to do anything fancy that we might need.

> PCI I/O resources will have to be kernel virtual, physical is impossible
> with PreP if we want to lift the 2Gbuser space restriction (PreP I/O is
> from 2 to 3 Gb physical and the first thing to do is to reallocate devices
> which use it since most firmware use it too liberally, like one device
> every ... 256Mb). There are other and better ways to increase user
> available virtual space, however. And anyway I don't want any stinking add
> in each in/out macro.

Adding a constant is fine, that's just one instruction.  I think you
need to stop and look at the relative speeds of an I/O access
(hundreds of nanoseconds, if not microseconds) with the speed of a few
instructions or even a cacheable load.  In any case, I/O accesses are
actually very infrequent (if you don't believe me, measure it), unless
you're doing PIO to a high-bandwidth device, in which case it should
be using DMA.

> > Unfortunately, there's no simple way to allow two busses to have the
> > legacy IOs. That means on UniN machines that they'll be available either
> > on the AGP bus, or the external PCI bus, but not both.
>
> Indeed, this is too awkward (is tere no way to redirect only the VGA
> part of the legacy I/O space ? That's what the PCI-PCI bridges do, but
> I've not yet used a single machine with AGP so I'm ignorant).

Could someone fill me in on why we need legacy I/O to the AGP bus?

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
