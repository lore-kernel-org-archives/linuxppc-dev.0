In-Reply-To: <19991122124702.006073@mailhost.mipsys.com>
Date: Mon, 22 Nov 1999 18:07:21 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: cort@ppc.kernel.org, paulus@linuxcare.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: bootloader & head.S weirdness (patch)
Message-Id: <19991122180721.017837@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 22, 1999, Benjamin Herrenschmidt <bh40@calva.net> wrote:

>I'm also trying to get initrd to work but I didn't fully understand the
>pointer calculations on r3/r4 done in identify_machine. It looks like
>loading the kernel at the above address and initrd 1Mb after the kernel
>(so I leave some room for prom_init to expand klimit) doesn't work (the
>ramdisk presence is not recognized). Should I pass a pointer in r3 which
>is already relative to KERNELBASE ? (basically, should I pass
>phys_initrd_address or phys_initrd_address+KERNELBASE ?) or should I just
>remove those pointer calculations from setup.c and assume r3 contains the
>real physical address of initrd ?

Ok, I have initrd working by changing the stuffs in setup.c to always
take r3 and r4 into account when they are both non-null and not
0xdeadbeef. I also had to pass the initrd_base + 0xc0000000 to the kernel
for it to work.

However, it works only when I load the kernel at 0x1000000 (16Mb). If I
load the kernel at 8Mb, then it fails mounting the ramdisk. The initrd
image is loaded just after the kernel (I leave a gap of 1Mb between the
kernel and the ramdisk). Of course, I use the kernel memory size, not
file size for the calculations.

I also know why loading the kernel below (4 or 6Mb) didn't work: RTAS is
instanciated at the fixed address 0x600000 (6Mb), which did override the
kernel image.

So now, I have the bootloader loaded at 0x200000, it's malloc pool at
0x300000, the kernel at 0x1000000, the ramdisk 1Mb after the kernel end,
and it works (provided that I apply the head.S patch I posted earlier). I
beleive all newworld machines have at least 32Mb of RAM, so this should
be fine for now, but I would still prefer to be able to "pack" things a
little bit better (and have an RTAS address calculated from the kernel
image size) since this bootloader may be usegful to other CHRP machines
with less memory.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
