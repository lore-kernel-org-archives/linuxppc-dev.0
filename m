To: Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com>
Cc: VALETTE Eric <valette@crf.canon.fr>, linuxppc-dev@lists.linuxppc.org,
        cort@cs.nmt.edu
Subject: Re: Linux-2.1.129 boot on MCP750
References: <SIMEON.9811231325.A@g-mun-af.muenchen.europe.mcd.mot.com>
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 08 Dec 1998 19:55:48 -0600
In-Reply-To: Alois Fertl's message of Mon, 23 Nov 1998 13:26:25 +0100 (W. Europe Standard Time)
Message-ID: <m2af0ycc4b.fsf@wf-rch.cirr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have posted patches to this group that fix all these problems.
You can search the lists for them.

Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com> writes:
> If you manage to put your zImage onto a prep partition
> of a hard drive or if you boot it from floppy it should
> work fine.
> 
> There is a problem in boot/misc.c which manifests only
> if netboot is used. Current ppcbug netboots at 0x5000 and
> this forces decompress to overwrite its own source.
> 
> You can fool netboot resp. boot/misc.c if you netboot
> zImage.initrd ( make zImage.initrd which requires ramdisk.image.gz
> in arch/ppc/boot; somewhere on the R4 CD ) and type
>    noinitrd
> to the Linux/PPC load: prompt.
> 
> I found some other improvement over the weekend which help using
> linuxppc with serial console only. Due to limited time I was not
> able to propagate them yet. I promise to do so over the next days.
> 
> Regards
>   Alois
> 
> 
> 
> On Fri, 20 Nov 1998 18:25:08 +0100 (CET) VALETTE Eric 
> <valette@crf.canon.fr> wrote:
> 
> > 
> > 
> > I have sucessfully compiled the brand new linux-2.1.129 source tree
> > without any glich. I used the PREP configuration, made the zImage and tried
> > to boot it using motorola ppcbug firmware.
> > 
> > I first discovered that I add to replace all putc, puts routine because
> > I use the serial line (not a big deal). Then I added a more general code
> > than puthex in order to print also decimal and fixed some output in 
> > arch/ppc/boot to get inflate errors.
> > 
> > Here is what I get now : It shows that inflate fails.
> > 
> > -----------------------------------------------------------
> > Local Memory Found =02000000 (&33554432)
> > 
> > MPU Clock Speed =233Mhz
> > 
> > BUS Clock Speed =67Mhz
> > 
> > WARNING: Keyboard Not Connected
> > 
> > Reset Vector Location  : ROM Bank B
> > Mezzanine Configuration: Single-MPU
> > Current 60X-Bus Master : MPU0
> > Idle MPU(s)            : NONE
> > 
> > System Memory: 32MB, ECC Enabled (ECC-Memory Detected)
> > L2Cache:       1024KB, 117Mhz
> > 
> > PPC1-Bug>nbo
> > Network Booting from: DEC21140, Controller 0, Device 0
> > Device Name: /pci@80000000/pci1011,9@e,0:0,0
> > Loading: /zImage
> > 
> > Client IP Address      = 194.2.81.157
> > Server IP Address      = 194.2.81.241
> > Gateway IP Address     = 194.2.81.254
> > Subnet IP Address Mask = 255.255.255.0
> > Boot File Name         = /zImage
> > Argument File Name     = 
> > 
> > Network Boot File load in progress... To abort hit <BREAK>
> > 
> > Bytes Received =&794942, Bytes Loaded =&794942
> > Bytes/Second   =&397471, Elapsed Time =2 Second(s)
> > 
> > Residual-Data Located at: $01F78000
> > loaded at:     5400 19FC0
> > 
> > relocated to:  600000 614BC0
> > 
> > board data at: 1F78000 1F7EA0C
> > 
> > relocated to:  60E0B4 614AC0
> > 
> > zimage at:     E400 C539E
> > 
> > avail ram:     400000 600000
> > 
> > 
> > 
> > Linux/PPC load: 
> > 
> > Uncompressing Linux...descompressing to : 0 400000inflate returned-3  <============
> > exit
> > 
> > ---------------------------------------------------------------------------
> > 
> > Reading the Makefile and trying to figure out how the binary image was 
> > done, I discovered that the compressed image is set in the file at the
> > same offset than the .bss and that there is in head.S a bzero of the
> > bss section As shown by the following header dump.
> > 
> > 
> > ----------------------------------------------------------------------------
> > objdump -h zvmlinux
> > 
> > zvmlinux:     file format elf32-powerpc
> > 
> > Sections:
> > Idx Name          Size      VMA       LMA       File off  Algn
> >   0 .text         00005950  00600000  00600000  00010000  2**2
> >                   CONTENTS, ALLOC, LOAD, READONLY, CODE
> >   1 .rodata       00001560  00605950  00605950  00015950  2**4
> >                   CONTENTS, ALLOC, LOAD, READONLY, DATA
> >   2 .data         00001b2c  00607000  00607000  00017000  2**2
> >                   CONTENTS, ALLOC, LOAD, DATA
> >   3 .bss          0000bbc0  00609000  00609000  00019000  2**2
> >                   ALLOC
> >   4 image         000b6f9f  00000000  00000000  00019000  2**0
> >                   CONTENTS, READONLY
> > ---------------------------------------------------------------------------
> > 
> > So I propose the following : 
> > 
> > Make mkprep know a little bit more about ELF and make a different binary image
> > with bss already zeroed and image moved from bss size. Do you know if libelf
> > package works on Linux PPC as It does on Linux Intel?
> > 
> > 1) Is the analysis correct?
> > 2) Do you want the small modif for printing decimal and the code that
> > prints correctly errors in gunzip routine?
> > 
> > 
> > 
> > 
> > -- 
> >    __                 
> >   /  `                   	Eric Valette
> >  /--   __  o _.          	Canon CRF
> > (___, / (_(_(__         	Rue de la touche lambert
> > 				35517 Cesson-Sevigne  Cedex
> > 				FRANCE
> > Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
> > E-mail: valette@crf.canon.fr
> 
> 
> 
> 

-- 
Corey Minyard               Internet:  minyard@acm.org
  Work: minyard@nortel.ca       UUCP:  minyard@wf-rch.cirr.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
