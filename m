Return-Path: <linuxppc-dev+bounces-18191-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CBF10706DE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Mar 2026 13:24:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fY2C70dQKz2xlM;
	Sun, 15 Mar 2026 00:24:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773494690;
	cv=none; b=Fo63w5WcMvodIeAP06mJ1U6vvDFJakGXqfkCu5PNe2MlfG/GufU9BrVqSBLpXhoU/Uu8Mi2MSljEMLz1LfGuyVtlB9MdPiGWqIMoi7oGUHSqqHTREbltWGbIGYr1fRxOrhEWPvQKZWn8skQoKEWTzRTuC/7ufZcI9Yn1OMrjFFf2GG2S6FCvj5HJPGUTas7RuoxktrLKXw+EUGqmMDNptN5ho0zqzGsUXFRPoLcNzsXRje0EpikDaHimB/ouyuM2/1nC4wmCgDYRkVvhR7qyIgfx0Q/PD4tf3X2bTGPPYrb98rpF/ryrSU+RYbpln1CV4mqmC6PM/vv7ZQWUsNmnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773494690; c=relaxed/relaxed;
	bh=kOSwv1rva8KHZJj1jI54EToQiUYUDhXZB51IkDOjPGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bP14Iuiaaz4ggenAi5dt/Rm42/ZNsP4tM3tVpnN47d1zb+bXYTVyQgvz064O/5bZXl3x659Q3EZSDhjyDX2p05PZRMBgLqvOPajdUvi2gh0BHiQGT6ZGA51XGLE7yFaUS20A3Zxz2mAcU5C5Wq39fH7sWun6JZL7x2QK+F/gxIavWE0BT958jlliX8uDLu7lzSA2aQ6G48fkIQRRucdSxbfLiVj6DSgSSgnZZc/a8lrBL1HDIwd1wY0ZBufFpjRxEk49Bcljm/SmV7ClmV5jL9R0y7Ijt+xKvnCOwauw36n3mbyBI5uvvN0nv8dZzEFWYkn/GC4LMye5KpH4zdfxaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gnIfUxYq; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gnIfUxYq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fY2C54mmHz2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Mar 2026 00:24:49 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62E5h1YZ529425
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kOSwv1rva8KHZJj1jI54EToQiUYUDhXZB51IkDOjP
	GU=; b=gnIfUxYqNSp2Lx/dnTGi+wn81RF+o+NndEuZ6X9zrf+zjC0/e4F7wCz8G
	QFsnz/iMR/3YtRLGTluQsXdBQgkWPWhQVhKHSmnKb0rU1Dr5bevZ/+iomgj+PKZs
	p5I2eAxHQjhXnGshdTFu8n+/muA31FCQQhju5PIm4zgOiBmsZG4nUPAskpGGshnV
	byav2GbOzq7Wdd5ittPj2jXuCDhu0EpYrSGeB7tMHsU6tbnxJSlVhVV7sKLH3h/S
	GNvYAMEZWJLzCdnxdYrwTpz6G77HSBD4QLfwxV+MaMO46yfX1SWb19vN1ePnOLXf
	wvW2/a/8UkUeYSLPA+tgCT3/VaVVQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyd398ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:24:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62E8UMJq025697
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:24:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8jdmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:24:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62EDOfMZ46465400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Mar 2026 13:24:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 668682004B;
	Sat, 14 Mar 2026 13:24:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAEDF20043;
	Sat, 14 Mar 2026 13:24:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.218.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 14 Mar 2026 13:24:39 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH 1/3] powerpc/pseries/htmdump: Free the global buffers in htmdump module exit
