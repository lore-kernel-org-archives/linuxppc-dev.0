Message-Id: <4.3.2.20000928071955.00b93d90@falcon.si.com>
Date: Thu, 28 Sep 2000 07:36:04 -0400
To: Ruedi.Hofer@ascom.ch, linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Re: VxWorks bootloader & PowerQUICC II, Booting the kernel
Cc: kernel@linux01.hasler.ascom.ch
In-Reply-To: <0G1L0010X4GL0O@pmdf-it.hasler.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi:

Want to try an experiment that I have been intending to try but haven't
gotten around to?  The following is a message detailing my theory that
objcopy can fix up the .image section so that the vxWorks loader _will_
load it.  In fact, it may already load it... but at location 0x00000000
instead of at the proper location due to the fact that the elf headers
say to load it there!

Note the LMA and VMA are both zero on .image and .initrd.  That needs
to be fixed up.  I believe you will find a symbols "end" and/or "_end"
which will be the location you want to change the LMA & VMA to.  This
can be extracted from your load file with grep and awk (or your tool of
choice).  The "LOAD" flag most likely needs to be set too (might as
well set "READONLY" and "DATA" too, while you are in there).  If this
were done, I suspect the sections would be loaded OK.  In the past,
I've set the "LOAD" flag and changed the section name to ".text" with
no apparent effect, not realizing that the LMA was zero.

Both of these changes can be easily made with objcopy.

Example objdump of the headers:

> > This is the section map through the command 'objdump -h
>zvmlinux.initrd'
> >
> > --------------------
> > zvmlinux.initrd:     file format elf32-big
> >
> > Sections:
> > Idx Name          Size      VMA       LMA       File off  Algn
> >   0 .text         000046e4  00400000  00400000  00010000  2**2
> >                   CONTENTS, ALLOC, LOAD, READONLY, CODE
> >   1 .rodata       000004a0  004046f0  004046f0  000146f0  2**4
> >                   CONTENTS, ALLOC, LOAD, READONLY, DATA
> >   2 .data         0000030c  00405000  00405000  00015000  2**2
> >                   CONTENTS, ALLOC, LOAD, DATA
> >   3 .bss          000051f0  00406000  00406000  00016000  2**2
> >                   ALLOC
> >   4 .image        00064605  00000000  00000000  00016000  2**0
> >                   CONTENTS, READONLY
> >   5 .initrd       00201d19  00000000  00000000  0007a605  2**0
> >                   CONTENTS, READONLY

---- from an old mail message ----

Frank has a very good tip.  I did an objdump on our zImage and the
makefile hack doesn't _rename_ the .gzimage section, it fills in the
load address!  We should be able to do this directly with objcopy.

 From the objcopy man page:
        --change-section-address=section{=,+,-}val,
        --adjust-section-vma=section{=,+,-}val
               Set or changes the VMA and LMA addresses of the
               named section.  If = is used, the section address
               is set to val.  Otherwise, val is added to or
               subtracted from the section address.  See the
               comments under --change-addresses, above.  If
               section does not exist in the input file, a warning
               will be issued, unless --no-change-warnings is
               used.

        --change-section-lma=section{=,+,-}val
               Set or change the LMA address of the named section.
               If = is used, the section address is set to val.
               Otherwise, val is added to or subtracted from the
               section address.  See the comments under
               --change-addresses, above.  If section does not
               exist in the input file, a warning will be issued,
               unless --no-change-warnings is used.

        --change-section-vma=section{=,+,-}val
               Set or change the VMA address of the named section.
               If = is used, the section address is set to val.
               Otherwise, val is added to or subtracted from the
               section address.  See the comments under
               --change-addresses, above.  If section does not
               exist in the input file, a warning will be issued,
               unless --no-change-warnings is used.


The next question is what to change the address to.  Hopefully there is
a symbol in it, making it relocatable.  Otherwise, there should be a
symbol in the symbol table pointing to it which we could use objdump to
extract.

