Message-ID: <386EFCF1.ABF25328@huawei.com.cn>
Date: Sun, 02 Jan 2000 15:23:29 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Raphael Bossek <raphael.bossek@solutions4linux.de>,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Please help me...
References: <386C150F.22B1A3D0@huawei.com.cn> <19991227094239.B1025@raphael.bossek.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




> hi dony,
>
> > Do you know why? How can I programme to make it run?
> i thing you have download it into wrong address! i would recompile
> the kernel with debugging information and single step your code...
> the decompressor and some of the first lines of code of the kernel
> are initialisation and possible to debug...

How can I debug whether the decompress_kernel() and some of the first
lines of code of the kernel in arch/ppc/mbxboot/head.s are running or not?
I think they are not running,  because
I cannot see any startup messages coded in decompress_kernel().

> check where the
> decompressor jump to and compare where the decompressor reads from!
> use binutils to get mixed code on your host and compare the lines
> with your debuger

Yes, I should try check, but I just don't know how to check that .
Can you give me some more detailed information for debug?

>
> let take me a look... the 8xxrom load the kernel elf image to phy
> address 0x00200000

Yes, I have downloaded your 8xxrom codes and read them.
But they seem to read the kernel from flash into RAM 0x00200000 on board,
which is a bit defferent from what I am doing.
Now I will try to express my idea to you as clearly as possibly. Please
give me some helpful suggestions.
I use the monitor program based on vxWorks BSP. This monitor program
initialize all the things after power on (or system reset): MPC860 CPU
initialization, MEMORY initialization, Serial Port initialization(SMC2)
and Ethernet initialization(SCC1) etc. Then it use the BOOTP/TFTP protocol
to download the kernel "zImage" (compressed) or "vmlinux" (uncompressed)
from a linux box Server which has been configured bootpd , tftpd, and nfsd
.Yes , It successfully download the kernel to RAM 0x00200000 on my custom
board. Then I am very confused at this stage. Now questions appears:
1     If I directly jump there 0x00200000 at this time, will it run and
decompress the kernel automatically?
I think there are some bootloader codes (including the
decompress_kernel()) at 0x00200000 at this time , so it should run  the
first lines of the bootloader codes and then decompress_kernel() in order,
right? But it fails at all. After loading the kernel, it just shows a
message "start at 0x00200000..." (which is coded in my monitor program)
and doesn't show some startup messages in decompress_kernel() such as
"loading at... relocated to...  board data at... relocated to... zImage
at... ". I think this means the decompress_kernel() doesn't run, even the
first lines of the bootloader also not run (How can I prove whether the
latter is running or not?)
I also try to put some lighting-led-on-board codes at the very begining of
the arch/ppc/mbxboot/head.S , those red and green leds also don't light.

> > Since the kernel is a compressed image (zvmlinux), need I make
> > some codes to decompress it and then run it? if so, how to do it?
> the decompressor is part of the image but it expects the real image
> at a special address which you have to consider before downloading
> into ram.

Sorry, I don't know what you are meaning here.


> this will be done by the 8xxrom from Magnus Damm and some
> patches for the 823 avilable at http://www.s4l.de/powerpc.html of
> course :-)

Yes, I have downloaded your 8xxrom and studied these two functionss
elf_bootz (), bootvm() in elf.c. After reading the kernel "zImage" from
flash to RAM 0x00200000, you seem to handle them to strip the elf header
before you call start_loc() to run the bootloader. Am I right?
So when I download the "zImage" to RAM 0x00200000 on my custom board ,Need
I do the same thing as you before jumping there directly to run the
bootloader?

Thank you very much:-))
dony



> the 8xxrom resists in flash and load the linux kernel from
> a pcmcia ide hd or from flash using a rom-fs but this is an another
> solution that can be used in a ready product with little modifications
> in image selection...

> --
> Raphael Bossek <raphael.bossek@solutions4linux.de> [ICQ #40047651]
> PGP fingerprint: DF 6F 2C 76 46 1E B4 1C  5B A5 2E 1B FC E0 D3 F6
> PGP public key: http://www.solutions4linux.de/private/pgpkey.asc


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
