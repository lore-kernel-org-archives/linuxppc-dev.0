Return-Path: <srs0=9r9h=js=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Jx8G6kWTzF1Pn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 15:46:38 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41Jx8G61Nyz8vqR
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 15:46:38 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41Jx8G2XVNz9s1B
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Jul 2018 15:46:38 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w625i2rj017883
 for <linuxppc-dev@ozlabs.org>; Mon, 2 Jul 2018 01:46:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jybhumrh9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 02 Jul 2018 01:46:36 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 2 Jul 2018 06:46:34 +0100
Subject: [PATCH v5 2/7] powerpc/pseries: Defer the logging of rtas error to
 irq work queue.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>
Date: Mon, 02 Jul 2018 11:16:29 +0530
In-Reply-To: <153051022088.30541.5610525713141009848.stgit@jupiter.in.ibm.com>
References: <153051022088.30541.5610525713141009848.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153051038591.30541.12824711468905210952.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

rtas_log_buf is a buffer to hold RTAS event data that are communicated
to kernel by hypervisor. This buffer is then used to pass RTAS event
data to user through proc fs. This buffer is allocated from vmalloc
(non-linear mapping) area.

On Machine check interrupt, register r3 points to RTAS extended event
log passed by hypervisor that contains the MCE event. The pseries
machine check handler then logs this error into rtas_log_buf. The
rtas_log_buf is a vmalloc-ed (non-linear) buffer we end up taking up a
page fault (vector 0x300) while accessing it. Since machine check
interrupt handler runs in NMI context we can not afford to take any
page fault. Page faults are not honored in NMI context and causes
kernel panic. Apart from that, as Nick pointed out, pSeries_log_error()
also takes a spin_lock while logging error which is not safe in NMI
context. It may endup in deadlock if we get another MCE before releasing
the lock. Fix this by deferring the logging of rtas error to irq work queue.

Current implementation uses two different buffers to hold rtas error log
depending on whether extended log is provided or not. This makes bit
difficult to identify which buffer has valid data that needs to logged
later in irq work. Simplify this using single buffer, one per paca, and
copy rtas log to it irrespective of whether extended log is provided or
not. Allocate this buffer below RMA region so that it can be accessed
in real mode mce handler.

Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskable interrupt")
Cc: stable@vger.kernel.org
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/paca.h        |    3 ++
 arch/powerpc/platforms/pseries/ras.c   |   47 ++++++++++++++++++++++----------
 arch/powerpc/platforms/pseries/setup.c |   16 +++++++++++
 3 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 3f109a3e3edb..b441fef53077 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -251,6 +251,9 @@ struct paca_struct {
 	void *rfi_flush_fallback_area;
 	u64 l1d_flush_size;
 #endif
+#ifdef CONFIG_PPC_PSERIES
+	u8 *mce_data_buf;		/* buffer to hold per cpu rtas errlog */
+#endif /* CONFIG_PPC_PSERIES */
 } ____cacheline_aligned;
 
 extern void copy_mm_to_paca(struct mm_struct *mm);
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index ef104144d4bc..14a46b07ab2f 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/fs.h>
 #include <linux/reboot.h>
+#include <linux/irq_work.h>
 
 #include <asm/machdep.h>
 #include <asm/rtas.h>
@@ -32,11 +33,13 @@
 static unsigned char ras_log_buf[RTAS_ERROR_LOG_MAX];
 static DEFINE_SPINLOCK(ras_log_buf_lock);
 
-static char global_mce_data_buf[RTAS_ERROR_LOG_MAX];
-static DEFINE_PER_CPU(__u64, mce_data_buf);
-
 static int ras_check_exception_token;
 
+static void mce_process_errlog_event(struct irq_work *work);
+static struct irq_work mce_errlog_process_work = {
+	.func = mce_process_errlog_event,
+};
+
 #define EPOW_SENSOR_TOKEN	9
 #define EPOW_SENSOR_INDEX	0
 
@@ -330,16 +333,20 @@ static irqreturn_t ras_error_interrupt(int irq, void *dev_id)
 	((((A) >= 0x7000) && ((A) < 0x7ff0)) || \
 	(((A) >= rtas.base) && ((A) < (rtas.base + rtas.size - 16))))
 
