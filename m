Message-Id: <A3E34B558F5CD211B4980008C7A4A99003163D3C@sparrow.eng.gilbarco.com>
From: "Williams, Kevin M." <kevin.m.williams@marconi.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Another question on the initialization of MMU on 860
Date: Mon, 5 Feb 2001 09:56:25 -0500 
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am having a similar problem on a custom 860 board. I do not think it is
exactly the same, but my system is hanging in the same place on the serial
output.  Here is my problem:

I can build and run our 2.2.13 version of the kernel on this hardware
without a problem.  I ported our custom 2.2.13 modifications to 2.4.0.  When
I boot 2.4.0, I get:

loaded at:     FFC20000 FFC2E580
relocated to:  00400000 0040E580
board data at: 004001C4 004001E0
relocated to:  00200100 0020011C
zimage at:     FFC2D000 FFCB103A
avail ram:     00201000 01000000

Linux/PPC load:
Uncompressing Linux...
Now booting the kernel

And then nothing.  When I hook up my VisionICE debugger, it runs and never
gives me an error, but when I stop running or take a snapshot of the code
once it's locked up, I get:

>BKM>.DR PC;
C000A1B0
>BKM>DI0 C000A1B0 28
!BREAK! - BUS ERROR
  Addres of Bus error =C000A1B0
>BKM>.DR GPR;
GPR register Group.(GPR)
C00021F4 C0154B70 C0153000 C0154B80 C000A1B0 40001032 151000 F C0151000 0
F80 0 C0181EFC FF000936 FFFFF004 910000 910000 910000 910000 910000

I can see from the debugger that MSR[IR] and MSR[DR] are set, so address
translation is enabled, but I'm not real clear on the details of the TLB's
or what Linux is trying to do at this point.

>From system.map I see that address C000A1B0 is the 'do_page_fault' function.
In the documentation folder "exceptions.txt" tells me this function gets
called "whenever the kernel tries to access an address that is currently not
accessible".  I started to read through the MMU and TLB documentation for
the PPC, but I've seen a couple posts stating that the MMU code works fine.
Since there is not an MMU problem, what else could be happening that makes
this memory not accessible?  It looks like the kernel never gets past
arch/ppc/kernel/head_8xx.s.

I am new to Linux and this is my first post. Any help is greatly
appreciated.

Kevin Williams


-----Original Message-----
From: Borlizzi Giacomo [mailto:giacomo.borlizzi@tei.ericsson.se]
Sent: Friday, February 02, 2001 5:03 AM
To: linuxppc-embedded@lists.linuxppc.org; Giacomo Borlizzi (TEI)
Subject: The initialization of MMU on 860



.. and now using the linux-2.4.1 I see on my vt100:

=>  go 830000
## Starting application at 0x00830000 ...
loaded at:     00830000 0083B1D4
relocated to:  00180000 0018B1D4
board data at: 001801B8 001801D4
relocated to:  00820100 0082011C
zimage at:     00836000 008AE0E1
initrd at:     008AE0E1 00A84F1E
avail ram:     00A85000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel


