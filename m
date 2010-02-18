Return-Path: <anton@ozlabs.org>
Date: Fri, 19 Feb 2010 09:11:51 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Call ibm,os-term if the ibm,extended-os-term is
	present
Message-ID: <20100218221151.GB31681@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We have had issues in the past with ibm,os-term initiating shutdown of a
partition. This is confusing to the user, especially if panic_timeout is
non zero.

The temporary fix was to avoid calling ibm,os-term if a panic_timeout was set
and since we set it on every boot we basically never call ibm,os-term.

An extended version of ibm,os-term has since been implemented which gives us
the behaviour we want:

  "When the platform supports extended ibm,os-term behavior, the return to the
  RTAS will always occur unless there is a kernel assisted dump active as
  initiated by an ibm,configure-kernel-dump call."

This patch checks for the ibm,extended-os-term property and calls ibm,os-term
if it exists.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/rtas.c	2010-02-18 20:31:17.283568754 +1100
+++ linux-cpumask/arch/powerpc/kernel/rtas.c	2010-02-19 09:07:05.735254857 +1100
@@ -690,10 +690,14 @@ void rtas_os_term(char *str)
 {
 	int status;
 
-	if (panic_timeout)
-		return;
-
-	if (RTAS_UNKNOWN_SERVICE == rtas_token("ibm,os-term"))
+	/*
+	 * Firmware with the ibm,extended-os-term property is guaranteed
+	 * to always return from an ibm,os-term call. Earlier versions without
+	 * this property may terminate the partition which we want to avoid
+	 * since it interferes with panic_timeout.
+	 */
+	if (RTAS_UNKNOWN_SERVICE == rtas_token("ibm,os-term") ||
+	    RTAS_UNKNOWN_SERVICE == rtas_token("ibm,extended-os-term"))
 		return;
 
 	snprintf(rtas_os_term_buf, 2048, "OS panic: %s", str);
@@ -704,8 +708,7 @@ void rtas_os_term(char *str)
 	} while (rtas_busy_delay(status));
 
 	if (status != 0)
-		printk(KERN_EMERG "ibm,os-term call failed %d\n",
-			       status);
+		printk(KERN_EMERG "ibm,os-term call failed %d\n", status);
 }
 
 static int ibm_suspend_me_token = RTAS_UNKNOWN_SERVICE;
