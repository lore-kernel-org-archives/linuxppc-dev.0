Message-ID: <391D5E99.D14A02F2@charter.net>
Date: Sat, 13 May 2000 08:54:33 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Richard Hendricks <richard.hendricks@motorola.com>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rom code to go on FADS?
References: <391B220F.9838E70F@charter.net> <391C3273.4BBF0884@motorola.com> <391C3945.9E0A439F@charter.net> <391C5416.15ADA181@motorola.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Richard Hendricks wrote:
...
> Maybe if you could post the "bare-bones" init code you are trying
> to use, we can offer more help.

Ok, here is the start.S I'm using - its pretty much from 8xxROM,
but with some changes by me.
	-Dan

/*  8xxROM - Startup Code for the FADS8xx series of Embedded Boards
 *  Copyright (C) 1998  Dan Malek <dmalek@jlc.net>
 *  Copyright (C) 1999  Magnus Damm <kieraypc01.p.y.kie.era.ericsson.se>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307  USA
 *
 *  The processor starts at 0x00000100 and the code is executed
 *  from flash. The code is organized to be at an other address
 *  in memory, but as long we don't jump around before relocating.
 *  board_init lies at a quite high address and when the cpu has
 *  jumped there, everything is ok.
 *  This works because the cpu gives the flash (CS0) the whole
 *  address space at startup, and board_init lies as a echo of
 *  the flash somewhere up there in the memorymap.
 *
 *  board_init will change CS0 to be positioned at the correct
 *  address and (s)dram will be positioned at address 0
 */
#include "config.h"

#define CONFIG_8xx 1
#define _LINUX_CONFIG_H 1

#include "ppc_asm.tmpl"
#include "ppc_defs.h"

#include <asm/processor.h>
#include <asm/cache.h>
#include <asm/mmu.h>
#include <board/board.h>

/* We don't want the  MMU yet.
*/
#undef MSR_KERNEL
#define MSR_KERNEL MSR_

        .text
        .globl  version_string
version_string:
        .string "8xxROM 0.3.0"
        . =
0x100

        .globl  _start
Xreset:
        addis   r2,0,_start@h
        ori             r2,r2,_start@l
        mtspr   LR,r2
        bclr    20,0


/* Machine check */
        STD_EXCEPTION(0x200, MachineCheck, MachineCheckException)

/* Data Storage exception.  "Never" generated on the 860. */
        STD_EXCEPTION(0x300, DataStorage, UnknownException)

/* Instruction Storage exception.  "Never" generated on the 860. */
        STD_EXCEPTION(0x400, InstStorage, UnknownException)

/* External Interrupt exception. */
        STD_EXCEPTION(0x500, ExtInterrupt, UnknownException)

/* Alignment exception. */
        . = 0x600
Alignment:
        EXCEPTION_PROLOG
        mfspr   r4,DAR
        stw     r4,_DAR(r21)
        mfspr   r5,DSISR
        stw     r5,_DSISR(r21)
        addi    r3,r1,STACK_FRAME_OVERHEAD
        li      r20,MSR_KERNEL
        rlwimi  r20,r23,0,16,16         /* copy EE bit from saved MSR */
        lis     r6, transfer_to_handler@h
        ori     r6, r6, transfer_to_handler@l
        mtlr    r6
        blrl
        .long   AlignmentException
        .long   int_return

/* Program check exception */
        . = 0x700
