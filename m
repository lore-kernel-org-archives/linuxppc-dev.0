Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586B8C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 09:40:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB426218D3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 09:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB426218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Qdtk52jMzDqTj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 20:40:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QdpN2b4jzDqTb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 20:36:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44QdpN1dZrz8tBg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 20:36:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44QdpN10jcz9sRs; Fri, 22 Mar 2019 20:36:44 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 44QdpM4Ph3z9sRj
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Mar 2019 20:36:43 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2M9XV81009447
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Mar 2019 05:36:41 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rcv3u2nvk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Mar 2019 05:36:41 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 22 Mar 2019 09:36:38 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Mar 2019 09:36:34 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2M9aYmd49283212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Mar 2019 09:36:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4E5BAE045;
 Fri, 22 Mar 2019 09:36:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA4A9AE04D;
 Fri, 22 Mar 2019 09:36:32 +0000 (GMT)
Received: from jupiter.in.ibm.com (unknown [9.193.101.136])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Mar 2019 09:36:32 +0000 (GMT)
Subject: [RFC PATCH 2/3] powernv/mce: Print correct severity for mce error.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Fri, 22 Mar 2019 15:06:31 +0530
In-Reply-To: <155324738319.7819.17982472592795327790.stgit@jupiter.in.ibm.com>
References: <155324738319.7819.17982472592795327790.stgit@jupiter.in.ibm.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032209-0028-0000-0000-000003570086
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032209-0029-0000-0000-00002415AA64
Message-Id: <155324739171.7819.1095626412782166400.stgit@jupiter.in.ibm.com>
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

