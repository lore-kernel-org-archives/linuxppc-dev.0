Return-Path: <linuxppc-dev+bounces-27768-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F365C982DE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 01:34:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmsT11V59z3ccg;
	Sat, 19 Sep 2026 11:33:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789781604;
	cv=none; b=HR43aCPIHDtL21+Jl7Nxlp99lDr6anYck3PrBMCGfBoPaFhwkK7xJ0Bl0GlF+0D2qX4BS9AtIpWiS15FAOK07Wi80K4LkJp6hM0cOzIETN0hcloPRus95AzvMlOJVp9DpxJJNW0+0KnKeYg0oq/4OB2FuykImGJ5NJCEopsntsXkKNJ7HjlD6ghk5G5DIdn31zyVyPb74Uz0xTF7qMzs9xnV/2hiZL4yG6s0d1UuMUIvDAyEWBILMDWt9qoru/aOFjEWPAn3sPikjlPogwcmBL6GFVYCJoa7+1crBuLLwbVVq7T/YZcxgfGAka1ycFuhTgBdwtirAPK9tUraf0meXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789781604; c=relaxed/relaxed;
	bh=9brRyILqr21NfsPunJSLVDDhoEO0fDeyEFwXk4ednRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9p0iZiJfVKHIhoqxyg5wPqErljaKRogPpRzW316DVvALCJo83/mhT2lnMorMTYdfulpfcx35vveD+APonmYj8EX8LuuzU0zn0TTpRsNevDcYBO8+8zwBWKONL66uMOH/HYiNsbh7X9oqYtkGfdjWxmQuEM60flZWl95sFAsozd4GyAL8BTak6QQaWcXLKAW2rJDsQbXCNEGDbt01YnwGp2i40vHTnhSpf40CzRYKjPbkeG0E++vlwG7jS1FfH634GP2enafd+qiLyt9t8bxjvFHs5jpHe3ks3wTveDEFcFioMqxi/Oabuic/GUtSlCc4u+6rxJRbSx7N9y71+aIkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kICrviCF; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kICrviCF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmsT002Gwz3bqx
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 11:33:23 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J0Nv9c2565988;
	Sat, 19 Sep 2026 01:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9brRyILqr21NfsPun
	JSLVDDhoEO0fDeyEFwXk4ednRM=; b=kICrviCFuVEtvrmGgIe+KXePRit7e1aHE
	Ur2nvazJPjgfwj/2PgMmQHncPPl53m1DFVIQx7J9e7UxxX/0idSa2cL5DXoXt3nc
	Dpr/5XJB/ZxvX1NvGkAjMcnhwRUGyB1pfPgZ0/YUbhf2R6G94EM00+l51qRJevEA
	lVFyO4zuhOX3BPUHeb4Boh8Ytq9EIsROsap3bAsFj+ZR4IrZ91yzYEN1tVJd2O2/
	uiakSGXzQVQDBcqTW2z0L/EqIXsuemhcZM6sXljcarFWrZU+eU9sHjlxOc+Y9yAf
	GBrulwhee5NG8DFJ9XFaq6li/hA8Whh4KEZFmQKcBjYPGw+8zwczg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gsftk04hg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 01:33:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68J1PmMf1662748;
	Sat, 19 Sep 2026 01:33:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gsgqn00fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 01:33:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68J1WYhF29098668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Sep 2026 01:32:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B234558051;
	Sat, 19 Sep 2026 01:33:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 109F45805A;
	Sat, 19 Sep 2026 01:33:17 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.101.145])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Sep 2026 01:33:16 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 09/20] scsi: ibmvfc: fix infinite reset loop on NULL evt in implicit logout path
Date: Fri, 18 Sep 2026 18:32:55 -0700
Message-ID: <20260919013306.2948028-10-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919013306.2948028-1-tyreld@linux.ibm.com>
References: <20260919013306.2948028-1-tyreld@linux.ibm.com>
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
X-Proofpoint-GUID: 50B31vID0Y6sRvubIVPBaOC66sS7Br0W
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDAxOCBTYWx0ZWRfX4fvr7XGU8fAV
 KJ6kt9KZ5NVTCst8gqsoSRArThQQCvuVekaipn30eSwcFPYCAp7WYlDHK6BBGjHX54HS73fZYsD
 z/0DTYzamYC6HlvuDzDXjj0Ma9d9jP8=
X-Authority-Analysis: v=2.4 cv=EMaTQFZC c=1 sm=1 tr=0 ts=6aade660 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=b_dQgyAL5RWhf91NP5kA:9
X-Proofpoint-ORIG-GUID: 50B31vID0Y6sRvubIVPBaOC66sS7Br0W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDAxOCBTYWx0ZWRfX6FH9HO0uq2f4
 KHHIOkI9h755jPkiRkoeBCiYf8ZpdAc2Lu1pKG/tWnnrcCLYkwUjs+YtrkVPopUXEJUoXkfvQgc
 blN6PCOqpI6OO5edU3NSRUipM1hKPtbWAUGUjCfiRxI4+5doEcEQr/6ELJrRd/PGAXpPyrLWcZj
 lX5qS13v/IZmHab2jm0rCmZFX5qGl4JVjQi47UYn0wTvw0w88AxoMm6NO7QQcGlXKPFZUfr4Vcs
 MVp6oYRPBBn+SKsCL7yOZIVQw+rLbLB6OtQ89BDC/RRdmrmJi0JFl2AJ0m65j2XzYzkZ9YWSRci
 aVvewPmWlui5b3dhwhKQqwbCTtcn0OxSgH/vziVzeV0m7jGzf/T6rf+LrGaXf9j123et6ZCrTvr
 bc5sM9E8+jQ0ftSUxdLM6ocAXtCDz3JOvbPzNp8RTbM0/o7EXYjNiY2ytAF87k9TCsZ9LYk8XVr
 4iATlEQZnKBd/DoN5kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_07,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190018

ibmvfc_tgt_implicit_logout_and_del() calls ibmvfc_set_tgt_action() with
IBMVFC_TGT_ACTION_NONE in the NULL evt error path. However the state
machine in ibmvfc_set_tgt_action() explicitly handles LOGOUT_RPORT and
only permits transitions to LOGOUT_RPORT_WAIT or DEL_RPORT from that
state; NONE is silently rejected and returns -EINVAL, leaving the target
stuck in LOGOUT_RPORT.

With the target permanently in LOGOUT_RPORT, ibmvfc_dev_logo_to_do()
keeps returning 1, causing the host to spin in an infinite reset loop.

Use IBMVFC_TGT_ACTION_DEL_RPORT instead, which is the same transition
taken by the !vhost->logged_in early-exit path in the same function and
is the correct valid transition to unblock target cleanup.

Fixes: 0122eab60b15 ("ibmvfc: check for NULL evt in implicit LOGO and target delete path")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 5ba8058991ef..70771f6420d9 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4545,7 +4545,7 @@ static void ibmvfc_tgt_implicit_logout_and_del(struct ibmvfc_target *tgt)
 
 	if (!evt) {
 		vhost->discovery_threads--;
-		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
+		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DEL_RPORT);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
 		__ibmvfc_reset_host(vhost);
 		return;
-- 
2.55.0