ProgramCheck:
        EXCEPTION_PROLOG
        addi    r3,r1,STACK_FRAME_OVERHEAD
        li      r20,MSR_KERNEL
        rlwimi  r20,r23,0,16,16         /* copy EE bit from saved MSR */
        lis     r6, transfer_to_handler@h
        ori     r6, r6, transfer_to_handler@l
        mtlr    r6
        blrl
        .long   ProgramCheckException
        .long   int_return

        /* No FPU on MPC8xx.  This exception is not supposed to
happen.
        */
        STD_EXCEPTION(0x800, FPUnavailable, UnknownException)

        /* I guess we could implement decrementer, and may have
         * to someday for timekeeping.
         */
        STD_EXCEPTION(0x900, Decrementer, UnknownException)
        STD_EXCEPTION(0xa00, Trap_0a, UnknownException)
        STD_EXCEPTION(0xb00, Trap_0b, UnknownException)

        STD_EXCEPTION(0xc00, SystemCall, UnknownException)
        STD_EXCEPTION(0xd00, SingleStep, UnknownException)

        STD_EXCEPTION(0xe00, Trap_0e, UnknownException)
        STD_EXCEPTION(0xf00, Trap_0f, UnknownException)

        /* On the MPC8xx, this is a software emulation interrupt.  It
occurs
         * for all unimplemented and illegal instructions.
         */
        STD_EXCEPTION(0x1000, SoftEmu, SoftEmuException)

        STD_EXCEPTION(0x1100, InstructionTLBMiss, UnknownException)
        STD_EXCEPTION(0x1200, DataTLBMiss, UnknownException)
        STD_EXCEPTION(0x1300, InstructionTLBError, UnknownException)
        STD_EXCEPTION(0x1400, DataTLBError, UnknownException)

        STD_EXCEPTION(0x1500, Reserved5, UnknownException)
        STD_EXCEPTION(0x1600, Reserved6, UnknownException)
        STD_EXCEPTION(0x1700, Reserved7, UnknownException)
        STD_EXCEPTION(0x1800, Reserved8, UnknownException)
        STD_EXCEPTION(0x1900, Reserved9, UnknownException)
        STD_EXCEPTION(0x1a00, ReservedA, UnknownException)
        STD_EXCEPTION(0x1b00, ReservedB, UnknownException)

        STD_EXCEPTION(0x1c00, DataBreakpoint, UnknownException)
        STD_EXCEPTION(0x1d00, InstructionBreakpoint, UnknownException)
        STD_EXCEPTION(0x1e00, PeripheralBreakpoint, UnknownException)
        STD_EXCEPTION(0x1f00, DevPortBreakpoint, UnknownException)


        .globl  _end_of_vectors
_end_of_vectors:


        . = 0x2000

_start:
        /* the original fadsrom code by Dan Malek did a lot of setup
*/
        /* in assembler, I moved most of the code to C for readability
*/

        addis   r3, 0, _start@h
        ori             r3, r3, _start@l
        addi    r3, r3, 0x0014  /* Jumps us into the NOPs below */
        mtctr
r3
        bctr

        nop
        nop

        /* Now we need to fix the LR since it points back to
0x0000_010x,
         * not 0x0280_010x like it needs to after we muck up the BCSR's
*/

        mflr    r3
        oris    r3, r3, 0x0280
        mtlr    r3

        addis   r0,0,0

        addi    r3, r0, MSR_    /* Set ME, RI flags */
        mtmsr   r3
        mtspr   SRR1, r3        /* Make SRR1 match MSR */

        /* Make the LR equal the PC. */
        oris    r3,r0,sync_jump@h
        ori             r3,r3,sync_jump@l
        mtspr   LR,r3
        bclr    20,0
sync_jump:

#if 1
        /* position IMMR */

        lis     r1, IMMR_VALUE@h
        ori     r1, r1, 0
        mtspr   638, r1

bror1start:
        /* need to setup BR1/OR1 to get to the BCSR on the fads */
        lis r9,0xffff
        ori r9,r9,0x8110
        lis r10,0x0210
        ori r10,r10,0x0001
        stw r9,0x10C(r1)
        stw r10,0x108(r1)

        /* signal on */
        lis     r8,0x210
        ori     r8,r8,16
        lis r9,0x210
        ori r9,r9,16
        lwz r10,0(r9)
        rlwinm r9,r10,0,4,2
        stw r9,0(r8)

#if 1
        /* signal delay */
        lis r8,0x5
sdloop1:
        addi r8,r8,-1
        li r9,-1
        cmpw r0,r8,r9
        bc 4,2,sdcont1
        b sdstop1
sdcont1:
        b sdloop1
sdstop1:
#endif

        /* signal off */
        lis     r8,0x210
        ori     r8,r8,16
        lis r9,0x210
        ori r9,r9,16
        lwz r10,0(r9)
        oris r9,r10,0x1000
        stw r9,0(r8)

#if 1
        /* signal delay */
        lis r8,0x5
