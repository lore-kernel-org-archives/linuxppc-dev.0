Return-Path: <linuxppc-dev+bounces-18193-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E5510706DC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Mar 2026 13:30:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fY2KB2hL2z2xjb;
	Sun, 15 Mar 2026 00:30:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773495006;
	cv=none; b=jWocKw0q+iZlNvsjwtoVJX3s2RiT2I5b0kZjarOSPw8EFWkiDbGpi8slW1DAxNgI/1uNPXgxaPPnxGUhNhvunVxUHjlviN0CdRbRcpWxh15PEMVXUBqlj8itLvnChy5gKL79alC9vb+Upzif4Gr1vFhnlQYAxXK4hzYmOQHKIirPPhcEAsgwXbVFCkmmDSbOEeQXAVEnneY/eoMUaeMal/Dk/TXgU4ko0TldctgzSF8jEEcGZ+zhnXZk2hQFrarYSfp5utlYfrQiREcwPOhpQLnRIp2yQyi7HMQJVZlLWvM7anO52KgMew66mmda9Oq4TZqUxrZZ7eaaLISa34uzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773495006; c=relaxed/relaxed;
	bh=v0q3s/fNB9MNCX19MY59+60il+L9nUBKH9E3H0+qOR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oSe7VNFIKURHXoTCmnX78i+raI6Ks8bNcDCCKLmEagzIWvjsqwdjo/m8fvqg9YwuHu7UsQoSddTtk46YyWBkU6ZV7vhxeSQKK4oaQ8ZopAavPHE0w6izxJmYtwoQeJUHD+MBPk1mjkJfe6L/nhGDlqXRqnkj5x/VA+SauQJNx6avZDUKUGORWTp2VBWPqXvv9cKZeLj+7F9SnTg2wGkLsQuaj0SAVIIQKPjpQHNdeoIvzXZU6jIDBVNTK+zog2PDCvxFH9R70GP1jFfxr9eggIbawhtj+lZHNDFjt6Tqf23h86j1yFCrEerj/xofiHUUwMwhImkWy06ZSZhCqpULaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TWOzf8UC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TWOzf8UC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fY2K91tVPz2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Mar 2026 00:30:04 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62E7uAM8717375
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=v0q3s/fNB9MNCX19MY59+60il+L9nUBKH9E3H0+qO
	R4=; b=TWOzf8UCLHKAv7YyTYEJFyfU87QeielKD6f2EXrSf+44w5+LFWhVP22mM
	rG73FPw4TuwE4QTa7IRBqwy0YdxeVRHBgIvjbsS+/roIiVHXMSUr2EZOfeyELD9D
	7fkj2sUHIt55IVc+foGOC1h/HY7dlEosXTXCoYuXKWftv2Y1sOCexYHTkXGS/JZF
	YV+PMAqi0zEulK7OJvvn+EHFXZCl/kvmKebCES7MT6lj48linFp7N/mPXV/UJVEQ
	j8YNIhjla1keOkaXuN6Ylm5I71VB0Jo0Dkg9WxfgeUdYQfe0gessdfVGloSvONPx
	frH3p6v8LDwRO8qj8lrcx0TERe1bA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3chb42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:30:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62E8HHc4020771
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:30:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9te0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:30:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62EDTvFt30802428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Mar 2026 13:29:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E8D220043;
	Sat, 14 Mar 2026 13:29:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D43C720040;
	Sat, 14 Mar 2026 13:29:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.218.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 14 Mar 2026 13:29:55 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH] powerpc/pseries/htmdump: Add memory configuration dump support to htmdump module
Date: Sat, 14 Mar 2026 18:59:53 +0530
Message-Id: <20260314132953.27269-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b562da cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=il5BMbMHr_CIBtWZiasA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDEwMyBTYWx0ZWRfX0vEN58h5+QZp
 u6yyurGfxE9QexFS7ZFjRcsIk6rpxOiiT4qXYUSOy5J4DXeVk3bnhk+YkPbWANMl3NKrxUoMhVz
 tj4b5/XbyCZipj4STiDSyBpAmYi7iDqI3KLrFfHzDQophBFJwB6/nMMmeWANoK4zeS/X6K/8nU2
 RmGZE+/lRbw4g0EE8Ctig7LCksAv1dSDmYdJsh7yvhmLH6rWM/NRK/gWZeiu0BczbwW5pSIAp44
 wHG9xZh6p1WM6foA3mizFv7jrO/hnpc9SoQ9YtHrRO2xphnrFzXG546xcdGV8iT5twx21G5Qs6U
 h5qdp8duf+EqSofZ12zDxbobftDNVEYxDVKPc4I7oqgwS18m16trx2O6Y7+1x2TmhoBPhpRSRoP
 JJfMczFXB+scx21BL0tuY38UmanSyShbltoCAs+6ckQN80eUlvjfeoq2EHWl02i5BOscSj0lchV
 nvz2+tOFbVE1qJnpowA==
X-Proofpoint-GUID: SSUJCWkBV9ZioirVVOzfHYnTd1MkAJn_
X-Proofpoint-ORIG-GUID: SSUJCWkBV9ZioirVVOzfHYnTd1MkAJn_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603140103

H_HTM (Hardware Trace Macro) hypervisor call has capability
to capture SystemMemory Configuration. This information
helps to understand the address mapping for the partitions
in the system.