Currently all machine check errors are printed as severe errors which isn't
correct. Print soft errors as warning instead of severe errors.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mce.h        |   26 +++---
 arch/powerpc/kernel/mce.c             |    5 +
 arch/powerpc/kernel/mce_power.c       |  143 +++++++++++++++++----------------
 arch/powerpc/platforms/powernv/opal.c |    2 
 4 files changed, 92 insertions(+), 84 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 8d0b1c24c636..314ed3f13d59 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -31,7 +31,7 @@ enum MCE_Version {
 enum MCE_Severity {
 	MCE_SEV_NO_ERROR = 0,
 	MCE_SEV_WARNING = 1,
-	MCE_SEV_ERROR_SYNC = 2,
+	MCE_SEV_SEVERE = 2,
 	MCE_SEV_FATAL = 3,
 };
 
@@ -110,17 +110,18 @@ enum MCE_LinkErrorType {
 };
 
 struct machine_check_event {
-	enum MCE_Version	version:8;	/* 0x00 */
-	uint8_t			in_use;		/* 0x01 */
-	enum MCE_Severity	severity:8;	/* 0x02 */
-	enum MCE_Initiator	initiator:8;	/* 0x03 */
-	enum MCE_ErrorType	error_type:8;	/* 0x04 */
-	enum MCE_Disposition	disposition:8;	/* 0x05 */
-	uint16_t		cpu;		/* 0x06 */
-	uint64_t		gpr3;		/* 0x08 */
-	uint64_t		srr0;		/* 0x10 */
-	uint64_t		srr1;		/* 0x18 */
-	union {					/* 0x20 */
+	enum MCE_Version	version:8;
+	uint8_t			in_use;
+	enum MCE_Severity	severity:8;
+	enum MCE_Initiator	initiator:8;
+	enum MCE_ErrorType	error_type:8;
+	enum MCE_Disposition	disposition:8;
+	uint8_t			sync_error;
+	uint16_t		cpu;
+	uint64_t		gpr3;
+	uint64_t		srr0;
+	uint64_t		srr1;
+	union {
 		struct {
 			enum MCE_UeErrorType ue_error_type:8;
 			uint8_t		effective_address_provided;
@@ -194,6 +195,7 @@ struct mce_error_info {
 	} u;
 	enum MCE_Severity	severity:8;
 	enum MCE_Initiator	initiator:8;
+	uint8_t			sync_error;
 };
 
 #define MAX_MC_EVT	100
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 44614462cb34..588a280a8a4a 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -122,6 +122,7 @@ void save_mce_event(struct pt_regs *regs, long handled,
 
 	mce->initiator = mce_err->initiator;
 	mce->severity = mce_err->severity;
+	mce->sync_error = mce_err->sync_error;
 
 	/*
 	 * Populate the mce error_type and type-specific error_type.
@@ -374,9 +375,9 @@ void machine_check_print_event_info(struct machine_check_event *evt,
 		break;
 	case MCE_SEV_WARNING:
 		level = KERN_WARNING;
-		sevstr = "";
+		sevstr = "Warning";
 		break;
-	case MCE_SEV_ERROR_SYNC:
+	case MCE_SEV_SEVERE:
 		level = KERN_ERR;
 		sevstr = "Severe";
 		break;
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 6b800eec31f2..06161de19060 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -133,106 +133,107 @@ struct mce_ierror_table {
 	unsigned int error_subtype;
 	unsigned int initiator;
 	unsigned int severity;
+	bool sync_error;
 };
 
 static const struct mce_ierror_table mce_p7_ierror_table[] = {
 { 0x00000000001c0000, 0x0000000000040000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000001c0000, 0x0000000000080000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000001c0000, 0x00000000000c0000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000001c0000, 0x0000000000100000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_INDETERMINATE, /* BOTH */
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000001c0000, 0x0000000000140000, true,
   MCE_ERROR_TYPE_TLB, MCE_TLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000001c0000, 0x0000000000180000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000001c0000, 0x00000000001c0000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
-{ 0, 0, 0, 0, 0, 0 } };
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
+{ 0, 0, 0, 0, 0, 0, 0 } };
 
 static const struct mce_ierror_table mce_p8_ierror_table[] = {
 { 0x00000000081c0000, 0x0000000000040000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000000080000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x00000000000c0000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000081c0000, 0x0000000000100000, true,
   MCE_ERROR_TYPE_ERAT,MCE_ERAT_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000081c0000, 0x0000000000140000, true,
   MCE_ERROR_TYPE_TLB, MCE_TLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000081c0000, 0x0000000000180000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x00000000001c0000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000008000000, true,
   MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_IFETCH_TIMEOUT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000008040000, true,
   MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_PAGE_TABLE_WALK_IFETCH_TIMEOUT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
-{ 0, 0, 0, 0, 0, 0 } };
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
+{ 0, 0, 0, 0, 0, 0, 0 } };
 
 static const struct mce_ierror_table mce_p9_ierror_table[] = {
 { 0x00000000081c0000, 0x0000000000040000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000000080000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x00000000000c0000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000081c0000, 0x0000000000100000, true,
   MCE_ERROR_TYPE_ERAT,MCE_ERAT_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000081c0000, 0x0000000000140000, true,
   MCE_ERROR_TYPE_TLB, MCE_TLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_WARNING, true },
 { 0x00000000081c0000, 0x0000000000180000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x00000000001c0000, true,
   MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_IFETCH_FOREIGN,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000008000000, true,
   MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_IFETCH_TIMEOUT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000008040000, true,
   MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_PAGE_TABLE_WALK_IFETCH_TIMEOUT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x00000000080c0000, true,
   MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_IFETCH,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000008100000, true,
   MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
 { 0x00000000081c0000, 0x0000000008140000, false,
   MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_STORE,
-  MCE_INITIATOR_CPU,  MCE_SEV_FATAL, }, /* ASYNC is fatal */
+  MCE_INITIATOR_CPU,  MCE_SEV_FATAL, false }, /* ASYNC is fatal */
 { 0x00000000081c0000, 0x0000000008180000, false,
   MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_STORE_TIMEOUT,
-  MCE_INITIATOR_CPU,  MCE_SEV_FATAL, }, /* ASYNC is fatal */
+  MCE_INITIATOR_CPU,  MCE_SEV_FATAL, false }, /* ASYNC is fatal */
 { 0x00000000081c0000, 0x00000000081c0000, true,
   MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH_FOREIGN,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
-{ 0, 0, 0, 0, 0, 0 } };
+  MCE_INITIATOR_CPU,  MCE_SEV_SEVERE, true },
+{ 0, 0, 0, 0, 0, 0, 0 } };
 
 struct mce_derror_table {
 	unsigned long dsisr_value;
@@ -241,103 +242,104 @@ struct mce_derror_table {
 	unsigned int error_subtype;
 	unsigned int initiator;
 	unsigned int severity;
+	bool sync_error;
 };
 
 static const struct mce_derror_table mce_p7_derror_table[] = {
 { 0x00008000, false,
   MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_LOAD_STORE,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00004000, true,
   MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000800, true,
   MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000400, true,
   MCE_ERROR_TYPE_TLB,  MCE_TLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000080, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,	/* Before PARITY */
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000100, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000040, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_INDETERMINATE, /* BOTH */
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
-{ 0, false, 0, 0, 0, 0 } };
+  MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
+{ 0, false, 0, 0, 0, 0, 0 } };
 
 static const struct mce_derror_table mce_p8_derror_table[] = {
 { 0x00008000, false,
   MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_LOAD_STORE,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00004000, true,
   MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00002000, true,
   MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_LOAD_TIMEOUT,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00001000, true,
   MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_PAGE_TABLE_WALK_LOAD_STORE_TIMEOUT,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000800, true,
   MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000400, true,
   MCE_ERROR_TYPE_TLB,  MCE_TLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000200, true,
   MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT, /* SECONDARY ERAT */
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000080, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,	/* Before PARITY */
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000100, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
-{ 0, false, 0, 0, 0, 0 } };
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
+{ 0, false, 0, 0, 0, 0, 0 } };
 
 static const struct mce_derror_table mce_p9_derror_table[] = {
 { 0x00008000, false,
   MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_LOAD_STORE,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00004000, true,
   MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00002000, true,
   MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_LOAD_TIMEOUT,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00001000, true,
   MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_PAGE_TABLE_WALK_LOAD_STORE_TIMEOUT,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000800, true,
   MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000400, true,
   MCE_ERROR_TYPE_TLB,  MCE_TLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000200, false,
   MCE_ERROR_TYPE_USER, MCE_USER_ERROR_TLBIE,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000080, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,	/* Before PARITY */
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_WARNING, true },
 { 0x00000100, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000040, true,
   MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_LOAD,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000020, false,
   MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000010, false,
   MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE_FOREIGN,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
 { 0x00000008, false,
   MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_LOAD_STORE_FOREIGN,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
-{ 0, false, 0, 0, 0, 0 } };
+  MCE_INITIATOR_CPU,   MCE_SEV_SEVERE, true },
+{ 0, false, 0, 0, 0, 0, 0 } };
 
 static int mce_find_instr_ea_and_pfn(struct pt_regs *regs, uint64_t *addr,
 					uint64_t *phys_addr)
@@ -427,11 +429,12 @@ static int mce_handle_ierror(struct pt_regs *regs,
 			mce_err->u.link_error_type = table[i].error_subtype;
 			break;
 		}
+		mce_err->sync_error = table[i].sync_error;
 		mce_err->severity = table[i].severity;
 		mce_err->initiator = table[i].initiator;
 		if (table[i].nip_valid) {
 			*addr = regs->nip;
-			if (mce_err->severity == MCE_SEV_ERROR_SYNC &&
+			if (mce_err->sync_error &&
 				table[i].error_type == MCE_ERROR_TYPE_UE) {
 				unsigned long pfn;
 
@@ -448,7 +451,7 @@ static int mce_handle_ierror(struct pt_regs *regs,
 	}
 
 	mce_err->error_type = MCE_ERROR_TYPE_UNKNOWN;
-	mce_err->severity = MCE_SEV_ERROR_SYNC;
+	mce_err->severity = MCE_SEV_SEVERE;
 	mce_err->initiator = MCE_INITIATOR_CPU;
 
 	return 0;
@@ -519,11 +522,12 @@ static int mce_handle_derror(struct pt_regs *regs,
 			mce_err->u.link_error_type = table[i].error_subtype;
 			break;
 		}
+		mce_err->sync_error = table[i].sync_error;
 		mce_err->severity = table[i].severity;
 		mce_err->initiator = table[i].initiator;
 		if (table[i].dar_valid)
 			*addr = regs->dar;
-		else if (mce_err->severity == MCE_SEV_ERROR_SYNC &&
+		else if (mce_err->sync_error &&
 				table[i].error_type == MCE_ERROR_TYPE_UE) {
 			/*
 			 * We do a maximum of 4 nested MCE calls, see
@@ -539,8 +543,9 @@ static int mce_handle_derror(struct pt_regs *regs,
 		return handled;
 
 	mce_err->error_type = MCE_ERROR_TYPE_UNKNOWN;
-	mce_err->severity = MCE_SEV_ERROR_SYNC;
+	mce_err->severity = MCE_SEV_SEVERE;
 	mce_err->initiator = MCE_INITIATOR_CPU;
+	mce_err->sync_error = 1;
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 77552e525e33..f2b063b027f0 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -505,7 +505,7 @@ static int opal_recover_mce(struct pt_regs *regs,
 		recovered = 0;
 	}
 
-	if (!recovered && evt->severity == MCE_SEV_ERROR_SYNC) {
+	if (!recovered && evt->sync_error) {
 		/*
 		 * Try to kill processes if we get a synchronous machine check
 		 * (e.g., one caused by execution of this instruction). This

