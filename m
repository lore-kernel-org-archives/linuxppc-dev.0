Date: Thu, 12 Oct 2000 19:57:08 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <19340906102959.14429@192.168.1.2>
Message-ID: <Pine.HPX.4.10.10010121921420.16113-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Oct 2000, Benjamin Herrenschmidt wrote:

> Note to linux-kenrel readers: This discussion is the Nth attempt to find
> a solution to handle both legacy IOs and PCI IOs on machines with several
> IO busses memory mapped at different locations in the CPU space.

Yes, I know, but I still suspect that it is a more acceptable solution.
How many ISA drivers are there in real use ?

By decreasing order of importance (others might disagree):

- 8259 (yuck) and RTC/CMOS (always handled by architecture specific code
  AFAICT so it can be done in the way we want)
- serial
- DMA (used by floppy, perhaps parallel)
- floppy
- parallel
- sound ? (I don't know anything about sound, none of my machines have
  sound, I hate sound in computers and all the multimierda stuff, but most
  people don't agree with me so I put it here)
- old legacy devices like modems, SCSI (I have an ISA-SCSI at home)

I don't know where to put RTC/CMOS on this scale, but it should be close
to the top.

> >No please, is there anybody bloat-conscious on this damned list ? Burying
> >more and more code inside each {in,out}[bwl] is not the solution.
>
> Well, that is pretty small overhead, and probably ridiculous compared to
> the overhead of the IO itself. Most fast devices use MMIO anyway.

The problem is not the speed, it is the bloat. And increasing icache
footprint may have impressive side effects. Given the average time
between I/O the code will no more be in the cache when it is executed
again, so it will be fetched from memory. Minimizing icache footprint
is being nice to applications by not thrashing their cache (especially
true for interrupt code). See the mail from David too. OTOH, the first
thing to do is to revert the eieio->sync patch, first it is wrong, second
it will be a killer on SMP machines with 4 or more processors.

> The problem is that whatever solution someone propose, there is _always_
> somebody to reject it.

Let us wait and see. This solution can be adapted little by little. As
soon as you have the major devices working the other drivers can be
upgraded gradually.

> >Just define a macro ISA_PORT or something like this and update the kernel
> >to replace all the in/out to fixed ports to do in/out(ISA_PORT(n)). If you
> >don't do it you'll get a nice panic so you'll find all the places quite
> >fast.
>
> That basically mean making different macros for ISA in/out and PCI in/
> out. I've proposed this several time, but it requires changes to the
> common code, and all I got when talking about this was flames from x86 people.

No it is not the same, it means that we acknowledge that ISA and PCI are
too entangled on x86 to use different functions.

> >PCI I/O resources will have to be kernel virtual, physical is impossible
> >with PreP if we want to lift the 2Gbuser space restriction (PreP I/O is
> >from 2 to 3 Gb physical and the first thing to do is to reallocate devices
> >which use it since most firmware use it too liberally, like one device
> >every ... 256Mb). There are other and better ways to increase user
> >available virtual space, however. And anyway I don't want any stinking add
> >in each in/out macro.
>
> Well, in 2.4 we can easily reassign PCI IOs if we configure the bridge
> with proper resources. If all goes well, my new PCI code should handle
> that fine (should be ready this week-end).
>
> >Indeed, this is too awkward (is tere no way to redirect only the VGA
> >part of the legacy I/O space ? That's what the PCI-PCI bridges do, but
> >I've not yet used a single machine with AGP so I'm ignorant).
>
> No, most bridges used on macs can't do that. In fact, AFAIK, it's not
> possible to access the ISA memory space neither on those machines (on
> UniN, I can't generate memory cycles at lower address than 0x80000000).

Ok, than it's impossible to put a good old VGA and initialize it
with the help of an emulator. It also means that UniN is not CHRP
compliant but we all suspected that.

> My "pet" solution would be to have all legacy drivers request an IO base
> this way
>
>   base = isa_get_IO_base(legacy_addr);
>
> The isa_get_IO_base function could then be "tweaked" to recognize known
> legacy addresses and return different bases. (There might still be
> problems with VGA vs. parallell, I don't know x86 world well enough to be
> sure).

I hate this, if VGA is basically the only problem, instead of using the
ISA_PORT in the drivers, use another macro, something like VGA_PORT(n).
This is reasonable if the problem is VGA versus the rest, you know what
you want to access in the driver, and which kind of device you have.
Other legacy drivers do not have to bother with it, they'll never have to
go to AGP.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
