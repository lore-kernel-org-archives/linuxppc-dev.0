Return-Path: <linuxppc-dev+bounces-20583-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A38CD3436
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 04:13:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBbMH2C7Dz2xdb;
	Fri, 08 May 2026 14:13:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778213595;
	cv=none; b=EsGniv7jWwAhAU+Q4t5HZKZ8DPoEUtVFZ80CnZxsI4nHqm+Tx4oB8no9Aos+fWioyTEY2xf45c0tylkrAYpMBB8Sw0bECODJ06s/9pxI2oZZROq9WM4v5opUHQ7LZCnbS/lpl8RUZZR6KB6VVbXneG0mDByIEsGB8MBvS/Sju6pQqpVenQPZGaaYuPm8nhBjgrFlftp+a+7giWZlXHNfS3SNx5ZwIT8kwQ7ooSjK6PEXCOWZkHQSztULtjdQhj0uu2cLFD5o1Zadz4No6yokbPRbnI3me4K8fSGnAD/67KfzuJMt9muCYduRhDqizXVqlYtCF9XGJmsdZ+R8/sTxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778213595; c=relaxed/relaxed;
	bh=ry5Fzd2b3UKSt84ruefsKE1AD7faRvnE2mG/pnRIvyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRBnoZECozIzEvRXEDp05DUQ87LLdmwdzqzClDMzBl7P/6IgvJRn1tGdtgcCtGESkavyTxWjBPuYmiS8SH2Kopk5yPnZ16AC3GPAWkzDo155FNIXgXewQVRmzfoXRN63xu/BCL5F6vVBvlCezh2KdersG3yTGmSrJxlI3aSYCWmzaQKRD4PVGIHIQVti5Rp99QGpTaxPlab8kM7m9zlqJCNqfi06zjxrL7N7PVii2SYzfANlszY3ifkwR/n19U82BzYKjhmnociMm1GvYScphNio2wpu+YcaRUvJTUNeQLRROHvLaS0muoS2Dwb7FYTbq/ZXmA3NKsfgc8+zr59t3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rumJzu3d; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rumJzu3d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBbMF4K2Wz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 14:13:12 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647HGKYw2771798;
	Fri, 8 May 2026 04:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ry5Fzd2b3UKSt84ruefsKE1AD7faRvnE2mG/pnRIv
	yI=; b=rumJzu3do7sJVdSiPV3K95Fy+PlnLlRnOQHpCzeDHC+fUz/0ZnSA7WLBY
	iC3cFgBltKzcYyv7mvja/56P9lcGgPqT8qwLGrHH9SVp8YH3du3G5duNydBsFg5r
	AbgSfslHDF6rqLV3eKregOuq3NWxUaXC3y2YrVBdOxWsr+3jBz96XsAw+AUFHGO4
	LSJWeLhjzBleNqPtlHAzssNolVGl20NOKKIBPVUibLnnjoZ+nFQ/jXW+yQ4kr42v
	ldb64lIb6qqq5mz2a9OGoxpoMlyRDjs22XO6odbSMZ0XGnXW3J73wFjm0gzMTar6
	pNr8gT0B5kYB4sJhEz9ik4ik1z0IQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xy0p53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 04:13:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6483self008374;
	Fri, 8 May 2026 04:13:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk6myf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 04:13:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6484D1Ng49021246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 04:13:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEDE320043;
	Fri,  8 May 2026 04:13:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E234C20040;
	Fri,  8 May 2026 04:12:58 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.124.210.110])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 04:12:58 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/hv-gpci: fix preempt count leak in sysfs show paths
Date: Fri,  8 May 2026 09:42:56 +0530
Message-ID: <20260508041256.3447113-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDAzNyBTYWx0ZWRfX3XztpEN77xxy
 wjQQVl3cPDyEsb/K+nn1DYMyjE1X+VhUJocpuyokCVVc11rMKx62tTZckBYxbGYEB82Tas13iOh
 E3Pen9YkqyWrrJ+fL+sorE6F91rhdXMNr7xt1HeIo9ZbdfVbAwE5EqI2F28Uk3+Bv/L3w9gXHnx
 5PYeq9E/aTxIcfqgp5Akfp6UN07KRhJjxgR5M4qAVIUOqdF5nJ+7DhJHMlc+WwscGBNHbX5Vf2+
 3PStbIbtmBdCGu9ajLlLQGgkzBC0ntmvjN5K0pAv8s+KVJ/mME9xkhWiUezpyOWWh0SxU0Kuyne
 pziAv26Ni7WmRR+sdIW5XWFYo6gE4HAPulkJHhHojN79ZVrOWG/5cvXR2BMYEUYr9pYk7OXft3U
 leLCzeo7VwlPls14M6fILV1p6AoBqjRiO0r23uiFZ3RaDFh/wgduuXXXbbB2HUEex6udCRnSNWm
 bPbljYXcJOgHhA7xg9w==
