Return-Path: <bigeasy@linux.vnet.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 905FDDDF1E
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 03:18:01 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l3BHHvTb077832
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 17:17:57 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3BHHuqf2687070
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:17:56 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3BHHuaq007941
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:17:56 +0100
Received: from [9.152.237.70] (dyn-9-152-237-70.boeblingen.de.ibm.com
	[9.152.237.70])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.12.11) with ESMTP
	id l3BHHujP007934
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:17:56 +0100
Message-Id: <20070411165702.634151000@linux.vnet.ibm.com>>
References: <20070411164910.657151000@linux.vnet.ibm.com>>
Date: Wed, 11 Apr 2007 18:49:12 +0200
From: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 2/3] PowerPC: lazy altivec enabling in kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This works right only for 64bit kernel and will break any 32bit kernel. 
Switching on altivec takes some time due to the MSR access. The speed-up is
about 50% in my aes-code. It might be usefull for the raid module as well. 

Signed-off-by: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
Index: ps3-linux/arch/powerpc/kernel/head_64.S
===================================================================
--- ps3-linux.orig/arch/powerpc/kernel/head_64.S
+++ ps3-linux/arch/powerpc/kernel/head_64.S
@@ -1229,6 +1229,13 @@ altivec_unavailable_common:
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
 	bne	.load_up_altivec	/* if from user, just load it up */
+	/*
+	 * the kernel is going to use AltiVec.
+	 * hopefully enable_kernel_altivec() has been called
+	 */
+	bl .altivec_enable_for_kernel_exception
+	b .ret_from_except
+
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
 	bl	.save_nvgprs
Index: ps3-linux/arch/powerpc/kernel/misc_64.S
===================================================================
--- ps3-linux.orig/arch/powerpc/kernel/misc_64.S
+++ ps3-linux/arch/powerpc/kernel/misc_64.S
@@ -493,6 +493,8 @@ _GLOBAL(giveup_altivec)
 	mfmsr	r5
 	oris	r5,r5,MSR_VEC@h
 	mtmsrd	r5			/* enable use of VMX now */
+
+giveup_user_altivec_save_vmx:
 	isync
 	cmpdi	0,r3,0
 	beqlr-				/* if no previous owner, done */
@@ -516,6 +518,14 @@ _GLOBAL(giveup_altivec)
 #endif /* CONFIG_SMP */
 	blr
 
+/*
+ * giveup_user_altivec(tsk)
+ * Same as giveup_altivec() but lets the exception handler
+ * enable AltiVec
+ */
+_GLOBAL(giveup_user_altivec)
+		b save_vmx
+
 #endif /* CONFIG_ALTIVEC */
 
 _GLOBAL(kernel_execve)
Index: ps3-linux/arch/powerpc/kernel/process.c
===================================================================
--- ps3-linux.orig/arch/powerpc/kernel/process.c
+++ ps3-linux/arch/powerpc/kernel/process.c
@@ -119,15 +119,21 @@ int dump_task_fpu(struct task_struct *ts
 #ifdef CONFIG_ALTIVEC
 void enable_kernel_altivec(void)
 {
-	WARN_ON(preemptible());
+	BUG_ON(preemptible());
+	/*
+	 * enable_kernel_altivec() will just save current AltiVec registers (if needed) and
+	 * return to caller (with MSR_VEC unchanged (probably not set)). The first AltiVec
+	 * instruction will raise an exception and the exception will enable the AltiVec for
+	 * the kernel. This is done to avoid the expensive "enable altivec" operation if it
+	 * is allready enabled. However, you have to disable preemtion while you are using
+	 * AltiVec.
+	 */
 
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC))
-		giveup_altivec(current);
-	else
-		giveup_altivec(NULL);	/* just enable AltiVec for kernel - force */
+		giveup_user_altivec(current);
 #else
-	giveup_altivec(last_task_used_altivec);
+	giveup_user_altivec(last_task_used_altivec);
 #endif /* CONFIG_SMP */
 }
 EXPORT_SYMBOL(enable_kernel_altivec);
Index: ps3-linux/arch/powerpc/kernel/traps.c
===================================================================
--- ps3-linux.orig/arch/powerpc/kernel/traps.c
+++ ps3-linux/arch/powerpc/kernel/traps.c
@@ -886,6 +886,12 @@ void altivec_unavailable_exception(struc
 	die("Unrecoverable VMX/Altivec Unavailable Exception", regs, SIGABRT);
 }
 
+void altivec_enable_for_kernel_exception(struct pt_regs *regs)
+{
+	printk("altivec_enable_for_kernel_exception: AltiVec mode on for kernel\n");
+	regs->msr |= MSR_VEC;
+}
+
 void performance_monitor_exception(struct pt_regs *regs)
 {
 	perf_irq(regs);
Index: ps3-linux/include/asm-powerpc/system.h
===================================================================
--- ps3-linux.orig/include/asm-powerpc/system.h
+++ ps3-linux/include/asm-powerpc/system.h
@@ -129,6 +129,7 @@ extern void enable_kernel_fp(void);
 extern void flush_fp_to_thread(struct task_struct *);
 extern void enable_kernel_altivec(void);
 extern void giveup_altivec(struct task_struct *);
+extern void giveup_user_altivec(struct task_struct *);
 extern void load_up_altivec(struct task_struct *);
 extern int emulate_altivec(struct pt_regs *);
 extern void giveup_spe(struct task_struct *);

--
