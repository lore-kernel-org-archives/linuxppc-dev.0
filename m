Return-Path: <linuxppc-dev+bounces-20144-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB9AFF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 04:48:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3rfG5Jt4z2yvr;
	Mon, 27 Apr 2026 14:47:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777265270;
	cv=none; b=NkW3oz29RsZnWs5KoJ5SEUq/87EUOl2iKdl64ob7D3Tew/X9gWgmVEJU5tSd0SARyhD6m9Xbdn6akUq6AsznzR1oiCnMiB9zu/28nQLLp5ViJz/XLQ35dxhfIKJ1NCgA4yQCiu55h9e5vtYTB9zXdA8mD9WqmIjY7rFQnNFEtH/l356g+FwJZf5xh9yJWguOyGDRHV4lBng9s9e6wiu++l1Dzg7oX3GUalhjhZU00/90CugCiH1tyDiiFppExgFq1l281X06hNS+fn8RoNXiAVS8LTbfQjS34ouIj735Hr3aG2bZH18t3QBbDL/mZi++fMY3j+ok6JsRtY7635odFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777265270; c=relaxed/relaxed;
	bh=xfVKei7BrUBq0PM4w2K7l5iPQ1FyKJXVs2BKC5KVP00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRmqTNsClZnMVa6zWThpMxmA3AnUGvSDlnoOQWsl1C2FWiPUEF5DdKjkwN7IIbW06pcuK2nVVTcI1SlTuh4I8YB7q9deKuqJqAd05ulpq43fra7wvDg2oAYEhYYbeD2Yc8+CcWol82oASuF3/p0pCFG0tr54xL5jvNb+9PgdD8AIYcdLcxQDiSpOfjk89geb2iITWRkHxO0MpjBFbIWVMUlGqhWArjx+9a7lTsjmxtP9WWeJiaMwkloWQIEGh2PzxjVydLxncnG6HphzrcdkTXfrPcwyNKB3kypvOe2VxmhLg9MtekhBCB3wugpvvwiwGC9FfWmoMZWoz/cpJ4kkNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gx1qkzgk; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gx1qkzgk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3rfG0f97z2yvC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 14:47:49 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QFBL9L1888684;
	Mon, 27 Apr 2026 04:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xfVKei7BrUBq0PM4w
	2K7l5iPQ1FyKJXVs2BKC5KVP00=; b=gx1qkzgkAc0lWgOR0R4I2ef3I0Sy7ZTAb
	V8Xc63O/el7KtxXFl2OB0KXamaNNLRy3DQAp42omv62hKtJJClpqS2eYOizP6bsU
	u2Rfn97wHrqSD2C0QTLl2N7N0RCZYvxrKXu70EIh3nY9BJF8V/3Y3ZuLQQwl5qkm
	ZmBQgb9sW3Hg1xSCYeZXTxEOVD/yN+vA6TNniRJSmDaLdivUDDi8vSWVYnhj/qBz
	IDhWhzrpvQyUPP3sPOMVHqYiDSwoq7erf93j1xpnVB2QRGrK2QG01ayzMinGjB9Y
	Yi1rhH5nXr1+Pto0ncVv1229fm1RVPHl6jREN6AWSbd+2VpJvRvxg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8v5wym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 04:47:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R4cgMb017047;
	Mon, 27 Apr 2026 04:47:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g3h0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 04:47:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63R4lejv36176232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 04:47:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 785522004B;
	Mon, 27 Apr 2026 04:47:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D917D20040;
	Mon, 27 Apr 2026 04:47:38 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com (unknown [9.123.5.233])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 04:47:38 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Cc: sshegde@linux.ibm.com, chleroy@kernel.org
Subject: [PATCH v2 4/4] powerpc/xive: Add warning if target CPU not found
Date: Mon, 27 Apr 2026 10:17:15 +0530
Message-ID: <20260427044715.559137-5-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427044715.559137-1-sshegde@linux.ibm.com>
References: <20260427044715.559137-1-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69eeea71 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=rQiant5xAKAa_VN20O8A:9
X-Proofpoint-ORIG-GUID: ct-DEGoSENUaq184Gzf2RwY2bqneYtti
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA0OCBTYWx0ZWRfX63B1zYaVFkWG
 zVCU7Hf31Rm5jS6ngFu+0E6NYvUap08E7gfXvl8IT8nXBD4ba3gJig7yLvnShXr4QPoNPK9WHMC
 1/yT7PIyx65wMdR47BDZIoxq/YQKDBm/Rlb8tJ9izB301QBeBqtEP9OFlLcEsHE5Tq6RDLbhsVW
 lmPP0c0gzkoAH2q+kOVz1VdTza7pjGq08QMVhP+5XAfImzq/v+yg8wVYkgTTvFqTYut1VFrwS+T
 yaKsABrI3CCrPAYlbEtqSJHwVU7aIMH0Ei/YQ/705RTzncJPbJk951AGKjDSnYf11/pREkxggEU
 wHEdQfvqIAu8WaME9CufdzuSez6xGIupBkZDb/wo0XCmAbPLTFOAX0cj0+h0E8SgZG1vRzYgJk3
 MI1EEuxWzKbu3XeiAhsYaxxwnR3C7U+hAlnW90jIdApOFxooSdyKWceAtvujSPoG2Y4aJGdAiCQ
 5pJahgS0H6TSvsaCS1w==
X-Proofpoint-GUID: XzEvI7IzlX339MXnMNfejCYI_lsPsFBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270048

Add a warn_once to warn if the CPU target is not found. This could help
to find about any such usecase.

This is a very rare case, which either means mask was empty or
atomic update failed for all online CPUs. So it is worth printing that
path for potential fix.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/sysdev/xive/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index c120be73d149..dadd1f46ec93 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -564,6 +564,7 @@ static int xive_find_target_in_mask(const struct cpumask *mask,
 			return cpu;
 	}
 
+	WARN_ONCE(1, "target CPU not found in mask: %*pbl\n", cpumask_pr_args(mask));
 	return -1;
 }
 
-- 
2.47.3


