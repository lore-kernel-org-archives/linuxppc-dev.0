Date: Wed, 14 Apr 1999 11:00:13 +0200
From: massin@col.bsf.alcatel.fr (Raphael Massin)
Message-Id: <199904140900.LAA14141@csp230.clb>
To: r44089@email.sps.mot.com
Subject: Re: Help about Kernel Image
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 
> Hello, everyone
>   I'm building a kernel for Motorola's FADS860 board.
> My code base is embedded-2_2p7.tar.gz. When I debug the code,
> I find some problems.
> In arch/ppc/boot/head.S, line 144, author using following code
> to clear the BSS segment:
> =======================================
> /* Clear all of BSS */
> lis r3,edata@h
> ori r3,r3,edata@l
> lis r4,end@h
> ori r4,r4,end@l
> subi r3,r3,4
> subi r4,r4,4
> li r0,0
> 50: stwu r0,4(r3)
> cmp 0,r3,r4
> bne 50b
> =======================================
> But in my binary code of zImage, the kernel image is between "edata" and
> "end"
> following is symbols list:
> ***************************************
> 0010420c A _etext       = 0x104648
> 00105320 A _edata       = 0x105320
> 00106008 B zimage_start = 0x106000
> 0010600c B orig_y
> 00106010 B zimage_size
> 00106014 B cols
> 00106018 B end_avail
> 0010601c B lines
> 00111bc0 A _end         = 0x111bc0
> ***************************************
> So, I have two questions:
> 1. the address of kerenl image is same as some variables, such as
>    orig_y, cols and so on.
> 2. clear the BSS segment, crash the kernel image befrom decompressing it.
> 

Hello,

In arch/ppc/boot/Makefile, objcopy is called to add the vmlinux.gz as a section
'image' in zvmlinux. I also had the problem that the beginning of this section
was cleared because it overlapped with the .bss section for the zimage.

I have modified the lines in the Makefile to
1) remove the .bss section
2) padd the .data section until after the end of the .bss section
3) add the vmlinux.gz as the 'image' section

here is the normal Makefile :

--------------------------------------------------------------------------------
zvmlinux: $(OBJECTS) ../coffboot/vmlinux.gz
#
# build the boot loader image and then compute the offset into it
# for the kernel image
#
	$(LD) $(ZLINKFLAGS) -o zvmlinux.tmp $(OBJECTS)
	$(OBJCOPY) $(OBJCOPY_ARGS) -R .comment --add-section=image=../coffboot/vmlinux.gz \
		zvmlinux.tmp $@
#
# then with the offset rebuild the bootloader so we know where the kernel is
#
	$(CC) $(CFLAGS) -DINITRD_OFFSET=0 -DINITRD_SIZE=0 \
		-DZIMAGE_OFFSET=`sh offset $(OBJDUMP) zvmlinux image` \
		-DZIMAGE_SIZE=`sh size $(OBJDUMP) zvmlinux image` -DKERNELBASE=$(KERNELBASE) \
		-c -o misc.o misc.c
	$(LD) $(ZLINKFLAGS) -o zvmlinux.tmp $(OBJECTS)
	$(OBJCOPY) $(OBJCOPY_ARGS) -R .comment --add-section=image=../coffboot/vmlinux.gz \
		zvmlinux.tmp $@
	rm zvmlinux.tmp
--------------------------------------------------------------------------------

and my modifications:

--------------------------------------------------------------------------------
zvmlinux: $(OBJECTS) $(FIRMPATH)vmlinux.gz
#
# build the boot loader image and then compute the offset into it
# for the kernel image
#
	$(LD) $(ZLINKFLAGS) -o $(FIRMPATH)zvmlinux.tmp $(OBJECTS)
	$(OBJCOPY) $(OBJCOPY_ARGS) -R .comment --pad-to=0x614000 --remove-section=.bss --add-section=image=$(FIRMPATH)vmlinux.gz $(FIRMPATH)zvmlinux.tmp $(FIRMPATH)$@
#
# then with the offset rebuild the bootloader so we know where the kernel is
#
	$(CC) $(CFLAGS) -DINITRD_OFFSET=0 -DINITRD_SIZE=0 \
		-DZIMAGE_OFFSET=`sh offset $(FIRMPATH)zvmlinux image` \
		-DZIMAGE_SIZE=`sh size $(FIRMPATH)zvmlinux image` -DKERNELBASE=$(KERNELBASE) \
		-c -o misc.o misc.c
	$(LD) $(ZLINKFLAGS) -o zvmlinux.tmp $(OBJECTS)
	$(OBJCOPY) $(OBJCOPY_ARGS)  -R .comment --pad-to=0x614000 --remove-section=.bss --add-section=image=$(FIRMPATH)vmlinux.gz $(FIRMPATH)zvmlinux.tmp $(FIRMPATH)$@
	rm $(FIRMPATH)zvmlinux.tmp
--------------------------------------------------------------------------------

I use FIRMPATH to generate the files elsewhere.

With that modifications, it is OK. What i would like to know is how
does it work without ? Indeed i know several persons on this mailing list
succeeded in booting their Linux without it.

I hope that helps.

	Raphael

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
