Return-Path: <linuxppc-dev+bounces-18192-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD8710706DC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Mar 2026 13:25:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fY2C83nfRz2xgv;
	Sun, 15 Mar 2026 00:24:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773494692;
	cv=none; b=XJ1knKT4nmYdytVKp6qSPf2oz062V/ZWspJo5B/HeUuVI5b3RcnCJ/CIMFKQjmZ/NoRSvrfwq9GiLA3s6QfXAtu/k08csQAIf+GDioLwdYrr7gzwqTcAjS6ZMQh5Vm/G2oFu28EW+UggJP47g6aH2N0F/zok0mg5s6Z4BQpT0SDiySxRzLOxxiLk/juY6jGSa+otocvIPxhnVjophGCExFYidozdCJMolkUweyUq+WR+AfbS/tndtq19UlAqTmmSQe74UYz2cfA/KGpgPfxlYzAMRh7PAJak+Oh/mn2lTfl57K62d8+KBFEvChWBuJpCtl26F80lVbS59pYMR1P+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773494692; c=relaxed/relaxed;
	bh=WOZVu7PdOQVme48cDrsHRZnHFRbkzvsd4gziWBiHRyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sbm2EHFMGMVpV9CPGlzrFIVvZ690HwYowAjoPYXN4fwMSKYFnV5qI9IZecizSejA+UQml2ISQuBqs7Ci5lR9EfQjnG0POHqRgrLdMExgc60gdKgin0sKypXUIIxDGNLznR5uJUldv0rK2BNMcaD6iaa9x1MpLqUYkhKOA7mcEqXh4C1Fhsm3J5zHH/UdUpLi+Fmm7xPMAX7/8mncknmSqscJ9zhfBQme0FXXYk853Tw7zAXMe8M4VXhzFA91NuBIPlUCsigeOwqpG/Nr8UsbWSe1EA14EL9NkS29MuGvBkU6MsgqCMJNvTJZSqMi5a9nyN6FYaCsaEFMSiUh5+wyNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bowip81x; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bowip81x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fY2C76LRYz3bpG
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Mar 2026 00:24:51 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62E6u1eB991317
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WOZVu7PdOQVme48cD
	rsHRZnHFRbkzvsd4gziWBiHRyE=; b=bowip81xqI11a12ezt9eO7O1UuMGMRKeW
	Xtuo1vO/bX0ZPIx6TZjZm9Vir/ytTFgy7YMmRqRbnYwoI6sXn7bb2TVIAOd58Wzj
	Xt0nO9xu1yZpKnxPeZEGg0P0ZuS3YPbsznXngAx+lXXf0Wm67jsjw4ixbF+HaOkE
	xv73JsyNrtBPxmGpHB3u4Q2lUtl1fkZsThHd3S5wUZiIIwefPcEmyJAsdmrsM9d0
	FLh1bywAJV0PiQhuerFGCcb7mYGGtG7xRAMdAWCZX0rYb8dtUqyKWlwPwCIh2PId
	FZWc2SfpNolPrfEzY/37lMH0Nnrog4VIqLIGtLL+juq9MhSZG+Wog==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy6499gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:24:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62E8OfhK018361
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:24:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8ae4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:24:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62EDOj3l58458496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Mar 2026 13:24:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B26F20043;
	Sat, 14 Mar 2026 13:24:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9194920040;
	Sat, 14 Mar 2026 13:24:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.218.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 14 Mar 2026 13:24:43 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH 3/3] powerpc/pseries/htmdump: Fix the offset value used in htm status dump
