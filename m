Return-Path: <linuxppc-dev+bounces-29235-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BE2CA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 08:30:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j39dm1Zk8z3bNr;
	Mon, 12 Oct 2026 19:30:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791793836;
	cv=none; b=X0wfL+jY75hcLbU2oSrR8DbUiwHTVfIQVrjrwUhCcmubxxu3zasZpbfqkkBDBgTVL5acqt4eG+TK1vKEaeTce8wra8m6eRrEVPXmMfSs/5lJVqNQ2yjNr/5KBHjZ99JFpgMDZOSBNQssFuSZDXD0mCcyOcWeq2oJnv3iujuXI89qzPaJcbsWUias6uGGLbYr51lLnhYoAPyd6l2LPQo7X/o+MIPJxcRe9Oocz9BztzVB2WdzsT9/OtPYP1rfr98K027qx6bA70MgKdlTALZSihlQOC4o/apjhwrMyoVug/gGTMPAuMJNTdWTGyx3AkNhXB9CJ7GZsLjnebW3bu6beQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791793836; c=relaxed/relaxed;
	bh=16BDxiUcLZ/nXLCJUaShAj1tY1axfepy8vCDz+0fufE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJ7SOVNszi4t35eYSa1LiGmvr1CpZBV/MgaZqNTpBvZ0ZdhVAcypLB30EEHcrtVN4qwgSCH/X7U7Ry1/bCd/hgbqEJxzeNswjx8d6VGvnDKkY6738eK+bKruTWXPYF0nyhr0hu4SZKhMJApnAfLtFwLv2C1fgxesMFSUowUAdY7rlSJFITyJDa7Ue2obP1xPzUYUjV0wLmZePh/+atHile+EvI8b6NsMNrYZVrmTv23IXSqJiMQpay4VK2HY716vfC3RjhfMfEpDYUd+igzRb55QsPfjnnzmYdkA+logK8xc+xYyjfB4HHUIUcODMOxUyolbX/IVliArn0XaFKa4ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ntE1s9dA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ntE1s9dA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j39dl2Tbnz30hC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 19:30:35 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5F2uu3481839;
	Mon, 12 Oct 2026 08:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=16BDxiUcLZ/nXLCJU
	aShAj1tY1axfepy8vCDz+0fufE=; b=ntE1s9dAWs1/ANHr+Fz/9aaG0w4moOvBI
	jkKBBvNulYr74LBqq1YF5s+n2FbUExPxBx/pPsaZiBopem3HkkzZqpKs/q+eKyGm
	xhGthg2npVMEYwV73/3prqVJmGlY3b0H3LLq/3M5z+LY19bVq1EsGG8QhXbfrkXB
	5UaY80WObn/ztrKBRNup8J/stZroMMYm496KAErGZx4L5xmfbqhlvbStk3QUm0S7
	Wz5Ja1OzFGgM9H6tTxKKFVU/sGB3M9LSozcaXe6qMXN8dPPActEWB2VCJioYvk74
	rbfUydCFEU/unXkoTmxi1vusl+9CyTLVaL/Z3fr0L2xA4T0c2ALxw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1vykf7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:29:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K22W935491;
	Mon, 12 Oct 2026 08:29:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjmbqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:29:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8Tgho39911882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:29:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E23820043;
	Mon, 12 Oct 2026 08:29:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9FC52004E;
	Mon, 12 Oct 2026 08:29:39 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.28.91])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 08:29:39 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 2/4] KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
Date: Mon, 12 Oct 2026 13:59:18 +0530
Message-ID: <20261012082922.218799-3-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261012082922.218799-1-gautam@linux.ibm.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX7GZpoWYpBoBI
 E6OJVbR467Z6s8JSBbf950/xpVgto58eH7I91QuyRNVCm/O0Y7NyfZN8AKEI35yy5bUdChF0tGN
 lOCFTu6peRoksg4ShOUMfXUV4xAOb00=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX+/dR87dkJfLD
 EgICbR6YwQ+RXeo9cVEA6rK6sjkck4fhAgM6V/zBF8V3QurCWBluQ2lbrvA9s4W0ra/B7KID1/I
 JtVMXA+cjtExjFoaDPTsLVRSdQEGh5lKrHAtvUad1zpe8UZLz7A7hmOp+JtxWKPUdCsjYXoL3pu
 KJSIB2vd5BFsZEqnCkepAHORdv73naSeLQscwVfoNjDhgcAezcafKgltjlC/eUbuw5LUPgXy63V
 Mo5IL69FZfO1wMtwJ3bg3UkOONrz3RJqZnuEQ7atojo3FgohuHtbpzY2S9s8f0JSmIYE4f8GBT7
 5ZsNRv3ZoD6IgtF5tPXbffz2BBN0JlAr6mWq/4IkkccNn4RW2HYB6IikuPjYl4oICWX5NTTNhlm
 zi2827P4u3QrUUjjHIrTuyJuaCbkXPj6NrZsSRn6hviLnEsie+EP48DEJ7ooN2JAXkod8zpoJj4
 DEEEMkXaCsLURPv66LQ==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acc9a7b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=K4naiS_KJ2Bkn_B7trIA:9
X-Proofpoint-ORIG-GUID: a8rC_B3RNAbEBBrPvcoCAuusjStu_4l0
X-Proofpoint-GUID: 8m4nvGw8DuVx4ODZPLNAaEQTlu0AL82v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120032

In kvmppc_xive_connect_vcpu(), if any failures are encountered, the
control flow jumps to the 'bail' label where kvmppc_xive_cleanup_vcpu()
is called. This cleanup function exits prematurely since
vcpu->arch.irq_type is set to KVMPPC_IRQ_DEFAULT at this point. This ends
up resulting in wasted memory.

Fix this by setting irq_type to KVMPPC_IRQ_XICS before vcpu configuration
starts. This makes XICS initialization symmetrical to XIVE
initialization done in kvmppc_xive_native_connect_vcpu().

Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
Cc: stable@vger.kernel.org # 4.12+
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v3:
None

v2:
None

 arch/powerpc/kvm/book3s_xive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 1d67237783b7..67219044fb8c 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1937,6 +1937,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 	xc->vp_id = vp_id;
 	xc->mfrr = 0xff;
 	xc->valid = true;
+	vcpu->arch.irq_type = KVMPPC_IRQ_XICS;
 
 	r = xive_native_get_vp_info(xc->vp_id, &xc->vp_cam, &xc->vp_chip_id);
 	if (r)
@@ -2025,7 +2026,6 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 		return r;
 	}
 
-	vcpu->arch.irq_type = KVMPPC_IRQ_XICS;
 	return 0;
 }
 
-- 
2.54.0


