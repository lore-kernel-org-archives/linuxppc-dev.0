Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38538C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:37:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76102064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76102064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jQ1X34YKzDqLJ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 20:37:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ganeshgr@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jPK21sySzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 20:05:54 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3F9xmLY100967
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 06:05:52 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rvq2r2jsk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 06:05:51 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ganeshgr@linux.ibm.com>;
 Mon, 15 Apr 2019 11:05:49 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 15 Apr 2019 11:05:46 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3FA5ktN58261594
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Apr 2019 10:05:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D76F5AE057;
 Mon, 15 Apr 2019 10:05:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20592AE04D;
 Mon, 15 Apr 2019 10:05:45 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.86])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 15 Apr 2019 10:05:44 +0000 (GMT)
From: Ganesh Goudar <ganeshgr@linux.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: hwpoison the pages upon hitting UE
Date: Mon, 15 Apr 2019 15:35:44 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19041510-0008-0000-0000-000002D9E921
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041510-0009-0000-0000-000022461CA5
Message-Id: <20190415100544.28459-1-ganeshgr@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-15_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=947 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150071
X-Mailman-Approved-At: Mon, 15 Apr 2019 20:21:04 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mahesh@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add support to hwpoison the pages upon hitting machine check
exception.

This patch queues the address where UE is hit to percpu array
and schedules work to plumb it into memory poison infrastructure.

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
---
 arch/powerpc/include/asm/mce.h       |  1 +
 arch/powerpc/kernel/mce_power.c      |  2 +-
 arch/powerpc/platforms/pseries/ras.c | 85 +++++++++++++++++++++++++++-
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 17996bc9382b..ad47fa865324 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -210,6 +210,7 @@ extern void release_mce_event(void);
 extern void machine_check_queue_event(void);
 extern void machine_check_print_event_info(struct machine_check_event *evt,
 					   bool user_mode, bool in_guest);
+unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr);
 #ifdef CONFIG_PPC_BOOK3S_64
 void flush_and_reload_slb(void);
 #endif /* CONFIG_PPC_BOOK3S_64 */
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 6b800eec31f2..367fbfa2e835 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -36,7 +36,7 @@
  * Convert an address related to an mm to a PFN. NOTE: we are in real
  * mode, we could potentially race with page table updates.
  */
-static unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
+unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 {
 	pte_t *ptep;
 	unsigned long flags;
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 452dcfd7e5dd..d689b5fa6354 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -41,6 +41,18 @@ static struct irq_work mce_errlog_process_work = {
 	.func = mce_process_errlog_event,
 };
 
+#ifdef CONFIG_MEMORY_FAILURE
+
+static void pseries_hwpoison_work_fn(struct work_struct *work);
+static DEFINE_PER_CPU(int, rtas_ue_count);
+static DEFINE_PER_CPU(unsigned long, rtas_ue_paddr[MAX_MC_EVT]);
+static DECLARE_WORK(hwpoison_work, pseries_hwpoison_work_fn);
+
+#define UE_EFFECTIVE_ADDR_PROVIDED	PPC_BIT8(1)
+#define UE_LOGICAL_ADDR_PROVIDED	PPC_BIT8(2)
+
+#endif /* CONFIG_MEMORY_FAILURE */
+
 #define EPOW_SENSOR_TOKEN	9
 #define EPOW_SENSOR_INDEX	0
 
@@ -707,6 +719,75 @@ static int mce_handle_error(struct rtas_error_log *errp)
 	return disposition;
 }
 
+#ifdef CONFIG_MEMORY_FAILURE
+
+static void pseries_hwpoison_work_fn(struct work_struct *work)
+{
+	unsigned long paddr;
+	int index;
+
+	while (__this_cpu_read(rtas_ue_count) > 0) {
+		index = __this_cpu_read(rtas_ue_count) - 1;
+		paddr = __this_cpu_read(rtas_ue_paddr[index]);
+		memory_failure(paddr >> PAGE_SHIFT, 0);
+		__this_cpu_dec(rtas_ue_count);
+	}
+}
+
+static void queue_ue_paddr(unsigned long paddr)
+{
+	int index;
+
+	index = __this_cpu_inc_return(rtas_ue_count) - 1;
+	if (index >= MAX_MC_EVT) {
+		__this_cpu_dec(rtas_ue_count);
+		return;
+	}
+	this_cpu_write(rtas_ue_paddr[index], paddr);
+	schedule_work(&hwpoison_work);
+}
+
+static void pseries_do_memory_failure(struct pt_regs *regs,
+				      struct pseries_mc_errorlog *mce_log)
+{
+	unsigned long paddr;
+
+	if (mce_log->sub_err_type & UE_LOGICAL_ADDR_PROVIDED) {
+		paddr = be64_to_cpu(mce_log->logical_address);
+	} else if (mce_log->sub_err_type & UE_EFFECTIVE_ADDR_PROVIDED) {
+		unsigned long pfn;
+
+		pfn = addr_to_pfn(regs,
+				  be64_to_cpu(mce_log->effective_address));
+		if (pfn == ULONG_MAX)
+			return;
+		paddr = pfn << PAGE_SHIFT;
+	} else {
+		return;
+	}
+	queue_ue_paddr(paddr);
+}
+
+static void pseries_process_ue(struct pt_regs *regs,
+			       struct rtas_error_log *errp)
+{
+	struct pseries_errorlog *pseries_log;
+	struct pseries_mc_errorlog *mce_log;
+
+	if (!rtas_error_extended(errp))
+		return;
+
+	pseries_log = get_pseries_errorlog(errp, PSERIES_ELOG_SECT_ID_MCE);
+	if (!pseries_log)
+		return;
+
+	mce_log = (struct pseries_mc_errorlog *)pseries_log->data;
+
+	if (mce_log->error_type == MC_ERROR_TYPE_UE)
+		pseries_do_memory_failure(regs, mce_log);
+}
+#endif /*CONFIG_MEMORY_FAILURE */
+
 /*
  * Process MCE rtas errlog event.
  */
@@ -764,7 +845,9 @@ static int recover_mce(struct pt_regs *regs, struct rtas_error_log *err)
 		_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
 		recovered = 1;
 	}
-
+#ifdef CONFIG_MEMORY_FAILURE
+	pseries_process_ue(regs, err);
+#endif
 	/* Queue irq work to log this rtas event later. */
 	irq_work_queue(&mce_errlog_process_work);
 
-- 
2.17.2