X-Proofpoint-ORIG-GUID: pJfAMLicPFT8ASpwj32WUG1nLKEl1xzr
X-Proofpoint-GUID: pJfAMLicPFT8ASpwj32WUG1nLKEl1xzr
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fd62d2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=T1Q85W7wrbM6iIICI_EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080037

Four sysfs show() callbacks in hv-gpci take get_cpu_var(hv_gpci_reqb)
(which calls preempt_disable()) but only call the matching put_cpu_var()
on the error path under the 'out:' label. Every successful read leaks
one preempt_disable():

  processor_bus_topology_show()
  processor_config_show()
  affinity_domain_via_virtual_processor_show()
  affinity_domain_via_domain_show()

(affinity_domain_via_partition_show() was already correct.)

On a CONFIG_PREEMPT=y kernel, repeated reads raise preempt_count and
eventually return to userspace with preemption still disabled. The
next user-mode page fault then hits faulthandler_disabled() == 1,
gets forced to SIGSEGV, and the resulting coredump trips
'BUG: scheduling while atomic' in call_usermodehelper_exec ->
wait_for_completion_state -> schedule:

  BUG: scheduling while atomic: <task>/<pid>/0x00000004
  ...
  __schedule_bug+0x6c/0x90
  __schedule+0x58c/0x13a0
  schedule+0x48/0x1a0
  schedule_timeout+0x104/0x170
  wait_for_completion_state+0x16c/0x330
  call_usermodehelper_exec+0x254/0x2d0
  vfs_coredump+0x1050/0x2590
  get_signal+0xb9c/0xc80
  do_notify_resume+0xf8/0x470

Add an out_success label that calls put_cpu_var() before returning
the byte count, mirroring affinity_domain_via_partition_show().

Fixes: 71f1c39647d8 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show processor bus topology information")
Fixes: 1a160c2a13c6 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show processor config information")
Fixes: 71a7ccb478fc ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity domain via virtual processor information")
Fixes: a69a57cac1ec ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity domain via domain information")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 arch/powerpc/perf/hv-gpci.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 5cac2cf3bd1e5..10c82cf8f5b39 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -210,7 +210,7 @@ static ssize_t processor_bus_topology_show(struct device *dev, struct device_att
 			0, 0, buf, &n, arg);
 
 	if (!ret)
-		return n;
+		goto out_success;
 
 	if (ret != H_PARAMETER)
 		goto out;
@@ -244,12 +244,14 @@ static ssize_t processor_bus_topology_show(struct device *dev, struct device_att
 				starting_index, 0, buf, &n, arg);
 
 		if (!ret)
-			return n;
+			goto out_success;
 
 		if (ret != H_PARAMETER)
 			goto out;
 	}
 
+out_success:
+	put_cpu_var(hv_gpci_reqb);
 	return n;
 
 out:
@@ -278,7 +280,7 @@ static ssize_t processor_config_show(struct device *dev, struct device_attribute
 			0, 0, buf, &n, arg);
 
 	if (!ret)
-		return n;
+		goto out_success;
 
 	if (ret != H_PARAMETER)
 		goto out;
@@ -312,12 +314,14 @@ static ssize_t processor_config_show(struct device *dev, struct device_attribute
 				starting_index, 0, buf, &n, arg);
 
 		if (!ret)
-			return n;
+			goto out_success;
 
 		if (ret != H_PARAMETER)
 			goto out;
 	}
 
+out_success:
+	put_cpu_var(hv_gpci_reqb);
 	return n;
 
 out:
@@ -346,7 +350,7 @@ static ssize_t affinity_domain_via_virtual_processor_show(struct device *dev,
 			0, 0, buf, &n, arg);
 
 	if (!ret)
-		return n;
+		goto out_success;
 
 	if (ret != H_PARAMETER)
 		goto out;
@@ -382,12 +386,14 @@ static ssize_t affinity_domain_via_virtual_processor_show(struct device *dev,
 				starting_index, secondary_index, buf, &n, arg);
 
 		if (!ret)
-			return n;
+			goto out_success;
 
 		if (ret != H_PARAMETER)
 			goto out;
 	}
 
+out_success:
+	put_cpu_var(hv_gpci_reqb);
 	return n;
 
 out:
@@ -416,7 +422,7 @@ static ssize_t affinity_domain_via_domain_show(struct device *dev, struct device
 			0, 0, buf, &n, arg);
 
 	if (!ret)
-		return n;
+		goto out_success;
 
 	if (ret != H_PARAMETER)
 		goto out;
@@ -448,12 +454,14 @@ static ssize_t affinity_domain_via_domain_show(struct device *dev, struct device
 					starting_index, 0, buf, &n, arg);
 
 		if (!ret)
-			return n;
+			goto out_success;
 
 		if (ret != H_PARAMETER)
 			goto out;
 	}
 
+out_success:
+	put_cpu_var(hv_gpci_reqb);
 	return n;
 
 out:
-- 
2.54.0


