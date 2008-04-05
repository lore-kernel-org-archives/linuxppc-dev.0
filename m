Return-Path: <dgaur@cdotd.ernet.in>
Received: from sandesh.cdotd.ernet.in (sandesh.cdotd.ernet.in [196.1.105.47])
	by ozlabs.org (Postfix) with ESMTP id 6C757DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Apr 2008 18:10:21 +1100 (EST)
Received: from sandesh.cdotd.ernet.in (localhost [127.0.0.1])
	by localhost.cdotd.ernet.in (Postfix) with ESMTP id 5ED51CFCFD
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Apr 2008 12:12:19 +0530 (IST)
Received: from mail1.cdotd.ernet.in (mail1.cdotd.ernet.in [196.1.105.196])by
	sandesh.cdotd.ernet.in (Postfix) with ESMTP id 3BECDCFAFDfor
	<linuxppc-embedded@ozlabs.org>; Sat,  5 Apr 2008 12:12:19 +0530 (IST)
Received: from cdotd.ernet.in (localhost.localdomain [127.0.0.1])by
	mail1.cdotd.ernet.in (8.12.5/8.12.5) with ESMTP id m356nf9Q021432for
	<linuxppc-embedded@ozlabs.org>; Sat, 5 Apr 2008 12:19:41 +0530
From: "Deepak Gaur" <dgaur@cdotd.ernet.in>
To: linuxppc-embedded@ozlabs.org
Subject: Booting Linux Kernel on MPC8560
Date: Sat, 5 Apr 2008 13:19:41 +0630
Message-Id: <20080405063151.M54613@cdotd.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have a task to boot Mvista kernel on MPC8560 based board. The bootloader in U-boot.
After decompression my final image is located at address 0x1fff0040 in SDRAM (starts
from 0) CCSRBAR register value is 0x000A0000 Bd_t is located at 0x7FFEA0 cmd line :
cmd_start 0x7FFF00 cmd_end 0x800D01 in SDRAM. After the u-boot transfers the control to
kernel it starts executing head_fsl_booke.S file . The execution get struck after
executing a few lines ... on a rfi instruction 
---------------------------------------------------------------------------
head_fsl_booke.S  First instruction("nop") at 0x1FFF0040 (SDRAM)
---------------------------------------------------------------------------
#include <linux/config.h>
#include <linux/threads.h>
#include <asm/processor.h>
#include <asm/page.h>
#include <asm/mmu.h>
#include <asm/pgtable.h>
#include <asm/cputable.h>
#include <asm/thread_info.h>
#include <asm/ppc_asm.h>
#include <asm/offsets.h>
#include "head_booke.h"

/* As with the other PowerPC ports, it is expected that when code
 * execution begins here, the following registers contain valid, yet
 * optional, information:
 *
 *   r3 - Board info structure pointer (DRAM, frequency, MAC address, etc.)
 *   r4 - Starting address of the init RAM disk
 *   r5 - Ending address of the init RAM disk
 *   r6 - Start of kernel command line string (e.g. "mem=128")
 *   r7 - End of kernel command line string
 *
 */
        .text
_GLOBAL(_stext)
_GLOBAL(_start)
        /*
         * Reserve a word at a fixed location to store the address
         * of abatron_pteptrs
         */
SD:0x1fff0040:        nop
/*
 * Save parameters we are passed
 */
        mr      r31,r3
        mr      r30,r4
        mr      r29,r5
        mr      r28,r6
        mr      r27,r7
                                                                                       
                           li      r24,0           /* CPU number */

/* We try to not make any assumptions about how the boot loader
 * setup or used the TLBs.  We invalidate all mappings from the
 * boot loader and load a single entry in TLB1[0] to map the
 * first 16M of kernel memory.  Any boot info passed from the
 * bootloader needs to live in this first 16M.
 *
 * Requirement on bootloader:
 *  - The page we're executing in needs to reside in TLB1 and
 *    have IPROT=1.  If not an invalidate broadcast could
 *    evict the entry we're currently executing in.
 *
 *  r3 = Index of TLB1 were executing in
 *  r4 = Current MSR[IS]
 *  r5 = Index of TLB1 temp mapping
 *
 * Later in mapin_ram we will correctly map lowmem, and resize TLB1[0]
 * if needed
 */

/* 1. Find the index of the entry we're executing in */
        bl      invstr                          /* Find our address */
invstr: mflr    r6                              /* Make it accessible */
        mfmsr   r7
        rlwinm  r4,r7,27,31,31                  /* extract MSR[IS] */
        mfspr   r7, SPRN_PID0
        slwi    r7,r7,16
        or      r7,r7,r4
        mtspr   SPRN_MAS6,r7
        tlbsx   0,r6                            /* search MSR[IS], SPID=PID0 */