Date: Sat, 14 Mar 2026 18:54:30 +0530
Message-Id: <20260314132432.25581-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
X-Authority-Analysis: v=2.4 cv=PbPyRyhd c=1 sm=1 tr=0 ts=69b5619e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=WbAkgvuUlIbhePhd3KgA:9
X-Proofpoint-ORIG-GUID: RmXQ-oxiO8dVTbhQm_qt4Y1487A3JPlT
X-Proofpoint-GUID: RmXQ-oxiO8dVTbhQm_qt4Y1487A3JPlT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDEwMyBTYWx0ZWRfX+gjRCqZ2iYjt
 Ab5cdHCLkK665p5IJ3jYiCtAHd+wuOl9vigoZDhDJaRz4phGJS00XCms1Nh4X0uwVzUlJ57q+Wj
 zvHgCBKBb8cUtONRlZSdZOaNqBEdCzMyO+osnnhwNGRrI9a4yKG6DsDru/2xrHCX6nQSzxgNRgh
 wstamwPpfaAbiPCq/k3HI9VzFUfpcpBzuFhCTSHAggfcA30d+LJqCeK+85kITzy5OYSlu1MJhfl
 g7zX7Eicwen3YaCWyx1Y1U3hVZsKT4/ED3ZLbxmHVeQxgpuJ7hjZSJGl/U1J9Mf9SK28Mool0JO
 2sp4kQVfTC83F+9BnJyu8/2pffvEpwJ321xElhSXif5qwN9BBQIDpMo5LTIcAN55Iwgh+Kkn8P8
 UfTmkdCuvhbwsxJbVWHFJK2AhZboCgCF5jECBAVzKkr5ZsVFuSuw7EH1PHAto75Bts7hlg/o1Tw
 4TT8ALjluLh+j6cJXdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140103

htmdump modules uses global memory buffers to capture
details like capabilities, status of specified HTM, read the
trace buffer. These are initialized during module init and
hence needs to be freed in module exit.

