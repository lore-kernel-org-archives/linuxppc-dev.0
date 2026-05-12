Return-Path: <linuxppc-dev+bounces-20784-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF23ECD4851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 11:57:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFFTb6gHrz2xjQ;
	Tue, 12 May 2026 21:57:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778587075;
	cv=none; b=kBvACWh+/vGDnKQCChd6Ua1tnxQ/mCt9HiwyN+z+YKSilCyrQgjPqdUqenu+J6HVUEhlNq0+7JqtlDSNknSnNI40F/XYHlPbIcPppLBYJMBaIqGfBiwl+lafcNE0ZzqG6NP3mtqpNYHlQHl3EgianHKykQzyVoLrivE7xgqV6aSoTOGuKy2u4v8ineimSCouf2C73yEUwDfdZ5JoKqsW0kTNzSS6X7bLWHU4TIPYPDT4OMPWUK9k2BJqw5cY8Y/9RkagsCH3rJlgOcV6SP42s+g3psC/GWyiVbNsBIhYkgOtUe2XB9jLo5gdPEJv+QOxWbkjh30EqoMASEzCk/95Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778587075; c=relaxed/relaxed;
	bh=jn0Ex3hGuYGLoizWFQHUBB1PfFzdzYTIkAWRpisqvTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6vXcSZJvtv9DwU2VRqoUDDKNOlz2YPz1j20yRzjta7Wn1PcwCrik1YJIDH1ujDUweD3YKzmEk7ULfVdkW37gZGMvMHQqHos0dmgM2UswaTTY+MUDVi8ScWvz3gScu9INxZrHQg5VfchZ7cAzGQQkwPqEQxQaHZeMjNOlrW2FmEEhVBzLtE84C01keBGGwz9+2GKqccr0OmbW+Va4ROwLhhFxjiKqD2JxBCWKJVIAhr07DSfnOYQXtnc7+yKbk2M7pbDjC/5VeSvRKE84F1HDqa74/ulUm+HlejLsxd2Olb9RnrBYidmnIZDyYcFCosu7pxg7biVoSKRTM8C+VZRcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NEmYxGRz; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NEmYxGRz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFFTZ4k8Sz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 21:57:53 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK7I0A3775829;
	Tue, 12 May 2026 11:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jn0Ex3hGuYGLoizWFQHUBB1PfFzdzYTIkAWRpisqv
	TE=; b=NEmYxGRzDmM9Uty0imaNRelwQ6Br0sgJ6NuzXFN6Rio4hjiDjuDJWd8lx
	ana2pzX5NY0JgB9sD947NI4siLNIR4zDxJv56wJRt+KkVh7Bd467IOc2THRCa4NX
	e1EVqck+qdkmMgj+kLfaWZePjj196mnGhp6vgHDxRGkYOcZh/jIMpWDE0S6VwiIX
	a8g9Lyn1Jpb8iWjuHQotBhFtORq7GlHHs9sawvOcL6LipGqZW7H9u8NX7dT5+RR7
	PFU2d2i7rP3Wr3vkfLgfQ9a8FGzhl9HrNGOUaskIVEv9JmNp28gjthHnjGrZj/9O
	aRojP/eNfNXmZymxUer8N1oyDj4eQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6jqar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 11:57:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CBsUv5021224;
	Tue, 12 May 2026 11:57:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgk01s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 11:57:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CBvcH746006560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 11:57:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5455620043;
	Tue, 12 May 2026 11:57:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F128B20040;
	Tue, 12 May 2026 11:57:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.72.48])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 11:57:35 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        "Vaibhav Jain (IBM)" <vaibhav@linux.ibm.com>
Subject: [PATCH v3]  KVM: PPC: Book3S HV: Add missing mappings for tracing exits
Date: Tue, 12 May 2026 17:27:24 +0530
Message-ID: <20260512115724.59299-1-gautam@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a0315b7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=xmqxItbY3JyJ2VEz8ywA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyMCBTYWx0ZWRfX19OlzG8a5wmU
 zCMlsmHj+T5nMRLXlwMTxcU35P/4rPXgrQQ3zdeolV0PbExvMMesNpKuM6epiNzsVH23c7Xdct2
 JDhS5FXj8xyaXz9ld9iwDEBy3SE6d7ftEadETVZcWSpY4s7d+qdMNrMIVsaU7mnVxx4G2jDAeHR
 3MD7Lp29BN5S8sq6EuuGqz3OpZGmecvV1NucAMgC7GNmIqvxWPODc8prR3zaW35s/bfQb7SYsT8
 t9Cw2byBTbec7KeBjmJls6gUrGIFi4VxlfUIZhZbBN/72Dh2X1CUHyDS1oCak+IekdpohVktmAd
 onY6eW+gFfyo27AFJAQXzsOM/ZefYEiy+eaWc3u76LKY8pGyy/6aEFAZ3Lmo/VBnd0BOCPxCgt1
 5a08IEYKEl6flnu0LrEc485Up9dCk9I1973p1KESXr/X2fm/zaiYiCj2YYulJFIi1HZEclO3LIJ
 QSPuH0mkLnj46NaF5vQ==
X-Proofpoint-GUID: UBJ75RrSkKtQ9p1kcyvx6dqEZWGPd48S
X-Proofpoint-ORIG-GUID: q17DBdulbzxBw15UHCo0O4d-4c5IpvB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120120

The macro kvm_trace_symbol_exit is used for providing the mappings
for the trap vectors and their names. Add mappings for H_FAC_UNAVAIL and
RETURN_TO_HOST so that trap reasons are displayed as string instead of
vector numbers when using the kvm_guest_exit tracepoint.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Vaibhav Jain (IBM) <vaibhav@linux.ibm.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v2:
1. Remove the trailing comma after last element

v3:
1. Add the mapping for 0x0

 arch/powerpc/kvm/trace_book3s.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
index 9260ddbd557f..4ee35c6d01aa 100644
--- a/arch/powerpc/kvm/trace_book3s.h
+++ b/arch/powerpc/kvm/trace_book3s.h
@@ -7,6 +7,7 @@
  */
 
 #define kvm_trace_symbol_exit \
+	{0x0, "RETURN_TO_HOST"}, \
 	{0x100, "SYSTEM_RESET"}, \
 	{0x200, "MACHINE_CHECK"}, \
 	{0x300, "DATA_STORAGE"}, \
@@ -28,6 +29,7 @@
 	{0xea0, "H_VIRT"}, \
 	{0xf00, "PERFMON"}, \
 	{0xf20, "ALTIVEC"}, \
-	{0xf40, "VSX"}
+	{0xf40, "VSX"}, \
+	{0xf80, "H_FAC_UNAVAIL"}
 
 #endif
-- 
2.53.0


