Return-Path: <anton@samba.org>
Date: Fri, 7 Jan 2011 14:56:09 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 4/8] powerpc/kdump: Remove ppc_md.machine_crash_shutdown
Message-ID: <20110107145609.13756a9a@kryten>
In-Reply-To: <20110107145255.72cf30ba@kryten>
References: <20110107145255.72cf30ba@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


No one uses ppc_md.machine_crash_shutdown, so remove it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/machdep.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/machdep.h	2011-01-07 12:51:54.082394288 +1100
+++ powerpc.git/arch/powerpc/include/asm/machdep.h	2011-01-07 12:51:56.222461754 +1100
@@ -236,12 +236,6 @@ struct machdep_calls {
 #ifdef CONFIG_KEXEC
 	void (*kexec_cpu_down)(int crash_shutdown, int secondary);
 
-	/* Called to do the minimal shutdown needed to run a kexec'd kernel
-	 * to run successfully.
-	 * XXX Should we move this one out of kexec scope?
-	 */
-	void (*machine_crash_shutdown)(struct pt_regs *regs);
-
 	/* Called to do what every setup is needed on image and the
 	 * reboot code buffer. Returns 0 on success.
 	 * Provide your own (maybe dummy) implementation if your platform
Index: powerpc.git/arch/powerpc/kernel/machine_kexec.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/machine_kexec.c	2011-01-07 12:51:54.082394288 +1100
+++ powerpc.git/arch/powerpc/kernel/machine_kexec.c	2011-01-07 12:51:56.222461754 +1100
@@ -44,10 +44,7 @@ void machine_kexec_mask_interrupts(void)
 
 void machine_crash_shutdown(struct pt_regs *regs)
 {
-	if (ppc_md.machine_crash_shutdown)
-		ppc_md.machine_crash_shutdown(regs);
-	else
-		default_machine_crash_shutdown(regs);
+	default_machine_crash_shutdown(regs);
 }
 
 /*
Index: powerpc.git/arch/powerpc/platforms/cell/qpace_setup.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/qpace_setup.c	2010-12-13 22:52:03.765247709 +1100
+++ powerpc.git/arch/powerpc/platforms/cell/qpace_setup.c	2011-01-07 12:51:56.222461754 +1100
@@ -148,6 +148,5 @@ define_machine(qpace) {
 #ifdef CONFIG_KEXEC
 	.machine_kexec		= default_machine_kexec,
 	.machine_kexec_prepare	= default_machine_kexec_prepare,
-	.machine_crash_shutdown	= default_machine_crash_shutdown,
 #endif
 };
Index: powerpc.git/arch/powerpc/platforms/pseries/kexec.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/pseries/kexec.c	2010-12-13 22:52:03.745247341 +1100
+++ powerpc.git/arch/powerpc/platforms/pseries/kexec.c	2011-01-07 12:51:56.222461754 +1100
@@ -66,7 +66,6 @@ static int __init pseries_kexec_setup(vo
 {
 	ppc_md.machine_kexec = default_machine_kexec;
 	ppc_md.machine_kexec_prepare = default_machine_kexec_prepare;
-	ppc_md.machine_crash_shutdown = default_machine_crash_shutdown;
 
 	return 0;
 }
