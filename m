Message-ID: <382B6913.133EBEFA@ctam.com.au>
Date: Fri, 12 Nov 1999 12:10:44 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: Hyunjong Do <bart@lgic.co.kr>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How do you boot your MPC860?
References: <00da01bf2cac$99714e80$143e9696@lgic.co.kr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hyunjong Do wrote:

> Hello, My name is Hyunjong

Hi.


> I saw your address from mailing list

Which mailing list ?  The linux-embedded or the linuxppc-embedded ?
I would suggest joining the linuxppc-embedded mailing list if you
haven't done so already.
http://lists.linuxppc.org/


> Congratulation on  booting your board.

Thanks.  I had lots of help from Dan Malek (thanks for your time) and
others on the linuxppc mailing list.


> actually I have MPC860 evaluation board from Motorolla

What is it ?  ADS, FADS, MBX ?
Dan really suggests that you don't waste too much time with ADS/FADS
because of the poor quality.  Others seem to be still working with the
FADS though.


> I have been developing SNMP agent for ADSL mux.
> the OS is vrtxsa 4.C.
> It works on mpc860 board , somehow.
> and personally I like to port using linux. but I don't know how.
> could you share your linux boot code for mpc860 or "HOW-TO" ?

Go to the following sites and read the embedded stuff.

http://www.ppc.kernel.org/
http://www.ppc.kernel.org/embedded.html

Get some of the files from the ftp server and read the
embedded_notes.txt and mbx_notes.txt files.  There maybe other READMEs
as well.

You need to compile with a gcc (egcs-1.1.1 or later.  egcs-1.1.2 or
gcc-2.95.x) compiler running on a powerpc machine (Mac, etc) or using a
gcc cross-compiler for the powerpc processor.  There is a prebuilt
cross-compiler link on the main web page but it is probably still the
egcs-1.1.1 version.  This is enough to compile the kernel.  You will
most likely need libraries to compile application code.

There are 2 kernel versions on the web site (embedded-2.2.5.tar.gz and
linux-2.3.18.tar.gz).  The 2.3.x series is not as stable as the 2.2.x
series (so I am told).  I guess I would recommend geting 2.2.5 going
first and then trying the 2.3.18 stuff later.  The 2.3.18 code has much
better configuration support for MPC860 peripherals.

Configuring the kernel is the hardest part to get right (well for me it
was).  Choose the absolute minimum to start with and get it to compile.
You can then experiment with adding drivers as you see fit.  Do not
choose modules for any of the drivers.  I also recommend configuring
using X-windows with the command "make xconfig".  This has the options
of saving configuration files and reloading them.  You can do it
manually too by copying to/from .config in the top level directory but I
prefer to let the X-Windows configuration tool do it.  Compile the
kernel with "make zImage" or "make zImage.initrd".  The latter requires
that you have a ramdisk image (called ramdisk.image.gz) of a root
filesystem.  Forget the initrd for now, at least until you can get the
kernel to compile with "make zImage".

You need a bootloader !!!
I ported a some startup code that we used on one of our custom boards.
It configures the watchdog, clocks, Flash, DRAM, chipselects and a few
ports.  It also has S-Record programming code.  I programmed this code
into the Flash SIMM using a BDM debugger (loaded it into RAM and then
ran it so I could use the S-Record programming code to program the
bootload into flash).  After testing/debugging the bootloader I then
programmed the zImage into flash.  The bootloader executes the zImage
and hey presto, it does it's job and starts loading the kernel and
outputing information to the console.

If your board is not supported in the kernel, you will need to modify
arch/ppc/mbxboot/head.S and arch/ppc/mbxboot/embed_config.c to setup
board specific paramters.

Hope this helps and gives you some idea of what is involved.  You will
need to do a bit of work.

Because I wrote the bootloader at work, I can not give it to you without
organising it with the boss.  It is a real mess at the moment anyway and
I would not give it to anyone in the state it is in.  A real hack job
you might say.  You should have some bootup code for your operating
system.  You can work with that or develop your own.  The minimal
requirement is to get ROM and RAM (>4MB required.  I use 16MB) going.
I setup a temporary stack in dualport RAM and call some C functions to
initialise FLASH and DRAM.  When this finishes and returns to my
startup.asm file, I then setup the stack in DRAM and continue with the
rest of the bootloader code by calling "main".  This method keeps the
assembler code down to a minimum.


> thanks..
> Hyunjong Do

No worries :)

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
