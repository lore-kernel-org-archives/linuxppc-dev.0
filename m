Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16242.64239.133401.668446@waldo.lisle.iphase.com>
Date: Thu, 25 Sep 2003 09:25:51 -0500
To: "Mark A. Greer" <mgreer@mvista.com>, Q-ha Park <qha@infoeq.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: using bdi2000 to debug ppcboot on mpc7455
From: bradbosch@attbi.com
In-Reply-To: <3F725407.3020907@mvista.com>
References: <004c01c382ff$de2da2f0$2a21a8c0@qha>
	<3F725407.3020907@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Q-ha,

You didn't give enough details about what you tried for us guess what
is wrong, but there are several issues with debugging U-Boot or
ppcboot with the bdi2000 which require a good understanding of what is
going on.  Here is some info that may be of help.  I also have a
request for you or anyone else using the 745x processors with the
BDI2000 at the end of this message.

In addition to the issue Mark pointed out, you can't use soft
breakpoints while you are running from ROM which is the common case
for the early init parts of U-Boot.

Also, once U-Boot has relocated itself, you need to identify the new
base address and inform gdb of the new load address.

In this example GDB session, I have my BDI config file set up for
address translation and software breakpoints.  I have included some
command options which are the defaults to make it more clear what is
going on.  I have also added some comments inline:

[brad@gizmo u-boot]$ ppc-linux-gdb
GNU gdb 5.1.1
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "--host=i386-redhat-linux --target=ppc-linux".
(gdb) add-symbol-file u-boot 0xfff00000
add symbol table from file "u-boot" at
        .text_addr = 0xfff00000
(y or n) y
Reading symbols from u-boot...done.

//// We didn't need the address above, but I wanted to make it clear
//// how it differs from the later use of add-symbol-file.

(gdb) target remote 10.100.50.221:2001
Remote debugging using 10.100.50.221:2001
_start () at /d/build/brad/u-boot-discov/u-boot/cpu/74xx_7xx/start.S:94
94              li      r21, BOOTFLAG_COLD      /* Normal Power-On: Boot from FLASH */
(gdb) b boot_cold
Breakpoint 1 at 0xfff02000: file /d/build/brad/u-boot-discov/u-boot/cpu/74xx_7xx/start.S, line 271.
(gdb) d
Delete all breakpoints? (y or n) y

//// We can't use software breakpoints yet so the above was just an easy
//// way to get the address where we want to set our hardware breakpoint.

(gdb) mon bi 0xfff02000 p
Breakpoint identification is 0

//// The monitor command is a handy way to avoid switching to a telnet
//// window to use the telnet interface.  The p option forces a physical
//// mode breakpoint.

(gdb) cont
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
boot_warm () at /d/build/brad/u-boot-discov/u-boot/cpu/74xx_7xx/start.S:271
271             li      r0, 0
(gdb) list in_flash
319             /* perform low-level init */
320             /* sdram init, galileo init, etc */
321             /* r3:  NHR bit from HID0 */
322
323             /* setup the bats */
324             bl      setup_bats
325             sync
326
327             /*
328              * Cache must be enabled here for stack-in-cache trick.
(gdb)
329              * This means we need to enable the BATS.
330              * This means:
331              *   1) for the EVB, original gt regs need to be mapped
332              *   2) need to have an IBAT for the 0xf region,
333              *      we are running there!
334              * Cache should be turned on after BATs, since by default
335              * everything is write-through.
336              * The init-mem BAT can be reused after reloc. The old
337              * gt-regs BAT can be reused after board_init_f calls
338              * board_pre_init (EVB only).
(gdb)
339              */
340     #if !defined(CONFIG_BAB7xx) && !defined(CONFIG_ELPPC)
341             /* enable address translation */
342             bl      enable_addr_trans
343             sync
344
345     #if 1
346             /* enable and invalidate the data cache */
347             bl      l1dcache_enable
348     #endif
(gdb) b 343
Breakpoint 3 at 0xfff0203c: file /d/build/brad/u-boot-discov/u-boot/cpu/74xx_7xx/start.S, line 343.
(gdb) d
Delete all breakpoints? (y or n) y
(gdb) mon ci
(gdb) mon bi 0xfff0203c v
Breakpoint identification is 0

