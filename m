Date: Tue, 7 Mar 2000 11:26:51 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IBM 850 - Open Firmware or not? and more on the ide byteswap
 game...
In-Reply-To: <38C42DE9.45EB8A99@amberdata.demon.co.uk>
Message-ID: <Pine.HPX.4.10.10003071102520.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 6 Mar 2000, David Monro wrote:

>
> Did the IBM 850 implement Open Firmware as described in the PReP spec?
> I'm guessing not, which is a pity. Can anybody enlighten me for certain?
>
> btw I've figured out why the 850 needs byteswapping of the IDE hard
> drives to work properly - I just realized that NT/ppc ran little endian,
> and the firmware understands little-endian FDISK style partition tables.
> Since we understand them too, but we are running big-endian, we end up
> in a mess. Why are we running big-endian btw?

Hmm, I'm starting to wonder, are you sure that the system is completely
reset to big endian mode ?  If the ARC firmware is designed to run NT, it
might set all the bits to little endian mode (that's not only the
processor but also the bridge and maybe more bits here and there).

Or is it that we should make the firmware believe that Linux/PPC is little
endian and then switch to big endian the whole system ourselves. My
interpretation is that the firmware might attempt to run both big and
little endian OS but that the disk access and especially partition table
interpretation routines only work correctly when the processor is in
little endian mode. IOW the firmware is hopelessly buggy.

BTW: big endian is the right way for PPC, you don't want to run a PPC
in niadne-elttil mode under any circumstance.

The solution might be an endian agnostic bootloader (probably hard to
write) which switches everything to big endian and then passes control
to the kernel. Or alternatively a bootloader option to run from ARC,

The best devices to make tests are CDROMs, but I suspect that ARC can't
read from a CD.

Does your system boot from PreP partition (0x41) and provide residual
data ? And does the residual data look correct or is it byteswapped
(wouldn't be too surprising) ?

> This causes my first drive (which is byteswapped so I can boot from it)
> to consume a lot more cpu when doing IO than the second drive (which is
> in native endian format).


>
> I guess that AIX had a hack whereby it created a little-endian FDISK
> partition table with the bootloader in a PReP boot partition and then
> played around without byteswapping with the rest of the disk. I'll have
> to find one running AIX and have a look at the disk with linux and see
> what I see.

At a time due to these problems, I had code in the kernel which could grok
a partition table in any endianness but the rest of the disk was in normal
order (even the extended partition tables).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
