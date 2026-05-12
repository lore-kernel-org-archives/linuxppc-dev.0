Return-Path: <linuxppc-dev+bounces-20765-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7135CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 08:47:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF9Fm3DHFz2yZc;
	Tue, 12 May 2026 18:47:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778575644;
	cv=none; b=F3G0H/91NrL15JMfpp3PWhNtF4dtazJWr3tQ5cCPW/DozcG8QStmSvvn52dQZth3I0C2jjx0yO/iE1IW3XAxoVAHrRfG645kPmOU/akyZABYyc/txKf/gjxXsUcYRMOcXr2hEDIXm1lFFUCA+HVkyneLdYDvVLdkiZw0FdeYSa0yohgNGDDxeq7cMZeORb2H3uoESRxZTpy3JH12cJUeCaBVTLT0UDX7pR+ojiFlXpxYti/qGD01xmmrZoLZlQUatwKqWgX6Wnqq2whpp7Xhx340avbQBn3RcTnhOVrtwlQ5MsLZy+VQ9GvVpY65SIlCQ/B9nmgDEZrMMmOo2JYYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778575644; c=relaxed/relaxed;
	bh=H+8//gvY5YDYvlSqS92b8ddYK8Ff04LnjBLCk2hUjM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZYkGghazKNUCBoJhDoB3kr7F5enp+BaAsjjytMSCNt7H6Ax3/+9sghrsLnjXmhi99LeUaKHybeNeTECgvj4ZpTcXMQeqFbPq/vPn7/Hw+I+FoEZrwOhYZKOtcAvFXuoEjMFHuNlQzDDFN1ACFeU90EprpaieUIO2UeZGF/VdZB3/2/5+v/PLe2814TTaYEuIPDu9DQ0Bi9iQMrAq4ur/pnMFKwGzbZ5dDtMOP5dBlFsdalG3I78fHSA5uGrPOov6kJTuOUPO3woK1ghafBhKaUV9rCX0uGxcaqeZ4jPh1Bxl/h3S25yKp1HCsBrcSaFVjLGvrOAkZ3xU8CIIb5bSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k6nUW4lS; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam.menghani@ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k6nUW4lS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam.menghani@ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF9Fl3DGqz2yYs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 18:47:22 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK7MRA2611630;
	Tue, 12 May 2026 08:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=H+8//gvY5YDYvlSqS92b8ddYK8Ff04LnjBLCk2hUj
	M0=; b=k6nUW4lSRwAYP0Doa93RrNuXLznN5GOiWpfcAqnQ/zskNv0VgZoYmV42A
	xa/58nfthhH4trOkcAEaqbt9FmlbZPUPE//NkJvxHx1SBXpYzDaIMskJ6/g/yIY6
	cCQqaim82T5F3vmhbdkiUJTm4RBruNK0FdPJNMGsIc1g4YihjvVBvJ68ZEmUV3Ju
	SNUj/P31XUeu0pWNf+yJb3h304nCGfJJfBg55z4t4z58a+Bu4Zva96pckPysvC7A
	dlcQ1gypNz3M65t01qLUAS9ItkzdV1Ai/OuCD46Ib1yqOaM/biYGWNAIk/Hk819P
	Uo4Qf/MP1HMKzQKppTfu1+7qGK6Kg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nvdt790-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 08:47:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C8ORNn016490;
	Tue, 12 May 2026 08:47:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgjbn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 08:47:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64C8l0Vf60424628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 08:47:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D3DD2005A;
	Tue, 12 May 2026 08:47:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68B9520040;
	Tue, 12 May 2026 08:46:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.72.48])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 08:46:57 +0000 (GMT)
From: Gautam Menghani <Gautam.Menghani@ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        atrajeev@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf script powerpc: Update the hcall list with new hcalls
Date: Tue, 12 May 2026 14:16:51 +0530
Message-ID: <20260512084654.57729-1-Gautam.Menghani@ibm.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a02e90a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=dQQfcrzLAAAA:20 a=VnNF1IyMAAAA:8
 a=ftAGlh2v0gGDii-5wccA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: _BvFowMn33zxF-CBdjQOaLyHowRvRzcK
