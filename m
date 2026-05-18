Return-Path: <linuxppc-dev+bounces-21025-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9E6CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 04:42:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJlX82s4Vz2xfB;
	Mon, 18 May 2026 14:42:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779079336;
	cv=none; b=Vr8PJSQju///vEUyaKR5rRPzxr9hCloAzX3LQ+M969QfBkTr20ldM2Njle4d4Faf/S4sXg2r0Ex1r8OH3Zq048be0p9jsIEXrEDe9alLeGvy+27QxWbfFkJvhF+KOGfVZ/Cw1nkAs0ab7dR8eizt+12wu7a5brH4IwDw1d/W25IBH0bmOeFnhEd9eE5Xh3BkUbidNMPAfG1wgTt716oyVZG2d9ASWBZQEFegfqc7MKqqhgy5NNzIemxCRNg6m/CHAKSwoif304YZP1WsAgz766mD1om8oAU8mIurfAl9DwFWpQF6214o5D2Qjr/o4P0n25KwRFFAlyXTyHZj8Ev13A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779079336; c=relaxed/relaxed;
	bh=bGWUFNUd70rQ8WihNw4jpC4+/xY2vnlDmpGuDw5bxQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URLvwn5+pUzmW+c0nQSesudX4NyB370mQHa5AVRaXllK/+84SDoeHGf2zsEjFzSKwHYgZz1x463D3YxivNFkViVsRMGqtswaUK3PvTBBd5lFwC8l1WhWIsv+ORgvw8HBSYCtvz+NP6MRZ667Utz0zuLOAJKyFHBNjFCZHFzxSmll0qpwRsAyMBUOKa8OACiTbvI1jQ3QS4Mi/hWu9HHwLODWIyRIeLTMP4Acg06EIHqllxR5kouEsDOzvv5shCq+2R8QUMNfuKrcLtYgQLSo70imb0C5uSmpoUk6+/fr/IjN/XQMN0h93eMV6ccGN3wo5/Ys6lZ6hwgGzSy6ujc9WQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Bob+Je/R; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Bob+Je/R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJlX70bmqz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 14:42:14 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H8j4hW620482;
	Mon, 18 May 2026 04:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bGWUFNUd70rQ8WihNw4jpC4+/xY2vnlDmpGuDw5bx
	Qg=; b=Bob+Je/Rhd2jPNcblU/JjBGDwT7MN4kL4Tplm6pQwPB/miTo2afP/n6OG
	ussqWY3Awn/Hs3uhEJIbEoGMixAnflspd4raDJVdeYpGwK/DMaIFcjzyw1z9Efvd
	b/cp2CZnEFPywiX/WhtIWJxyhT1iKryoEyatzuNYqV4sxBX2FCjymx6xSbTI9wyD
	fDmfzKV8Vq7ET2a83PnuQ8PLi/jbsm2SQ9uFKwsXAGbjgRAbmklJKDRXARKV36tr
	wnj5yqhJVq+O2hpVXZkD6eS1CFhdlqtS8Zn++v/FjvX/BvXinoDH0sGc8tkGWah5
	3Z6m2q4BKwvvLUFD0SAKV+jItocHw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h885s9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 04:42:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I4dMfu028251;
	Mon, 18 May 2026 04:42:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wpvc1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 04:42:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I4fwdE45744632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 04:41:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79BFB2004D;
	Mon, 18 May 2026 04:41:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20FC220040;
	Mon, 18 May 2026 04:41:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.47.251])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 04:41:55 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, atrajeev@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2] KVM: PPC: Kconfig: Enable CONFIG_VPA_PMU with KVM
Date: Mon, 18 May 2026 10:11:49 +0530
Message-ID: <20260518044150.34632-1-gautam@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: PpjuoOT9BjwOhUhLQsC87Y3Z8qEG--ja
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA0MSBTYWx0ZWRfX4K9NQFNAFt8/
 StCBKLsWKzJWsfzTJTf593fHSB99oKGv5RSzJeGGO+NuwUR/aMtlisBFKS07qsgHO3JZZEhjKjT
 76RgwG8NuM3PjW6X1kdfXt2Hv4j3GqovCPrjp1VSbkllo0cujn9WyIEdSrIxXzFoubQRLCYoPKl
 lKPULk4WS8r5B6Xa1zV8q5VvXDbd5+pY92Th4gy90MBYEbtN3ljWppfCU0f3aK+fSA70ztJPLDs
 u0Fnd+cpNo458Mg51J3r/g+3s4WTUkW71uKua6DuOY0KlMsN7smYyQOJqM2fUb7fR/D0A2i1vHA
 WlOVW+069coUCIMoq0D0MfNJTYn2Au8tg1OsehZb/sptSbUUIjLqrluBSK4z9PHWJ+B2Gbh+gAE
 sSXSZWQ0hyLuNLZN7FKjG8bA7hVRcI8hXVvtXA/qnT0Sa54RTiSqk7KGo+GdRVuIWoNxmFeooqj
 n/W3l7UtxFOkPKUwQsg==
X-Proofpoint-GUID: vjKVfJVpSCIxUrFwZ6gp_3WBDmW1M8qf
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0a989b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=cDqL2IBmYfLLLIMnpHoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180041

Enable CONFIG_VPA_PMU with KVM to enable its usage. Currently, the
vpa-pmu driver cannot be used since it is not enabled in distro configs.

On fedora kernel 6.13.7, the config option is disabled:
$ cat /boot/config-6.19.12-200.fc43.ppc64le  | grep VPA_PMU
 # CONFIG_VPA_PMU is not set

Fixes: 176cda0619b6c ("powerpc/perf: Add perf interface to expose vpa counters")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
1. Rebased on latest master

 arch/powerpc/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 9a0d1c1aca6c..56e86b46ff13 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -82,6 +82,7 @@ config KVM_BOOK3S_64_HV
 	select KVM_BOOK3S_HV_POSSIBLE
 	select KVM_BOOK3S_HV_PMU
 	select CMA
+	select VPA_PMU if HV_PERF_CTRS
 	help
 	  Support running unmodified book3s_64 guest kernels in
 	  virtual machines on POWER7 and newer processors that have
-- 
2.53.0


