Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9A6C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 19:44:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EB220823
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 19:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EB220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Cr8L2L2pzDqHw
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 06:44:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Cr5n5mSkzDqF0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 06:42:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Cr5n34kfz8t7p
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 06:42:37 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Cr5n26hXz9s5R; Tue,  5 Mar 2019 06:42:37 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mahesh@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Cr5l3kr3z9s00
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Mar 2019 06:42:34 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x24Ja394137560
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Mar 2019 14:42:29 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r17ckqjxh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 04 Mar 2019 14:42:29 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 4 Mar 2019 19:42:22 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 4 Mar 2019 19:42:21 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x24JgKfk28639364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Mar 2019 19:42:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B9E211C050;
 Mon,  4 Mar 2019 19:42:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A83D11C04A;
 Mon,  4 Mar 2019 19:42:20 +0000 (GMT)
Received: from [192.168.0.25] (unknown [9.199.42.223])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  4 Mar 2019 19:42:19 +0000 (GMT)
Subject: [PATCH] powerpc/hmi: Fix kernel hang when TB is in error state.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Tue, 05 Mar 2019 01:12:19 +0530
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030419-0020-0000-0000-0000031E72E6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030419-0021-0000-0000-0000217077F3
Message-Id: <155172853902.20037.16712960724031791025.stgit@jupiter>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-04_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040140
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

On TOD/TB errors timebase register stops/freezes until HMI error recovery
gets TOD/TB back into running state. On successful recovery, TB starts
running again and udelay() that relies on TB value continues to function
properly. But in case when HMI fails to recover from TOD/TB errors, the
TB register stay freezed. With TB not running the __delay() function
keeps looping and never return. If __delay() is called while in panic
path then system hangs and never reboots after panic.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
This patch has been tested with below skiboot changes:
http://patchwork.ozlabs.org/project/skiboot/list/?series=95315
---
 arch/powerpc/include/asm/opal-api.h            |   10 ++++++++++
 arch/powerpc/include/asm/opal.h                |    2 ++
 arch/powerpc/include/asm/time.h                |    2 ++
 arch/powerpc/kernel/time.c                     |    9 +++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 +
 arch/powerpc/platforms/powernv/opal.c          |   21 +++++++++++++++++++++
 arch/powerpc/platforms/powernv/setup.c         |    5 ++++-
 7 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 870fb7b239ea..727c74c1693f 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -209,6 +209,7 @@
 #define OPAL_SENSOR_GROUP_ENABLE		163
 #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
 #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
+#define OPAL_HANDLE_HMI2			166
 #define	OPAL_NX_COPROC_INIT			167
 #define OPAL_LAST				167
 
@@ -634,6 +635,15 @@ struct OpalHMIEvent {
 	} u;
 };
 
