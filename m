Message-ID: <D73A25AA6E54D511AD74009027B1110F2C8634@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Patrick Mahoney'" <pmahoney@8d.com>,
	ppcboot-users@lists.sourceforge.net,
	linuxppc-embedded@lists.linuxppc.org
Cc: yooth@ipone.co.kr
Subject: RE: ppcboot on rpxlite_dw mpc850
Date: Wed, 25 Sep 2002 14:59:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The RPXlite_config in ppcboot is for the Embedded Planet LITE CW not the DW.
The CW is high boot and has DRAM, the DW is low boot and has SDRAM.



-----Original Message-----
From: Patrick Mahoney [mailto:pmahoney@8d.com]
Sent: Wednesday, September 25, 2002 2:49 PM
To: ppcboot-users@lists.sourceforge.net;
linuxppc-embedded@lists.linuxppc.org
Cc: yooth@ipone.co.kr
Subject: ppcboot on rpxlite_dw mpc850



Hello lists,

Apologies for the crosspost. I believe both lists are concerned.

Regarding my problem, i searched the archives and did not find any
relevant information. Yet, i am new to this project, so there might be
some elementary stuff i am not aware of...

I have an RPXlite_dw board from EmbeddedPlanet with the MPC850 chip. I
use SourceGate II ver 4 from Avocet Systems for debugging. I am trying
to boot ppcboot on it.

For ppcboot compilation, i did:

$ make RPXlite_config
$ make

I installed the binary file into flash. Using the debugger, i can see
that the first instructions are located at address 0x100, as they
should be.

When i boot the board, no output is performed on the serial
port. The first few instructions appear as follows (as viewed by the
debugger) with the corresponding code snippet pasted at the end.

0x100 LIS	r3,-0x5E0
0x104 MTSPR	IMMR,r3
0x108 LI	r21,0x1
0x10C B		0x118
0x110 LI	r21,0x2
0x114 B		0x118
0x118 LI	r3,0x1002
0x11C MTMSR	r3

Using the debugger and doing a step by step execution, it seems that
these instructions generate breakpoint exceptions, change the memory
map in some way, and jump somewhere in the code. It finally ends by
executing the 'FFFF' instruction (in flash?) which generates a
float-instruction exception. I apologize for this somewhat unclear
description, but it seems that the execution is different from time to
time.

Now, here are my interrogations...

- Has anyone booted ppcboot with this exact board?

- Where does the LI instruction come from? It doesn't appear in the
Motorola's 32 bit ppc ref books. Could the problem be at the
cross-compiling level?

- Here's a notice written by Yoo. Jonghoon in the
.../board/RPXlite/flash.c file:

/*
 * Yoo. Jonghoon, IPone, yooth@ipone.co.kr
 * PPCboot port on RPXlite board
 *
 * Some of flash control words are modified. (from 2x16bit device
 * to 4x8bit device)
 * RPXLite board I tested has only 4 AM29LV800BB devices. Other devices
 * are not tested.
 *
 * (?) Does an RPXLite board which
 *      does not use AM29LV800 flash memory exist ?
 *      I don't know...
 */

Can I rightfully conclude that ppcboot has yet to be ported to this
precise board? If so, what are the modifications that would be to be
done? Any useful links?

Best regards,


Patrick Mahoney


.../cpu/mpc8xx/start.S:
================================================
        .globl  _start
_start:
        lis     r3, CFG_IMMR@h          /* position IMMR */
        mtspr   638, r3
        li      r21, BOOTFLAG_COLD      /* Normal Power-On: Boot from FLASH
*/
        b       boot_cold

        . = EXC_OFF_SYS_RESET + 0x10

        .globl  _start_warm
_start_warm:
        li      r21, BOOTFLAG_WARM      /* Software reboot
*/
        b       boot_warm

boot_cold:
boot_warm:

        /* Initialize machine status; enable machine check interrupt
*/

/*----------------------------------------------------------------------*/
        li      r3, MSR_KERNEL          /* Set ME, RI flags */
        mtmsr   r3

================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
