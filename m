From: duncanp@research.canon.com.au
Date: Tue, 11 Apr 2000 11:47:45 +1000 (EST)
Subject: Re: How to get zImage into rom for 8xxrom on FADS board.
To: "Dan A. Dickey" <ddickey@charter.net>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <38F24018.16C3266F@charter.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Message-Id: <20000411005159.D39862C12@eos.research.canon.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

On 10 Apr, Dan A. Dickey wrote:
>
> Please, no snide remarks about the FADS.  :)
>
> I now have 8xxrom compiled, loaded, and running on my FADS.
> But, of course - no disks, nor file system in flash.
> Can someone detail how I can take a zImage and get it
> into flash so that 8xxrom will boot it?  I've just about
> managed it (8xxrom will detect ELF images and load them),
> but not quite yet.  I'm using mpc8bug to download Srecords
> to the flash - so in short, I'm asking how to create an
> S-record file of either a small fs (with the zImage file in
> it), or create the S-record file of the zImage suitable
> for downloading.  Surely, someone has done this before...
> what's the magic incantation?

I don't have a FADS board to play with, but can give you some general
ideas on how to get one working without a disk.

You should just be able to make an s-record of the zImage, and drop it
into flash, more or less wherever you like. Objcopy can be used to
generate the s-record:

powerpc-linux-objcopy -I binary -O srec --change-addresses=0xff800000
--change-start=0x10000 zImage zImage.srec

You may want to change the argument to --change-addresses - this is the
address the zImage will end up getting flashed to. Or, this address may
not matter - depends on the behaviour of mpc8bug.

8xxrom doesn't support booting images straight from flash at the
moment, so you'll have to hack it a little bit. Basically, modify
elf_bootz() to do only the following:

        start_loc = (void ((*)()))(0xzImaegaddress);
        printf("Starting 0x%x\n", (uint)start_loc);
        (*start_loc)(bdinfo);

Where zImageaddress is the start address of your zImage + 64k - this
is important as you must jump over the elf header, which you don't
really need to know about when running the image from flash. The kenel
image will decompress itself to its link address (0x10000 if you use the
incantation of objcopy i've given above), and run.

These instructions are kinda vague, but i hope thay might help you our
of trouble. Give me a yell if you've got more questions.

Dunk.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
