Message-Id: <200212230835.JAA13251@hzsms01.nl.lucent.com>
Date: Mon, 23 Dec 2002 09:35:55 +0100 (MET)
From: Jaap-Jan Boor <jjboor@lucent.com>
Reply-To: Jaap-Jan Boor <jjboor@lucent.com>
Subject: Re: Serious Problem: After Uncompresseing Linux..., what's next
To: pkanthi@yahoo.com
Cc: linuxppc-embedded@lists.linuxppc.org, gary@chez-thomas.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Hi Folks,
>
> I think finally i have idea as to why boot process was
> failing. After uncompressing linux image, the code
> execution was aborting with an ESR value of
> 0x08000000, which stands for "ILLEGAL INSTRUCTION".
> When i checked the instruction causing this, i figured
> that, 'tlbia' (0x00002384) is the culprit. tlbia is a
> valid instruction in PPC405 instruction set.
>
> I still don;t understand, how come it is getting
> rejected. Am i missing anything? Can anyone please
> throw some light on this?

I don't know anything about your cpu (405) but make
sure you understand any prerequisites for the tlbia
instruction or what it's function is (may be your
instruction cache is totally invalid after this
instruction or your immu settings are not correct)

Jaap-Jan

>
> thanks,
> Prakash
>
>
>
>
> --- Prakash kanthi <pkanthi@yahoo.com> wrote:
> >
> > Gary,
> >
> > I really appreciate your help. Here is what i am
> > doing. Sorry it is little long. But was necessasry.
> >
> > 1. I have a boot loader(xrom.elf) of size around
> > 400KB
> > which basically have menu driven tests along with an
> > option to jump to linux kernel(zImage.initrd.elf).
> >
> > 2. xrom.elf is compiled to start at 0xfffffffc and
> > jump to 0x00000000 to have rest of functionality.
> > zImage.initrd.elf is compiled to start at
> > 0x00400000.
> >
> > 3. I load zImage.initrd.elf first and then xrom.elf
> > (xilinx tool makes sure that they are loaded to
> > corresponding locations based on ELF header).
> >
> > 4. After loading both, i start running xrom.elf and
> > it
> > shows up a menu in my UART terminal. I jump to linux
> > (0x00400000).
> >
> > 5. I see that linux is basically reading the board
> > info, setting UART, prints some boot messages onto
> > it
> > and then performs uncompression (gunzip function
> > takes
> > the rest of linux image and puts the uncompressed
> > code
> > starting from 0x0).
> >
> > 6. Up untill, everything is ok. After this, control
> > jumps to 0x0 and starts executing.
> >
> > My problems are,
> >
> > a. Once the uncompression process is done, i am not
> > sure if the image is copied to 0x0 (i do see value
> > changes in memory starting from 0x0).
> > b. As uncompression process is embedded into
> > zImage.initrd.elf, i do not objdump does not tell me
> > which function it is going to execute after
> > uncompression.
> >
> > Please suggest.
> >
> > Thanks,
> > Prakash
> >
> >
> >
> >
> >
> > --- Gary Thomas <gary@chez-thomas.org> wrote:
> > > On Fri, 2002-12-20 at 09:48, Prakash kanthi wrote:
> > > > I do have xilinx tools and i am working with
> > their
> > > V2P
> > > > product. I completely understands what you are
> > > said.
> > > > But the problem is, right after the
> > uncompression
> > > and
> > > > cpy to 0x00000000, i loose total control because
> > i
> > > > don't have any clue what is getting executed.
> > > >
> > >
> > > What sort of things can you do with the Xilinx
> > > tools?  Is
> > > there any way to set [hardware] breakpoints or
> > > single step?
> > >
> > > > And also, i have my boot monitor code at
> > > 0x00000000,
> > > > before uncompress process overwrites it. I see
> > > that
> > > > some of that code is getting executed after jump
> > > to
> > > > 0x0. I reason i am overwriting 0x0 is because, i
> > > only
> > > > have 8MB RAM.
> > > >
> > >
> > > 8M should be plenty of RAM.
> > >
> > >
> >
> >
> >
>
>
>

---
J.G.J. Boor
Lucent Technologies Nederland b.v.	Room:  BE-525
Optical Networking Group TMS Data 	Phone: +31 (0)35 687 4721
Larenseweg 50, P.O. Box 1168, 		Fax:   +31 (0)35 687 5976
1200 BD, Hilversum, The Netherlands	mailto:jjboor@lucent.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