Date: Sat, 14 Mar 2026 18:54:32 +0530
Message-Id: <20260314132432.25581-3-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260314132432.25581-1-atrajeev@linux.ibm.com>
References: <20260314132432.25581-1-atrajeev@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OcxdQ2OIAqRidHtxyZp_-DZv2u6azws1
X-Proofpoint-GUID: OcxdQ2OIAqRidHtxyZp_-DZv2u6azws1
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b561a2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=r3PrFMhtbkYojMpozuMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDEwMyBTYWx0ZWRfXyNjmHIjENHKi
 MQ4fioFc5CjRF76gypDP5tkAP7oD0D2udJdFTttdNPDblXqaQa24hjEOS1cVvgF2MUbom6sE/Wr
 xg8TFinUwAQrAzJc3UV4QAiPuZSwIcWmTXj69M0IyFiDG6sLf0m8rEolh43Bj8ovcuAElJ7sweR
 MDYrJJAlvyG9m7olGtWCnSbQcMhSI1vbGQS4dcCCI++gPbGEanus/6HyQFH+vxKUEJkVlPyBop6
 YzVYmKtx1Vh9+vvkK/7y1ATktbM1ymZvdxkWl0G/pojE0c55PB1nep6V6K9GUOnNwdCnv23OZBp
 gqoDeJn3QLRUcxXPbILd5hqizlBwpiOieTBygwp3A3gsHesFcC8OuvCGMIrfBZKcaDLcyBnjxgE
 HQVrLR8KvwXu5edp1aLJ9tbkZrJyd6sr0yeRpyvk8aVVTpkFK70QaDOlw1sNu/hrQeJ5pqTnS6q
 7N6/CzhgxiYmd3AAUjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140103

H_HTM call is invoked using three parameters specifying
the address of the buffer, size of the buffer and offset
where to read from. offset used was always zero.
"offset" is value from output buffer header that points
to next entry to dump. zero is the first entry to dump.
next entry is read from the output bufferbyte offset 0x8.
Update htmstatus_read() function to use right offset. Return
when offset points to -1

Fixes: 627cf584f4c3 ("powerpc/pseries/htmdump: Add htm status support to htmdump module")
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/htmdump.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/htmdump.c b/arch/powerpc/platforms/pseries/htmdump.c
index 34978a794eba..76444c6c5cc1 100644
--- a/arch/powerpc/platforms/pseries/htmdump.c
+++ b/arch/powerpc/platforms/pseries/htmdump.c
@@ -231,15 +231,26 @@ static ssize_t htmstatus_read(struct file *filp, char __user *ubuf,
 	u64 *num_entries;
 	u64 to_copy;
 	int htmstatus_flag;
+	loff_t offset = 0;
+	u64 status_offset = 0;
 
 	/*
 	 * Invoke H_HTM call with:
 	 * - operation as htm status (H_HTM_OP_STATUS)
-	 * - last three values as addr, size and offset
+	 * - last three values as addr, size and offset.
+	 *   "offset" is value from output buffer header
+	 *   that points to next entry to dump. 0 is the first
+	 *   entry to dump. next entry is read from the output
+	 *   bufferbyte offset 0x8.
 	 */
+	if (*ppos) {
+		status_offset = *(u64 *)(htm_status_data + 0x8);
+		if (status_offset == -1)
+			return 0;
+	}
 	rc = htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreindexonchip,
 				   htmtype, H_HTM_OP_STATUS, virt_to_phys(htm_status_data),
-				   PAGE_SIZE, 0);
+				   PAGE_SIZE, be64_to_cpu(status_offset));
 
 	ret = htm_return_check(rc);
 	if (ret <= 0) {
@@ -261,7 +272,9 @@ static ssize_t htmstatus_read(struct file *filp, char __user *ubuf,
 	else
 		htmstatus_flag = 0x6;
 	to_copy = 32 + (be64_to_cpu(*num_entries) * htmstatus_flag);
-	return simple_read_from_buffer(ubuf, count, ppos, htm_status_data, to_copy);
+	*ppos += to_copy;
+
+	return simple_read_from_buffer(ubuf, count, &offset, htm_status_data, to_copy);
 }
 
 static const struct file_operations htmstatus_fops = {
-- 
2.47.3


