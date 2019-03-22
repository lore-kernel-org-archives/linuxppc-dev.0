Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD769C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 09:38:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0083B218D3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 09:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0083B218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QdrH6zwXzDqTQ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 20:38:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QdpF5QRJzDqSp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 20:36:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44QdpF4Ybqz8x8X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 20:36:37 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44QdpF4Bpcz9sRs; Fri, 22 Mar 2019 20:36:37 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 44QdpD5rkKz9sRj
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Mar 2019 20:36:35 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2M9XUOL066435
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Mar 2019 05:36:33 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rcw02gkvt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Mar 2019 05:36:33 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 22 Mar 2019 09:36:22 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Mar 2019 09:36:18 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2M9aQaa33030244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Mar 2019 09:36:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32D0CAE056;
 Fri, 22 Mar 2019 09:36:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AD39AE045;
 Fri, 22 Mar 2019 09:36:24 +0000 (GMT)
Received: from jupiter.in.ibm.com (unknown [9.193.101.136])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Mar 2019 09:36:24 +0000 (GMT)
Subject: [RFC PATCH 1/3] powernv/mce: reduce mce console logs to lesser lines.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Fri, 22 Mar 2019 15:06:23 +0530
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032209-4275-0000-0000-0000031DFCFE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032209-4276-0000-0000-0000382C87F9
Message-Id: <155324738319.7819.17982472592795327790.stgit@jupiter.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-22_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=845 adultscore=0 classifier=spam adjust=0 reason=mlx
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