X-Proofpoint-ORIG-GUID: bAAr_YA-alRKDYvpn0Jlmbe1YR4TwpxI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA4NiBTYWx0ZWRfX794P8/bu83J2
 MmB5WsaYcsGX4bR65QzWL+nkEJFqNwezbSYGqDJG/KQurJyJJRWYsSDNF9YanNttdseBYsXdo+t
 PqaZ0plHDXe8VhZ2dEUBBbemRoEa7jtWPKM3P/cPca3LAndrHQhrsjSvqYCb/+pH9dEiBTLDkkk
 2Fol6EEf4bOgZJj5CECLbLK1PwDSXHV2WjgBOpz368EGVAdHvuTmC1+fYs7ERdswGz4Ih4WxFNs
 tE1ZD/RfwK8m/qAs3kD9TGLWGTTsmOSQr68HGHpHDg85CibynxuqeYpmMZL9xXaNwDSu19V8ciS
 ngBlMp2tCjgYTELaAiP8/cHyy5BgrnuXI+dLSYdQpVM56tutjxYqEiPbCqReiGYz051fuLR9g21
 Zk33RT1VKjpaCKLCiDI1M0gCcEVl5JXcDqMRjdTmC4yvWS82B0ZZRa32FjBHTloBMXQbnszjqeQ
 vaTcGFOYjVTzykJT3Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120086

From: Gautam Menghani <gautam@linux.ibm.com>

Update the hcall list with the hcalls in bcc's ppchcalls script [1].