sdloop2:
        addi r8,r8,-1
        li r9,-1
        cmpw r0,r8,r9
        bc 4,2,sdcont2
        b sdstop2
sdcont2:
        b sdloop2
sdstop2:
#endif

        /* signal on */
        lis     r8,0x210
        ori     r8,r8,16
        lis r9,0x210
        ori r9,r9,16
        lwz r10,0(r9)
        rlwinm r9,r10,0,4,2
        stw r9,0(r8)
#endif

        addis   r0,0,0

         /* invalidate all tlb's */

        tlbia
        isync

#if 1
        /* Reset the caches.
        */

        lis     r21, IDC_UNALL@h        /* Unlock all */
        mtspr   IC_CST, r21
        mtspr   DC_CST, r21

        lis     r21, IDC_INVALL@h       /* Invalidate all */
        mtspr   IC_CST, r21
        mtspr   DC_CST, r21

        lis     r21, IDC_DISABLE@h      /* Disable data cache */
        mtspr   DC_CST, r21

#if 0
        lis     r21, IDC_ENABLE@h       /* Enable instruction cache */
#else
        lis     r21, IDC_DISABLE@h      /* Disable instruction cache */
#endif
        mtspr   IC_CST, r21
#endif

        /* initialize some sprs that are hard to access from c */

        /* Disable serialized ifetch and show cycles (i.e. set processor
         * to normal mode).
         * this is also a silicon bug workaround, see errata
         */

        li      r21, 0x0007
        mtspr   ICTRL, r21

        /* Disable debug mode entry.
        */

        li      r21, 0
        mtspr   DER, r21

        /* position IMMR */

        lis     r1, IMMR_VALUE@h
        mtspr   638, r1

        /* set up the stack to the internal DPRAM */
/*      oris    r1,r0,0 */
        ori             r1,r1,0x3000
        /* load the stack pointer 72 bytes down from top of stack to
ensure one
         * stack frame of safety margin.
         */
        stwu    r0,-72(r1)

        /* let the c-code set up the rest */

        lis     r2,board_init@h
        ori     r2,r2,board_init@l
        mtlr    r2                   /* Easiest way to do an absolute
jump */

blr

        /* board_init will call start_main as the last thing it does. */

        .globl  start_main

start_main:

        /* Initialize stack pointer and jump to main function.
         * the c-code passed the stackpointer in r3 and the
         * argument to main in r4.
         */

        mr      r1, r3          /* first argument from c-code */
        mr      r3, r4          /* second argument to first */
        mr      r4, r5          /* third argument to second */
        bl      main_loop

1:      b       1b              /* Loop forever if main exits */


/*
 * This code finishes saving the registers to the exception frame
 * and jumps to the appropriate handler for the exception.
 * Register r21 is pointer into trap frame, r1 has new stack pointer.
 */
        .globl  transfer_to_handler
transfer_to_handler:
        stw     r22,_NIP(r21)
        lis     r22,MSR_POW@h
        andc    r23,r23,r22
        stw     r23,_MSR(r21)
        SAVE_GPR(7, r21)
        SAVE_4GPRS(8, r21)
        SAVE_8GPRS(12, r21)
        SAVE_8GPRS(24, r21)
#if 0
        andi.   r23,r23,MSR_PR
        mfspr   r23,SPRG3               /* if from user, fix up tss.regs
*/
        beq     2f
        addi    r24,r1,STACK_FRAME_OVERHEAD
        stw     r24,PT_REGS(r23)
2:      addi    r2,r23,-TSS             /* set r2 to current */
        tovirt(r2,r2,r23)
#endif
        mflr    r23
        andi.   r24,r23,0x3f00          /* get vector offset */
        stw     r24,TRAP(r21)
        li      r22,0
        stw     r22,RESULT(r21)
        mtspr   SPRG2,r22               /* r1 is now kernel sp */
#if 0
        addi    r24,r2,TASK_STRUCT_SIZE /* check for kernel stack
overflow */
        cmplw   0,r1,r2
        cmplw
