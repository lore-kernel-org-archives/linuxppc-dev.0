Return-Path: <linuxppc-dev+bounces-22764-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99194CD98E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 09:21:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggwGT0gC1z2yRF;
	Thu, 18 Jun 2026 19:21:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781774513;
	cv=none; b=aCRBgmOWsFd1ppnH/ALVpDTzZvwA+Y+aCyWIUJw9T4YEoizW0eifVSDnqfWQ+c9JcQcYni8eRU385XFlvqesEyj+t3a67Ymua+T/bYkPOPRFThajVPmRngnR54v+J4yNJzzsZcp6YF2s25YWmrW+U+TMeNGfxhephYJ2nFprWESWf0+b0Yx3DKraQ36nATAgUIVrzOlkcKG1BJmbMwiwFvJHgcz0J6tjX0ZenBI5AHm87jVp3B0J0SYST0iE5e1nfogoZI3ClxIxmfJkCJCRcTcOzaknGzKWfwNJexQegmy0XoK6nw/In27kZaGn3n2RnPv8fEB+SMwRN2LTgj/0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781774513; c=relaxed/relaxed;
	bh=tdbarJPqjC55LTRElMsZwxi5F6G9ivMOr+PAq0++WHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WK6+Sy1qBSx/4rrCQyZSolSkEtf5/Ld6VOQBDYEBkbAlqX82hEVHRJrEIGMR92gzMBx3JPj1bSnG/TQfWXFTm19lP1p/Jex4j+6qu503PLcx1qeXeyDWQmvxgNPMZ0WE82DVr7kYRj1tHSy1myC8ioSSVV0MNzzYFb7/U7hgSAz1RFlETcsKHXBANVZqDI0fmc2sZQqdAVMnIINoJsoGFt57Ez6qL3iF0iwWBv+KNj5L1WgVviBU1Vn+k+KKb3CtzaamhFmk5lin4TqUNmq5ss9ycP/ez+lotMmYIZxhqC8HEE8lbQ+BBZqRqrTMWIkWKw4Yksbkeuh9qRE47wxdtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=s5uqt5rn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=s5uqt5rn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggwGR5hhdz2yNn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 19:21:51 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781774507; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tdbarJPqjC55LTRElMsZwxi5F6G9ivMOr+PAq0++WHk=;
	b=s5uqt5rncTH+2b0PE8E3zxxT2GgfpCDjIrVA5pMQ7C0h/0qVtlQVxmQqp/MZCAy3Gb3jqSINDBkU79O9oFRUOMGeHT8J2FjG4V8PLVo8yDEujI7PDxj7DuG0gg8RcIbCl+894BR6nVwEPdrKqFVyjWa5eQWSZeBcpE1pn6zqBNY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X56TK4t_1781774500;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X56TK4t_1781774500 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 17:21:44 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	rafael@kernel.org,
	tony.luck@intel.com,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	tongtiangen@huawei.com,
	james.morse@arm.com,
	robin.murphy@arm.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	tglx@linutronix.de,
	mingo@redhat.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v15 2/9] ACPI: APEI: GHES: use exception context to gate SIGBUS on poison consumption
Date: Thu, 18 Jun 2026 17:21:16 +0800
Message-ID: <20260618092124.3901230-3-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260618092124.3901230-1-tianruidong@linux.alibaba.com>
References: <20260618092124.3901230-1-tianruidong@linux.alibaba.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a GHES SEA (Synchronous External Abort) fires while the CPU
was executing in kernel mode, it typically means that kernel code
itself consumed a poisoned memory location -- e.g. copy_from_user()
/ copy_to_user() invoked from a ioctl() or write() syscall touched
a poisoned user page or page-cache page on behalf of the task.

The expected behaviour in that case is that the faulting kernel
helper returns via its extable fixup and the syscall returns an
error (e.g. -EFAULT) to user space. It is NOT appropriate to deliver
SIGBUS to the current task: the task did not directly dereference
the poisoned address, the kernel did on its behalf, and the kernel
is able to recover.

Up to now ghes_handle_memory_failure() unconditionally promoted any
synchronous recoverable memory error to MF_ACTION_REQUIRED, which
ends up SIGBUS on current -- regardless of whether the poison was
consumed from user space or from inside the kernel on the task's
behalf. That kills tasks that should instead have seen a plain
syscall error.

