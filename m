Return-Path: <anton@samba.org>
Date: Wed, 12 Jan 2011 16:50:51 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 7/9] powerpc: Fix corruption when grabbing FWNMI data
Message-ID: <20110112165051.1a14d652@kryten>
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


The FWNMI code uses a global buffer without any locks to read the RTAS error
information. If two CPUs take a machine check at once then we will corrupt
this buffer.

Since most FWNMI rtas messages are not of the extended type, we can create a
64bit percpu buffer and use it where possible. If we do receive an extended
RTAS log then we fall back to the old behaviour of using the global buffer.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/pseries/ras.c	2010-10-15 13:23:38.701320228 +1100
+++ powerpc.git/arch/powerpc/platforms/pseries/ras.c	2010-10-15 13:23:39.901333776 +1100
@@ -54,7 +54,8 @@
 static unsigned char ras_log_buf[RTAS_ERROR_LOG_MAX];
 static DEFINE_SPINLOCK(ras_log_buf_lock);
 
-static char mce_data_buf[RTAS_ERROR_LOG_MAX];
+static char global_mce_data_buf[RTAS_ERROR_LOG_MAX];
+static DEFINE_PER_CPU(__u64, mce_data_buf);
 
 static int ras_get_sensor_state_token;
 static int ras_check_exception_token;
@@ -196,12 +197,24 @@ static irqreturn_t ras_error_interrupt(i
 	return IRQ_HANDLED;
 }
 
-/* Get the error information for errors coming through the
+/*
+ * Some versions of FWNMI place the buffer inside the 4kB page starting at
+ * 0x7000. Other versions place it inside the rtas buffer. We check both.
+ */
+#define VALID_FWNMI_BUFFER(A) \
+	((((A) >= 0x7000) && ((A) < 0x7ff0)) || \
+	(((A) >= rtas.base) && ((A) < (rtas.base + rtas.size - 16))))
+
+/*
+ * Get the error information for errors coming through the
  * FWNMI vectors.  The pt_regs' r3 will be updated to reflect
  * the actual r3 if possible, and a ptr to the error log entry
  * will be returned if found.
  *
- * The mce_data_buf does not have any locks or protection around it,
+ * If the RTAS error is not of the extended type, then we put it in a per
+ * cpu 64bit buffer. If it is the extended type we use global_mce_data_buf.
+ *
+ * The global_mce_data_buf does not have any locks or protection around it,
  * if a second machine check comes in, or a system reset is done
  * before we have logged the error, then we will get corruption in the
  * error log.  This is preferable over holding off on calling
@@ -210,20 +223,31 @@ static irqreturn_t ras_error_interrupt(i
  */
 static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
 {
-	unsigned long errdata = regs->gpr[3];
-	struct rtas_error_log *errhdr = NULL;
 	unsigned long *savep;
+	struct rtas_error_log *h, *errhdr = NULL;
 
-	if ((errdata >= 0x7000 && errdata < 0x7fff0) ||
-	    (errdata >= rtas.base && errdata < rtas.base + rtas.size - 16)) {
-		savep = __va(errdata);
-		regs->gpr[3] = savep[0];	/* restore original r3 */
-		memset(mce_data_buf, 0, RTAS_ERROR_LOG_MAX);
-		memcpy(mce_data_buf, (char *)(savep + 1), RTAS_ERROR_LOG_MAX);
-		errhdr = (struct rtas_error_log *)mce_data_buf;
+	if (!VALID_FWNMI_BUFFER(regs->gpr[3])) {
+		printk(KERN_ERR "FWNMI: corrupt r3\n");
+		return NULL;
+	}
+
+	savep = __va(regs->gpr[3]);
+	regs->gpr[3] = savep[0];	/* restore original r3 */
+
+	/* If it isn't an extended log we can use the per cpu 64bit buffer */
+	h = (struct rtas_error_log *)&savep[1];
+	if (!h->extended) {
+		memcpy(&__get_cpu_var(mce_data_buf), h, sizeof(__u64));
+		errhdr = (struct rtas_error_log *)&__get_cpu_var(mce_data_buf);
 	} else {
-		printk("FWNMI: corrupt r3\n");
+		int len;
+
+		len = max_t(int, 8+h->extended_log_length, RTAS_ERROR_LOG_MAX);
+		memset(global_mce_data_buf, 0, RTAS_ERROR_LOG_MAX);
+		memcpy(global_mce_data_buf, h, len);
+		errhdr = (struct rtas_error_log *)global_mce_data_buf;
 	}
+
 	return errhdr;
 }
 
@@ -235,7 +259,7 @@ static void fwnmi_release_errinfo(void)
 {
 	int ret = rtas_call(rtas_token("ibm,nmi-interlock"), 0, 1, NULL);
 	if (ret != 0)
-		printk("FWNMI: nmi-interlock failed: %d\n", ret);
+		printk(KERN_ERR "FWNMI: nmi-interlock failed: %d\n", ret);
 }
 
 int pSeries_system_reset_exception(struct pt_regs *regs)
