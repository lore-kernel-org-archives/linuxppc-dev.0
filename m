Return-Path: <linuxppc-dev+bounces-29634-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658F3CCF2C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 18:40:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6Vwd2T2sz2ySc;
	Sun, 18 Oct 2026 05:40:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792262401;
	cv=none; b=oZL+esjPQXXeRvcjQJdVkFvMirnirLwmOdk3/V6l2K5FZ+LtBkDxaoZUWh9gJSzXR0jyvxBHzQG++ZqOyhLdAS0WbQPCI6K+1nHTe2dWTEpD+RfWwYySSqHVNr7JocRjVsAXlahdhDLwYAqMGQC2vWh8AJ9vqyAUCxZy57HsJ2B7EbQka4PxZsM4Pk4HQRgMH3aSAFR8s7xYqI3JS9xkzaS//tuGok6+jUSz3WtfHAmvWcgYNzeEuv8wpa8a5vCx+1oORHlc1unN9Ybp22VnXH90yWKu0qPG8MzFbyfu30vPDrgSy8oZp1VkAIpRit6PRDK1UmGVz4RucN1jR2AhZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792262401; c=relaxed/relaxed;
	bh=jOSTDu/LPV2hnD8ermLoXOjRDsEmLDyWj3fpyB7Btwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SK+1qJKY07flGT8hUkA4hg8fBLrfdn0B2c0FaukMwnXUlcNke8kHUKPsCS6CVCnRTJWfoUwmZXoo7MEM5+0rtttHVjH1KZVyhqvcko+uCiALLdBRPx6eY7acN5eG93bYmhRcf6rTQEoLIWSVoHhBWvszcS37Sr7rXNNSWR2Bygen8Fa0V6QeBX5ugpKPPdlZ3uVdsgRUePOWaRVY676cPk8tIL3/aI1OzTjoLm5JyYTY4dr04thhiqNDdAs1tJ5UDbOBZHUhFNYtXy92nzlrrNsw1Vl62Qfoj9pDm3lFKTiFRAFFXa52ENc9FshrGN2GTKLMakGNFHDAes4fdn7Vaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=So0JUCjI; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=So0JUCjI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6Vwc3c7bz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 05:40:00 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGEKVn2777425;
	Sat, 17 Oct 2026 18:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jOSTDu/LPV2hnD8er
	mLoXOjRDsEmLDyWj3fpyB7Btwc=; b=So0JUCjIr2fGjiXj+87oormTg2peRrWB7
	25ksoHWeAx9pnmX1/+COasuzz7t2/uCNajKNagGs+CB/NOIJPlwQMQEbQi2WU67w
	tG4Hkvve98J+qBh8OrSIWgte5kB4+8SuBe959mXgC8hIEUhqefKVqUoubCfFHRmJ
	wg5qqZ8ksOASv8N1+Mac7TbfRxBTU0Cg0zq+d6Z2kjiLaSU+CiBXCCBSfL8MbVzp
	s0YxYyAD6kPMrS8CjJ3ufxiRlwYTR6vZRv2sHHmdg6zCvW0uXhJB4XzdeioArQXP
	2BCLQPkzM5zsxW152LcyeSUu8Ab7QAtuevwqNIojz06vhwIJZ8ZGQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbxehjwxf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGJv43078174;
	Sat, 17 Oct 2026 18:39:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hbne4vs21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69HIdi8r27919072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 18:39:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5BEE2004E;
	Sat, 17 Oct 2026 18:39:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBB6E20043;
	Sat, 17 Oct 2026 18:39:36 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 18:39:36 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 4/9] keys/trusted_keys: propagate wrapping key generation errors
Date: Sun, 18 Oct 2026 00:08:48 +0530
Message-ID: <20261017183853.596052-5-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017183853.596052-1-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfXzo6gKb5pGW7W
 8/GJYaPwGGg7Yy1dV54H1ewOBAN/K3cz8WsCjThs25qbXGfN3WbHRBSUcUtK7cbbe57iHuYph0G
 w71kcmafnxzbkrpqtCrjz3pipiZ9CgK/aaKqdqn1T9OfzLj5Uwu8eaRwHe5Oa/tkKmPxm7JZUsb
 +KcRkyKo7TWhZjwpWSFWy85TBnHnCyNLC+MchXNJ+Zm+XifTmXBTsOG9V12tF56b7Gtt1JjI1cQ
 pc3tPkp5JY51WxYt6S4aZ656YGE09bh73OpODsIloCn/1ufBRr/UtzubK9TROoWZYQX3kWqkX0m
 UPJnzSPXnMVhzXh3fytSHzUlUbuSPGlWMedmglxQ1ByXt+7fEGB2FWVe7yb4lT0+0lj6c3ze7LS
 g46+Q/9WGpYtoFFElABC+bUYgmKKl/7pBEc1K8wA7jhNX2fP34i7w6/M+EMOWGF8lcd6m/b9ZmW
 r+8KiMkys9NB7g+AvqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX5bLMRjByCHgS
 fi+CoLBMEf+GzXx5NQnxTXohMZwnZ2tDEqWYIVWZg1VUNsREDUw5I9u/xBcCwy43vXJgV4PWsl3
 BDmRK6sbo3ppBbB7/DYDv+Gpfcnt3NQ=
X-Proofpoint-GUID: lZo-g7myqHilAj3ve6SsPOqrPnpFwt7e
X-Proofpoint-ORIG-GUID: KkqnyH5BETKvu6fRRbNcyUf1o6Ke_bJ4
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ad3c0f4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sFUY0Dm8-Bub5huaTLsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170072

plpks_gen_wrapping_key() returns a negative errno when default wrapping key
generation fails. However, trusted_pkwm_init() returns -EINVAL for all such
failures, discarding the original error.

Propagate the error returned by plpks_gen_wrapping_key() unchanged.

Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 security/keys/trusted-keys/trusted_pkwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index b6b5697426a8..633a7674d065 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -170,7 +170,7 @@ static int trusted_pkwm_init(void)
 	ret = plpks_gen_wrapping_key();
 	if (ret) {
 		pr_err("Failed to generate default wrapping key\n");
-		return -EINVAL;
+		return ret;
 	}
 
 	return register_key_type(&key_type_trusted);
-- 
2.52.0


