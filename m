Date: Sun, 8 Aug 1999 23:26:21 -0400
From: Daniel Jacobowitz <drow@false.org>
To: mlan@cpu.lu
Cc: hedrick@Astro.Dyer.Vanderbilt.Edu, mj@ucw.cz, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
Message-ID: <19990808232621.B352@them.org>
References: <Pine.LNX.3.96.990728021015.14664A-100000@Astro.Dyer.Vanderbilt.Edu> <199908081954.VAA02923@piglet.cpu.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199908081954.VAA02923@piglet.cpu.lu>; from Michel Lanners on Sun, Aug 08, 1999 at 09:54:12PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Aug 08, 1999 at 09:54:12PM +0200, Michel Lanners wrote:
> Problems start with the changed definition of a few ide functions, now
> using hw_regs_t, in asm-ppc/ide.h. As a result,
> arch/ppc/kernel/pmac_setup.c and chrp_pci.c need to include linux/ide.h
> instead of asm/ide.h. In addition, pmac_setup.c
> defines an empty ide_init_default_hwifs(), but it was previously
> defined in asm-ppc/ide.h. Patch (linux-asm-ide.patch) below.

Check.

> Then, I had the problem of enabling the PCI IO space of the card; I
> have tried a more generic patch which I'll send in a different mail
> with other PCI-related stuff (IRQ related).

Great.  I hacked around this in Promise.

> What annoyed me the most, was getting access to the I/O-ports of the
> Promise going. Turns out that the PCI config registers contain the IO
> address as seen from the bus, which is not the same as seen from the
> CPU. In fact, they start at 0x0 on the PCI bus, but the host bridge
> maps that area to 0xf2000000 on the processor bus. 
> 
> This fact was already catered for with the definition of outb/inb and
> friends, which get an offset added to the port. Unfortunately, the
> PowerMac IDE code undoes this and replaces it with a different
> mechanism, which in essence removes the offset. Grrr..
> 
> I've solved the problem by adding the right offset directly to the
> io-port values as found in the kernel's PCI structures. I think this
> needs more serious rework, though. Paul, are you the author of the
> PowerMac IDE stuff? So we can work this out... 

This didn't, oddly, stop my card from working.  It does, however, make
me lock up hard if I hdparm -i /dev/hda.

Oh, if you didn't pick this up, you can make it ide0/1 instead of
ide2/3 by enable CONFIG_BLK_DEV_OFFBOARD.

> >> > /dev/hdc:
> >> >   Timing buffered disk reads:  32 MB in  5.83 seconds = 5.49 MB/sec
> ;-)) How about this:
> 
> /dev/hde:
>  Timing buffered disk reads:  64 MB in  6.60 seconds = 9.70 MB/sec
> Maxtor 91024D4; 10G 7200 RPM, UDMA-2 ie 33 MB/s.

Eek.  I want that :)


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
