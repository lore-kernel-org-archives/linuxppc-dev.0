Date: Thu, 3 Aug 2000 14:31:42 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Keith Owens <kaos@ocs.com.au>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Where does ppc define __start___ksymtab? 
In-Reply-To: <31728.965305116@ocs3.ocs-net>
Message-ID: <Pine.HPX.4.10.10008031422570.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000, Keith Owens wrote:

> On Thu, 3 Aug 2000 14:01:44 +0200 (METDST),
> Gabriel Paubert <paubert@iram.es> wrote:
> >On Thu, 3 Aug 2000, Keith Owens wrote:
> >> If we want anything in the kernel then we put it there, and say where
> >> we want it.  Anything not explicitly listed is discarded.  I just did
> >> this with ix86 and vmlinux shrank by 9K, mainly in .bss.  It would not
> >> boot afterwards so obviously some part of that 9K is required but right
> >> now it works by some "magic" storing the unknown sections.  I'm going
> >> to track down which sections are not being explicitly placed.
> >
> >I have trouble parsing this, since the bss by definition does not occupy
> >any space in vmlinux.
>
> It is wierd.

Indeed, Try to generate a linker map, it should help you tracking these
phantoms. In my Makefile for the prepboot bootloader (not yet
in the official kernel, not even bk tree), I have the following:


zImage: $(OBJECTS) $(IMAGES) ppcboot.lds
        $(OBJCOPY) $(TOPDIR)/vmlinux vmlinux -R .comment -S -K _start -K _end
        $(LD) -o zImage $(OBJECTS) --just-symbols=vmlinux \
        -b binary $(IMAGES) -T ppcboot.lds -Map zImage.map
					   ^^^^^^^^^^^^^^^
        rm vmlinux

and the .bss in zImage.map for my zImage looks like:

.bss            0x000b8320     0x1134
 *(.sbss)
 .sbss          0x000b8320       0x10 zlib.o
 *(.bss)
 .bss           0x000b8330     0x1090 zlib.o
                0x000b93c0                .=ALIGN(0x4)
 COMMON         0x000b93c0       0x94 em86.o
                                  0x0 (size before relaxing)
                0x000b93c0                v86_private
                0x0000044d                __bss_words=(SIZEOF(.bss)>>=0x2)
                0x000b8000

These might be the COMMON sections then.

	Gabriel.

P.S: I just received you other mail while finishing this, so my guess was
right. But generating a map is still a useful trick when you are lost in a
linker script (been there, done that).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
