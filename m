Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 49AE267BAA
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 18:34:10 +1000 (EST)
Date: Wed, 19 Jul 2006 10:34:05 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
Subject: [PATCH] force 64bit mode in fwnmi handlers to workaround firmware bugs
Message-ID: <20060719083405.GA4622@suse.de>
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


The firmware of POWER4 and JS20 systems does not switch the cpu to 64bit
mode when the registered system_reset and machine_check handlers get called.
If a 32bit process runs on that cpu at the time of the event, the cpu 
remains in 32bit mode. xmon and kdump can not deal with it, the result is
an error like 'Bad kernel stack pointer fff2aad0 at 3200'.
xmon just loses some register info, but booting the kdump kernel usually fails.

Both handlers are not hot paths.  Duplicate the EXCEPTION_PROLOG_PSERIES macro
and add two instructions to switch to 64bit:

 li     r11,5; 
 rldimi r10,r11,61,0; 


Signed-off-by: Olaf Hering <olh@suse.de>
---
 arch/powerpc/kernel/head_64.S |   35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc2/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-2.6.18-rc2.orig/arch/powerpc/kernel/head_64.S
+++ linux-2.6.18-rc2/arch/powerpc/kernel/head_64.S
@@ -191,6 +191,37 @@ exception_marker:
 	ori	reg,reg,(label)@l;	/* virt addr of handler ... */
 #endif
 
+/*
+ * Equal to EXCEPTION_PROLOG_PSERIES, except that it forces 64bit mode.
+ * The firmware calls the registered system_reset_fwnmi and
+ * machine_check_fwnmi handlers in 32bit mode if the cpu happens to run
+ * a 32bit application at the time of the event.
+ * This firmware bug is present on POWER4 and JS20.
+ */
+#define EXCEPTION_PROLOG_PSERIES_FORCE_64BIT(area, label)		\
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
+	/* force 64bit mode */						\
+	li	r11,5;			/* MSR_SF_LG|MSR_ISF_LG */	\
+	rldimi	r10,r11,61,0;		/* insert into top 3 bits */	\
+	/* done 64bit mode */						\
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
@@ -604,14 +635,14 @@ slb_miss_user_pseries:
 system_reset_fwnmi:
 	HMT_MEDIUM
 	mtspr	SPRN_SPRG1,r13		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common)
+	EXCEPTION_PROLOG_PSERIES_FORCE_64BIT(PACA_EXGEN, system_reset_common)
 
 	.globl machine_check_fwnmi
       .align 7
 machine_check_fwnmi:
 	HMT_MEDIUM
 	mtspr	SPRN_SPRG1,r13		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common)
+	EXCEPTION_PROLOG_PSERIES_FORCE_64BIT(PACA_EXMC, machine_check_common)
 
 #ifdef CONFIG_PPC_ISERIES
 /***  ISeries-LPAR interrupt handlers ***/
