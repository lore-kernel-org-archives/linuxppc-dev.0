Date: Thu, 12 Oct 2000 17:49:22 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <19340906084536.29942@192.168.1.2>
Message-ID: <Pine.HPX.4.10.10010121719150.16113-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Oct 2000, Benjamin Herrenschmidt wrote:

> >Since the card is a x86 one int10 is needed to initialize it, don't expect
> >the int10 code to work under linux/ppc though, it needs ISA IO and memory
> >access which don't work.
> >I have code to fix PIO for machines with only one iobase, but it
> >doesn't work with Uni-N machines (i have no idea how to handle code like
> >inb(0x3C3) in this machines and until someone figures out how to handle it
> >don't expect int10 to work....)
>
> I'm updating the PCI code in linuxppc_2_5 tree (which is more or less
> meant to be merged in _2_3 soon). I'm adding a couple of cases to the
> sys_pciconfig_iobase syscall to return the ISA mem and IO bases (if they
> exist).
>
> On the kernel side, one of the PCI IO busses will be mapped to ISA. What
> I'll do is basically to change the kernel inb/outb functions to do
> something like
>
> if (addr < 64k)
>   do_io(isa_io_base + addr)
> else
>   do_io(addr)

No please, is there anybody bloat-conscious on this damned list ? Burying
more and more code inside each {in,out}[bwl] is not the solution.

Just define a macro ISA_PORT or something like this and update the kernel
to replace all the in/out to fixed ports to do in/out(ISA_PORT(n)). If you
don't do it you'll get a nice panic so you'll find all the places quite
fast.

Advantages:
- no iobase added in the PCI case: add iobase to all the
pci_resource_start and the driver code shrinks. Have you ever counted
the lwz instructions to access iobase, I have seen sequences where it
represented 1/4 to 1/3 of the instructions!

- for fixed I/O ports, ok, use the ISA_PORT(n)

- for old legacy drivers but with variable addresses (serial for PreP...)
you just need to add the I/O base in the probe code provided the field
used to store the port is wide enough (not 16 bits). BTW, then for
inb/outb the compiler only has to add an offset to a parameter, not
iobase+base+offset, making the code more compact: it directly maps
to reg+offset addresses.

- on x86 ISA_PORT(n) will be (n), so they won't scream too much and the
drivers can be updated gradually.

Drawbacks ?

> This way, PCI IOs will be able to use real physical addresses that will
> have been put by the fixup code in the IO resources, while legacy IOs
> will tap the IO bus that we have decided is the "legacy" bus.

PCI I/O resources will have to be kernel virtual, physical is impossible
with PreP if we want to lift the 2Gbuser space restriction (PreP I/O is
from 2 to 3 Gb physical and the first thing to do is to reallocate devices
which use it since most firmware use it too liberally, like one device
every ... 256Mb). There are other and better ways to increase user
available virtual space, however. And anyway I don't want any stinking add
in each in/out macro.


> Unfortunately, there's no simple way to allow two busses to have the
> legacy IOs. That means on UniN machines that they'll be available either
> on the AGP bus, or the external PCI bus, but not both.

Indeed, this is too awkward (is tere no way to redirect only the VGA
part of the legacy I/O space ? That's what the PCI-PCI bridges do, but
I've not yet used a single machine with AGP so I'm ignorant).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
