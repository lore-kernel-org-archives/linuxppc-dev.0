Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id 465ED67A7D
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2005 03:47:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 31 Mar 2005 19:47:32 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D23@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

When CPU has no (classic) FPU, and math emulation is disabled,
fp instructions are not allowed in kernel mode.
This bug has been found with crashme (crash01) of LTP, on a e500 system.

The patch was made against linux 2.6.11.6.
A trivial typo fix has been appended.

Rem: a CONFIG_PPCFPU define could make life easier.


Signed-off-by: Stephane Fillod <fillods@gmail.com>

--- linux/arch/ppc/kernel/align.c	6 Dec 2004 16:18:11 -0000
1.1.1.1
+++ linux/arch/ppc/kernel/align.c	31 Mar 2005 16:33:25 -0000
@@ -333,10 +333,14 @@
 	}
=20
 	if (flags & F) {
+#if !(defined(CONFIG_4xx) || defined(CONFIG_8xx) ||
defined(CONFIG_E500)) || defined(CONFIG_MATH_EMULATION)
 		preempt_disable();
 		if (regs->msr & MSR_FP)
 			giveup_fpu(current);
 		preempt_enable();
+#else
+		return 0;
+#endif
 	}
=20
 	/* If we read the operand, copy it in, else get register values
*/
@@ -366,6 +370,8 @@
 		}
 		break;
=20
+#if !(defined(CONFIG_4xx) || defined(CONFIG_8xx) ||
defined(CONFIG_E500)) || defined(CONFIG_MATH_EMULATION)
+
 	/* Single-precision FP load and store require conversions... */
 	case LD+F+S:
 		preempt_disable();
@@ -379,6 +385,7 @@
 		cvt_df(&data.d, &data.f, &current->thread.fpscr);
 		preempt_enable();
 		break;
+#endif
 	}
=20
 	if (flags & ST) {
--- linux/arch/ppc/kernel/misc.S	26 Mar 2005 03:28:36 -0000
1.1.1.2
+++ linux/arch/ppc/kernel/misc.S	31 Mar 2005 16:33:25 -0000
@@ -1096,7 +1096,8 @@
  * and exceptions as if the cpu had performed the load or store.
  */
=20
-#if defined(CONFIG_4xx) || defined(CONFIG_E500)
+#if !(defined(CONFIG_4xx) || defined(CONFIG_E500) ||
defined(CONFIG_8xx)) ||  defined(CONFIG_MATH_EMULATION)
+#if defined(CONFIG_4xx) || defined(CONFIG_E500)
 _GLOBAL(cvt_fd)
 	lfs	0,0(r3)
 	stfd	0,0(r4)
@@ -1125,6 +1126,7 @@
 	stfd	0,-4(r5)
 	blr
 #endif
+#endif
=20
 /*
  * Create a kernel thread
--- linux/arch/ppc/kernel/process.c	26 Mar 2005 03:28:20 -0000
1.1.1.2
+++ linux/arch/ppc/kernel/process.c	31 Mar 2005 16:33:25 -0000
@@ -342,7 +342,7 @@
 	printk("\n");
 #ifdef CONFIG_KALLSYMS
 	/*
-	 * Lookup NIP late so we have the best change of getting the
+	 * Lookup NIP late so we have the best chance of getting the
 	 * above info out without failing
 	 */
 	printk("NIP [%08lx] ", regs->nip);


Best Regards,

--=20
Stephane