To fix this, the execution mode in which the exception was taken
must be captured at the arch-level entry point, where pt_regs (and
hence user_mode(regs)) are still available. The estatus node that
later drains the error in IRQ / process context no longer has
access to the original regs.

Introduce:

    enum context { ... };

and plumb the value all the way down to the queued estatus node:

 * Add an 'enum context context' field to struct ghes_estatus_node
   and record it in ghes_in_nmi_queue_one_entry().
 * Extend ghes_notify_sea() and the internal
   ghes_in_nmi_spool_from_list() with an enum context parameter.

Then consume the recorded context in ghes_handle_memory_failure()
for the GHES_SEV_RECOVERABLE / sync path:

    flags = sync && context == GHES_CTX_USER ? MF_ACTION_REQUIRED : 0;

i.e. MF_ACTION_REQUIRED (and thus SIGBUS via the task_work path) is
only raised for user-mode poison consumption. Synchronous errors
taken in kernel mode fall back to memory_failure_queue() with
flags=0, asynchronously isolating the poisoned page while letting
the faulting kernel helper's extable fixup return -EFAULT
to user space.

Paths that pass NO_USE are unaffected:
sync is false for them, so flags stays 0 as before.

Signed-off-by: Ruidong Tian  <tianruidong@linux.alibaba.com>
---
 arch/arm64/kernel/acpi.c |  2 +-
 drivers/acpi/apei/ghes.c | 36 ++++++++++++++++++++----------------
 include/acpi/ghes.h      | 15 +++++++++++++--
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 5891f92c2035..fa74f32c6e8c 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -409,7 +409,7 @@ int apei_claim_sea(struct pt_regs *regs)
 	 */
 	local_daif_restore(DAIF_ERRCTX);
 	nmi_enter();
-	err = ghes_notify_sea();
+	err = ghes_notify_sea(GHES_CTX(regs));
 	nmi_exit();
 
 	/*
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..2c39adfb584a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -529,7 +529,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 }
 
 static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev, bool sync)
+				       int sev, bool sync, enum ghes_exec_ctx context)
 {
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
@@ -543,7 +543,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
 		flags = MF_SOFT_OFFLINE;
 	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
-		flags = sync ? MF_ACTION_REQUIRED : 0;
+		flags = sync && context == GHES_CTX_USER ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
 		return ghes_do_memory_failure(mem_err->physical_addr, flags);
@@ -552,10 +552,10 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 }
 
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
-				     int sev, bool sync)
+				     int sev, bool sync, enum ghes_exec_ctx context)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
-	int flags = sync ? MF_ACTION_REQUIRED : 0;
+	int flags = sync && context == GHES_CTX_USER ? MF_ACTION_REQUIRED : 0;
 	int length = gdata->error_data_length;
 	char error_type[120];
 	bool queued = false;
@@ -910,7 +910,8 @@ static void ghes_log_hwerr(int sev, guid_t *sec_type)
 }
 
 static void ghes_do_proc(struct ghes *ghes,
-			 const struct acpi_hest_generic_status *estatus)
+			 const struct acpi_hest_generic_status *estatus,
+			 enum ghes_exec_ctx context)
 {
 	int sev, sec_sev;
 	struct acpi_hest_generic_data *gdata;
@@ -937,11 +938,11 @@ static void ghes_do_proc(struct ghes *ghes,
 			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev, sync);
+			queued = ghes_handle_memory_failure(gdata, sev, sync, context);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+			queued = ghes_handle_arm_hw_error(gdata, sev, sync, context);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
 			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
 
@@ -1190,7 +1191,7 @@ static int ghes_proc(struct ghes *ghes)
 		if (ghes_print_estatus(NULL, ghes->generic, estatus))
 			ghes_estatus_cache_add(ghes->generic, estatus);
 	}
-	ghes_do_proc(ghes, estatus);
+	ghes_do_proc(ghes, estatus, GHES_CTX_NA);
 
 out:
 	ghes_clear_estatus(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);
@@ -1297,7 +1298,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 		len = cper_estatus_len(estatus);
 		node_len = GHES_ESTATUS_NODE_LEN(len);
 
-		ghes_do_proc(estatus_node->ghes, estatus);
+		ghes_do_proc(estatus_node->ghes, estatus, estatus_node->context);
 
 		if (!ghes_estatus_cached(estatus)) {
 			generic = estatus_node->generic;
@@ -1335,7 +1336,8 @@ static void ghes_print_queued_estatus(void)
 }
 
 static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
-				       enum fixed_addresses fixmap_idx)
+				       enum fixed_addresses fixmap_idx,
+				       enum ghes_exec_ctx context)
 {
 	struct acpi_hest_generic_status *estatus, tmp_header;
 	struct ghes_estatus_node *estatus_node;
@@ -1364,6 +1366,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	if (!estatus_node)
 		return -ENOMEM;
 
+	estatus_node->context = context;
 	estatus_node->ghes = ghes;
 	estatus_node->generic = ghes->generic;
 	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
@@ -1398,14 +1401,15 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 }
 
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
-				       enum fixed_addresses fixmap_idx)
+				       enum fixed_addresses fixmap_idx,
+				       enum ghes_exec_ctx context)
 {
 	int ret = -ENOENT;
 	struct ghes *ghes;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(ghes, rcu_list, list) {
-		if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx))
+		if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx, context))
 			ret = 0;
 	}
 	rcu_read_unlock();
@@ -1488,7 +1492,7 @@ static LIST_HEAD(ghes_sea);
  * Return 0 only if one of the SEA error sources successfully reported an error
  * record sent from the firmware.
  */
