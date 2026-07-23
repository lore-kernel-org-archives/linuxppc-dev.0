Return-Path: <linuxppc-dev+bounces-24670-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A18C4453D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 00:02:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5BBR42KZz2ynW;
	Thu, 23 Jul 2026 10:02:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784764926;
	cv=none; b=MZoUUKrxp2n5NmrmqlMVGPx4kz56+9Q6eJg2LSMNQjxs7ebNum2aExHBASTlY3k4QbExhyUyo3CnBKKlOVFpkP3JRxFO6M8BcUjGGnNgKo2R9nPmili6juvZcGmkGEB8KKO0qT+ZhnqH4cPuoPPTd2ShQPk9PXFO/FKvjWvl8IE+dhYmwLqeSw2kVSvx+sfLCMOpAbKVyvbA+gfntJdawYgPYmj2o1GjnRzVnuuZYbzkQhgeOA+bi1HrZuVQlkQdoJxNtIDBCsL3tjmTZu9q36BYB0iB5GLrmZYPQWDWwdDLTMUqU5VqR9lFeGAU7a7gY//WbHTHRmWShJ5Z5Ux4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784764926; c=relaxed/relaxed;
	bh=QTcx3GUwnUGWervFwOBNbS/xCBTHJ2fcCNdUSchFYis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGORE636FcdPEmPVQM/iQmTaOKiqzhR5GjJdcXJV/03Vvo9r8hn9jGSajbCYYRsU4cGVFhHIAGDnTCU98VrbOX0dFX6t2lY9gBCkYK8QcvWyUMzmsRCmiBCKsbonx+lF8F6Edsf8Xc6XmFl8KMo+FMwyeoii+QtQJ+NTpdsradpf1bHaPTc/34f94HjFCRaS2FMzQ7qBFlJCe3ekihTSatr70crxcEkbGN9PaxgkLs86fGFO3dvn13Ax5dLnQwswKbbdGbM4TFemYvqPPJaW0PYKO7rvKh5RqQLV+TI4vVgUqaKKXPZPlJRixcINel9ZysUjssq+uGf1bi5/N1afjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dxkapA0D; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dxkapA0D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5BBL2j6Jz2ygg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 10:02:01 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MIC04w713608;
	Thu, 23 Jul 2026 00:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QTcx3GUwnUGWervFw
	OBNbS/xCBTHJ2fcCNdUSchFYis=; b=dxkapA0DX/yryGShitVIbxLiedarpRWgf
	lroCRb80XjgmXnfj+BVVhiBlFLW14wOXmsrvqqrOh52pQ5yr3Y3dDFFF0f5o4zx7
	t1zCraz4qUEG1fjnnGo0vEcmrJMPECjhI2VExIl4GYe5LViU0UdHNLvjOfD7Awwz
	r+gF8lsW4wL6rUiutUS1Ge7n5wq1hc/hFuxiYGzrtR5ZVjII3CVpEdugPZlRQ9jd
	ZgqQRAsYkRjdomjBFfPE9Ho8ki7Rq46vj5qq65ST6ZPDCnRsN/mCd5dkxs3KRIdH
	sZe8vRXvegQR9Lvn9bQgs+dGtf3+vB9CgcpnFvgG87pSUH/hY7H7g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahccsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:01:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MNnaIF028159;
	Thu, 23 Jul 2026 00:01:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah9q27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:01:57 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N01usj30802528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 00:01:56 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8723258068;
	Thu, 23 Jul 2026 00:01:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D47AE58064;
	Thu, 23 Jul 2026 00:01:55 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.118.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 00:01:55 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 04/33] ibmvfc: free ibmvfc_target allocations with mempool_free
Date: Wed, 22 Jul 2026 17:01:20 -0700
Message-ID: <20260723000149.969416-5-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723000149.969416-1-tyreld@linux.ibm.com>
References: <20260723000149.969416-1-tyreld@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 7D5iPR5E4_REOKeDKMM0Iu3NaGJykQ58
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX7FLFT9meQCbW
 jQjq1zgmjGDz3mphtB8RFcuA4VhyMDfnJrNK+Ao7SjY6+pYniSiSiDl/vGxwyShoPsFN1Up+W07
 uk/BW2Lw85LKjNrOWqgn9g+N5GCBBfgbh4PKNCvD8InIMhREQm+8FgUGBjg96zfhlH+gHx9X5wI
 Ks9GRwdAH6vjTeQ80IkXlCGUNsTNoBq+R4uUfsuFjS/wAO5nNbhPUKTHnGYSYCdWhn3nV9nnuk+
 tV78cztRXQ4wRDsQSp9qc4UhFlwOae8ha9gphBMipwYGbIjfr7olm/m6BvQi3Uedzv7HFEjtVrN
 28cWddPpretQYr5kcjWgx450l84l11wKI73V+6qLn7qx8EhnzG3jWKDDadDi8KIi8Amxe0GbntJ
 raw3Q7B7SPITjP0oNSDDWAzyHvQV85NAq39xYhJREo0t1aM1DYpgoAabCXX4nB9AzhT7VocwQhj
 bvyhB4kbjJnHCV0AIAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX/UHiy6AMRO9v
 laFRAsVxJIw2qEiIuUZL7hkRmlNNqKOhyDHfl0GufDw0JQCrgrK4oNg6Bp1gQku4EngtY3Jcqlm
 OHO9fUpZq0awSrjZ75VA4usl2SXzD+4=
X-Proofpoint-GUID: 7D5iPR5E4_REOKeDKMM0Iu3NaGJykQ58
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a6159f6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=CDwl4yW-xjfRfShkF8wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220234

The ibmvfc_target *tgt structures for discovery are allocated using
mempool_alloc but in turn free'd via kfree in ibmvfc_release_target
breaking pool guarentees.

Fixup ibmvfc_release_target to call mempool_free instead so that memory
is properly returned to the mempool instead of the general allocator.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 59102dd1c787..412e946abcb7 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1366,7 +1366,7 @@ static void ibmvfc_set_rport_dev_loss_tmo(struct fc_rport *rport, u32 timeout)
 static void ibmvfc_release_tgt(struct kref *kref)
 {
 	struct ibmvfc_target *tgt = container_of(kref, struct ibmvfc_target, kref);
-	kfree(tgt);
+	mempool_free(tgt, tgt->vhost->tgt_pool);
 }
 
 /**
-- 
2.55.0


