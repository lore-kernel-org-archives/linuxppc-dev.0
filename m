Message-ID: <390FDE5F.EFEF7015@ssh.com>
Date: Wed, 03 May 2000 11:07:59 +0300
From: Arto Vuori <avuori@ssh.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: linuxppc-embedded@lists.linuxppc.org, bkuschak@yaoo.com,
        jim.chapman@iname.com, frank@mitre.org
Subject: Re: Getting the image section of the ELF file to load w/ VxWorks boot
 ROM
References: <m12mgPF-001SyZC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:
>
>         I am having trouble loading the image section of the elf file
>         (contains the gzip compressed Linux kernel) with the VxWorks boot
>         ROM or the EST VisionICE on the EST SBC8260 board.  Both of these
>         options appear to ignore this section.
>

I had similar problems. It seems that EST tools don't convert all ELF
sections in zImage. I managed to get around the problem by building
bootimage by using different method than in arch/ppc/coffboot or
mbxboot. Instead using objcopy to add new sections, i use
arch/ppc/chrpboot/piggypack.c to generate object files from images and
after that link them with rest of objects. Here's couple lines from my
Makefile that does the actual job:

image.o: piggyback ../coffboot/vmlinux.gz
        ./piggyback image < ../coffboot/vmlinux.gz | $(AS) -o image.o

zImage: $(OBJS) no_initrd.o mknote
        $(LD) $(LD_ARGS) -o $@ $(OBJS) no_initrd.o $(LIBS)
        ./mknote > note
        $(OBJCOPY) $@ $@ --add-section=.note=note -R .comment

You also need to modify some .c files so that they can find the image
address and size.

--
Arto Vuori
email: avuori@ssh.com
mobile:	+358 40 754 5223

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