Patch adds freeing of the memory in module exit. The change
also includes minor clean up for the variable name. The
read call back for the debugfs interface file saves filp->private_data
to local variable name which is same as global variable
name for the memory buffers. Rename these local variable
names.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/htmdump.c | 31 +++++++++++++-----------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/htmdump.c b/arch/powerpc/platforms/pseries/htmdump.c
index 742ec52c9d4d..93f0cc2dc7fb 100644
--- a/arch/powerpc/platforms/pseries/htmdump.c
+++ b/arch/powerpc/platforms/pseries/htmdump.c
@@ -86,7 +86,7 @@ static ssize_t htm_return_check(long rc)
 static ssize_t htmdump_read(struct file *filp, char __user *ubuf,
 			     size_t count, loff_t *ppos)
 {
-	void *htm_buf = filp->private_data;
+	void *htm_buf_data = filp->private_data;
 	unsigned long page, read_size, available;
 	loff_t offset;
 	long rc, ret;
@@ -100,7 +100,7 @@ static ssize_t htmdump_read(struct file *filp, char __user *ubuf,
 	 * - last three values are address, size and offset
 	 */
 	rc = htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreindexonchip,
-				   htmtype, H_HTM_OP_DUMP_DATA, virt_to_phys(htm_buf),
+				   htmtype, H_HTM_OP_DUMP_DATA, virt_to_phys(htm_buf_data),
 				   PAGE_SIZE, page);
 
 	ret = htm_return_check(rc);
@@ -112,7 +112,7 @@ static ssize_t htmdump_read(struct file *filp, char __user *ubuf,
 	available = PAGE_SIZE;
 	read_size = min(count, available);
 	*ppos += read_size;
-	return simple_read_from_buffer(ubuf, count, &offset, htm_buf, available);
+	return simple_read_from_buffer(ubuf, count, &offset, htm_buf_data, available);
 }
 
 static const struct file_operations htmdump_fops = {
@@ -226,7 +226,7 @@ static int htmstart_get(void *data, u64 *val)
 static ssize_t htmstatus_read(struct file *filp, char __user *ubuf,
 			     size_t count, loff_t *ppos)
 {
-	void *htm_status_buf = filp->private_data;
+	void *htm_status_data = filp->private_data;
 	long rc, ret;
 	u64 *num_entries;
 	u64 to_copy;
@@ -238,7 +238,7 @@ static ssize_t htmstatus_read(struct file *filp, char __user *ubuf,
 	 * - last three values as addr, size and offset
 	 */
 	rc = htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreindexonchip,
-				   htmtype, H_HTM_OP_STATUS, virt_to_phys(htm_status_buf),
+				   htmtype, H_HTM_OP_STATUS, virt_to_phys(htm_status_data),
 				   PAGE_SIZE, 0);
 
 	ret = htm_return_check(rc);
@@ -255,13 +255,13 @@ static ssize_t htmstatus_read(struct file *filp, char __user *ubuf,
 	 * So total count to copy is:
 	 * 32 bytes (for first 7 fields) + (number of HTM entries * entry size)
 	 */
-	num_entries = htm_status_buf + 0x10;
+	num_entries = htm_status_data + 0x10;
 	if (htmtype == 0x2)
 		htmstatus_flag = 0x8;
 	else
 		htmstatus_flag = 0x6;
 	to_copy = 32 + (be64_to_cpu(*num_entries) * htmstatus_flag);
-	return simple_read_from_buffer(ubuf, count, ppos, htm_status_buf, to_copy);
+	return simple_read_from_buffer(ubuf, count, ppos, htm_status_data, to_copy);
 }
 
 static const struct file_operations htmstatus_fops = {
@@ -273,7 +273,7 @@ static const struct file_operations htmstatus_fops = {
 static ssize_t htminfo_read(struct file *filp, char __user *ubuf,
 			     size_t count, loff_t *ppos)
 {
-	void *htm_info_buf = filp->private_data;
+	void *htm_info_data = filp->private_data;
 	long rc, ret;
 	u64 *num_entries;
 	u64 to_copy;
@@ -284,7 +284,7 @@ static ssize_t htminfo_read(struct file *filp, char __user *ubuf,
 	 * - last three values as addr, size and offset
 	 */
 	rc = htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreindexonchip,
-				   htmtype, H_HTM_OP_DUMP_SYSPROC_CONF, virt_to_phys(htm_info_buf),
+				   htmtype, H_HTM_OP_DUMP_SYSPROC_CONF, virt_to_phys(htm_info_data),
 				   PAGE_SIZE, 0);
 
 	ret = htm_return_check(rc);
@@ -301,15 +301,15 @@ static ssize_t htminfo_read(struct file *filp, char __user *ubuf,
 	 * So total count to copy is:
 	 * 32 bytes (for first 5 fields) + (number of HTM entries * entry size)
 	 */
-	num_entries = htm_info_buf + 0x10;
+	num_entries = htm_info_data + 0x10;
 	to_copy = 32 + (be64_to_cpu(*num_entries) * 16);
-	return simple_read_from_buffer(ubuf, count, ppos, htm_info_buf, to_copy);
+	return simple_read_from_buffer(ubuf, count, ppos, htm_info_data, to_copy);
 }
 
 static ssize_t htmcaps_read(struct file *filp, char __user *ubuf,
 			     size_t count, loff_t *ppos)
 {
-	void *htm_caps_buf = filp->private_data;
+	void *htm_caps_data = filp->private_data;
 	long rc, ret;
 
 	/*
@@ -319,7 +319,7 @@ static ssize_t htmcaps_read(struct file *filp, char __user *ubuf,
 	 *   and zero
 	 */
 	rc = htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreindexonchip,
-				   htmtype, H_HTM_OP_CAPABILITIES, virt_to_phys(htm_caps_buf),
+				   htmtype, H_HTM_OP_CAPABILITIES, virt_to_phys(htm_caps_data),
 				   0x80, 0);
 
 	ret = htm_return_check(rc);
@@ -328,7 +328,7 @@ static ssize_t htmcaps_read(struct file *filp, char __user *ubuf,
 		return ret;
 	}
 
-	return simple_read_from_buffer(ubuf, count, ppos, htm_caps_buf, 0x80);
+	return simple_read_from_buffer(ubuf, count, ppos, htm_caps_data, 0x80);
 }
 
 static const struct file_operations htminfo_fops = {
@@ -482,6 +482,9 @@ static void __exit htmdump_exit(void)
 {
 	debugfs_remove_recursive(htmdump_debugfs_dir);
 	kfree(htm_buf);
+	kfree(htm_status_buf);
+	kfree(htm_info_buf);
+	kfree(htm_caps_buf);
 }
 
 module_init(htmdump_init);
-- 
2.47.3


