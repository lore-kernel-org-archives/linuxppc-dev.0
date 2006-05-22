Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26912679E2
	for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2006 04:46:18 +1000 (EST)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 73212EFF9
	for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2006 20:46:13 +0200 (CEST)
Date: Mon, 22 May 2006 20:46:12 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: pseries softreset on cpus in 32bit mode
Message-ID: <20060522184612.GA15282@suse.de>
References: <20060522164111.GA14462@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060522164111.GA14462@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, May 22, Olaf Hering wrote:

> 
> Consider a simple app like this, which is placed as '/init' in an initrd
> cpio archive:
> 
> hello32.c
> 
> #include <stdio.h>                                                                                                              
> int main(void) {
>         printf("foobar\n");
>         asm("li 31,0; b .\n");
>         return 0;
> }

Modified the userland app to init some registers with a fixed value, and
ran a kernel with the debug patch below. It gets into bad_stack from
decrementer_common = c000000000003400. 3200 is coming from 
c000000000003200 <system_reset_common>:

So what does that mean? Should a softreset disable interrupts?

Linux version 2.6.17-rc4-g353b28ba-dirty (olaf@pomegranate) (gcc version 4.1.0 (SUSE Linux)) #13 SMP Mon May 22 20:38:56 CEST 2006
[boot]0012 Setup Arch
Top of RAM: 0x1e000000, Total RAM: 0x1e000000
Memory hole size: 0MB
PPC64 nvram contains 16384 bytes
Using default idle loop
[boot]0015 Setup Done
Built 1 zonelists
Kernel command line:  root=/dev/hda2  xmon=on quiet
foobar
Bad kernel stack pointer ffad3ad0 at 3200
cpu 0x1: Vector: c000000007a5ef10  at [c000000007a5ed40]
    pc: 0000000000003200
    lr: 0000000010000338
    sp: ffad3ad0
   msr: 40001032
  current = 0xc00000000ffc67e0
  paca    = 0xc00000000053a100
    pid   = 1, comm = init
enter ? for help
1:mon> r
R00 = 0000000010000338   R16 = c0000000004470e8
R01 = 00000000ffad3ad0   R17 = 0000000000000000
R02 = 000000001009c470   R18 = 00000000000413cd
R03 = 0000000007aceff8   R19 = 0000000000507ab8
R04 = 000000001002489c   R20 = 0000000000000042
R05 = 0000000040000042   R21 = 0000000000000042
R06 = 0000000000004000   R22 = 0000000000000042
R07 = 000000001000b100   R23 = 0000000000000042
R08 = 000000000000f932   R24 = 0000000000000042
R09 = 0000000000000000   R25 = 0000000000000042
R10 = 0000000000000000   R26 = 0000000000000042
R11 = 0000000000000000   R27 = 0000000000000042
R12 = 00000000200fffff   R28 = 0000000000000042
R13 = c00000000053a100   R29 = 0000000000003420
R14 = c000000000448a38   R30 = 0000000000003200
R15 = 4000000002010000   R31 = 0000000010000368
pc  = 0000000000003200
lr  = 0000000010000338
msr = 0000000040001032   cr  = 20000042
ctr = 0000000000032ddc   xer = 00000000200fffff   trap = c000000007a5ef10
1:mon> 


Index: linux-2.6/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/head_64.S
+++ linux-2.6/arch/powerpc/kernel/head_64.S
@@ -269,7 +269,12 @@ exception_marker:
        subi    r1,r1,INT_FRAME_SIZE;   /* alloc frame on kernel stack  */ \
        beq-    1f;                                                        \
        ld      r1,PACAKSAVE(r13);      /* kernel stack to use          */ \
-1:     cmpdi   cr1,r1,0;               /* check if r1 is in userspace  */ \
+1:                                     \
+       cmpdi   cr1,r29,0x42;           \
+       bne     cr1,2f;                 \
+       li      r29,2f@l;               \
+2:                                     \
+       cmpdi   cr1,r1,0;               /* check if r1 is in userspace  */ \
        bge-    cr1,bad_stack;          /* abort if it is               */ \
        std     r9,_CCR(r1);            /* save CR in stackframe        */ \
        std     r11,_NIP(r1);           /* save SRR0 in stackframe      */ \
@@ -600,6 +605,7 @@ slb_miss_user_pseries:
 system_reset_fwnmi:
        HMT_MEDIUM
        mtspr   SPRN_SPRG1,r13          /* save r13 */
+       mfspr   r31,SPRN_SRR0
        EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common)
 
        .globl machine_check_fwnmi
@@ -842,6 +848,7 @@ bad_stack:
        std     r9,_CCR(r1)
        std     r10,GPR1(r1)
        std     r11,_NIP(r1)
+       mr      r30,r11
        std     r12,_MSR(r1)
        mfspr   r11,SPRN_DAR
        mfspr   r12,SPRN_DSISR
