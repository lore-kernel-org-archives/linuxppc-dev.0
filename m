From: Benjamin Herrenschmidt <bh40@calva.net>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Linux/PowerPC Devel List
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
Date: Thu, 12 Oct 2000 17:13:52 +0200
Message-Id: <19340906084536.29942@192.168.1.2>
In-Reply-To: <Pine.LNX.4.21.0010121542340.18328-100000@idd-01.imbc.gr>
References: <Pine.LNX.4.21.0010121542340.18328-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Since the card is a x86 one int10 is needed to initialize it, don't expect
>the int10 code to work under linux/ppc though, it needs ISA IO and memory
>access which don't work.
>I have code to fix PIO for machines with only one iobase, but it
>doesn't work with Uni-N machines (i have no idea how to handle code like
>inb(0x3C3) in this machines and until someone figures out how to handle it
>don't expect int10 to work....)

I'm updating the PCI code in linuxppc_2_5 tree (which is more or less
meant to be merged in _2_3 soon). I'm adding a couple of cases to the
sys_pciconfig_iobase syscall to return the ISA mem and IO bases (if they
exist).

On the kernel side, one of the PCI IO busses will be mapped to ISA. What
I'll do is basically to change the kernel inb/outb functions to do
something like

if (addr < 64k)
  do_io(isa_io_base + addr)
else
  do_io(addr)

This way, PCI IOs will be able to use real physical addresses that will
have been put by the fixup code in the IO resources, while legacy IOs
will tap the IO bus that we have decided is the "legacy" bus.

It's a bit ugly, but AFAIK, we don't have any arch where IOs are memory
mapped below 64K physical. I would have prefered Paul's mecanism for
appending the IO spaces, but...

Unfortunately, there's no simple way to allow two busses to have the
legacy IOs. That means on UniN machines that they'll be available either
on the AGP bus, or the external PCI bus, but not both.
What you might do is to consider the ISA io base to be the IO base of the
bus that holds the card for which you are trying to run the BIOS. (By
using the syscall to retreive this IO base for the VGA card) instead of
asking the kernel for the "legacy" IO base.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
