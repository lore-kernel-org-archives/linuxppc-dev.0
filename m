Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: mpcbdm SDRAM and Flash program
Reply-To: bin_ren@myrealbox.com
From: "Bin Ren" <bin_ren@myrealbox.com>
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 24 Dec 2002 20:48:24 +0800
MIME-Version: 1.0
Message-ID: <1040734104.7b13ac00bin_ren@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all:
  We're reading mails to this list for quite a while and finally
have found no other way but to post our question here.

  Our target is MPC860 Processor Card, with MPC860SR, 2M flash
and 32M SDRAM (AMD's AM29LV107B). We're using MPCBDM, with a
self-made BDM wire, to debug. We have written our own "mpc.init"
and "Flash.dev", which may not be correct. But we can successfully
read and write any word in SDRAM and flash, can load a cross-compiled
program to SDRAM, can ident, erase and clear flash.

  But we do have to STRANGE problems here:

1. After loading a program to SDRAM, we use "jump *0x0" to
execute the program. Immediately, the program received signal
SIGINIT and sometimes SIGTRAP. If we set a breakpoint at the
beginning of the program, we CANNOT move to the next instruction!

2. We can load program to flash WITH mpcbdm_fflush DISABLED,
but whenever we enable it, an error occurs. Only the first byte
is written into the flash.

3. We are trying to use ppcboot-2.0, which format, .bin or .srec
should be loaded into the flash and at which position? the very
start of flash??

Info: Memory Map:
SDRAM: CS5: 0x00000000 - 0x01ffffff
Internal:   0xff000000 - 0xff003fff
FLASH: CS0: 0xffe00000 - 0xffffffff

The followings are the error messages:

############################################################
(gdb) lo hello_world
Loading section .text, size 0x11c lma 0x40000
Loading section .data, size 0x58 lma 0x5011c
Loading section .got2, size 0x18 lma 0x50174
Start address 0x40004 , load size 396
Transfer rate: 3168 bits in <1 sec, 132 bytes/write.
(gdb) sym hello_world
Reading symbols from hello_world...done.
(gdb) jump *0x40004
Continuing at 0x40004.
*** run
*** Resume
*** wait freeze
E!I!
Program received signal SIGINT, Interrupt.
r00=ffffffff  r01=ffe00000  r02=000000aa  r03=ffe00000  r04=00000055
r05=ffe00000  r06=000000a0  r07=00000000  r08=00000000  r09=00000d0a
r10=00000000  r11=00000000  r12=00000000  r13=00000000  r14=00000000
r15=00000000  r16=00000000  r17=00000d0a  r18=00000000  r19=00034280
r20=00000000  r21=00000000  r22=00000000  r23=00000000  r24=00000000
r25=000000c7  r26=00000000  r27=00000000  r28=ff002fff  r29=ffe00fff
r30=00000000  r31=00000000
CR := (CR0|4CR1|8CR2|12CR3|16CR4|20CR5|24CR6|28CR7)
SPR 2:Condition Register, UM140
CR = 0x30000000 = (CR0=0x3|CR1=0x0|CR2=0x0|CR3=0x0|CR4=0x0|CR5=0x0|CR6=0x0|CR7=0x0)
ICR := (|RST|CHSTP|MCI||6EXTI|ALI|PRI|FPUVI|DECI||13SYSI|TR||17SEI|ITLBMS|DTBLMS|ITLBER|DTLBER||28LBRK|IBRK|EBRK|DPI)
SPR 148:Interrupt Cause Register, UM994
ICR = 0xffffffff = (RST|CHSTP|MCI|EXTI|ALI|PRI|FPUVI|DECI|SYSI|TR|SEI|ITLBMS|DTBLMS|ITLBER|DTLBER|LBRK|IBRK|EBRK|DPI)
0x40004 <hello_world>:	stwu	r1,-32(r1)
hello_world (argc=0, argv=0x0) at hello_world.c:28
28	{
(gdb)
##############################################################
(gdb) mpcbdm flash conf 0xffe00000 1 AM29LV017B
(gdb) mpcbdm flash clear 0xffe00000
clear FLASH bank 0 [0xffe00000,0xffffffff] ?(y or n) y
(gdb) mpcbdm flash file "ppcboot.bin" 0xffe00000
Copying to flash with remote routines using buffer[0xff002000,0xff002fff]...
Copy file "ppcboot.bin" len 0x0001a8ac to FLASH at [0xffe00000,0xffe1a8ab] ?(y or n) y
...
...
checking FLASH [0xffe19000,0xffe19fff]...
*** Resume
*** wait freeze
checking FLASH [0xffe1a000,0xffe1a8ab]...
*** Resume
*** wait freeze
Copying to Flash using remote routines...
writing FLASH [0xffe00000,0xffe00fff]...
*** Resume
*** wait freeze
error: FLASH failure at 0xffe00000: nResult=0x00001000
##############################################################


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