Also add cpu number while displaying mce log. This will help cleaner logs
when mce hits on multiple cpus simultaneously.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mce.h |    2 -
 arch/powerpc/kernel/mce.c      |   86 ++++++++++++++++++++--------------------
 2 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 17996bc9382b..8d0b1c24c636 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -116,7 +116,7 @@ struct machine_check_event {
 	enum MCE_Initiator	initiator:8;	/* 0x03 */
 	enum MCE_ErrorType	error_type:8;	/* 0x04 */
 	enum MCE_Disposition	disposition:8;	/* 0x05 */
-	uint8_t			reserved_1[2];	/* 0x06 */
+	uint16_t		cpu;		/* 0x06 */
 	uint64_t		gpr3;		/* 0x08 */
 	uint64_t		srr0;		/* 0x10 */
 	uint64_t		srr1;		/* 0x18 */
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index b5fec1f9751a..44614462cb34 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -112,6 +112,7 @@ void save_mce_event(struct pt_regs *regs, long handled,
 	mce->srr1 = regs->msr;
 	mce->gpr3 = regs->gpr[3];
 	mce->in_use = 1;
+	mce->cpu = get_paca()->paca_index;
 
 	/* Mark it recovered if we have handled it and MSR(RI=1). */
 	if (handled && (regs->msr & MSR_RI))
@@ -310,7 +311,9 @@ static void machine_check_process_queued_event(struct irq_work *work)
 void machine_check_print_event_info(struct machine_check_event *evt,
 				    bool user_mode, bool in_guest)
 {
-	const char *level, *sevstr, *subtype;
+	const char *level, *sevstr, *subtype, *err_type;
+	uint64_t ea = 0;
+	char dar_str[50];
 	static const char *mc_ue_types[] = {
 		"Indeterminate",
 		"Instruction fetch",
@@ -384,101 +387,100 @@ void machine_check_print_event_info(struct machine_check_event *evt,
 		break;
 	}
 
-	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
-	       evt->disposition == MCE_DISPOSITION_RECOVERED ?
-	       "Recovered" : "Not recovered");
-
-	if (in_guest) {
-		printk("%s  Guest NIP: %016llx\n", level, evt->srr0);
-	} else if (user_mode) {
-		printk("%s  NIP: [%016llx] PID: %d Comm: %s\n", level,
-			evt->srr0, current->pid, current->comm);
-	} else {
-		printk("%s  NIP [%016llx]: %pS\n", level, evt->srr0,
-		       (void *)evt->srr0);
-	}
-
-	printk("%s  Initiator: %s\n", level,
-	       evt->initiator == MCE_INITIATOR_CPU ? "CPU" : "Unknown");
 	switch (evt->error_type) {
 	case MCE_ERROR_TYPE_UE:
+		err_type = "UE";
 		subtype = evt->u.ue_error.ue_error_type <
 			ARRAY_SIZE(mc_ue_types) ?
 			mc_ue_types[evt->u.ue_error.ue_error_type]
 			: "Unknown";
-		printk("%s  Error type: UE [%s]\n", level, subtype);
 		if (evt->u.ue_error.effective_address_provided)
-			printk("%s    Effective address: %016llx\n",
-			       level, evt->u.ue_error.effective_address);
-		if (evt->u.ue_error.physical_address_provided)
-			printk("%s    Physical address:  %016llx\n",
-			       level, evt->u.ue_error.physical_address);
+			ea = evt->u.ue_error.effective_address;
 		break;
 	case MCE_ERROR_TYPE_SLB:
+		err_type = "SLB";
 		subtype = evt->u.slb_error.slb_error_type <
 			ARRAY_SIZE(mc_slb_types) ?
 			mc_slb_types[evt->u.slb_error.slb_error_type]
 			: "Unknown";
-		printk("%s  Error type: SLB [%s]\n", level, subtype);
 		if (evt->u.slb_error.effective_address_provided)
-			printk("%s    Effective address: %016llx\n",
-			       level, evt->u.slb_error.effective_address);
+			ea = evt->u.slb_error.effective_address;
 		break;
 	case MCE_ERROR_TYPE_ERAT:
+		err_type = "ERAT";
 		subtype = evt->u.erat_error.erat_error_type <
 			ARRAY_SIZE(mc_erat_types) ?
 			mc_erat_types[evt->u.erat_error.erat_error_type]
 			: "Unknown";
-		printk("%s  Error type: ERAT [%s]\n", level, subtype);
 		if (evt->u.erat_error.effective_address_provided)
-			printk("%s    Effective address: %016llx\n",
-			       level, evt->u.erat_error.effective_address);
+			ea = evt->u.erat_error.effective_address;
 		break;
 	case MCE_ERROR_TYPE_TLB:
+		err_type = "TLB";
 		subtype = evt->u.tlb_error.tlb_error_type <
 			ARRAY_SIZE(mc_tlb_types) ?
 			mc_tlb_types[evt->u.tlb_error.tlb_error_type]
 			: "Unknown";
-		printk("%s  Error type: TLB [%s]\n", level, subtype);
 		if (evt->u.tlb_error.effective_address_provided)
-			printk("%s    Effective address: %016llx\n",
-			       level, evt->u.tlb_error.effective_address);
+			ea = evt->u.tlb_error.effective_address;
 		break;
 	case MCE_ERROR_TYPE_USER:
+		err_type = "User";
 		subtype = evt->u.user_error.user_error_type <
 			ARRAY_SIZE(mc_user_types) ?
 			mc_user_types[evt->u.user_error.user_error_type]
 			: "Unknown";
-		printk("%s  Error type: User [%s]\n", level, subtype);
 		if (evt->u.user_error.effective_address_provided)
-			printk("%s    Effective address: %016llx\n",
-			       level, evt->u.user_error.effective_address);
+			ea = evt->u.user_error.effective_address;
 		break;
 	case MCE_ERROR_TYPE_RA:
+		err_type = "Real address";
 		subtype = evt->u.ra_error.ra_error_type <
 			ARRAY_SIZE(mc_ra_types) ?
 			mc_ra_types[evt->u.ra_error.ra_error_type]
 			: "Unknown";
-		printk("%s  Error type: Real address [%s]\n", level, subtype);
 		if (evt->u.ra_error.effective_address_provided)
-			printk("%s    Effective address: %016llx\n",
-			       level, evt->u.ra_error.effective_address);
+			ea = evt->u.ra_error.effective_address;
 		break;
 	case MCE_ERROR_TYPE_LINK:
+		err_type = "Link";
 		subtype = evt->u.link_error.link_error_type <
 			ARRAY_SIZE(mc_link_types) ?
 			mc_link_types[evt->u.link_error.link_error_type]
 			: "Unknown";
-		printk("%s  Error type: Link [%s]\n", level, subtype);
 		if (evt->u.link_error.effective_address_provided)
-			printk("%s    Effective address: %016llx\n",
-			       level, evt->u.link_error.effective_address);
+			ea = evt->u.link_error.effective_address;
 		break;
 	default:
 	case MCE_ERROR_TYPE_UNKNOWN:
-		printk("%s  Error type: Unknown\n", level);
+		err_type = "Unknown";
+		subtype = "";
 		break;
 	}
+
+	if (ea && evt->srr0 != ea)
+		sprintf(dar_str, "DAR: %016llx ", ea);
+	else
+		memset(dar_str, 0, sizeof(dar_str));
+
+	if (in_guest || user_mode) {
+		printk("%sMCE: CPU%d: (%s) %s %s %s at %016llx %s[%s]\n",
+			level, evt->cpu, sevstr,
+			in_guest ? "Guest" : "Host",
+			err_type, subtype, evt->srr0, dar_str,
+			evt->disposition == MCE_DISPOSITION_RECOVERED ?
+			"Recovered" : "Not recovered");
+		printk("%sMCE: CPU%d: PID: %d Comm: %s\n",
+			level, evt->cpu, current->pid, current->comm);
+	} else {
+		printk("%sMCE: CPU%d: (%s) Host %s %s at %016llx %s[%s]\n",
+			level, evt->cpu, sevstr, err_type, subtype, evt->srr0,
+			dar_str,
+			evt->disposition == MCE_DISPOSITION_RECOVERED ?
+			"Recovered" : "Not recovered");
+		printk("%sMCE: CPU%d: NIP: [%016llx] %pS\n",
+			level, evt->cpu, evt->srr0, (void *)evt->srr0);
+	}
 }
 EXPORT_SYMBOL_GPL(machine_check_print_event_info);
 

