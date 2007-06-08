Return-Path: <b_kisku@yahoo.co.in>
Received: from web8508.mail.in.yahoo.com (web8508.mail.in.yahoo.com
	[202.43.219.170]) by ozlabs.org (Postfix) with SMTP id 929CADDEDB
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 20:55:07 +1000 (EST)
Date: Fri, 8 Jun 2007 11:48:24 +0100 (BST)
From: Barisa kisku <b_kisku@yahoo.co.in>
Subject: porting problem  for  MPC860
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <586758.72444.qm@web8508.mail.in.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am new to embedded system.And i am trying port
linux-2.6.20 in a custom board to learn about 
porting and Linux OS.

I have used following version of various codes.

U-Boot  : 1.1.6
Linux   : 2.6.20
cross-compiler - gcc-4.1.1

System  details :
      custom board(near to MBX board)
      MPC860 processor
      4MB Flash
      8MB  SRAM
Kernel image(uIamge) at moment compiled for default
MBX configuration.

Linux kernel(uImage) is loaded by U-Boot on SRAM.Then
we tried to boot linux using BOOTM command.Then we
tried to see the flow execution by using Emulator.

Following piece of codes is from
arch/ppc/kernel/head_8xx.S file.
-------------------------------------------------- 
      
.globl  __start
__start:
        mr      r31,r3 /* save parameters */
        mr      r30,r4
        mr      r29,r5
        mr      r28,r6
        mr      r27,r7
      /* We have to turn on the MMU right away 
          so we get cache modes 
         * set correctly.
         */
        bl      initial_mmu
        
       :
       :
       :

turn_on_mmu:
        mfmsr   r0
        ori     r0,r0,MSR_DR|MSR_IR
        mtspr   SPRN_SRR1,r0
        sync
        isync
        :
        :

initial_mmu:
        tlbia    /* Invalidate all TLB entries */
#ifdef CONFIG_PIN_TLB
        lis     r8, MI_RSV4I@h
        ori     r8, r8, 0x1c00
#else
        li      r8, 0
#endif
        mtspr   SPRN_MI_CTR, r8 /* Set instruction MMU
control */

#ifdef CONFIG_PIN_TLB
        lis     r10, (MD_RSV4I | MD_RESETVAL)@h
        ori     r10, r10, 0x1c00
        mr      r8, r10
#else
        lis     r10, MD_RESETVAL@h
#endif
#ifndef CONFIG_8xx_COPYBACK
        oris    r10, r10, MD_WTDEF@h
       mtspr   SPRN_MD_CTR, r10 /* set data TLB
control */

        /* Now map the lower 8 Meg into the TLBs.  For
this quick hack,
         * we can load the instruction and data TLB
registers with the
         * same values.
         */
        lis     r8, KERNELBASE@h /* Create vaddr for
TLB */
        ori     r8, r8, MI_EVALID /* Mark it valid */
        mtspr   SPRN_MI_EPN, r8
        mtspr   SPRN_MD_EPN, r8
        li      r8, MI_PS8MEG /* Set 8M byte page */
        ori     r8, r8, MI_SVALID /* Make it valid */
        mtspr   SPRN_MI_TWC, r8
        mtspr   SPRN_MD_TWC, r8
        li      r8, MI_BOOTINIT /* Create RPN for
address 0 */
        mtspr   SPRN_MI_RPN, r8   /* Store TLB entry
*/
     mtspr   SPRN_MD_RPN, r8
        lis     r8, MI_Kp@h /* Set the protection mode
*/
        mtspr   SPRN_MI_AP, r8
        mtspr   SPRN_MD_AP, r8

  /* Map another 8 MByte at the IMMR to get the  
processor 
         * internal registers (among other things).
         */
#ifdef CONFIG_PIN_TLB
        addi    r10, r10, 0x0100
        mtspr   SPRN_MD_CTR, r10
#endif
        mfspr   r9, 638   /* Get current IMMR */
        andis.  r9, r9, 0xff80 /* Get 8Mbyte boundary
*/

        mr      r8, r9 /* Create vaddr for TLB */
        ori     r8, r8, MD_EVALID /* Mark it valid */
        mtspr   SPRN_MD_EPN, r8
        li      r8, MD_PS8MEG  /* Set 8M byte page */
        ori     r8, r8, MD_SVALID   /* Make it valid
*/
***********----------------**************************
        UPTO THIS POINT ALL THE REGISTER/SPECIAL
REGISTER(SPR) ARE GETTING UPDATED BY THE DESIRED
VALUE.

BUT FOLLOWING STATEMENTS ARE NOT WORKING PROPERLY.
 ***************-----------------------------------***
        mtspr   SPRN_MD_TWC, r8
        mr      r8, r9     /* Create paddr for TLB */
        ori     r8, r8, MI_BOOTINIT|0x2 /* Inhibit
cache -- Cort */
        mtspr   SPRN_MD_RPN, r8
           :
           :
           :

 HASHDEFS are as follows :
 MD_PS8MEG --0x0000000c
 MD_EVALID --0x00000200
 MD_SVALID --0x00000001
KERNELBASE --0xc0000000
MI_BOOTINIT --0x000001fd
MI_EVALID ----0x00000200
MI_SVALID ----0x00000001
MI_Kp -------0x40000000
MD_RESETVAL---0x04000000

CONFIG_PIN_TLB is not defined for my configuration 
CONFIG_8xx_COPYBACK is definedfor my configuration.

Please help me in finding out the problem 

And same board is working with other OS(e.g ECOS)
ported by other person.


thanks,
Barisa Kisku

       


      Looking for people who are YOUR TYPE? Find them at in.groups.yahoo.com