:((((


and on the emulator:

>RUN>
!ERROR! - Unexpected Exception(s) Taken at 00001228
Exception(s) Reported are (ECR) : Machine Check,
Current Address Pointer (SRR0)  : 00001228
Machine State Register (MSR)    : 00001000
Data Address Register (DAR)     : 040003FC
Data Interrupt Register (DSISR) : 000002B4
Break Address Register (BAR)    : 00000000
Interrupt Cause Register (ICR)  : 10201000
PPC Instruction at    $00001228 : 0x82B40000 :ppc LWZ
R21,0x0000(R20)
>BKM>

>BKM>dr
 R00     = 00000300 R01     = C0116E10 R02     = 3FFFFDA8 R03     =
C0116ED0
 R04     = C0820100 R05     = 0000A4A3 R06     = 00820000 R07     =
0082000D
 R08     = C014D88C R09     = C0140000 R10     = 00000000 R11     =
00008624
 R12     = 00000005 R13     = 00000000 R14     = 00FDB200 R15     =
010C0000
 R16     = 00000000 R17     = 00000000 R18     = 00000000 R19     =
00000000
 R20     = 040003FC R21     = 00000000 R22     = 00000000 R23     =
C0002838
 R24     = C000A44C R25     = 00F9FC70 R26     = 00030000 R27     =
C0116ED0
 R28     = C0820100 R29     = 008AE0E1 R30     = 0000A4A3 R31     =
0082000D
 CR      = 35005009 MSR     = 00001000 LR      = C0002838 SRR0    =
00001228
 SRR1    = 00001000 SPRG0   = 00000000 SPRG1   = 001801B8 SPRG2   =
00000000
 SPRG3   = 80000000 XER     = 80000000 CTR     = 00000000 PC      =
00001228
>BKM>

>BKM>dr mmu
MMU register Group. (MMU)
 MICTR   = 00001F00 MIAP    = 40000000 MIEPN   = C0000200 MITWC   =
0000000D
 MIRPN   = 000001FD MIDCAM  = 4082140E MIDRAM0 = 00000EFF MIDRAM1 =
00000002
 MDCTR   = 14001E00 MCASID  = 00000000 MDAP    = 40000000 MDEPN   =
3FFFFE00
 MTWB    = 040003FC MDTWC   = 00000FFC MDRPN   = 220001FF MTW     =
00001032
 MDDCAM  = 00320020 MDDRAM0 = EF104A0D MDDRAM1 = EF104A0D
>BKM>

Then after some investigation I discovered that the MTWB (the tablewalk
M_TWB) register
was not initialized by the kernel startup process, and when a data table
miss occurs the
related interrupt routine crashes due to an access to an illegal
address.

Now I'll try to investigating where is the initialization value.... but
if there is
a fast response about it I'll very apprecciate.

This is the initialiazation code of kernel....


 .globl __start
__start:
 mr r31,r3   /* save parameters */
 mr r30,r4
 mr r29,r5
 mr r28,r6
 mr r27,r7
 li r24,0   /* cpu # */

 tlbia   /* Invalidate all TLB entries */
 li r8, 0
 mtspr MI_CTR, r8 /* Set instruction control to zero */
 lis r8, MD_RESETVAL@h
#ifndef CONFIG_8xx_COPYBACK
 oris r8, r8, MD_WTDEF@h
#endif
 mtspr MD_CTR, r8 /* Set data TLB control */

 /* Now map the lower 8 Meg into the TLBs.  For this quick hack,
  * we can load the instruction and data TLB registers with the
  * same values.
  */
 lis r8, KERNELBASE@h /* Create vaddr for TLB */
 ori r8, r8, MI_EVALID /* Mark it valid */
 mtspr MI_EPN, r8
 mtspr MD_EPN, r8
 li r8, MI_PS8MEG  /* Set 8M byte page */
 ori r8, r8, MI_SVALID /* Make it valid */
 mtspr MI_TWC, r8
 mtspr MD_TWC, r8
 li r8, MI_BOOTINIT  /* Create RPN for address 0 */
 mtspr MI_RPN, r8  /* Store TLB entry */
 mtspr MD_RPN, r8
 lis r8, MI_Kp@h  /* Set the protection mode */
 mtspr MI_AP, r8
 mtspr MD_AP, r8

 /* Map another 8 MByte at the IMMR to get the processor
  * internal registers (among other things).
  */
 mfspr r9, 638   /* Get current IMMR */
 andis. r9, r9, 0xff80  /* Get 8Mbyte boundary */

 mr r8, r9   /* Create vaddr for TLB */
 ori r8, r8, MD_EVALID /* Mark it valid */
 mtspr MD_EPN, r8
 li r8, MD_PS8MEG  /* Set 8M byte page */
 ori r8, r8, MD_SVALID /* Make it valid */
 mtspr MD_TWC, r8
 mr r8, r9   /* Create paddr for TLB */
 ori r8, r8, MI_BOOTINIT|0x2 /* Inhibit cache -- Cort */
 mtspr MD_RPN, r8

 /* Since the cache is enabled according to the information we
  * just loaded into the TLB, invalidate and enable the caches here.
  * We should probably check/set other modes....later.
  */
 lis r8, IDC_INVALL@h
 mtspr IC_CST, r8
 mtspr DC_CST, r8
 lis r8, IDC_ENABLE@h
 mtspr IC_CST, r8
#ifdef CONFIG_8xx_COPYBACK
 mtspr DC_CST, r8
#else
 /* For a debug option, I left this here to easily enable
  * the write through cache mode
  */
 lis r8, DC_SFWT@h
 mtspr DC_CST, r8
 lis r8, IDC_ENABLE@h
 mtspr DC_CST, r8
#endif

/* We now have the lower 8 Meg mapped into TLB entries, and the caches
 * ready to work.
 */

turn_on_mmu:
 mfmsr r0
 ori r0,r0,MSR_DR|MSR_IR
 mtspr SRR1,r0
 lis r0,start_here@h
 ori r0,r0,start_here@l
 mtspr SRR0,r0
 SYNC
 rfi    /* enables MMU */

........
......
.......

this is the interrupt routine


 . = 0x1200
DataStoreTLBMiss:
#ifdef CONFIG_8xx_CPU6
 stw r3, 8(r0)
 li r3, 0x3f80
 stw r3, 12(r0)
 lwz r3, 12(r0)
#endif
 mtspr M_TW, r20 /* Save a couple of working registers */
 mfcr r20
 stw r20, 0(r0)
 stw r21, 4(r0)
 mfspr r20, M_TWB /* Get level 1 table entry address */

 /* If we are faulting a kernel address, we have to use the
  * kernel page tables.
  */
 andi. r21, r20, 0x0800
 beq 3f
 lis r21, swapper_pg_dir@h
 ori r21, r21, swapper_pg_dir@l
 rlwimi r20, r21, 0, 2, 19
3:
 lwz r21, 0(r20) /* Get the level 1 entry */            <<------ the
crash point !!!!!!!
 rlwinm. r20, r21,0,0,19 /* Extract page descriptor page address */
 beq 2f  /* If zero, don't try to find a pte */

 /* We have a pte table, so load fetch the pte from the table.
  */
 tophys(r21, r21)
 ori r21, r21, 1 /* Set valid bit in physical L2 page */
#ifdef CONFIG_8xx_CPU6
 li r3, 0x3b80
 stw r3, 12(r0)
 lwz r3, 12(r0)
#endif
 mtspr MD_TWC, r21 /* Load pte table base address */
 mfspr r20, MD_TWC /* ....and get the pte address */
 lwz r20, 0(r20) /* Get the pte */
.......
......

ciao,
/Giacomo Borlizzi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
