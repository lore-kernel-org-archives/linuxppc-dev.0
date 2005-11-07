Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 502C7684B6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 03:25:24 +1100 (EST)
Date: Mon, 7 Nov 2005 09:24:24 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20051107112424.GE15522@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Edson Seabra <edson.seabra@cyclades.com>
Subject: BDI and 85xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

FYI

Edson had to patch this in to get BDI to work on 85xx with 2.6.14.

--- /home/edson/linux-2.6.14/Makefile	2005-10-27 17:02:08.000000000 -0700
+++ Makefile	2005-11-02 10:32:00.000000000 -0800
@@ -524,7 +524,7 @@
 endif
 
 ifdef CONFIG_DEBUG_INFO
-CFLAGS		+= -g
+CFLAGS		+= -g -ggdb
 endif
 
 include $(srctree)/arch/$(ARCH)/Makefile
--- /home/edson/linux-2.6.14/arch/ppc/kernel/head_fsl_booke.S	2005-10-27 17:02:08.000000000 -0700
+++ arch/ppc/kernel/head_fsl_booke.S	2005-11-02 19:59:21.000000000 -0800
@@ -187,6 +187,10 @@
 
 	xori	r6,r4,1
 	slwi	r6,r6,5		/* setup new context with other address space */
+#if defined(CONFIG_BDI_SWITCH)
+	mfmsr   r9
+	rlwimi  r6,r9,0,22,22   /* preserve MSR[DE] */
+#endif
 	bl	1f		/* Find our address */
 1:	mflr	r9
 	rlwimi	r7,r9,0,20,31
@@ -238,6 +242,10 @@
 /* 7. Jump to KERNELBASE mapping */
 	lis	r7,MSR_KERNEL@h
 	ori	r7,r7,MSR_KERNEL@l
+#if defined(CONFIG_BDI_SWITCH)
+	mfmsr   r9
+	rlwimi  r7,r9,0,22,22   /* preserve MSR[DE] */
+#endif
 	bl	1f			/* Find our address */
 1:	mflr	r9
 	rlwimi	r6,r9,0,20,31
@@ -371,6 +379,10 @@
 	ori	r4,r4,start_kernel@l
 	lis	r3,MSR_KERNEL@h
 	ori	r3,r3,MSR_KERNEL@l
+#if defined(CONFIG_BDI_SWITCH)
+	mfmsr   r5
+	rlwimi  r3,r5,0,22,22   /* preserve MSR[DE] */
+#endif
 	mtspr	SPRN_SRR0,r4
 	mtspr	SPRN_SRR1,r3
 	rfi			/* change context and jump to start_kernel */
--- /home/edson/linux-2.6.14/arch/ppc/kernel/process.c	2005-10-27 17:02:08.000000000 -0700
+++ arch/ppc/kernel/process.c	2005-11-02 19:33:12.000000000 -0800
@@ -473,6 +473,10 @@
 	regs->nip = nip;
 	regs->gpr[1] = sp;
 	regs->msr = MSR_USER;
+#if (defined(CONFIG_BOOKE) && defined(CONFIG_BDI_SWITCH))
+	/* propagate the debug enable bit for BDI support */
+	regs->msr |= (mfmsr() & MSR_DE);
+#endif
 	if (last_task_used_math == current)
 		last_task_used_math = NULL;
 	if (last_task_used_altivec == current)
