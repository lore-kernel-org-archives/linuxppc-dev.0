Return-Path: <anton@samba.org>
Date: Wed, 12 Jan 2011 16:49:19 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 6/9] powerpc: Rework pseries machine check handler
Message-ID: <20110112164919.77ac3b71@kryten>
In-Reply-To: <20110112164318.753a435b@kryten>
References: <20110112164318.753a435b@kryten>
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


Rework pseries machine check handler:

- If MSR_RI isn't set, we cannot recover even if the machine check was fully
  recovered

- Rename nonfatal to recovered

- Handle RTAS_DISP_LIMITED_RECOVERY

- Use BUS_MCEERR_AR instead of BUS_ADRERR

- Don't check all the RTAS error log fields when receiving a synchronous
  machine check. Recent versions of the pseries firmware do not fill them
  in during a machine check and instead send a follow up error log with
  the detailed information. If we see a synchronous machine check, and we
  came from userspace then kill the task.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/pseries/ras.c	2010-10-15 13:23:34.161268941 +1100
+++ powerpc.git/arch/powerpc/platforms/pseries/ras.c	2010-10-15 13:23:38.701320228 +1100
@@ -259,31 +259,43 @@ int pSeries_system_reset_exception(struc
  * Return 1 if corrected (or delivered a signal).
  * Return 0 if there is nothing we can do.
  */
-static int recover_mce(struct pt_regs *regs, struct rtas_error_log * err)
+static int recover_mce(struct pt_regs *regs, struct rtas_error_log *err)
 {
-	int nonfatal = 0;
+	int recovered = 0;
 
-	if (err->disposition == RTAS_DISP_FULLY_RECOVERED) {
+	if (!(regs->msr & MSR_RI)) {
+		/* If MSR_RI isn't set, we cannot recover */
+		recovered = 0;
+
+	} else if (err->disposition == RTAS_DISP_FULLY_RECOVERED) {
 		/* Platform corrected itself */
-		nonfatal = 1;
-	} else if ((regs->msr & MSR_RI) &&
-		   user_mode(regs) &&
-		   err->severity == RTAS_SEVERITY_ERROR_SYNC &&
-		   err->disposition == RTAS_DISP_NOT_RECOVERED &&
-		   err->target == RTAS_TARGET_MEMORY &&
-		   err->type == RTAS_TYPE_ECC_UNCORR &&
-		   !(current->pid == 0 || is_global_init(current))) {
-		/* Kill off a user process with an ECC error */
-		printk(KERN_ERR "MCE: uncorrectable ecc error for pid %d\n",
-		       current->pid);
-		/* XXX something better for ECC error? */
-		_exception(SIGBUS, regs, BUS_ADRERR, regs->nip);
-		nonfatal = 1;
+		recovered = 1;
+
+	} else if (err->disposition == RTAS_DISP_LIMITED_RECOVERY) {
+		/* Platform corrected itself but could be degraded */
+		printk(KERN_ERR "MCE: limited recovery, system may "
+		       "be degraded\n");
+		recovered = 1;
+
+	} else if (user_mode(regs) && !is_global_init(current) &&
+		   err->severity == RTAS_SEVERITY_ERROR_SYNC) {
+
+		/*
+		 * If we received a synchronous error when in userspace
+		 * kill the task. Firmware may report details of the fail
+		 * asynchronously, so we can't rely on the target and type
+		 * fields being valid here.
+		 */
+		printk(KERN_ERR "MCE: uncorrectable error, killing task "
+		       "%s:%d\n", current->comm, current->pid);
+
+		_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
+		recovered = 1;
 	}
 
 	log_error((char *)err, ERR_TYPE_RTAS_LOG, 0);
 
-	return nonfatal;
+	return recovered;
 }
 
 /*