+static inline struct rtas_error_log *fwnmi_get_errlog(void)
+{
+	return (struct rtas_error_log *)local_paca->mce_data_buf;
+}
+
 /*
  * Get the error information for errors coming through the
  * FWNMI vectors.  The pt_regs' r3 will be updated to reflect
  * the actual r3 if possible, and a ptr to the error log entry
  * will be returned if found.
  *
- * If the RTAS error is not of the extended type, then we put it in a per
- * cpu 64bit buffer. If it is the extended type we use global_mce_data_buf.
+ * Use one buffer mce_data_buf per cpu to store RTAS error.
  *
- * The global_mce_data_buf does not have any locks or protection around it,
+ * The mce_data_buf does not have any locks or protection around it,
  * if a second machine check comes in, or a system reset is done
  * before we have logged the error, then we will get corruption in the
  * error log.  This is preferable over holding off on calling
@@ -349,7 +356,7 @@ static irqreturn_t ras_error_interrupt(int irq, void *dev_id)
 static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
 {
 	unsigned long *savep;
-	struct rtas_error_log *h, *errhdr = NULL;
+	struct rtas_error_log *h;
 
 	/* Mask top two bits */
 	regs->gpr[3] &= ~(0x3UL << 62);
@@ -362,22 +369,20 @@ static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
 	savep = __va(regs->gpr[3]);
 	regs->gpr[3] = savep[0];	/* restore original r3 */
 
-	/* If it isn't an extended log we can use the per cpu 64bit buffer */
 	h = (struct rtas_error_log *)&savep[1];
+	/* Use the per cpu buffer from paca to store rtas error log */
+	memset(local_paca->mce_data_buf, 0, RTAS_ERROR_LOG_MAX);
 	if (!rtas_error_extended(h)) {
-		memcpy(this_cpu_ptr(&mce_data_buf), h, sizeof(__u64));
-		errhdr = (struct rtas_error_log *)this_cpu_ptr(&mce_data_buf);
+		memcpy(local_paca->mce_data_buf, h, sizeof(__u64));
 	} else {
 		int len, error_log_length;
 
 		error_log_length = 8 + rtas_error_extended_log_length(h);
 		len = min_t(int, error_log_length, RTAS_ERROR_LOG_MAX);
-		memset(global_mce_data_buf, 0, RTAS_ERROR_LOG_MAX);
-		memcpy(global_mce_data_buf, h, len);
-		errhdr = (struct rtas_error_log *)global_mce_data_buf;
+		memcpy(local_paca->mce_data_buf, h, len);
 	}
 
-	return errhdr;
+	return (struct rtas_error_log *)local_paca->mce_data_buf;
 }
 
 /* Call this when done with the data returned by FWNMI_get_errinfo.
@@ -422,6 +427,17 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
 	return 0; /* need to perform reset */
 }
 
+/*
+ * Process MCE rtas errlog event.
+ */
+static void mce_process_errlog_event(struct irq_work *work)
+{
+	struct rtas_error_log *err;
+
+	err = fwnmi_get_errlog();
+	log_error((char *)err, ERR_TYPE_RTAS_LOG, 0);
+}
+
 /*
  * See if we can recover from a machine check exception.
  * This is only called on power4 (or above) and only via
@@ -466,7 +482,8 @@ static int recover_mce(struct pt_regs *regs, struct rtas_error_log *err)
 		recovered = 1;
 	}
 
-	log_error((char *)err, ERR_TYPE_RTAS_LOG, 0);
+	/* Queue irq work to log this rtas event later. */
+	irq_work_queue(&mce_errlog_process_work);
 
 	return recovered;
 }
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index fdb32e056ef4..60a067a6e743 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -41,6 +41,7 @@
 #include <linux/root_dev.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
+#include <linux/memblock.h>
 
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -101,6 +102,9 @@ static void pSeries_show_cpuinfo(struct seq_file *m)
 static void __init fwnmi_init(void)
 {
 	unsigned long system_reset_addr, machine_check_addr;
+	u8 *mce_data_buf;
+	unsigned int i;
+	int nr_cpus = num_possible_cpus();
 
 	int ibm_nmi_register = rtas_token("ibm,nmi-register");
 	if (ibm_nmi_register == RTAS_UNKNOWN_SERVICE)
@@ -114,6 +118,18 @@ static void __init fwnmi_init(void)
 	if (0 == rtas_call(ibm_nmi_register, 2, 1, NULL, system_reset_addr,
 				machine_check_addr))
 		fwnmi_active = 1;
+
+	/*
+	 * Allocate a chunk for per cpu buffer to hold rtas errorlog.
+	 * It will be used in real mode mce handler, hence it needs to be
+	 * below RMA.
+	 */
+	mce_data_buf = __va(memblock_alloc_base(RTAS_ERROR_LOG_MAX * nr_cpus,
+					RTAS_ERROR_LOG_MAX, ppc64_rma_size));
+	for_each_possible_cpu(i) {
+		paca_ptrs[i]->mce_data_buf = mce_data_buf +
+						(RTAS_ERROR_LOG_MAX * i);
+	}
 }
 
 static void pseries_8259_cascade(struct irq_desc *desc)
