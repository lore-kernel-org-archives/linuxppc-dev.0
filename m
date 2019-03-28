Return-Path: <SRS0=U6gC=R7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C60C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 11:42:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DFD20700
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 11:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DFD20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VNJh4L41zDqKD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 22:42:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VNGj26mlzDqHw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 22:40:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44VNGh5xYlz8tRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 22:40:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44VNGh53R9z9sPp; Thu, 28 Mar 2019 22:40:44 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 44VNGh0mM3z9sPj
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Mar 2019 22:40:43 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2SBYNnS133868
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Mar 2019 07:40:41 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rgtpu8f58-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Mar 2019 07:40:41 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 28 Mar 2019 11:40:38 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Mar 2019 11:40:35 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2SBeYjb55246994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2019 11:40:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF0AA4204C;
 Thu, 28 Mar 2019 11:40:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 284C34204B;
 Thu, 28 Mar 2019 11:40:34 +0000 (GMT)
Received: from [192.168.0.24] (unknown [9.85.72.216])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 28 Mar 2019 11:40:33 +0000 (GMT)
Subject: [PATCH] powerpc/pseries/mce: Improve array initialization.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Thu, 28 Mar 2019 17:10:33 +0530
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032811-0012-0000-0000-0000030865CC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032811-0013-0000-0000-0000213F969D
Message-Id: <155377322203.28683.445138408998573736.stgit@jupiter>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-28_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=607 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280084
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This is a follow up to the patch that fixed misleading print for TLB
mutlihit due to wrongly populated mc_err_types[] array. Convert all the
static array initialization to '[x] = val' style for better
readability of array indexing and avoid any further confusion.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/ras.c |   52 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 452dcfd7e5dd..a25c2ac0c9c0 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -539,44 +539,44 @@ static void pseries_print_mce_info(struct pt_regs *regs,
 	int disposition = rtas_error_disposition(errp);
 
 	static const char * const initiators[] = {
-		"Unknown",
-		"CPU",
-		"PCI",
-		"ISA",
-		"Memory",
-		"Power Mgmt",
+		[0] = "Unknown",
+		[1] = "CPU",
+		[2] = "PCI",
+		[3] = "ISA",
+		[4] = "Memory",
+		[5] = "Power Mgmt",
 	};
 	static const char * const mc_err_types[] = {
-		"UE",
-		"SLB",
-		"ERAT",
-		"Unknown",
-		"TLB",
-		"D-Cache",
-		"Unknown",
-		"I-Cache",
+		[0] = "UE",
+		[1] = "SLB",
+		[2] = "ERAT",
+		[3] = "Unknown",
+		[4] = "TLB",
+		[5] = "D-Cache",
+		[6] = "Unknown",
+		[7] = "I-Cache",
 	};
 	static const char * const mc_ue_types[] = {
-		"Indeterminate",
-		"Instruction fetch",
-		"Page table walk ifetch",
-		"Load/Store",
-		"Page table walk Load/Store",
+		[0] = "Indeterminate",
+		[1] = "Instruction fetch",
+		[2] = "Page table walk ifetch",
+		[3] = "Load/Store",
+		[4] = "Page table walk Load/Store",
 	};
 
 	/* SLB sub errors valid values are 0x0, 0x1, 0x2 */
 	static const char * const mc_slb_types[] = {
-		"Parity",
-		"Multihit",
-		"Indeterminate",
+		[0] = "Parity",
+		[1] = "Multihit",
+		[2] = "Indeterminate",
 	};
 
 	/* TLB and ERAT sub errors valid values are 0x1, 0x2, 0x3 */
 	static const char * const mc_soft_types[] = {
-		"Unknown",
-		"Parity",
-		"Multihit",
-		"Indeterminate",
+		[0] = "Unknown",
+		[1] = "Parity",
+		[2] = "Multihit",
+		[3] = "Indeterminate",
 	};
 
 	if (!rtas_error_extended(errp)) {

