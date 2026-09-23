Return-Path: <linuxppc-dev+bounces-28055-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6702C9830B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 18:29:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqlqy45B2z30V6;
	Thu, 24 Sep 2026 04:29:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790188190;
	cv=none; b=RHZKm3FCEnfeAxTdC7WEacYgvrJ62EKBsW3korgVvFFB48IfgeUzq66YElbFGXMEWTyoGCf64SbU6HuSJKaUTlzwachxcHmJtEvaN5DUDZW0vLzXNZomtPrUui3NAflmWLSIBm8q0d2SEixQhTq89bdQb1cGi8f+f80aGLvZ/JxxMwFC8G4UJAdHJ3eZnF5UzTz0dvGexeEt9ca1TH8fSs9yeFo3C7tbP6HkO+6m4PJJd6QwOIcF0sVvnxPmXV/8BUyV05w+A11/+4Th91MR1uEa0/yFc6+HMwxjOVe550NKEEWr3i+3hmdbkEGXe7ov1kxkGnlOSp8sj0mRViUq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790188190; c=relaxed/relaxed;
	bh=CIO81MQmUZtyjUlktnrVjloqMXEXfOvi7Kyr/qIBmBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7cLQHAbmixpnPnJHlMCWlMBbyCYWLmAm8ecIrtAqNBypuFNt3nGyzbnG9YNxUsjYjCvwf4UpzwkWV1sXeFF+2wqBvgpxCWwnU1wz8D7ANoP9bAUyumkpN677+xTP2AzB9NMU6g91crm5YQWU/pir3pUkgjLgGcbeLaYbm8aG3RxhFd8dRIQugfS9RVBWanBW6Zk3JObi9o80PKzhTcwVmqpWGnhIpHbMP6NwDxdhcpmFgG//UhlLUQkIQafGeImVnvbaDpmDr6c/REq36O/DvCkO9755+cS3CfqUZNT13DnDqeczLDdE5wVjL0OlffpOh7oWiWCYHNoHD6u6L/SUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mD4vznrk; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mD4vznrk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqlqx5x0Vz3048
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 04:29:49 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGZngj3926353;
	Wed, 23 Sep 2026 18:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CIO81MQmUZtyjUlkt
	nrVjloqMXEXfOvi7Kyr/qIBmBY=; b=mD4vznrkbGbhZDPmfSkDb6+hFpweMOfE5
	qpR5Jj5GUplUiRRxcsq8YxYheKKKgZnlzYNUu67HgqwL8IoU8cYK+BYqFMPJNKch
	l00S12WSqRN+r1fzVOxwD95MUc3KA0v5+B+40LFfchYSIupdMhWdxtEdvigkBRYj
	xJVmWryHKkR8PsP1weOLRVuyrPHiCVbFeCI5il/8KOJo1uJNqT0eERCW0cu8TVsi
	F3qLH9ghXGW59jhlOUqFgx/OA6jVpHvtcn4AKjao8a6UOKdz7Ghz6vlFnZ9/Ko7X
	JdOjdjXqgKRS/n5VQ4NffPh6NTtJAsg5KcTvPGVNuyCk3wVlfwDIg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2n0rh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWtpc3571223;
	Wed, 23 Sep 2026 18:29:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkj93n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NITZnQ42008976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:29:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 667D520043;
	Wed, 23 Sep 2026 18:29:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D93CA20040;
	Wed, 23 Sep 2026 18:29:29 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.83.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:29:29 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, gjoyce@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com,
        ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 06/12] pseries/plpks: clear signed update authentication buffer
Date: Wed, 23 Sep 2026 23:58:10 +0530
Message-ID: <20260923182816.151451-7-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923182816.151451-1-ssrish@linux.ibm.com>
References: <20260923182816.151451-1-ssrish@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: pTlMW5FpqqNPDc4iJtWWC8fLY4K1NgxW
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab41a94 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=aIiXfJ5NXcxv1dgaZq0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfXwK3vRJxSY8s6
 tS7kovMHYKcbB6+mM/XJ4ImhJWfROy2jPJfhCnLKHz7ztWgKh0d5I7PPeH/dPnY8OkHUsVigELL
 fLylOzd5VxNGykw1w86aI9IjnJ8ukTkjxjD0TW5P6Y+KM5OojB7xTrRYYpXKaGWU52WWgo2y8Rg
 ktFIbcLOx2NsLxhc29VZjjHONmZeszCS5F0ju5PIp6M1Oc7OISe8FrVcKOODZlWPraKXPdT3E9A
 oRMi/S+H7YrTDHZH3FFx7LHinV3CRodEA8cKEqmAjVqNVWotZg5Y0gwXZOBCEBUjJm9ugf3zdFR
 V8KuS/8t0W+6XM55KIrfFG7guhBUtirrhPgO+kHv+0SY5cb4PkXXQRAWPgtLmMVoDwTOhTGcvWw
 ijy7UlhR2r/mx63IU0x+LJW03vxJ0DnNyZv3NBp0OmgwjGL6hxGI0oSm97OTMfID4DdFAvyJsxl
 Tlq8f572oL1j8TWBWdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX3OJ01FwRDBKP
 GMiZYvVlO4vdGkPZox+k1U1WWNZXfHeFkh8LZ06VsTKzxLrJPBwd0VD9F4L0uok8JjEP0Rk5Fld
 TlgpKadrq4EAL+oryhe0VYLiX2OaWHs=
X-Proofpoint-GUID: HBBs54GYQynKQnWX-v275IboKyKe_sLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230072

The PLPKS signed update operation uses an authentication buffer that
contains a password. Freeing this buffer with kfree(), without wiping
the contents, can leave sensitive data in memory.

Use kfree_sensitive() to wipe the buffer when freeing it.

Fixes: 899d9b8fee66 ("powerpc/pseries: Implement signed update for PLPKS objects")
Cc: stable@vger.kernel.org # 6.3
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 17a73a04d45b..b057e378a6b3 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -685,7 +685,7 @@ int plpks_signed_update_var(struct plpks_var *var, u64 flags)
 
 	kfree(label);
 out:
-	kfree(auth);
+	kfree_sensitive(auth);
 
 	return rc;
 }
-- 
2.52.0


