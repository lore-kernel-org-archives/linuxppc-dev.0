Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <39340E4A.2E0893C9@lucent.com>
Date: Tue, 30 May 2000 13:54:02 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: Daniel Wu <Daniel.Wu@alcatel.com.au>
Subject: Re: Porting LinuxPPC
References: <20000519051051.236093C972@elph.research.canon.com.au>
	 <39253A48.24B90117@snmc.com> <39253D0B.F9AF86EE@raleigh.ibm.com>
	 <392562CE.A71A4F49@embeddededge.com> <392A3147.3A9AC5C2@alcatel.com.au> <00May30.174931est.115248@border.alcanet.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daniel Wu wrote:
> I'm still having problems with booting the kernel - I've got to the point where the
> compressed image has been successfully decompressed and starts to execute code in
> kernel/head.S, which sets up the TLBs. However, as soon as the code turns on the
> mmu, the code crashes!
>
> I'm running this under a BDM monitor, could this be the source of the problem?

I know nothing about BDM, but I did just last week get the linux kernel
up on our board (this one is a single-CPU PPC604 with 48 MB DRAM).

The linux kernel expects to be loaded at physical address 0 and for
execution to start at address 0, in real mode (i.e. MMU disabled).
Depending upon configuration, the kernel may expect registers
r3-r7 to contain valid memory pointers, or it may expect there
to be a Mackintosh boot ROM available, or it may actually expect to
have been loaded at 0x00100000 and will relocate itself to physical
address 0, etc. -- you probably need to go through head.S with a
fine-toothed comb, and make sure you have configured the kernel
correctly for your hardware. In my case I basically copied the
CONFIG_PREP code, adding appropriate CONFIG_LSPS code in most places
("LSPS" is the name of our board). I also added "LSPS" to config.in
so I could configure it. So far I have touched 10 kernel source
files, and have added 2 files for my lsps_setup and lsps_driver.


>  One
> thing I noticed is that the kernel uses virtual addresses starting at c0000000 and
> the BDM monitor fails to do the translation. Is there any way to get around this?

I don't think so -- that looks pretty basic to me, throughout the PPC
port. But your boot monitor should not need to do the translation --
load the kernel image at 0 and jump to addr 0, all in real mode of your
boot monitor. But you do need to configure the Linux kernel with device
drivers which can talk to your hardware....

	And you may need to configure that option to load at 0x00100000
	if your boot monitor uses the memory at addr 0....


Note if you load a compressed kernel you need to load it higher than
0x00100000 or so and jump to its first instruction -- it will
decompress the kernel to addr 0 and jump to it there. I have not
gotten a compressed image to work, and I am booting vmlinux directly
(but for me it's not an issue -- it takes just 3.1 seconds from the
<CR> of my boot command to a bash prompt from the board).

	HEY -- IS THAT A RECORD??? has anyone ever booted Linux faster
	than 3.1 seconds? Of course this is a _VERY_ bare-bones system
	with just a console and a 4 MB initrd-ramdisk.


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
