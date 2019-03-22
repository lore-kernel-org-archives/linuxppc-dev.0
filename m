Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC50C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 09:42:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA82021904
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 09:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA82021904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Qdwf72J8zDqTj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 20:42:10 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QdpX0fS9zDqTK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 20:36:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44QdpW6hVxz8tBg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 20:36:51 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44QdpW63Jhz9sRs; Fri, 22 Mar 2019 20:36:51 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mahesh@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44QdpW1RFwz9sRj
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Mar 2019 20:36:50 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2M9XgrO095270
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Mar 2019 05:36:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rctuxx3dj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Mar 2019 05:36:48 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 22 Mar 2019 09:36:38 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Mar 2019 09:36:35 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2M9ahCY17105062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Mar 2019 09:36:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50114A4060;
 Fri, 22 Mar 2019 09:36:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B970CA405B;
 Fri, 22 Mar 2019 09:36:41 +0000 (GMT)
Received: from jupiter.in.ibm.com (unknown [9.193.101.136])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Mar 2019 09:36:41 +0000 (GMT)
Subject: [RFC PATCH 3/3] powenv/mce: print additional information about mce
 error.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Fri, 22 Mar 2019 15:06:40 +0530
In-Reply-To: <155324738319.7819.17982472592795327790.stgit@jupiter.in.ibm.com>
References: <155324738319.7819.17982472592795327790.stgit@jupiter.in.ibm.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032209-0016-0000-0000-00000265DE33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032209-0017-0000-0000-000032C10241
Message-Id: <155324740037.7819.10748646728863055152.stgit@jupiter.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-22_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220072
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
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Print more information about mce error whether it is an hardware or
software error.

Some of the mce errors can be easily categorized as hardware or software
errors e.g. UEs are due to hardware error, where as error triggered due to
invalid usage of tlbie is a pure software bug. But not all the mce errors
can be easily categorize into either software or hardware. There are errors
like multihit errors which are usually result of a software bug, but in
some rare cases a hardware failure can cause a multihit error. In past, we
have seen case where after replacing faulty chip, multihit errors stopped
occurring. Same with parity errors, which are usually due to faulty hardware
but there are chances where multihit can also cause an parity error. Such
errors are difficult to determine what really caused it. Hence this patch
classifies mce errors into following four categorize:
	1. Hardware error:
		UE and Link timeout failure errors.
	2. Hardware error, small probability of software cause:
		SLB/ERAT/TLB Parity errors.
	3. Software error
		Invalid tlbie form.
	4. Software error, small probability of hardware failure
		SLB/ERAT/TLB Multihit errors.

Sample o/p:

[ 1259.331319] MCE: CPU40: (Warning) Guest SLB Multihit at 00007fff9a59dc60 DAR: 000001003d740320 [Recovered]
[ 1259.331324] MCE: CPU40: PID: 24051 Comm: qemu-system-ppc
[ 1259.331345] MCE: CPU40: Software error, small probability of hardware failure

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mce.h  |   10 ++++
 arch/powerpc/kernel/mce.c       |   12 ++++
 arch/powerpc/kernel/mce_power.c |  107 +++++++++++++++++++++++----------------
 3 files changed, 86 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 314ed3f13d59..cef5f3c50a5c 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -56,6 +56,14 @@ enum MCE_ErrorType {
 	MCE_ERROR_TYPE_LINK = 7,
 };
 
