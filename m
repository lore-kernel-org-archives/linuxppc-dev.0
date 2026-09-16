Return-Path: <linuxppc-dev+bounces-27480-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34822C88E5C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 11:12:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlGSd1H0yz2yGT;
	Wed, 16 Sep 2026 21:12:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789557153;
	cv=none; b=SB5iY9XoM6QKl/Bat4Qjkyk8xKAEXFjsPxPY6LRz44bedvcvsZoRcPHwa3DC83lEXt1jB9N8kzYN9SCOppmAsQHTYZfhtsew+5Kvn7h1KVKCXfQLr71uXBjl3+nwjVUjGtzgSQBtM9d1GabV0DheHMBLjxaU0ZimwHK+ZvrhCOX/i4rMOnyeXkDaNRCCopGt5YNsj+JlPfOF6qpl0s28dGMMieH+951OhvvjejfVupzMWJ2LE0KtdzvZ7bPxlOw8vnPLkUNMbWuRHHQ4sKd2FMGSEeQYfnfFLRDyWVcYqwlLaUW7HaKh7GaB4gKGzmksmKma2m5I8Qfqp/5xSkHOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789557153; c=relaxed/relaxed;
	bh=faSX4AAZSqVGtLbmDetcK4i4w+C+Om8OaPN0ycG+DYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQSklCjIa0R0Onnn211RcTGwOMyajFy0UtvqWcE8pAdzZYnG19wZCssomWdErA/K+n2lnM8hfT8PgJaBAX802wY1/iHGM8FNz//RlNT1X84HN3N7w3nfFsNOEjDJnxaFTIUH8MM/BNllYlL9JLR9m+58yC0H7Ih/q/iF7/DxvYHH1aFk810fgP4SPW34xQM73jJcugiL8USRNuK8b/o3K3NKvC4tY0caW0zEikKGpCyxYQctTV6/FpZ3pYkAJkXzOAgVBLrd2to9C28S5+n/Ny7ZZHwUivleUdP5TGeVR0GIte4UsqE14QxGptRxvRGons2xKV9O47QW75YEiAb67A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SFvyz/vP; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SFvyz/vP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlGSb3M4Tz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 21:12:31 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLVv8X1990303;
	Wed, 16 Sep 2026 11:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=faSX4AAZSqVGtLbmDetcK4i4w+C+Om8OaPN0ycG+D
	YI=; b=SFvyz/vPtYkFrGwnYbCRKOKfI96tLqWRDoviubD/ARXKTYIu2VRdtpI3N
	NejuHteUrfB9CO5EGr2jfKjFrdeNEyoBRa21NrBb0h8LR0I7QnHrlB9vGKvAHfch
	elujff+FRl84LFnzRTO+FSe3T6RPf3SsV89qFmwBN6n/S4nC8fGWTnj0WIeFXJvE
	QTD+wwGmp3+EliSNrntLCzrwlFhTmszgAPFxaXW5iBYrLniJWuHEfa1FDDN/10X3
	HNSRALV7llLb8BVz5tEf6mK+/arJUuY77mcxdZ/tURfqYCEQPb7UYIXKD7d7kC/0
	UJpM6bYWa+vBIC97TuKYUM5EVqOKA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv3s94-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 11:12:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68G7delY388926;
	Wed, 16 Sep 2026 11:12:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxse0qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 11:12:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GBCD6P31916394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 11:12:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A7B22004B;
	Wed, 16 Sep 2026 11:12:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D2D420040;
	Wed, 16 Sep 2026 11:12:11 +0000 (GMT)
Received: from dhcp-9-123-14-178.bl1-in.ibm.com (unknown [9.123.14.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 11:12:11 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Free the queue pages in error path
Date: Wed, 16 Sep 2026 16:42:08 +0530
Message-ID: <20260916111210.1982-1-gautam@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0NSBTYWx0ZWRfXy7paDTrHd791
 VBLUSAlhuCt12WyQeB4tpcbGIXg+6ObcS8j6I2dX/NMHCLcCR/dAl9N6XqAkv7PZP+EurMp1GyX
 Ymk/ik0lCwD0Pi9HOl9wQCUh9Zj54D4=
X-Proofpoint-ORIG-GUID: 41rkJerXAH4EPHsKhpQStXEr0EU-Aqs5
X-Proofpoint-GUID: JlxabOqM1LDDgIDRyfu2jAn8okPxKC4k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0NSBTYWx0ZWRfX+6A7m9vwobxX
 eida+rFiUK6LVg5FurMvMerdj0Gsz4ZtgH9iWOPF7vJyrUGEui3lC86vEMwIFN+qBPcubbKBERB
 ti7eNOCrJS30Z8bb/NrJeW1ujXBitRJixGFpTg/nolBw2GmfSy6ez6kYnzgdyvPoTlXN8MvN5+h
 BioJV2CZtQnauXQhgqeVlXV1itqkjtDZHaueodD7TM/wfnmQBa3zC4KIeQ906d9Cbgpnm93+Unw
 1nZZcHBCAxqbgxsCDpgFqZAu3FPgyzSTA7cXdZzaZ2dKgxKYN4F8rfdvgmnDE+Zs8RMuILS7NEm
 z1Eftbb+whF1FWSARwuLCRy//HRUqcuGi26Hbvv8B79W8TZDrtCVqtL4H9A4i2HmPWuKinoSbV+
 NsSxwsWShjLnOoL/1iV3KcJoziSSWxhiWV/vGGRpAjbAGgDLx0HbiLO0v6nWr87EBdKsVSluE2F
 ogkQAq83cja5qzD3mKg==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aaa7992 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=EurUxE5MuTDynMuEDIsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160145

If the xive_native_configure_queue() call fails, the qpage allocated is
not freed, which results in wasted memory. Fix this by freeing the qpage
in the error path.

Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_xive.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 1d67237783b7..6f8648d9302b 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -961,9 +961,11 @@ static int xive_provision_queue(struct kvm_vcpu *vcpu, u8 prio)
 	 */
 	rc = xive_native_configure_queue(xc->vp_id, q, prio, qpage,
 					 xive->q_order, true);
-	if (rc)
+	if (rc) {
+		free_pages((unsigned long)qpage, xive->q_page_order);
 		pr_err("Failed to configure queue %d for VCPU %d\n",
 		       prio, xc->server_num);
+	}
 	return rc;
 }
 
-- 
2.50.1 (Apple Git-155)