[1] : https://github.com/iovisor/bcc/blob/master/tools/ppchcalls.py

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 tools/perf/scripts/python/powerpc-hcalls.py | 86 ++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
index 8b78dc790adb..f69a1d229526 100644
--- a/tools/perf/scripts/python/powerpc-hcalls.py
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -112,11 +112,12 @@ hcall_table = {
 	420: 'H_CREATE_RPT',
 	424: 'H_REMOVE_RPT',
 	428: 'H_REGISTER_RPAGES',
-	432: 'H_DISABLE_AND_GETC',
+	432: 'H_DISABLE_AND_GET',
 	436: 'H_ERROR_DATA',
 	440: 'H_GET_HCA_INFO',
 	444: 'H_GET_PERF_COUNT',
 	448: 'H_MANAGE_TRACE',
+	456: 'H_GET_CPU_CHARACTERISTICS',
 	468: 'H_FREE_LOGICAL_LAN_BUFFER',
 	472: 'H_POLL_PENDING',
 	484: 'H_QUERY_INT_STATE',
@@ -135,11 +136,17 @@ hcall_table = {
 	644: 'H_ADD_CONN',
 	648: 'H_DEL_CONN',
 	664: 'H_JOIN',
+	672: 'H_VASI_SIGNAL',
 	676: 'H_VASI_STATE',
+	680: 'H_VIOCTL',
 	688: 'H_ENABLE_CRQ',
 	696: 'H_GET_EM_PARMS',
 	720: 'H_SET_MPP',
 	724: 'H_GET_MPP',
+	732: 'H_REG_SUB_CRQ',
+	736: 'H_FREE_SUB_CRQ',
+	740: 'H_SEND_SUB_CRQ',
+	744: 'H_SEND_SUB_CRQ_INDIRECT',
 	748: 'H_HOME_NODE_ASSOCIATIVITY',
 	756: 'H_BEST_ENERGY',
 	764: 'H_XIRR_X',
@@ -147,7 +154,84 @@ hcall_table = {
 	772: 'H_COP',
 	788: 'H_GET_MPP_X',
 	796: 'H_SET_MODE',
+	808: 'H_BLOCK_REMOVE',
+	856: 'H_CLEAR_HPT',
+	864: 'H_REQUEST_VMC',
+	876: 'H_RESIZE_HPT_PREPARE',
+	880: 'H_RESIZE_HPT_COMMIT',
+	892: 'H_REGISTER_PROC_TBL',
+	896: 'H_SIGNAL_SYS_RESET',
+	904: 'H_ALLOCATE_VAS_WINDOW',
+	908: 'H_MODIFY_VAS_WINDOW',
+	912: 'H_DEALLOCATE_VAS_WINDOW',
+	916: 'H_QUERY_VAS_WINDOW',
+	920: 'H_QUERY_VAS_CAPABILITIES',
+	924: 'H_QUERY_NX_CAPABILITIES',
+	928: 'H_GET_NX_FAULT',
+	936: 'H_INT_GET_SOURCE_INFO',
+	940: 'H_INT_SET_SOURCE_CONFIG',
+	944: 'H_INT_GET_SOURCE_CONFIG',
+	948: 'H_INT_GET_QUEUE_INFO',
+	952: 'H_INT_SET_QUEUE_CONFIG',
+	956: 'H_INT_GET_QUEUE_CONFIG',
+	960: 'H_INT_SET_OS_REPORTING_LINE',
+	964: 'H_INT_GET_OS_REPORTING_LINE',
+	968: 'H_INT_ESB',
+	972: 'H_INT_SYNC',
+	976: 'H_INT_RESET',
+	996: 'H_SCM_READ_METADATA',
+	1000: 'H_SCM_WRITE_METADATA',
+	1004: 'H_SCM_BIND_MEM',
+	1008: 'H_SCM_UNBIND_MEM',
+	1012: 'H_SCM_QUERY_BLOCK_MEM_BINDING',
+	1016: 'H_SCM_QUERY_LOGICAL_MEM_BINDING',
+	1020: 'H_SCM_UNBIND_ALL',
+	1024: 'H_SCM_HEALTH',
+	1048: 'H_SCM_PERFORMANCE_STATS',
+	1052: 'H_PKS_GET_CONFIG',
+	1056: 'H_PKS_SET_PASSWORD',
+	1060: 'H_PKS_GEN_PASSWORD',
+	1068: 'H_PKS_WRITE_OBJECT',
+	1072: 'H_PKS_GEN_KEY',
+	1076: 'H_PKS_READ_OBJECT',
+	1080: 'H_PKS_REMOVE_OBJECT',
+	1084: 'H_PKS_CONFIRM_OBJECT_FLUSHED',
+	1096: 'H_RPT_INVALIDATE',
+	1100: 'H_SCM_FLUSH',
+	1104: 'H_GET_ENERGY_SCALE_INFO',
+	1108: 'H_PKS_SIGNED_UPDATE',
+	1116: 'H_WATCHDOG',
+	# Platform specific hcalls used by KVM on PowerVM
+	1120: 'H_GUEST_GET_CAPABILITIES',
+	1124: 'H_GUEST_SET_CAPABILITIES',
+	1136: 'H_GUEST_CREATE',
+	1140: 'H_GUEST_CREATE_VCPU',
+	1144: 'H_GUEST_GET_STATE',
+	1148: 'H_GUEST_SET_STATE',
+	1152: 'H_GUEST_RUN_VCPU',
+	1156: 'H_GUEST_COPY_MEMORY',
+	1160: 'H_GUEST_DELETE',
+	# Platform-specific hcalls used by the Ultravisor
+	61184: 'H_SVM_PAGE_IN',
+	61188: 'H_SVM_PAGE_OUT',
+	61192: 'H_SVM_INIT_START',
+	61196: 'H_SVM_INIT_DONE',
+	61204: 'H_SVM_INIT_ABORT',
+	# Platform specific hcalls used by KVM
 	61440: 'H_RTAS',
+	# Platform specific hcalls used by QEMU/SLOF
+	61441: 'H_LOGICAL_MEMOP',
+	61442: 'H_CAS',
+	61443: 'H_UPDATE_DT',
+	# Platform specific hcalls provided by PHYP
+	61560: 'H_GET_24X7_CATALOG_PAGE',
+	61564: 'H_GET_24X7_DATA',
+	61568: 'H_GET_PERF_COUNTER_INFO',
+	# Platform-specific hcalls used for nested HV KVM
+	63488: 'H_SET_PARTITION_TABLE',
+	63492: 'H_ENTER_NESTED',
+	63496: 'H_TLB_INVALIDATE',
+	63500: 'H_COPY_TOFROM_GUEST',
 }
 
 def hcall_table_lookup(opcode):
-- 
2.53.0