+/* OPAL_HANDLE_HMI2 out_flags */
+enum {
+	OPAL_HMI_FLAGS_TB_RESYNC	= (1ull << 0), /* Timebase has been resynced */
+	OPAL_HMI_FLAGS_DEC_LOST		= (1ull << 1), /* DEC lost, needs to be reprogrammed */
+	OPAL_HMI_FLAGS_HDEC_LOST	= (1ull << 2), /* HDEC lost, needs to be reprogrammed */
+	OPAL_HMI_FLAGS_TOD_TB_FAIL	= (1ull << 3), /* TOD/TB recovery failed. */
+	OPAL_HMI_FLAGS_NEW_EVENT	= (1ull << 63), /* An event has been created */
+};
+
 enum {
 	OPAL_P7IOC_DIAG_TYPE_NONE	= 0,
 	OPAL_P7IOC_DIAG_TYPE_RGC	= 1,
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index a55b01c90bb1..7b0bc104a89c 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -203,6 +203,7 @@ int64_t opal_set_param(uint64_t token, uint32_t param_id, uint64_t buffer,
 int64_t opal_sensor_read(uint32_t sensor_hndl, int token, __be32 *sensor_data);
 int64_t opal_sensor_read_u64(u32 sensor_hndl, int token, __be64 *sensor_data);
 int64_t opal_handle_hmi(void);
+int64_t opal_handle_hmi2(__be64 *out_flags);
 int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
 int64_t opal_unregister_dump_region(uint32_t id);
 int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
@@ -352,6 +353,7 @@ int opal_power_control_init(void);
 extern int opal_machine_check(struct pt_regs *regs);
 extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
 extern int opal_hmi_exception_early(struct pt_regs *regs);
+extern int opal_hmi_exception_early2(struct pt_regs *regs);
 extern int opal_handle_hmi_exception(struct pt_regs *regs);
 
 extern void opal_shutdown(void);
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 54bf7e68a7e1..57e968413d1e 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -36,6 +36,8 @@ extern unsigned long ppc_proc_freq;
 extern unsigned long ppc_tb_freq;
 #define DEFAULT_TB_FREQ		125000000UL
 
+extern bool tb_invalid;
+
 struct div_result {
 	u64 result_high;
 	u64 result_low;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3646affae963..523a6b455d8e 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -152,6 +152,8 @@ EXPORT_SYMBOL_GPL(ppc_proc_freq);
 unsigned long ppc_tb_freq;
 EXPORT_SYMBOL_GPL(ppc_tb_freq);
 
+bool tb_invalid;
+
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 /*
  * Factor for converting from cputime_t (timebase ticks) to
@@ -461,6 +463,13 @@ void __delay(unsigned long loops)
 				diff += 1000000000;
 			spin_cpu_relax();
 		} while (diff < loops);
+	} else if (tb_invalid) {
+		/*
+		 * TB is in error state and isn't ticking anymore.
+		 * HMI handler was unable to recover from TB error.
+		 * Return immediately, so that kernel won't get stuck here.
+		 */
+		spin_cpu_relax();
 	} else {
 		start = get_tbl();
 		while (get_tbl() - start < loops)
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index f4875fe3f8ff..8ec43594aa1c 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -267,6 +267,7 @@ OPAL_CALL(opal_sensor_read,			OPAL_SENSOR_READ);
 OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
 OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
 OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
+OPAL_CALL(opal_handle_hmi2,			OPAL_HANDLE_HMI2);
 OPAL_CALL(opal_config_cpu_idle_state,		OPAL_CONFIG_CPU_IDLE_STATE);
 OPAL_CALL(opal_slw_set_reg,			OPAL_SLW_SET_REG);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 79586f127521..e4adbcf89cf4 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -613,6 +613,27 @@ int opal_hmi_exception_early(struct pt_regs *regs)
 	return 0;
 }
 
+int opal_hmi_exception_early2(struct pt_regs *regs)
+{
+	s64 rc;
+	__be64 out_flags;
+
+	/*
+	 * call opal hmi handler.
+	 * Check 64-bit flag mask to find out if an event was generated,
+	 * and whether TB is still valid or not etc.
+	 */
+	rc = opal_handle_hmi2(&out_flags);
+	if (rc != OPAL_SUCCESS)
+		return 0;
+
+	if (be64_to_cpu(out_flags) & OPAL_HMI_FLAGS_NEW_EVENT)
+		local_paca->hmi_event_available = 1;
+	if (be64_to_cpu(out_flags) & OPAL_HMI_FLAGS_TOD_TB_FAIL)
+		tb_invalid = true;
+	return 1;
+}
+
 /* HMI exception handler called in virtual mode during check_irq_replay. */
 int opal_handle_hmi_exception(struct pt_regs *regs)
 {
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 14befee4b3f1..3cf40f689aac 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -401,7 +401,10 @@ static void __init pnv_setup_machdep_opal(void)
 	/* ppc_md.system_reset_exception gets filled in by pnv_smp_init() */
 	ppc_md.machine_check_exception = opal_machine_check;
 	ppc_md.mce_check_early_recovery = opal_mce_check_early_recovery;
-	ppc_md.hmi_exception_early = opal_hmi_exception_early;
+	if (opal_check_token(OPAL_HANDLE_HMI2))
+		ppc_md.hmi_exception_early = opal_hmi_exception_early2;
+	else
+		ppc_md.hmi_exception_early = opal_hmi_exception_early;
 	ppc_md.handle_hmi_exception = opal_handle_hmi_exception;
 }
 

