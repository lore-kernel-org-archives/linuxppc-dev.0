Return-Path: <linuxppc-dev+bounces-29094-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B081CA601E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 12:31:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1R6m6S2Pz30Cj;
	Fri, 09 Oct 2026 23:31:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791549072;
	cv=none; b=Ae13+krHAkrwVKhSkmjfcWaSEVYXUwWmexWrFn9UyK1n8jLCIjt60hFHyPwlL4m2+LtVSIKL6mIPB6LukwjWkW5kxYCL3TQWRlMBnxgD93PKSiy5jY6BfZuUATa2XfjJ+Igr/reebZ/PlxJZMAICkR/probwdHAWPaaAjdmpduYl/Mb6NcwU2h8W+yyouWS9tPQYOktR0Df+0BN6X9bItnBwf12Mh1Ov6FOyAFmq5tOfSs85f8v3bqFxsDuon3CTJTRbglrjKwF7FG577D3lmks1XbCXDEA0bOUB9K44BrPgYX+AbNsWItlfRy10/+YvLeAZ2gtS5eXx7FxwQDm79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791549072; c=relaxed/relaxed;
	bh=8GSzKabQCQqUw8EmDuulh8MOnAkFvJBnb5+uLHEIwuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xyj57gMA41liSMavPWhKf3KHYOrldEYLnxTuJD2uTybpNkEKOrtxDum5D/TLWJcrdGKZ3jkqUvH/VO0tvXxKAUyxabR/zLSsDVRmJwlPAzNRWLru+Y3wgESJd1DuLwlWYVdoVfjq0iw04n5yJ8Bfm4ckIDjDe/uj7iWVKzH7bAbpL0ValfPQuZolqiQypF37QSo/8R707g7J78viGD8UoPostf/bZt2dcA6d8W7I7365wEpt1c5AuPWngrSFakB6rgpol8ZIvtTQzhJ7PbwuOuIOpNg3hAMrrspl+w3MssQgaKFhTvPFR1zOD5EVY7xbAIOJ3FCAZTTxLiSzxM1s2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Kph5N0Mz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Kph5N0Mz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1R6m2R0mz30gC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 23:31:12 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998aTAp3775106;
	Fri, 9 Oct 2026 12:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8GSzKabQCQqUw8EmD
	uulh8MOnAkFvJBnb5+uLHEIwuM=; b=Kph5N0Mz+FzNGnBgNWSEsiJ7Dpx0deZm+
	67f6ezoAYoEglZw2LvxyrL99ostFtZfn1XaBG5ZIHs8ec1DlmjLYfIgv66ZyZgIw
	EGodvMWXHEDxPBW86noRqyMA4Yg1kZUonk+HovPrjCkHx3YbR2eLL0UFBgP4vmKr
	+IaSOqyf57L/MWIH+s31qTrWrLo+DQKr/S24I9pI/sjsx55rgHo4NLtnkzNC44BQ
	d8XhzggF62ZcRx+NLfHG5OyLYjdAi4nU6PMSVgyMstW/3vQ3iDWCK4AXNob2C6Vw
	5h0G/uUhRPhLjGRYK3ZCc6jzvfUeGqRTUmDfsYG3K1QlpmY9pPrqA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvjm3w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 12:31:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I52C3538396;
	Fri, 9 Oct 2026 12:31:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3u2wsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 12:31:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699CUxWi30081424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 12:30:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68B2220043;
	Fri,  9 Oct 2026 12:30:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9D682004E;
	Fri,  9 Oct 2026 12:30:56 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.27.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 12:30:56 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] KVM: PPC: Book3S HV: XICS: Avoid masking VP IPI on init failure
Date: Fri,  9 Oct 2026 18:00:32 +0530
Message-ID: <20261009123035.157770-4-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009123035.157770-1-gautam@linux.ibm.com>
References: <20261009123035.157770-1-gautam@linux.ibm.com>
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
X-Proofpoint-GUID: H_Rb5at_LdYDTpaoBUUjRRdmVZBEu8Qr
X-Proofpoint-ORIG-GUID: 9b4bP_ioE2mbmHs36j7zTILefAe-OMQW
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac8de88 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=5A-eSp_wyuwTZ9lofRAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfX7TIjKzUl1266
 5LNjA1F6g1Q30B4x79c3pBTOT2Nqh1rQC2Vqdq+4HkGnWDq611vvyvSXeKnFTVAkqv82RXa5mLX
 ZIqGmLskvwp0fUPc0I+D746rf/3dF0QTloiHrYVGlsG95W4Aj/y7JSflgkg5yuCB+qHgrTe0Rt6
 +adZbAxk0jezL87DMSWXveFvfgzwUufX/tFFUsRQTbXdP6F6kP65GoiCuLZZMeWQcDt2hBQogf3
 n2xsACEVqXyzquE7zJlki2lRm3HsXZMUhXMeLxZz4r0qnT+GSPSl4W8gXTAL22oKwfS6lwUqoi/
 EXFpH+j+xJ7blQJ11t2kyNpZ5WrKoDbA2vtL9aeuReyLGPc/dRqyMFq9itImtTLCDHYbORx9Riv
 8aVTOOOE5UkX7KpQ14p6Vi2Yy1zz5j1DHpPyT0dCpVj/H7p4jsI9kr99nbwE3oFfe82nRZ4d+eh
 sjSs+lo/ZEM5AXv+Qwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfXxLuy7qQlKR68
 opDg7cCM1x6HkCqjJ3+VINTceNh8xoilABeAc7ZIxHantLuaPA5ZGnNAOYH+5o6jtl9bJAQrrmq
 jZTahJN3RmrEtvVF7IZmvuJ5+G4UysA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090048

In kvmppc_xive_connect_vcpu() if there is a failure before
xc->vp_ipi_data is setup, it can result in a NULL pointer dereference in
kvmppc_xive_cleanup_vcpu(). Fix this by adding a check before masking
the VP IPI before accessing the MMIO pages.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_xive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 67219044fb8c..b27127c43315 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1818,7 +1818,8 @@ void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
 	kvmppc_xive_disable_vcpu_interrupts(vcpu);
 
 	/* Mask the VP IPI */
-	xive_vm_esb_load(&xc->vp_ipi_data, XIVE_ESB_SET_PQ_01);
+	if (xc->vp_ipi_data.eoi_mmio)
+		xive_vm_esb_load(&xc->vp_ipi_data, XIVE_ESB_SET_PQ_01);
 
 	/* Free escalations */
 	for (i = 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
-- 
2.55.0


