Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E9DA67B87
	for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2006 23:07:23 +1000 (EST)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 992811EBC1
	for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2006 15:07:17 +0200 (CEST)
Date: Tue, 23 May 2006 15:07:17 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] force 64bit mode in system_reset_fwnmi for broken POWER4
	firmware
Message-ID: <20060523130717.GA22364@suse.de>
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

> NIP [0000000000003200] 0x3200
> LR [0000000010000338] 0x10000338

The reason is that system_reset_fwnmi is called in 32bit mode. Forcing
64bit mode fixes the corrupt NIP for me. JS20 and p690 are affected,
seems to work on p550 and JS21.

According to this change for EXCEPTION_PROLOG_COMMON, I get still into
decremeter_common, but its not fatal anymore because the cpu is now in
64bit mode and the stack is forced to PACAKSAVE(r13).

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




Index: linux-2.6/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/head_64.S
+++ linux-2.6/arch/powerpc/kernel/head_64.S
@@ -211,6 +211,29 @@ exception_marker:
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
+	li	r11,5;			/* MSR_SF_LG|MSR_ISF_LG */	\
+	rldicr	r11,r11,61,2;		/* (5 << 61) */	\
+	or	r10,r10,r11;						\
+	mfspr	r11,SPRN_SRR0;		/* save SRR0 */			\
+	LOAD_HANDLER(r12,label)						\
+	ori	r10,r10,MSR_IR|MSR_DR|MSR_RI;				\
+	mtspr	SPRN_SRR0,r12;						\
+	mfspr	r12,SPRN_SRR1;		/* and SRR1 */			\
+	mtspr	SPRN_SRR1,r10;						\
+	rfid;								\
+	b	.	/* prevent speculative execution */
+
 #define EXCEPTION_PROLOG_PSERIES(area, label)				\
 	mfspr	r13,SPRN_SPRG3;		/* get paca address into r13 */	\
 	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
@@ -600,14 +623,14 @@ slb_miss_user_pseries:
 system_reset_fwnmi:
 	HMT_MEDIUM
 	mtspr	SPRN_SPRG1,r13		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common)
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