1,r1,r24
        crand   1,1,4
        bgt     stack_ovf               /* if r2 < r1 <
r2+TASK_STRUCT_SIZE */
#endif
        lwz     r24,0(r23)              /* virtual address of handler */
        lwz     r23,4(r23)              /* where to go when done */
        mtspr   SRR0,r24
        mtspr   SRR1,r20
        mtlr    r23
        SYNC
        rfi                             /* jump to handler, enable MMU
*/

int_return:
        mfmsr   r30             /* Disable interrupts */
        li      r4,0
        ori     r4,r4,MSR_EE
        andc    r30,r30,r4
        SYNC                    /* Some chip revs need this... */
        mtmsr   r30
        SYNC
        lwz     r2,_CTR(r1)
        lwz     r0,_LINK(r1)
        mtctr   r2
        mtlr    r0
        lwz     r2,_XER(r1)
        lwz     r0,_CCR(r1)
        mtspr   XER,r2
        mtcrf   0xFF,r0
        REST_10GPRS(3, r1)
        REST_10GPRS(13, r1)
        REST_8GPRS(23, r1)
        REST_GPR(31, r1)
        lwz     r2,_NIP(r1)     /* Restore environment */
        lwz     r0,_MSR(r1)
        mtspr   SRR0,r2
        mtspr   SRR1,r0
        lwz     r0,GPR0(r1)
        lwz     r2,GPR2(r1)
        lwz     r1,GPR1(r1)
        SYNC
        rfi

/* Cache functions.
*/
        .globl  icache_enable
icache_enable:
        SYNC
        lis     r3, IDC_INVALL@h
        mtspr   IC_CST, r3
        lis     r3, IDC_ENABLE@h
        mtspr   IC_CST, r3
        blr

        .globl  icache_disable
icache_disable:
        SYNC
        lis     r3, IDC_DISABLE@h
        mtspr   IC_CST, r3
        blr

        .globl  dcache_enable
dcache_enable:
#if 0
        SYNC
#endif
#if 1
        lis     r3, 0x0400              /* Set cache mode with MMU off
*/
        mtspr   MD_CTR, r3
#endif

        lis     r3, IDC_INVALL@h
        mtspr   DC_CST, r3
#if 0
        lis     r3, DC_SFWT@h
        mtspr   DC_CST, r3
#endif
        lis     r3, IDC_ENABLE@h
        mtspr   DC_CST, r3
        blr

        .globl  dcache_disable
dcache_disable:
        SYNC
        lis     r3, IDC_DISABLE@h
        mtspr   DC_CST, r3
        lis     r3, IDC_INVALL@h
        mtspr   DC_CST, r3
        blr

        .globl  dc_stat
dc_stat:
        mfspr   r3, DC_CST
        blr

        .globl  dc_read
dc_read:
        mtspr   DC_ADR, r3
        mfspr   r3, DC_DAT
        blr

#if 1
        .globl  udelay
udelay:
        mulli   r4,r3,1000      /* nanoseconds */
        addi    r4,r4,59
        li      r5,60
        divw    r4,r4,r5        /* BUS ticks */
1:      mftbu   r5
        mftb
r6
        mftbu   r7
        cmp     0,r5,r7
        bne     1b              /* Get [synced] base time */
        addc    r9,r6,r4        /* Compute end time */
        addze   r8,r5
2:      mftbu   r5
        cmp     0,r5,r8
        blt     2b
        bgt     3f
        mftb    r6
        cmp     0,r6,r9
        blt     2b
3:      blr
#endif


        .globl  get_immr
get_immr:
        mfspr   r3, 638
        blr

        .globl get_pvr
get_pvr:
        mfspr   r3, PVR
        blr


        .globl wr_ic_cst
wr_ic_cst:
        mtspr   IC_CST, r3
        blr

        .globl rd_ic_cst
rd_ic_cst:
        mfspr   r3, IC_CST
        blr

        .globl wr_ic_adr
wr_ic_adr:
        mtspr   IC_ADR, r3
        blr


        .globl wr_dc_cst
wr_dc_cst:
        mtspr   DC_CST, r3
        blr

        .globl rd_dc_cst
rd_dc_cst:
        mfspr   r3, DC_CST
        blr

        .globl
wr_dc_adr
wr_dc_adr:
        mtspr   DC_ADR, r3
        blr

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