-int ghes_notify_sea(void)
+int ghes_notify_sea(enum ghes_exec_ctx context)
 {
 	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sea);
 	int rv;
@@ -1497,7 +1501,7 @@ int ghes_notify_sea(void)
 		return -ENOENT;
 
 	raw_spin_lock(&ghes_notify_lock_sea);
-	rv = ghes_in_nmi_spool_from_list(&ghes_sea, FIX_APEI_GHES_SEA);
+	rv = ghes_in_nmi_spool_from_list(&ghes_sea, FIX_APEI_GHES_SEA, context);
 	raw_spin_unlock(&ghes_notify_lock_sea);
 
 	return rv;
@@ -1552,7 +1556,7 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 		return ret;
 
 	raw_spin_lock(&ghes_notify_lock_nmi);
-	if (!ghes_in_nmi_spool_from_list(&ghes_nmi, FIX_APEI_GHES_NMI))
+	if (!ghes_in_nmi_spool_from_list(&ghes_nmi, FIX_APEI_GHES_NMI, GHES_CTX_NA))
 		ret = NMI_HANDLED;
 	raw_spin_unlock(&ghes_notify_lock_nmi);
 
@@ -1606,7 +1610,7 @@ static void ghes_nmi_init_cxt(void)
 static int __ghes_sdei_callback(struct ghes *ghes,
 				enum fixed_addresses fixmap_idx)
 {
-	if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx)) {
+	if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx, GHES_CTX_NA)) {
 		irq_work_queue(&ghes_proc_irq_work);
 
 		return 0;
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 8d7e5caef3f1..8460707ea4b0 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -33,10 +33,21 @@ struct ghes {
 	void __iomem *error_status_vaddr;
 };
 
+enum ghes_exec_ctx {
+	GHES_CTX_NA = -1,
+	GHES_CTX_KERNEL = 0,
+	GHES_CTX_USER = 1
+};
+
+#define GHES_CTX(regs)	((regs) ? (user_mode(regs) ? GHES_CTX_USER \
+						   : GHES_CTX_KERNEL) \
+				: GHES_CTX_NA)
+
 struct ghes_estatus_node {
 	struct llist_node llnode;
 	struct acpi_hest_generic *generic;
 	struct ghes *ghes;
+	enum ghes_exec_ctx context;
 };
 
 struct ghes_estatus_cache {
@@ -135,9 +146,9 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
 	     section = acpi_hest_get_next(section))
 
 #ifdef CONFIG_ACPI_APEI_SEA
-int ghes_notify_sea(void);
+int ghes_notify_sea(enum ghes_exec_ctx context);
 #else
-static inline int ghes_notify_sea(void) { return -ENOENT; }
+static inline int ghes_notify_sea(enum ghes_exec_ctx context) { return -ENOENT; }
 #endif
 
 struct notifier_block;
-- 
2.39.3


