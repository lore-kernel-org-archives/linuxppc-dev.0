Date: Mon, 17 Nov 2003 13:29:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Cc: Wolfgang Denk <wd@denx.de>, Dale Farnsworth <dale@farnsworth.org>
Subject: MPC5xxx code issues
Message-ID: <20031117202944.GH30251@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Okay, after giving the code a good review, here's my list of things to
try and get done on the MPC5xxx code:

I don't understand:
include/asm-ppc/io.h: Why does CONFIG_ICECUBE define _IO_BASE, etc to 0
when it sets isa_io_base, etc.
drivers/i2c/i2c-algo-mpc5xxx.c, drivers/i2c/i2c-icecube.c: Is the
-icecube file actually icecube specific or is this a case of following
the 8xx model?

Must clean: These files need some sort of rewrite to look less like a
drop of commerical code into the kernel and more like working the
commercial code into the kernel:
arch/ppc/5xxx_io/bestcomm/capi/Makefile
arch/ppc/5xxx_io/bestcomm/code_dma/image_rtos1/Makefile
arch/ppc/5xxx_io/bestcomm/code_dma/image_rtos2/Makefile
arch/ppc/5xxx_io/bestcomm/include/dummy files (should these be needed?)

Really should get reviewed: These drivers really should be run past the
respective overall maintainers.  I cannot push these to Marcelo (with
the exeception of the FEC driver) without their approval:
arch/ppc/5xxx_io/fec.[ch]
drivers/i2c/i2c-algo-mpc5xxx.c
drivers/i2c/i2c-icecube.c
drivers/ide/ide-dma.c (I've seen a similar patch for 2.6 so this should
be easy to get in).
drivers/ide/ppc/mpc5xxx_ide.c, etc (I'm not actually sure if Alan
reviews drivers, or would given that he's spending less time on Linux
right now).
drivers/mtd/maps/icecube.c (There's recent MTD changes so that the
physmap.c driver can be used instead on a lot of platforms, I don't know
if this would work for the IceCube or not.  Something to keep in mind
however, should MTD be updated in kernel.org)
drivers/usb/host/usb-ohci.c, etc.

Wishlist: It really would be nice to do this, but I can accept it if
they don't happen:
CONFIG_UBOOT: In all uses of it that I can see at least in the kernel
code we could just as easily have the in-tree bootwrapper create the
__res data and always act like we're on U-Boot.
defconfigs: Since I don't know the board families well (and google was
no help here), should both IceCube and Glacier default to MPC5200 ?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