//// We just turned on address translation so the rest of our hardware
//// breakpoints must use virtual mode, thus the v above.

(gdb) cont
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
in_flash () at /d/build/brad/u-boot-discov/u-boot/cpu/74xx_7xx/start.S:343
343             sync
(gdb) symbol-file
Discard symbol table from `/d/build/brad/u-boot-discov/u-boot/u-boot'? (y or n) y
No symbol file now.
(gdb) add-symbol-file u-boot 0x0ffb8000
add symbol table from file "u-boot" at
        .text_addr = 0xffb8000
(y or n) y
Reading symbols from u-boot...done.

//// Prepare to set breakpoints after we relocate to RAM.  Throw out
//// the old symbol table and reload it with the correct base address
//// (which we got from examining the code or as reported by U-Boot before
//// it began running in RAM.

(gdb) b after_reloc
Breakpoint 5 at 0xffba92c: file db64360.c, line 416.
(gdb) d
Delete all breakpoints? (y or n) y
(gdb) mon ci
(gdb) mon bi 0xffba92c v
Breakpoint identification is 0
(gdb) cont
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
after_reloc (gd=0xff96f9c, dest_addr=268140544) at db64360.c:416
416             board_init_r(gd, dest_addr);

//// OK.  Now we are in RAM and we can use soft breakpoints from here
//// on out.

(gdb) b board_init_r
Breakpoint 6 at 0xffc14a0: file board.c, line 589.
(gdb) cont
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
after_reloc (gd=0xff96f9c, dest_addr=268140544) at db64360.c:416
416             board_init_r(gd, dest_addr);
(gdb) list
411             }
412             memoryMapDeviceSpace(BOOT_DEVICE, CFG_FLASH_BASE, CFG_FLASH_SIZE);
413     #endif
414
415             /* now, jump to the main ppcboot board init code */
416             board_init_r(gd, dest_addr);
417
418             /* NOTREACHED */
419     }
420
(gdb) print /x dest_addr
$1 = 0xffb8000
(gdb) step


Once you get all this working, could you please do me a favor and let
me know if you ever have any problems with single step ("mon ti" or
"stepi") not working?  I have a lot of trouble with this with my
7447/Discovery II combo and I am trying to figure out if it is a board
issue or a processor issue or a BDI issue.

--Brad

Q-ha Park writes:
 >
 > [I apologize this question is off topic in this mailing
 > list:ppc-embedded. But I coundn't find a better place to ask,
 > ppcboot-users is inactive..]
 >
 > I'm new to BDI2000, and after reading a manual that came with the tool,
 > I tried to debug ppcboot using bdi2000 and gdb. The problem is I just
 > can't set the breakpoint whether be it software or hardware breakpoint;
 > For example, when I set the break point at "boot_cold" and type
 > "continue", the program just runs without ever stopping at the
 > breakpoint where it's supposed to stop!
 >
 > Here's what I did:
 > a. turn on bdi2000.
 > b. connect to bdi2000 in gdb session.
 > c. set the breakpoint
 > d. type "continue"
 >
 > ==========
 > 90              li      r21, BOOTFLAG_COLD      /* Normal Power-On: Boot
 > from FLASH */
 > (gdb) l
 > 85              .ascii  CONFIG_IDENT_STRING, "\0"
 > 86
 > 87              . = EXC_OFF_SYS_RESET
 > 88              .globl  _start
 > 89      _start:
 > 90              li      r21, BOOTFLAG_COLD      /* Normal Power-On: Boot
 > from FLASH */
 > 91              b       boot_cold
 > 92              sync
 > 93
 > 94              . = EXC_OFF_SYS_RESET + 0x10
 > (gdb) b boot_cold
 > Breakpoint 1 at 0xfff02000: file
 > /home/users/qpark/hobby/ppcboot-1.1.6/cpu/74xx_7xx/start.S, line 253.
 > (gdb) cont
 > Continuing.
 > (continues for good...)
 > ==========
 >
 > What am I probably doing wrong? FYI, I tried to remove H/W breakpoint
 > before I entered "go"
 >
 > Any help would be greatly appreciated!!
 >
 > :::::::::::::::::::::::::::::::::::::::::::::::::
 > Q-ha Park
 >
 >

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
