Message-Id: <4.3.2.20000626080626.00b482e0@falcon.si.com>
Date: Mon, 26 Jun 2000 08:48:36 -0400
To: "Kwansuk Kim" <kskim@neowave.co.kr>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: omitted kernel sections 
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <200006260808.KAA23698@denx.local.net>
References: <Your message of "Mon, 26 Jun 2000 15:43:35 +0900." <NEBBKFENMLEDKDHMEHPJKEMECAAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jon Diekema and I tried Wolfgang's "load" flag hint with the EST JTAG
debugger and were unsuccessful.  We were unable to use objcopy to make
the extra sections loadable.  We are guessing that you have to set the
loadable flag, but you also have to label the section ".text" for the
tools that are giving problems (EST in our case).  Jon produced a patch
(based on work by Arto Vuori) which goes into the makefile and makes
valid loadable sections out of the gzimage (compressed kernel) and the
rdimage (initial ramdisk) sections.

Dan Malek has rejected the patch in the BitKeeper tree, although Jon
and I disagree with him.  I didn't find Dan's reply in the archives, it
apparently was a direct reply.  His arguments, as I recall (and my
apologies, Dan, if I get them wrong), are:

* It makes the image larger.
 > Not really, its just some more elf headers that get stripped on loading.

* It isn't how everybody uses the load: everybody just strips the elf
header (pastes on a proprietary(?) header) and uses it as as a raw
binary image
 > I disagree, we ran into the problem, developers before us ran into
the problem, and it is coming up again.

* It requires an extra relink step.
 > Not a big deal in my book given the benefits: a valid elf file that
is loadable by commonly used tools.

Dan said in a later message that he had put together a C program that
rewrote the elf headers to make the file a loadable elf file, but I
have not investigated his program.

I'm having problems finding the messages in the archives using the
search (it apparently is only searching June -- the indexing only
covers the latest month?).  For details, see the summary of the May
messages, which includes Jon's proposed patch:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/linuxppc-embedded.200005

Search for the following header:
 From owner-linuxppc-embedded@lists.linuxppc.org  Tue May  9 12:52:58 2000
Message-Id: <m12pEA0-001SyZC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: Getting the image section of the ELF file to load w/
VxWorks boot ROM
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 9 May 2000 13:51:08 -0400 (EDT)
In-Reply-To: <391834D3.9E57B710@Zentropix.com> from "Daniel G.
Clemmensen" at May 09, 2000 11:54:59 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The approach that I settled upon was identified in my initial post,
however I didn't actually do all the steps.  I have attached the the
files that are needed to make it work.

Note: The Linux_2_3 BitKeeper repository at FMS Labs contains
       these changes.


At 10:08 AM 6/26/00 +0200, Wolfgang Denk wrote:

>In message <NEBBKFENMLEDKDHMEHPJKEMECAAA.kskim@neowave.co.kr> Kwansuk
>Kim wrote:
> >
> > when I was following the procedure : initialize console on SMC2,
> memory allocation for kernel and ramdisk...
> > there was a problem. The compressed kernel image wasn't loaded. So
> the procedure stopped on gunzip process.
>
>Which version of Linux are you using?
>
> > I use AMC BDM port, and I speculate the messages.
> >
> > It's the message when kernel is loaded.
> >
> > ---------------------------------------
> > > LOAD 'c:\860source\zvmlinux.initrd'
> >   Warning: symbols deleted - check use in macros etc.
> >  Loading section '.text' located at 0x00400000..0x004046E4
> >  Loading section '.rodata' located at 0x004046F0..0x00404B90
> >  Loading section '.data' located at 0x00405000..0x0040530C
> >  Loading section '.bss' located at 0x00406000..0x0040B1F0
> >   Warning:
> >   'main' function not found in file: c:\860source\zvmlinux.initrd
> >   Note: in startup routine. Enter STEP to go to High-level module.
>
>It seems your debugger loads only the boot loader code,  but  neither
>the kernel nor the initrd.
>
> > This is the section map through the command 'objdump -h
> zvmlinux.initrd'
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
> >
> > Why weren't .image, .initrd section loaded? Because they aren't elf
> format file?
>
>Most probably because your debugger loads  only  such  sections  that
>have the "LOAD" flag set.
>
> > What can I do? I haven't any idea.
>
>There are several solutions; for instance, use objcopy to set the
>"LOAD" flag on the '.image' and '.initrd' sections, too.
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>If programming was easy, they wouldn't need something as  complicated
>as a human being to do it, now would they?
>                        - L. Wall & R. L. Schwartz, _Programming Perl_
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
