Return-Path: <linuxppc-dev+bounces-27072-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC23C88E40
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 02:19:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgysl11W7z2yrd;
	Fri, 11 Sep 2026 12:19:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789093163;
	cv=none; b=QMmv3zlcC/sDNMGLlqpDQLY0qkhjmR4jjV2YUuNxrfZugpaeXR5YAK7rgpFIrFWujfR31QxWdXadO0LEwxIlSJt13By3kEAYrkxICOv/x+zdphkFIPHUTZwwVOitv6s255KtuKj89lwhIFfZ2sr6WxhO5CHUn2lymNx0KnxyrOUvR8adlItNkUrxXch+Kcl3p4z6ubk+rYbwU50ccBxYg+f4pCPK+GJbreFkGTo4E0NowPo+6cL6R9vaasZBCk6IfcQes+DlqSKVTL4pf7fVlpEGMiU2QOyDmyMtNO88ZvG/Kaerb4Gut26XQyjHzyV6GjADD1Xkb/RJPh3w7390UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789093163; c=relaxed/relaxed;
	bh=bVsy6e7RIWsa4inSYVWZiBsIlesxYTQaoaS4XZ8tKXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROn5/J9E7KQ5CC84KxdbsdN0VRaMMLubp9UGX2GrH58PHcG3lZnFRHAUkzssfMfUNoGGCmbhxEvplYg7EETRStA3TdCTemnrZS0nv/Pq8pFqFpxTJNH+Id15lZwLKzVGN3zTQ6g1izc+BGwb3HtnPkH9iE0duVUQdn0U2B2cnEqIryJWqa3YAdbUCHgnQEaEEyrXQNgZ6G83uYQSuKTSxo8fPcCQSjPbZoaWcOhVpm8pjXj97yY6Gzh+TLIve0WocsBFEYh6lPQT2EbqVRSvHIeWaEltSJ+U0Dw7e+41zbIZC3V311P+uf/TOP7fWWgkWfjUpA/KqbjxuNaSZDSeIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T4zsGC7B; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T4zsGC7B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgysj4Fbjz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 12:19:21 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B12J2r311149;
	Fri, 11 Sep 2026 02:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bVsy6e7RIWsa4inSY
	VWZiBsIlesxYTQaoaS4XZ8tKXk=; b=T4zsGC7BM8fBhzVfvenCKJQ3lKExHkc/m
	tFhy2b8kJlQHOg26yotKL2KgGQa2ZAyjj9m6RFgIMs2BGbq88Chsa7goH5TNTiLu
	UX7zUw1XRalHeJN0pDnhdsxPBd5xWgHBfeHSZPWJzMwenM5+Kw9io1jDQjtNbfdo
	pWNEpUH3aNx/Mdw9Vl5SaQPj0vnHJviKfNsCT25qPe4f9GqC9aTWjw4WUHJGGuEs
	BMKTjKcZEYnygMzomgB7onFUDKYhoY7cWi4K6AORQCHAualBAxcGGAN+rzkcHoxN
	ewhMfzDCceQLzocJLd1oxsbcGKJdmdPhU9ThC+GTQURwAQTEUor6Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8prtbm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 02:19:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B15AC7872168;
	Fri, 11 Sep 2026 02:19:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwk3u32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 02:19:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68B2JGVC26411620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 02:19:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDFBA58063;
	Fri, 11 Sep 2026 02:19:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA86458059;
	Fri, 11 Sep 2026 02:19:14 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.103.123])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 02:19:14 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v9 3/9] scsi: ibmvfc: add FPIN extended flag and async sub-CRQ queue handle
Date: Thu, 10 Sep 2026 19:19:03 -0700
Message-ID: <20260911021910.1038128-4-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911021910.1038128-1-tyreld@linux.ibm.com>
References: <20260911021910.1038128-1-tyreld@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=eM2GH3p1 c=1 sm=1 tr=0 ts=6aa36526 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=dC3NDtCKD2fC6gceAXcA:9
X-Proofpoint-ORIG-GUID: CdLyKflFMqogQUlNhQxfQfVAn0POrVpC
X-Proofpoint-GUID: CdLyKflFMqogQUlNhQxfQfVAn0POrVpC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDAyNCBTYWx0ZWRfX1Pgz1/tfv3Zo
 jwD+JQwyJyR1A+NFWn+LDRQfk0Co2ozeeg0cIecIVCCXeWrzvZFlHfhIuAqmsWWupgpjRtLDb2e
 YYgQf2SuiMBgA/akMwro4Nmv1aGLfgs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDAyNCBTYWx0ZWRfX+bHwBgJqnsd+
 UWycja9q87HJSiXt4uY0p6oT3fsjqW2SmSuXh1nwx4AY8hbPzy1VI6YSad2raWF/De+qgElVNag
 M34FOIuXA2O0FoC+YURpLC7+XAqQwqQEB1+vj5UHnIpnt18+ZN15jdgJDKNsLNmT/6qAL9OWyuM
 bhOIyV8CVkfjqLdq193jTE32b0JigYVWZT9NRVW8ETu0QOP4PSvYQhFlkQrSYLJJqSvTL9F1MTZ
 sXhFAmw3mRdZDRZjPA875jedB73nlvV1fosOH101WlhbEb19hVXOCimSsMp20HkXULxJDwJeBHV
 AmW+GQjEXo11Nsf92/b/AQyfxFNx+JZf3bCHaSwU+qtUw//TSmymiK2+Jim0DiAUtdjNBGsGAUg
 CYf42Xx95M2JwW9IIIqnY3MbYtusqtKi/aW8VJLGfNZx7EgSfEEx5iBeMdnCCtwZBKNZEI9KxzP
 SyDWucQ5IYjJmeIqJPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110024

From: Dave Marquardt <davemarq@linux.ibm.com>

Add IBMVFC_ASYNC_IS_FPIN_EXT flag bit (0x02) to ibmvfc_async_sub_crq.flags
to distinguish extended FPIN events from standard ones.

Add async_sub_crq field of type ibmvfc_queue to ibmvfc_host to hold the
queue handle for the asynchronous sub-CRQ, alongside the existing crq and
async_crq queues.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index d7a30e7a4a28..a8a063d99564 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -773,6 +773,7 @@ struct ibmvfc_async_sub_crq {
 	volatile u8 valid;
 	u8 flags;
 #define IBMVFC_ASYNC_ID_IS_ASSOC_ID	0x01
+#define IBMVFC_ASYNC_IS_FPIN_EXT	0x02
 	u8 link_state;
 	u8 fpin_status;
 	__be16 event;
@@ -990,6 +991,7 @@ struct ibmvfc_host {
 	mempool_t *tgt_pool;
 	struct ibmvfc_queue crq;
 	struct ibmvfc_queue async_crq;
+	struct ibmvfc_queue async_sub_crq;
 	struct ibmvfc_channels scsi_scrqs;
 	struct ibmvfc_channels nvme_scrqs;
 	struct ibmvfc_npiv_login login_info;
-- 
2.55.0