+enum MCE_ErrorClass {
+	MCE_ECLASS_UNKNOWN = 0,
+	MCE_ECLASS_HARDWARE,
+	MCE_ECLASS_HARD_INDETERMINATE,
+	MCE_ECLASS_SOFTWARE,
+	MCE_ECLASS_SOFT_INDETERMINATE,
+};
+
 enum MCE_UeErrorType {
 	MCE_UE_ERROR_INDETERMINATE = 0,
 	MCE_UE_ERROR_IFETCH = 1,
@@ -115,6 +123,7 @@ struct machine_check_event {
 	enum MCE_Severity	severity:8;
 	enum MCE_Initiator	initiator:8;
 	enum MCE_ErrorType	error_type:8;
+	enum MCE_ErrorClass	error_class:8;
 	enum MCE_Disposition	disposition:8;
 	uint8_t			sync_error;
 	uint16_t		cpu;
@@ -195,6 +204,7 @@ struct mce_error_info {
 	} u;
 	enum MCE_Severity	severity:8;
 	enum MCE_Initiator	initiator:8;
+	enum MCE_ErrorClass	error_class:8;
 	uint8_t			sync_error;
 };
 
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 588a280a8a4a..1ec7ba7c766d 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -123,6 +123,7 @@ void save_mce_event(struct pt_regs *regs, long handled,
 	mce->initiator = mce_err->initiator;
 	mce->severity = mce_err->severity;
 	mce->sync_error = mce_err->sync_error;
+	mce->error_class = mce_err->error_class;
 
 	/*
 	 * Populate the mce error_type and type-specific error_type.
@@ -361,6 +362,13 @@ void machine_check_print_event_info(struct machine_check_event *evt,
 		"Store (timeout)",
 		"Page table walk Load/Store (timeout)",
 	};
+	static const char *mc_error_class[] = {
+		"Unknown",
+		"Hardware error",
+		"Hardware error, small probability of software cause",
+		"Software error",
+		"Software error, small probability of hardware failure",
+	};
 
 	/* Print things out */
 	if (evt->version != MCE_V1) {
@@ -482,6 +490,10 @@ void machine_check_print_event_info(struct machine_check_event *evt,
 		printk("%sMCE: CPU%d: NIP: [%016llx] %pS\n",
 			level, evt->cpu, evt->srr0, (void *)evt->srr0);
 	}
+
+	subtype = evt->error_class < ARRAY_SIZE(mc_error_class) ?
+		mc_error_class[evt->error_class] : "Unknown";
+	printk("%sMCE: CPU%d: %s\n", level, evt->cpu, subtype);
 }
 EXPORT_SYMBOL_GPL(machine_check_print_event_info);
 
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 06161de19060..adeed82e59c9 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -131,6 +131,7 @@ struct mce_ierror_table {
 	bool nip_valid; /* nip is a valid indicator of faulting address */
 	unsigned int error_type;
 	unsigned int error_subtype;
+	unsigned int error_class;
 	unsigned int initiator;
 	unsigned int severity;
 	bool sync_error;
@@ -138,99 +139,103 @@ struct mce_ierror_table {
 
 static const struct mce_ierror_table mce_p7_ierror_table[] = {
 { 0x00000000001c0000, 0x0000000000040000, true,
-  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000001c0000, 0x0000000000080000, true,
-  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY, MCE_ECLASS_HARD_INDETERMINATE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000001c0000, 0x00000000000c0000, true,
-  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000001c0000, 0x0000000000100000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_INDETERMINATE, /* BOTH */
+  MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000001c0000, 0x0000000000140000, true,
-  MCE_ERROR_TYPE_TLB, MCE_TLB_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_TLB, MCE_TLB_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000001c0000, 0x0000000000180000, true,
-  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000001c0000, 0x00000000001c0000, true,
-  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0, 0, 0, 0, 0, 0, 0 } };
 
 static const struct mce_ierror_table mce_p8_ierror_table[] = {
 { 0x00000000081c0000, 0x0000000000040000, true,
-  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000000080000, true,
-  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY, MCE_ECLASS_HARD_INDETERMINATE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x00000000000c0000, true,
-  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000081c0000, 0x0000000000100000, true,
-  MCE_ERROR_TYPE_ERAT,MCE_ERAT_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000081c0000, 0x0000000000140000, true,
-  MCE_ERROR_TYPE_TLB, MCE_TLB_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_TLB, MCE_TLB_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000081c0000, 0x0000000000180000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH,
+  MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x00000000001c0000, true,
-  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000008000000, true,
-  MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_IFETCH_TIMEOUT,
+  MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_IFETCH_TIMEOUT, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000008040000, true,
   MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_PAGE_TABLE_WALK_IFETCH_TIMEOUT,
+  MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0, 0, 0, 0, 0, 0, 0 } };
 
 static const struct mce_ierror_table mce_p9_ierror_table[] = {
 { 0x00000000081c0000, 0x0000000000040000, true,
-  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000000080000, true,
-  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY, MCE_ECLASS_HARD_INDETERMINATE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x00000000000c0000, true,
-  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000081c0000, 0x0000000000100000, true,
-  MCE_ERROR_TYPE_ERAT,MCE_ERAT_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000081c0000, 0x0000000000140000, true,
-  MCE_ERROR_TYPE_TLB, MCE_TLB_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_TLB, MCE_TLB_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000081c0000, 0x0000000000180000, true,
-  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH,
+  MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x00000000001c0000, true,
-  MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_IFETCH_FOREIGN,
+  MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_IFETCH_FOREIGN, MCE_ECLASS_SOFTWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000008000000, true,
-  MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_IFETCH_TIMEOUT,
+  MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_IFETCH_TIMEOUT, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000008040000, true,
   MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_PAGE_TABLE_WALK_IFETCH_TIMEOUT,
+  MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x00000000080c0000, true,
-  MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_IFETCH,
+  MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_IFETCH, MCE_ECLASS_SOFTWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000008100000, true,
-  MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH,
+  MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH, MCE_ECLASS_SOFTWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000008140000, false,
-  MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_STORE,
+  MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_STORE, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,  MCE_SEV_FATAL, false }, /* ASYNC is fatal */
 { 0x00000000081c0000, 0x0000000008180000, false,
   MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_STORE_TIMEOUT,
   MCE_INITIATOR_CPU,  MCE_SEV_FATAL, false }, /* ASYNC is fatal */
-{ 0x00000000081c0000, 0x00000000081c0000, true,
+{ 0x00000000081c0000, 0x00000000081c0000, true, MCE_ECLASS_HARDWARE,
   MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH_FOREIGN,
   MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0, 0, 0, 0, 0, 0, 0 } };
@@ -240,6 +245,7 @@ struct mce_derror_table {
 	bool dar_valid; /* dar is a valid indicator of faulting address */
 	unsigned int error_type;
 	unsigned int error_subtype;
+	unsigned int error_class;
 	unsigned int initiator;
 	unsigned int severity;
 	bool sync_error;
@@ -247,97 +253,108 @@ struct mce_derror_table {
 
 static const struct mce_derror_table mce_p7_derror_table[] = {
 { 0x00008000, false,
-  MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_LOAD_STORE,
+  MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_LOAD_STORE, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00004000, true,
   MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE,
+  MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000800, true,
-  MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000400, true,
-  MCE_ERROR_TYPE_TLB,  MCE_TLB_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_TLB,  MCE_TLB_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000080, true,
-  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,	/* Before PARITY */
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000100, true,
-  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY,
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY, MCE_ECLASS_HARD_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000040, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_INDETERMINATE, /* BOTH */
+  MCE_ECLASS_HARD_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0, false, 0, 0, 0, 0, 0 } };
 
 static const struct mce_derror_table mce_p8_derror_table[] = {
 { 0x00008000, false,
-  MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_LOAD_STORE,
+  MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_LOAD_STORE, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00004000, true,
   MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE,
+  MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00002000, true,
-  MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_LOAD_TIMEOUT,
+  MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_LOAD_TIMEOUT, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00001000, true,
   MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_PAGE_TABLE_WALK_LOAD_STORE_TIMEOUT,
+  MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000800, true,
-  MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000400, true,
-  MCE_ERROR_TYPE_TLB,  MCE_TLB_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_TLB,  MCE_TLB_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000200, true,
   MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT, /* SECONDARY ERAT */
+  MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000080, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,	/* Before PARITY */
+  MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000100, true,
-  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY,
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY, MCE_ECLASS_HARD_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0, false, 0, 0, 0, 0, 0 } };
 
 static const struct mce_derror_table mce_p9_derror_table[] = {
 { 0x00008000, false,
-  MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_LOAD_STORE,
+  MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_LOAD_STORE, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00004000, true,
   MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE,
+  MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00002000, true,
-  MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_LOAD_TIMEOUT,
+  MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_LOAD_TIMEOUT, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00001000, true,
   MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_PAGE_TABLE_WALK_LOAD_STORE_TIMEOUT,
+  MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000800, true,
-  MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000400, true,
-  MCE_ERROR_TYPE_TLB,  MCE_TLB_ERROR_MULTIHIT,
+  MCE_ERROR_TYPE_TLB,  MCE_TLB_ERROR_MULTIHIT, MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000200, false,
-  MCE_ERROR_TYPE_USER, MCE_USER_ERROR_TLBIE,
+  MCE_ERROR_TYPE_USER, MCE_USER_ERROR_TLBIE, MCE_ECLASS_SOFTWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000080, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,	/* Before PARITY */
+  MCE_ECLASS_SOFT_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000100, true,
-  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY,
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY, MCE_ECLASS_HARD_INDETERMINATE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000040, true,
-  MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_LOAD,
+  MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_LOAD, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000020, false,
   MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE,
+  MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000010, false,
   MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE_FOREIGN,
+  MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000008, false,
-  MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_LOAD_STORE_FOREIGN,
+  MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_LOAD_STORE_FOREIGN, MCE_ECLASS_HARDWARE,
   MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0, false, 0, 0, 0, 0, 0 } };
 
@@ -406,6 +423,7 @@ static int mce_handle_ierror(struct pt_regs *regs,
 
 		/* now fill in mce_error_info */
 		mce_err->error_type = table[i].error_type;
+		mce_err->error_class = table[i].error_class;
 		switch (table[i].error_type) {
 		case MCE_ERROR_TYPE_UE:
 			mce_err->u.ue_error_type = table[i].error_subtype;
@@ -451,6 +469,7 @@ static int mce_handle_ierror(struct pt_regs *regs,
 	}
 
 	mce_err->error_type = MCE_ERROR_TYPE_UNKNOWN;
+	mce_err->error_class = MCE_ECLASS_UNKNOWN;
 	mce_err->severity = MCE_SEV_SEVERE;
 	mce_err->initiator = MCE_INITIATOR_CPU;
 
@@ -499,6 +518,7 @@ static int mce_handle_derror(struct pt_regs *regs,
 
 		/* now fill in mce_error_info */
 		mce_err->error_type = table[i].error_type;
+		mce_err->error_class = table[i].error_class;
 		switch (table[i].error_type) {
 		case MCE_ERROR_TYPE_UE:
 			mce_err->u.ue_error_type = table[i].error_subtype;
@@ -543,6 +563,7 @@ static int mce_handle_derror(struct pt_regs *regs,
 		return handled;
 
 	mce_err->error_type = MCE_ERROR_TYPE_UNKNOWN;
+	mce_err->error_class = MCE_ECLASS_UNKNOWN;
 	mce_err->severity = MCE_SEV_SEVERE;
 	mce_err->initiator = MCE_INITIATOR_CPU;
 	mce_err->sync_error = 1;

