Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 66014679E1
	for <linuxppc-dev@ozlabs.org>; Sat, 27 May 2006 21:34:20 +1000 (EST)
Date: Sat, 27 May 2006 13:34:13 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] force 64bit mode in system_reset_fwnmi for broken POWER4
	firmware
Message-ID: <20060527113412.GA31075@suse.de>
References: <20060522164111.GA14462@suse.de> <20060523130717.GA22364@suse.de>
	<17526.59069.781220.922878@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17526.59069.781220.922878@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, May 26, Paul Mackeras wrote:

> Olaf Hering writes:
> 
> > According to this change for EXCEPTION_PROLOG_COMMON, I get still into
> > decremeter_common, but its not fatal anymore because the cpu is now in
> > 64bit mode and the stack is forced to PACAKSAVE(r13).
> > 
> >         subi    r1,r1,INT_FRAME_SIZE;   /* alloc frame on kernel stack  */ \
> >         beq-    1f;                                                        \
> >         ld      r1,PACAKSAVE(r13);      /* kernel stack to use          */ \
> > -1:     cmpdi   cr1,r1,0;               /* check if r1 is in userspace  */ \
> > +1:                                     \
> > +       cmpdi   cr1,r29,0x42;           \
> 
> Ummm, what's r29 supposed to have in it here?
> 
> > +       bne     cr1,2f;                 \
> > +       li      r29,2f@l;               \
> 
> And why are we setting it?
> 
> Does it look like the SRR0 and SRR1 values are correct when we get
> this problem occurring?  Is it just the MSR that is bogus?

I looked into this again, my debug patch was wrong. I cant rely on the
hello32, r29 has to be set in the system_reset path. This is the
register dump. It shows that the cpus are in 32bit mode, and that
system_reset_fwnmi calls system_reset_common correctly.


0:mon> r
R00 = 000000001000036c   R16 = 0000000000000042
R01 = 00000000ffe96ad0   R17 = 0000000000000042
R02 = 000000001009b470   R18 = 0000000000000042
R03 = 0000000000000009   R19 = 0000000000000042
R04 = 000000001002228c   R20 = 0000000000000042
R05 = 0000000040042082   R21 = 0000000000000042
R06 = 0000000000004000   R22 = 0000000000000042
R07 = 0000000010008af0   R23 = 0000000000000042
R08 = 0000000000000000   R24 = 0000000000000042
R09 = 0000000000000000   R25 = 0000000000000042
R10 = 8000000000001032   R26 = 0000000000000042
R11 = 00000000ffe96a50   R27 = 0000000000000042
R12 = 0000000020000082   R28 = 0000000000000042
R13 = 000000001009a410   R29 = 0000000000003220
R14 = 0000000000000042   R30 = 0000000000001002
R15 = 0000000000000042   R31 = a000000000001032
pc  = 00000000100003b4
lr  = 000000001000036c
msr = 000000000000d032   cr  = 20000082
ctr = 0000000000032ddc   xer = 00000000000fffff   trap =  100
0:mon> c1
1:mon> r
R00 = 000000001000036c   R16 = 0000000000000042
R01 = 00000000ffe96ad0   R17 = 0000000000000042
R02 = 000000001009b470   R18 = 0000000000000042
R03 = 0000000000000007   R19 = 0000000000000042
R04 = 000000001002228c   R20 = 0000000000000042
R05 = 0000000040022082   R21 = 0000000000000042
R06 = 0000000000004000   R22 = 0000000000000042
R07 = 0000000010008af0   R23 = 0000000000000042
R08 = 0000000000000000   R24 = 0000000000000042
R09 = 0000000000000000   R25 = 0000000000000042
R10 = 8000000000001032   R26 = 0000000000000042
R11 = 00000000ffe96a50   R27 = 0000000000000042
R12 = 0000000020000082   R28 = 0000000000000042
R13 = 000000001009a410   R29 = 0000000000003220
R14 = 0000000000000042   R30 = 0000000000001002
R15 = 0000000000000042   R31 = a000000000001032
pc  = 00000000100003b4
lr  = 000000001000036c
msr = 000000000000d032   cr  = 20000082
ctr = 0000000000032ddc   xer = 00000000000fffff   trap =  100




Index: linux-2.6/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/head_64.S
+++ linux-2.6/arch/powerpc/kernel/head_64.S
@@ -211,6 +211,31 @@ exception_marker:
 	ori	reg,reg,(label)@l;	/* virt addr of handler ... */
 #endif
 
+#define EXCEPTION_PROLOG_PSERIES_BROKEN_POWER4_FIRMWARE(area, label)				\
+	mfspr	r13,SPRN_SPRG3;		/* get paca address into r13 */	\
+	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
+	std	r10,area+EX_R10(r13);					\
+	std	r11,area+EX_R11(r13);					\
+	std	r12,area+EX_R12(r13);					\
+	mfspr	r9,SPRN_SPRG1;						\
+	std	r9,area+EX_R13(r13);					\
+	mfcr	r9;							\
+	clrrdi	r12,r13,32;		/* get high part of &label */	\
+	mfmsr	r10;							\
+	mr	r30,r10;						\
+	li	r11,5;			/* MSR_SF_LG|MSR_ISF_LG */	\
+	rldicr	r11,r11,61,2;		/* (5 << 61) */	\
+	or	r10,r10,r11;						\
+	mfspr	r11,SPRN_SRR0;		/* save SRR0 */			\
+	LOAD_HANDLER(r12,label)						\
+	ori	r10,r10,MSR_IR|MSR_DR|MSR_RI;				\
+	mtspr	SPRN_SRR0,r12;						\
+	mfspr	r12,SPRN_SRR1;		/* and SRR1 */			\
+	mr	r31,r10;						\
+	mtspr	SPRN_SRR1,r10;						\
+	rfid;								\
+	b	.	/* prevent speculative execution */
+
 #define EXCEPTION_PROLOG_PSERIES(area, label)				\
 	mfspr	r13,SPRN_SPRG3;		/* get paca address into r13 */	\
 	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
@@ -269,7 +294,12 @@ exception_marker:
 	subi	r1,r1,INT_FRAME_SIZE;	/* alloc frame on kernel stack	*/ \
 	beq-	1f;							   \
 	ld	r1,PACAKSAVE(r13);	/* kernel stack to use		*/ \
-1:	cmpdi	cr1,r1,0;		/* check if r1 is in userspace	*/ \
+1:				\
+	cmpdi   cr1,r29,0x42;	\
+	bne     cr1,2f;		\
+	li      r29,2f@l;	\
+2: ;				\
+	cmpdi	cr1,r1,0;		/* check if r1 is in userspace	*/ \
 	bge-	cr1,bad_stack;		/* abort if it is		*/ \
 	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
 	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
@@ -600,14 +630,15 @@ slb_miss_user_pseries:
 system_reset_fwnmi:
 	HMT_MEDIUM
 	mtspr	SPRN_SPRG1,r13		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common)
+	li	r29,0x42
+	EXCEPTION_PROLOG_PSERIES_BROKEN_POWER4_FIRMWARE(PACA_EXGEN, system_reset_common)
 
 	.globl machine_check_fwnmi
       .align 7
 machine_check_fwnmi:
 	HMT_MEDIUM
 	mtspr	SPRN_SPRG1,r13		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common)
+	EXCEPTION_PROLOG_PSERIES_BROKEN_POWER4_FIRMWARE(PACA_EXMC, machine_check_common)
 
 #ifdef CONFIG_PPC_ISERIES
 /***  ISeries-LPAR interrupt handlers ***/