#ifndef CONFIG_E200
 mfspr   r7,SPRN_MAS1
        andis.  r7,r7,MAS1_VALID@h
        bne     match_TLB
        mfspr   r7,SPRN_PID1
        slwi    r7,r7,16
        or      r7,r7,r4
        mtspr   SPRN_MAS6,r7
        tlbsx   0,r6                            /* search MSR[IS], SPID=PID1 */
        mfspr   r7,SPRN_MAS1
        andis.  r7,r7,MAS1_VALID@h
        bne     match_TLB
        mfspr   r7, SPRN_PID2
        slwi    r7,r7,16
        or      r7,r7,r4
        mtspr   SPRN_MAS6,r7
        tlbsx   0,r6                            /* Fall through, we had to match */
#endif
match_TLB:
        mfspr   r7,SPRN_MAS0
        rlwinm  r3,r7,16,20,31                  /* Extract MAS0(Entry) */

        mfspr   r7,SPRN_MAS1                    /* Insure IPROT set */
        oris    r7,r7,MAS1_IPROT@h
        mtspr   SPRN_MAS1,r7
        tlbwe

/* 2. Invalidate all entries except the entry we're executing in */
        mfspr   r9,SPRN_TLB1CFG
        andi.   r9,r9,0xfff
        li      r6,0                            /* Set Entry counter to 0 */
1:      lis     r7,0x1000                       /* Set MAS0(TLBSEL) = 1 */
        rlwimi  r7,r6,16,4,15                   /* Setup MAS0 = TLBSEL | ESEL(r6) */
        mtspr   SPRN_MAS0,r7
        tlbre
        mfspr   r7,SPRN_MAS1
        rlwinm  r7,r7,0,2,31                    /* Clear MAS1 Valid and IPROT */
        cmpw    r3,r6
        beq     skpinv                          /* Dont update the current execution TLB */
        mtspr   SPRN_MAS1,r7
  tlbwe
        isync
skpinv: addi    r6,r6,1                         /* Increment */
        cmpw    r6,r9                           /* Are we done? */
        bne     1b                              /* If not, repeat */

        /* Invalidate TLB0 */
        li      r6,0x04
        tlbivax 0,r6
#ifdef CONFIG_SMP
        tlbsync
#endif
        /* Invalidate TLB1 */
        li      r6,0x0c
        tlbivax 0,r6
#ifdef CONFIG_SMP
        tlbsync
#endif
        msync

/* 3. Setup a temp mapping and jump to it */
        andi.   r5, r3, 0x1     /* Find an entry not used and is non-zero */
        addi    r5, r5, 0x1
        lis     r7,0x1000       /* Set MAS0(TLBSEL) = 1 */
        rlwimi  r7,r3,16,4,15   /* Setup MAS0 = TLBSEL | ESEL(r3) */
        mtspr   SPRN_MAS0,r7
        tlbre

        /* Just modify the entry ID and EPN for the temp mapping */
        lis     r7,0x1000       /* Set MAS0(TLBSEL) = 1 */
        rlwimi  r7,r5,16,4,15   /* Setup MAS0 = TLBSEL | ESEL(r5) */
        mtspr   SPRN_MAS0,r7
        xori    r6,r4,1         /* Setup TMP mapping in the other Address space */
        slwi    r6,r6,12
        oris    r6,r6,(MAS1_VALID|MAS1_IPROT)@h
        ori     r6,r6,(MAS1_TSIZE(BOOKE_PAGESZ_4K))@l
        mtspr   SPRN_MAS1,r6
        mfspr   r6,SPRN_MAS2
        li      r7,0            /* temp EPN = 0 */
    rlwimi  r7,r6,0,20,31
        mtspr   SPRN_MAS2,r7
        tlbwe

        xori    r6,r4,1
        slwi    r6,r6,5         /* setup new context with other address space */
        bl      1f              /* Find our address */
1:      mflr    r9
        rlwimi  r7,r9,0,20,31
        addi    r7,r7,24
        mtspr   SRR0,r7     <------------------------ SRR0 1A40
        mtspr   SRR1,r6     <------------------------ SRR1 20
        rfi                 <------------------------ It goes to LOCATION 0x00001A40

/* 4. Clear out PIDs & Search info */
SD: 0x1fff01A40        li      r6,0
                       mtspr   SPRN_PID0,r6

SD memory locattion as reported by ICE

The SRR0 contains 0x00001A40 address for rfi. The memory location of next instruction
happens to be similar to contents of SRR0 . It is 0x1fff01a40. It is that the SRR0
should have contained 0x1fff01A40 or 0x00001A40 is correct. Actually on 0x00001A40 there
 no instruction is defined (as reported by ICE it is "undef")

Please help me in understanding this behaviour and more specifically need of "rfi"
instruction in this file.

Thanks

Deepak Gaur
