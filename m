Message-Id: <200006280733.JAA27847@denx.local.net>
To: Steven Hanley <sjh@wibble.net>
cc: Rolf Liu <rolfl@sc23.sc.mcel.mot.com>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: problem with compressing the kernel 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 28 Jun 2000 16:19:12 +1000."
             <395998E0.65DD0D9B@wibble.net>
Date: Wed, 28 Jun 2000 09:33:47 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <395998E0.65DD0D9B@wibble.net> Steven Hanley wrote:
>
> you seem to be confused anyway, yes the kernel is compressed for x86
> machiens (it is however not compressed for other architectures, my ppc
> box uses a normal uncompresased vmlinux image.

Well, on the  (embedded)  PowerPC  systems  we  are  running  we  use
compressed  kernel  images  - saving lots of space in expensive FLASH
memory is reason enough.

> wheras a kernel image (for ppc) will look like
>
> [17:18:53] 1 innuendo sjh ~>file /mac/System\ Folder/Linux\
> Kernels/vmlinux-2.2.15pre14
> /mac/System Folder/Linux Kernels/vmlinux-2.2.15pre14: ELF 32-bit MSB
> executable, PowerPC or cisco 4500, version 1, statically linked, not
> stripped

This is what you see. Bat some things look different from  what  they
really are.

I see this:

->  file linux-2.2.13/arch/ppc/mbxboot/zvmlinux
linux-2.2.13/arch/ppc/mbxboot/zvmlinux: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1, statically linked, not stripped

Nevertheless, this  file  _contains_  a  compressed  (gzipped)  Linux
kernel image as a special section "image":

-> powerpc-linux-objdump -h linux-2.2.13/arch/ppc/mbxboot/zvmlinux

linux-2.2.13/arch/ppc/mbxboot/zvmlinux:     file format elf32-powerpc

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00004a90  00100000  00100000  00010000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .rodata       000006a0  00104a90  00104a90  00014a90  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .data         0000031c  00106000  00106000  00016000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  3 .bss          000031fc  00107000  00107000  00017000  2**2
                  ALLOC
  4 image         0005d3f8  00000000  00000000  00017000  2**0
                  CONTENTS, READONLY



> which is a plain all ordinary elf binary pretty much
>
> the compressed kernels found on x86 boxes will look like

There are more things in heaven and earth, Steven, / Than are dreamt
of in your philosophy. :-)

> it may seem you can just gzip an uncompressed vmlinux and get a vmlinuz
> that will boot, except if you notice the devel image just there is not a
> gzip file. There is some executable code added on the front of the image
> so the x86 box will run it on boot up, some of this code uncompresses
> the image.

Same on (embedded) PowerPC

> Now of course I wonder why you would need the ability as after all a
> linux box is all you need to compile and make the image, or heck a

There are systems which are too slow and/or too limited to compile  a
kernel (especially embedded systems).

> And of course remember you dont need otr use compressed images on ppc
> machines.

You do, in some cases.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Do not follow where the path may lead....go instead where there is no
path and leave a trail.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