In my example, there are some symbols.  Since my example has been
modified by the makefile already, I don't know which symbols are used
and which are created by the makefile hack.  It should be easy to find
out, however.

[vanbaren@gr-356872 vanbaren]$ objdump -x zImage |grep 0040b278
     LOAD off    0x0001b278 vaddr 0x0040b278 paddr 0x0040b278 align 2**16
   5 .gzimage      00072677  0040b278  0040b278 0001b278  2**0
0040b278 l    d  .gzimage       00000000
0040b278 g     O *ABS*  00000000 end
0040b278 g     O *ABS*  00000000 _end
0040b278 g     O *ABS*  00000000 _gzstart


[vanbaren@gr-356872 vanbaren]$ objdump -a zImage

zImage:     file format elf32-big
zImage

[vanbaren@gr-356872 vanbaren]$ objdump -x zImage |less

zImage:     file format elf32-big
zImage
architecture: UNKNOWN!, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x00400000

Program Header:
     LOAD off    0x00010000 vaddr 0x00400000 paddr 0x00400000 align 2**16
          filesz 0x00005330 memsz 0x0000b278 flags rwx
     LOAD off    0x0001b278 vaddr 0x0040b278 paddr 0x0040b278 align 2**16
          filesz 0x00072677 memsz 0x00072677 flags r--

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
   0 .text         00004ac0  00400000  00400000 00010000  2**2
                   CONTENTS, ALLOC, LOAD, READONLY, CODE
   1 .rodata       000004d8  00404ac0  00404ac0 00014ac0  2**4
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
   2 .data         00000330  00405000  00405000 00015000  2**2
                   CONTENTS, ALLOC, LOAD, DATA
   3 .data.init    00000000  00406000  00406000 0008d8ef  2**0
                   CONTENTS
   4 .bss          00005278  00406000  00406000 00016000  2**2
                   ALLOC
   5 .gzimage      00072677  0040b278  0040b278 0001b278  2**0
                   CONTENTS, ALLOC, LOAD, READONLY, DATA


At 03:42 PM 6/27/00 +0200, Frank Przybylski wrote:

>Hi,
>
>Jerry Van Baren wrote:
> >
> > Jon Diekema and I tried Wolfgang's "load" flag hint with the EST JTAG
> > debugger and were unsuccessful.  We were unable to use objcopy to make
> > the extra sections loadable.  We are guessing that you have to set the
> > loadable flag, but you also have to label the section ".text" for the
> > tools that are giving problems (EST in our case).  Jon produced a patch
> > (based on work by Arto Vuori) which goes into the makefile and makes
> > valid loadable sections out of the gzimage (compressed kernel) and the
> > rdimage (initial ramdisk) sections.
> >
>
>I'd guess it's more important to adjust the VMA than the section's
>name to tell
>the loader where to put the sections content.
>
>If you examine the section's listing you'll notice address zero for
>.image and
>.initrd, so only setting the load flag won't do the job.
>
>I only prepare the kernel image (right now, I don't use .initrd) for
>loading
>with the following objcopy call:
>
>'powerpc-linux-objcopy \
>  --set-section-flags=image=contents,alloc,load,readonly,data \
>  --adjust-section-vma=image=$(powerpc-linux-objdump -h
> $kernel/zvmlinux | \
>  grep .bss | awk '{print "0x"$4}') \
>  $kernel/zvmlinux \
>  $kernel/zvmlinux2'
>
>To be on the secure side one should correct the vma's of .image to fit
>behind
>.bss and of .initrd behind .image.
>
>I thought someone patched the makefile to do this? (I guess, I'm not
>working on
>the actual sources, but I don't like the idea behind bitkeeper very much
>either...)
>
>hth
>         Frank
>
>--
>===============================================================================
>Frank Przybylski,VAS GmbH,Gotenstr.6,20097
>Hamburg,GERMANY,TEL:+49-40-238568-14
>    mailto:Frank.Przybylski@vas-gmbh.de , visit us at
> http://www.vas-gmbh.de
>===============================================================================
>


gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
