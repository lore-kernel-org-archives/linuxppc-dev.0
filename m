Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000001c3f71c$1372ee30$7ec7c7c7@dkhoo>
From: "Dennis Khoo" <dkhoo@atmxdsl.com>
To: "RamanaYV" <venkataramana_y@mic.co.in>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <4034377A.000003.00996@RAMANAYV>
Subject: Re: PPCBOOT in customised MPC860T board
Date: Thu, 19 Feb 2004 11:09:24 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ramana,

Perhaps you should try the u-boot forum and use pick a tqm board as your
guide for the u-boot port.  But briefly for u-boot port:

1. Change Makefile to use your cross compiler and add your board config
2. Create a file named your_board.h in u-boot-x.x.x/include/configs for your
board configs.
3. Create a dir for your board under u-boot-x.x.x/board and in it
a) write/copy some flash routines in say flash.c
b) write/copy some ram routines in say your_board.c
c) write/copy other files like Makefile, etc
4. Modify u-boot-x.x.x/include/commproc.h to your board specs.
5. Compile and burn the u-boot.bin through BDM(I use DENX's $50 BDM4GDB but
that required on the MPCBDM so invest in a BDI2000.)

For the kernel(for 2.4.22 but 2.4.19 is similar):

1. Change the Makefile to use the right cross-compiler and also to tell it
to
build a ppc kerel. For example, add an entry "YOUR_BOARD CONFIG_YOURBOARD \"
in the list of boards under "if [ "$CONFIG_8xx" =
"y" ]; then" ....

2. Modify arch/ppc/config.in to add your board name to list of boards
already
present in the kernel for your cpu family.

#if defined(CONFIG_YOURBOARD)
 #include <platforms/yourboard.h>
 #endif

Please note that different kernel versions have different organizations so
yourboard.h which you will create later may have to be placed in a different
location.

3. Add the following to include/asm/mpc8xx.h:

 #if defined(CONFIG_YOURBOARD)
 #include <platforms/yourboard.h>
 #endif

4. Create the include/asm/yourboard.h   Not much to do here basically
#define IMAP_ADDR/SIZE to get the board going. (look at tqm board for
guidance)

5.  This next step is optional but it saves me a lot of time when I clean
and
rebuild my kernel.  When I clean my kernel, the .config file which was
created
when I do a "make menuconfig" or "make config" is wiped out and the next
time
when I build a kernel, the default config file "arch/ppc/defconfig is used
which usually means I have to reconfigure a lot of
the options.  To save time, right after I do a "make menuconfig" and the
.config
file is generated in the top directory, I copy the .config file and replace
arch/ppc/defconfig with it.

6. (If your board has ethernet) Add board specific scc ethernet pin info to
include/asm/commproc.h(find a spot
somewhere between the list of boards and possibly change
arch/ppc/8xx_io/fec.c to get fast ethernet(fec) to work.

7. whatever else you need.

Hopes this helps

Dennis Khoo
Software Engineer
Adapcom, INC.

----- Original Message -----
From: "RamanaYV" <venkataramana_y@mic.co.in>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, February 18, 2004 8:11 PM
Subject: PPCBOOT in customised MPC860T board


>
> I was working in MPC860T customised board and trying to port linux
through
> PPCBOOT.
>
> can you give me breif guidence to boot PPCBOOT in my board and to port
> linux-2.4.19 based kernel.
>
> Thank you,
> Ramana
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
