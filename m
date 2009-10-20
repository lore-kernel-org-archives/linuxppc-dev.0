Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr7.xs4all.nl (smtp-vbr7.xs4all.nl [194.109.24.27])
	by ozlabs.org (Postfix) with ESMTP id A596EB7B8F
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 01:20:26 +1100 (EST)
Received: from mail3.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id n9KEKNij020433
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Oct 2009 16:20:24 +0200 (CEST)
	(envelope-from nvbolhuis@aimvalley.nl)
Message-ID: <4ADDC726.1000002@aimvalley.nl>
Date: Tue, 20 Oct 2009 16:20:22 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org >> \"linuxppc-dev@ozlabs.org\""
	<linuxppc-dev@ozlabs.org>
Subject: bus error exception handler not working
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


reading a bogus address in u-boot gives:

=> md 0x88000000
88000000:Machine check in kernel mode.
Caused by (from msr): regs 0ff0ec28 Unknown values in msr
NIP: 0000111C XER: 2000005F LR: 0FFDB104 REGS: 0ff0ec28 TRAP: 0200 DAR: 00000000
MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00

GPR00: 0FFDB104 0FF0ED18 0FF0EF48 0FFE9DAC 00000002 00000010 FFFFFFFF 00000030
GPR08: 00000001 00000020 00000000 00000009 0FF0E828 1001910C 0FFF9000 0FFE9E10
GPR16: 0FFE9DAC 0FFEADF8 0FFEADF0 0FFEDCE4 48024028 8800002B 88000000 88000000
GPR24: 0FF0ED20 00000040 00000000 00000004 0FF0ED20 00000004 0FFFA650 88000000
Call backtrace:
0FFDB104 0FFC67B4 0FFCF668 0FFCED70 0FFCEEE0 0FFD1AA8 0FFB5FF4
0FFB2644
machine check
Resetting the board.


U-Boot 2008.10 (Oct 16 2009 - 14:57:46) MPC83XX, version=0x00910161

Reset Status: Software Hard, External/Internal Soft, External/Internal Hard



doing the same in linux kernel gives an immediate reboot (checkstop):


# readmm 32 88000000 1

U-Boot 2008.10 (Oct 16 2009 - 14:57:46) MPC83XX, version=0x00910161

Reset Status: Check Stop, External/Internal Soft, External/Internal Hard




We're using an MPC8313E on a custom board (similar to MPC8313E-RDB) with
U-Boot v2008.10 and linux 2.6.28.

The problem is that the linux kernel exception handler (arch/powerpc/kernel/head_32.S)
doesn't work. It looks like this:


         . = 0x200
0x200   mtspr   SPRN_SPRG0,r10
         mtspr   SPRN_SPRG1,r11
         mfcr    r10

#define EXCEPTION_PROLOG_1      \
0x20c   mfspr   r11,SPRN_SRR1;          /* check whether user or kernel */ \
         andi.   r11,r11,MSR_PR; \
         tophys(r11,r1);                 /* use tophys(r1) if kernel */ \
         beq     1f;             \
         mfspr   r11,SPRN_SPRG3; \
         lwz     r11,THREAD_INFO-THREAD(r11);    \
         addi    r11,r11,THREAD_SIZE;    \
         tophys(r11,r11);        \
1:      subi    r11,r11,INT_FRAME_SIZE  /* alloc exc. frame */


#define EXCEPTION_PROLOG_2      \
         CLR_TOP32(r11);         \
0x230   stw     r10,_CCR(r11);          /* save registers */ \
         stw     r12,GPR12(r11); \
         stw     r9,GPR9(r11);   \
         mfspr   r10,SPRN_SPRG0; \
         stw     r10,GPR10(r11); \
         mfspr   r12,SPRN_SPRG1; \
         stw     r12,GPR11(r11); \
         mflr    r10;            \
         stw     r10,_LINK(r11); \
         mfspr   r12,SPRN_SRR0;  \
         mfspr   r9,SPRN_SRR1;   \
         stw     r1,GPR1(r11);   \
         stw     r1,0(r11);      \
         tovirt(r1,r11);                 /* set new kernel sp */ \
         li      r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
         MTMSRD(r10);                    /* (except for mach check in rtas) */ \
         stw     r0,GPR0(r11);   \
         lis     r10,STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
0x278   addi    r10,r10,STACK_FRAME_REGS_MARKER@l; \
         stw     r10,8(r11);     \
         SAVE_4GPRS(3, r11);     \
         SAVE_2GPRS(7, r11)

0x298   addi    r3,r1,STACK_FRAME_OVERHEAD

         EXC_XFER_STD(0x200, machine_check_exception)
0x29c	li r10,trap
	...
	bl machine_check_exception



somehow machine_check_exception isn't reached. can anyone tell me why ?
is there something wrong with EXCEPTION_PROLOG_1/EXCEPTION_PROLOG_2 ?
