Message-ID: <38C5643C.D9C2A4BD@amberdata.demon.co.uk>
Date: Tue, 07 Mar 2000 20:19:08 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IBM 850 - Open Firmware or not? and more on the ide byteswapgame...
References: <Pine.HPX.4.10.10003071102520.22162-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
>
> On Mon, 6 Mar 2000, David Monro wrote:
>
> >
> > Did the IBM 850 implement Open Firmware as described in the PReP spec?
> > I'm guessing not, which is a pity. Can anybody enlighten me for certain?
> >
> > btw I've figured out why the 850 needs byteswapping of the IDE hard
> > drives to work properly - I just realized that NT/ppc ran little endian,
> > and the firmware understands little-endian FDISK style partition tables.
> > Since we understand them too, but we are running big-endian, we end up
> > in a mess. Why are we running big-endian btw?
>
> Hmm, I'm starting to wonder, are you sure that the system is completely
> reset to big endian mode ?  If the ARC firmware is designed to run NT, it
> might set all the bits to little endian mode (that's not only the
> processor but also the bridge and maybe more bits here and there).
>

Oh, I think it is properly set up etc; I just finally had a realization
that since NT was running little-endian, it didn't have the overhead of
swapping the disk in order to run the same way round as the partition
table indicated it was running.

> Or is it that we should make the firmware believe that Linux/PPC is little
> endian and then switch to big endian the whole system ourselves. My
> interpretation is that the firmware might attempt to run both big and
> little endian OS but that the disk access and especially partition table
> interpretation routines only work correctly when the processor is in
> little endian mode. IOW the firmware is hopelessly buggy.

It isn't really that bad - basically they picked one format for the
parition table (which happened to be the NT one). Other OSs can do what
they like as long as the firmware sees a valid little-endian FDISK
partition table with a PReP boot partition in it (and then the OS has to
make sure it doesn't stomp on the boot partition). This afternoon I had
a look at an AIX disk and discovered it was partitioned with a 3M PReP
partition starting 2M from the front of the disk and nothing else. So
I'd imagine that AIX probably stores something in the first 2M, and then
uses everything execpt the first 5M of the disk under its own scheme.

> BTW: big endian is the right way for PPC, you don't want to run a PPC
> in niadne-elttil mode under any circumstance.

Unless you are Micro$oft :-) For that matter, Workplace OS (ie OS/2 for
ppc) ran little-endian. I would guess in both cases the compaines
decided that the endian cleanup of the source wasn't worth the hassle.
Actually, why does it matter which way up you run the CPU?

According to the PREP spec Solaris/PPC was also little-endian!
Presumably they decided PReP machines looked more like PCs than sparcs.
In which case the only OS that the PReP spec mentions which runs
big-endian is AIX. (What was Taligent - something from Apple maybe? The
name in mentioned in the spec, but all the slots in the tables under
that heading are blank, and so is the appendix for it :-))

[..]
> At a time due to these problems, I had code in the kernel which could grok
> a partition table in any endianness but the rest of the disk was in normal
> order (even the extended partition tables).

Have you still got this code anywhere? This is exactly what we need; to
grok the primary partition table little-endian but everything else
native. Then we just need to write an fdisk to work with it :-)

Cheers,

	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