Support dumping system memory configuration from Hardware
Trace Macro (HTM) function via debugfs interface. Under
debugfs folder "/sys/kernel/debug/powerpc/htmdump", add
file "htmsystem_mem".

The interface allows only read of this file which will present the
content of HTM buffer from the hcall. The 16th offset of HTM
buffer has value for the number of entries for array of processors.
Use this information to copy data to the debugfs file

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Note: This is dependent on patch set posted here which added
bug fixes/clean up:
https://lore.kernel.org/linuxppc-dev/20260314132432.25581-1-atrajeev@linux.ibm.com/T/#t

 arch/powerpc/platforms/pseries/htmdump.c | 70 ++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/htmdump.c b/arch/powerpc/platforms/pseries/htmdump.c
index 76444c6c5cc1..489a80e87082 100644
--- a/arch/powerpc/platforms/pseries/htmdump.c
+++ b/arch/powerpc/platforms/pseries/htmdump.c
@@ -16,6 +16,7 @@ static void *htm_buf;
 static void *htm_status_buf;
 static void *htm_info_buf;
 static void *htm_caps_buf;
+static void *htm_mem_buf;
 static u32 nodeindex;
 static u32 nodalchipindex;
 static u32 coreindexonchip;
@@ -115,12 +116,72 @@ static ssize_t htmdump_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, count, &offset, htm_buf_data, available);
 }
 
+static ssize_t htmsystem_mem_read(struct file *filp, char __user *ubuf,
+		size_t count, loff_t *ppos)
+{
+	void *htm_mem_data = filp->private_data;
+	long rc, ret;
+	u64 *num_entries;
+	u64 to_copy = 0;
+	loff_t offset = 0;
+	u64 mem_offset = 0;
+
+	/*
+	 * Invoke H_HTM call with:
+	 * - operation as htm status (H_HTM_OP_STATUS)
+	 * - last three values as addr, size and offset. "offset"
+	 *   is value from output buffer header that points to next
+	 *   entry to dump. 0 is the first entry to dump. next entry
+	 *   is read from the output bufferbyte offset 0x8.
+	 *
+	 *   When first time hcall is invoked, mem_offset should be
+	 *   zero because zero is the first entry.
+	 *   In the next hcall, offset of next entry to read from is
+	 *   picked from output buffer header itself. So don't fill
+	 *   mem_offset for first read.
+	 *
+	 *  If there is no further data to read in next iteration,
+	 *  offset value from output buffer header will point to -1.
+	 */
+	if (*ppos) {
+		mem_offset = *(u64 *)(htm_mem_data  + 0x8);
+		if (mem_offset == -1)
+			return 0;
+	}
+	rc = htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreindexonchip,
+			htmtype, H_HTM_OP_DUMP_SYSMEM_CONF, virt_to_phys(htm_mem_data),
+			PAGE_SIZE, be64_to_cpu(mem_offset));
+	ret = htm_return_check(rc);
+	if (ret <= 0) {
+		pr_debug("H_HTM hcall returned for op: H_HTM_OP_DUMP_SYSMEM_CONF with hcall returning  %ld\n", ret);
+		return ret;
+	}
+
+	/*
+	 * HTM system mem buffer, start of buffer + 0x10 gives the
+	 * number of HTM entries in the buffer.
+	 * So total count to copy is:
+	 * 32 bytes (for first 5 fields) + (number of HTM entries * entry size)
+	 */
+	num_entries = htm_mem_data + 0x10;
+	to_copy = 32 + (be64_to_cpu(*num_entries) * 32);
+
+	*ppos += to_copy;
+	return simple_read_from_buffer(ubuf, count, &offset, htm_mem_data, to_copy);
+}
+
 static const struct file_operations htmdump_fops = {
 	.llseek = NULL,
 	.read	= htmdump_read,
 	.open	= simple_open,
 };
 
+static const struct file_operations htmsystem_mem_fops = {
+	.llseek = NULL,
+	.read   = htmsystem_mem_read,
+	.open   = simple_open,
+};
+
 static int  htmconfigure_set(void *data, u64 val)
 {
 	long rc, ret;
@@ -483,9 +544,17 @@ static int htmdump_init_debugfs(void)
 		return -ENOMEM;
 	}
 
+	/* Memory to present HTM system memory configuration */
+	htm_mem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!htm_mem_buf) {
+		pr_err("Failed to allocate htm mem buf\n");
+		return -ENOMEM;
+	}
+
 	debugfs_create_file("htmstatus", 0400, htmdump_debugfs_dir, htm_status_buf, &htmstatus_fops);
 	debugfs_create_file("htminfo", 0400, htmdump_debugfs_dir, htm_info_buf, &htminfo_fops);
 	debugfs_create_file("htmcaps", 0400, htmdump_debugfs_dir, htm_caps_buf, &htmcaps_fops);
+	debugfs_create_file("htmsystem_mem", 0400, htmdump_debugfs_dir, htm_mem_buf, &htmsystem_mem_fops);
 
 	return 0;
 }
@@ -511,6 +580,7 @@ static void __exit htmdump_exit(void)
 	kfree(htm_status_buf);
 	kfree(htm_info_buf);
 	kfree(htm_caps_buf);
+	kfree(htm_mem_buf);
 }
 
 module_init(htmdump_init);
-- 
2.47.3


