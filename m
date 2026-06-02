Return-Path: <linuxppc-dev+bounces-21898-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8A8CD6E64
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 11:57:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV8T84ymfz2xy3;
	Tue, 02 Jun 2026 21:57:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780401436;
	cv=none; b=VSEZBqtt7zig2h5qBGDRknfC4L/QLDRIkiMynMv8kiyaUx8zkDsGZfGrCOo9g8Rj1s2effdbGmPkrU2c4m2+es2DcFJv2gjM0DrBBInyovHWVV01SgsQDTv2LADuqC/pmUJMCgC8uH8xRxYT4iUk28vEvdej2N1O7urVUFwaoXBcNQ5A6t9UiwYXaMXWMbBSm7AAS2nTtD3g4mu3F/R5Qb2UzTZr7eEW+rMX5dX6uEiIXbXpDKCg9D/D7XvI94Jp7ZEIvAtz+dtNokpSvxbibFZQZyBc3P+b3+xwLST1RankccVM+uLkoXvbMjJo45loZTLCIcDQbK2Y/UYyoBiGow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780401436; c=relaxed/relaxed;
	bh=J9hlGSrpxxsAaFLtSptz6DwaNbMHc8NzE3DkZXd+9Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nk/29ITl7qKDpFv13pLo1j8c8rzzYUH0KfkyWe9XPBBfr+JlbViPY7sUt0meHgIEIrKLU1I6eP3hol7uxpcYy+GUl6hGIKvVDApZhbxna9zBCrWkY/KZX2ZcBbTusPn4hEmmBP/WFSjjcsTC47FO6Nm1EsDdmppFaT5SQ8HW6QZFOQlcsJZQXzopjU5977h0mfPBIg6H/it11BzyS6yY4mPx5m01N3R0eBwaDECklLbqqOvd2Muru5/gvMbGSnjTVhWoUcQN2onGEk9JrvvPWgZ/m/jLNF+wZdTAmzoE055P3gKeTnqEg47alebM+ObAlCvwqjRZJZ98xtaUxhsS/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mXh/u0vV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam.menghani@ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mXh/u0vV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam.menghani@ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV8T73G10z2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 21:57:13 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6523FLn11260942;
	Tue, 2 Jun 2026 11:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=J9hlGSrpxxsAaFLtSptz6DwaNbMHc8NzE3DkZXd+9
	Mw=; b=mXh/u0vV+9Kn5FnR4M68FAcAuLAOIyR2UPB+SV91yZg467LId4qgmWXqi
	8P+MIadKVHN3T3IIsP8fJeQKMbOh93eIAMCYPoq14EM5h8cCAWYdpeRkanHkzheA
	e6cBb9GpWc+IAKFrSErBJTdRyOKJO7u1pSoQErqk8bNrkXPBjubwc1dmiHzna1xz
	2aYWALlD6TEn9QOCy1V/2oMx31oCw0R0TJDO0UeTdwbobBhjwgqh8wO5JpMRqjhc
	vBDOhZ+TvZQHgtdOVS2Rv87n+EYrnEFlxpk11h/exKh1T7IAz2pdbOIrIrUegUWG
	OxPfn4f0DINl5WUaXKKh4cX5J3KTA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd45s6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:56:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652Bs9Xq012663;
	Tue, 2 Jun 2026 11:56:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qb94s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:56:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652BuqQt29688084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 11:56:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 992A620043;
	Tue,  2 Jun 2026 11:56:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4EC520040;
	Tue,  2 Jun 2026 11:56:49 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.11.154])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 11:56:49 +0000 (GMT)
From: Gautam Menghani <Gautam.Menghani@ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        atrajeev@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] perf script powerpc: Update the hcall list with new hcalls
Date: Tue,  2 Jun 2026 17:26:40 +0530
Message-ID: <20260602115644.8133-1-Gautam.Menghani@ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExMSBTYWx0ZWRfX+uF6bSnrz7b/
 sgwbxhBvxCykhK6NCMWQ2sPG/eX6upZKvDA8DVP2H+8V2QguVUOLWiUOEzB2P0vB4rLcWSGA+vL
 p9X6KRbU6gOp0Sj77oO2oqP8iaEaCVFGBnObnDVnefRrkgAKBCVXTANvKwfHe0nIblV1pv+CdIt
 z72CaWUqFog29dBrkq685sz0O02iLttNk+5+kKlzCPS4qwzhLNHXUDXWry3gNIv82m2tnqri9zw
 dpQ3k6rzaG5SGTds1288tndu8zF5FKbxLZDCniC45tdmYESO7aiyki68FIgLB1+w+vlXy370WWh
 +O8/tmxTNLG3qrI2/KJIpl7fkX4kpcLOM/Lw/yJW/XZG/2zung+O9xl8mTXkGe/+XUIBK85gOOo
 10PUIXnMlbV+4Vk8CE5e3Dv9mbTKHaWp6nUDlzo3ATpvTpXH92RvTbH59Wr+L6aK/HlaCx+cYg+
 sNi6aRFhcMCq4nnk60w==
X-Proofpoint-GUID: cZ4G7D_ok8DrEcaERhrrTq6JQThC4VDH
X-Proofpoint-ORIG-GUID: kseULfHND3mdmMmC32NaP0ZTQetE9xO-
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1ec509 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=9AdMxfjQAAAA:20
 a=ftAGlh2v0gGDii-5wccA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020111

From: Gautam Menghani <gautam@linux.ibm.com>

Update the hcall list with the newer hcalls in PPC.

[1]: github.com/torvalds/linux/blob/master/arch/powerpc/include/asm/hvcall.h

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
1. Add some of the missing hcalls. (Tejas)
2. Separate out the typo fix for H_DISABLE_AND_GET in another patch.

 tools/perf/scripts/python/powerpc-hcalls.py | 89 +++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
index 8b78dc790adb..f897d6a5e051 100644
--- a/tools/perf/scripts/python/powerpc-hcalls.py
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -117,10 +117,12 @@ hcall_table = {
 	440: 'H_GET_HCA_INFO',
 	444: 'H_GET_PERF_COUNT',
 	448: 'H_MANAGE_TRACE',
+	456: 'H_GET_CPU_CHARACTERISTICS',
 	468: 'H_FREE_LOGICAL_LAN_BUFFER',
 	472: 'H_POLL_PENDING',
 	484: 'H_QUERY_INT_STATE',
 	580: 'H_ILLAN_ATTRIBUTES',
+	584: 'H_ADD_LOGICAL_LAN_BUFFERS',
 	592: 'H_MODIFY_HEA_QP',
 	596: 'H_QUERY_HEA_QP',
 	600: 'H_QUERY_HEA',
@@ -135,11 +137,17 @@ hcall_table = {
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
@@ -147,7 +155,88 @@ hcall_table = {
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
+	1112: 'H_HTM',
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
+	# Key wrapping hcalls
+	1168: 'H_PKS_WRAP_OBJECT',
+	1172: 'H_PKS_UNWRAP_OBJECT',
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


