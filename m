Return-Path: <linuxppc-dev+bounces-29663-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87468CCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 17:09:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j74tF2x6Mz2yfD;
	Mon, 19 Oct 2026 04:09:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792343397;
	cv=none; b=ASCUlSZjnzPTAJ7VP002wBigQn8ASbq8hsE439i9FMSCJHzcpmvhO4jvszyVPNRxWal44DnwyqBQjAcRjjtXDFNP/LLKKxbp2YQsPoOvGCYi/XfKjsCDQVkdu8BTsMEXo03elrexr9DympwCPFO0uqFkLH6fJfuhZJt2nzEYd5wrWjgdNJP3yZmvX3oyOz6/KRkQJ+qmpge/7ow5iDBeIqRnK65iAhh1RNglX7U8/6oYqayo3KB1iZ0Y6LWEd8RLW44K59kVkkEcENgZPtDNlWKRc8Vg+Q49St2r04giEVhXIwKxAjy6sGpBngHJMhg9ByGInAl0qD70QRwHZGLg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792343397; c=relaxed/relaxed;
	bh=jOSTDu/LPV2hnD8ermLoXOjRDsEmLDyWj3fpyB7Btwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3WcrbgSiWAOOOubdBLNxBQ4/1EnUeE2BYptF8tQJNvG6VhcqHZeNToIs4GtskFBI51tKPMZVrjN5Pgk9/WZwYeJjgtwcj9EDV3gkL2+Jp5BSOG3fOgUDIj20YMWId+zfCkYWR7PyW4L1bPFcLljn9aRjLj2daAq5HZH7ilrpfqrzGnNu6rWxy/grO0jBqw2+DHnWMXkFkuowgT3IxOdnFCXT8RMu0pCoSLV4XYtoDwKxH/WEoVzqkV1DK0YscHfceXSOZa/jD5vcv00BIw5U9/e3vzVtAJ34t/g3Tey6uBX0E53ZhTtRCWRS7CnM0Z70N9mwXxMveafySEjbBbnNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ncQePMUR; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ncQePMUR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j74tD4Q7lz2xg9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 04:09:56 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFF3si1295584;
	Sun, 18 Oct 2026 17:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jOSTDu/LPV2hnD8er
	mLoXOjRDsEmLDyWj3fpyB7Btwc=; b=ncQePMURka/Kh+eEy3BK2xjbM8NC4HBj1
	Z0ajk+Zx0MwMaxo+d4H88YYRy/4VHr6CsQG77wZeUOuLufm1z4yvCMlbAMv5PKpJ
	ZLdCRkX/w5yn/jAupu7dnb8w0iEBFAwn6Ybp8yg/xqiY6wQ3PPMlLkNuxJA2GjCi
	S8Of8Kl80PzZOBFsAKjbBWcHtIOc+jdlmlz/IYCCGAdcHWzOgHtBybQqF1thFKiY
	KTtWB2bo/8x0rFGl6lcHcdgxcP/xy9FpGi4UYRWYCy1I3jCwOobwpnUjioPRfWN2
	EicFOUl9eQxWu/hJoHNeD6LEHYU3qG3ZBAel8LJmHKI/HfZHONs2g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0r7ep1g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFYm0S2728115;
	Sun, 18 Oct 2026 17:09:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hckqva9pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69IH9dag39911888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Oct 2026 17:09:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 194C220043;
	Sun, 18 Oct 2026 17:09:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29C2420040;
	Sun, 18 Oct 2026 17:09:31 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.125.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Oct 2026 17:09:30 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 4/9] keys/trusted_keys: propagate wrapping key generation errors
Date: Sun, 18 Oct 2026 22:38:39 +0530
Message-ID: <20261018170844.491252-5-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018170844.491252-1-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX8q9CNpFAV8ur
 yj2/smJ/tEDcEg5HKvs+RZEcJkk4aUnZP/IOk3W2qvI8QejYWN3Yiz6HCceqWir5e0SR6aEyIS4
 6zqzy/M81Wp4L9J8PjeTBa1VuJkqVpI=
X-Authority-Analysis: v=2.4 cv=PrUG/AM3 c=1 sm=1 tr=0 ts=6ad4fd58 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sFUY0Dm8-Bub5huaTLsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX8DZFHfxOZ2Ds
 sZYXlQyKR84DSYsLJGv3g81DzuWlkW3rdMkARehrvn0n0qSqoVsdtF9flx7tL0b9p6DGuTiHB01
 IfrdHcxOBDxkv37RmMZmnanO/pwv/xrUviDndilS43PxC8Gl7UJdvyBk8HSvF+cP3nEQn/14bBG
 bZUsGe9JOPXJSoYt9RpDOEEsX1oJIxhUAnqRh5VrcUPw6OZTgXn+m2ch0D2sCorBw6lLOKzjgTk
 LMibFxd43NAQC4mEEMZguvFnXiNIGnv8aMzScp0VgRsO3piierSP3ZgPP/56jtsStpIzQlQB2Ux
 T01ajRExcfw45WXp5Jk4IE7sAXtXHbMf5DxnqnHOsfq72GbeaMANLAspnbjlE7YDhgVh68+NiiR
 s5EE/Cz+z/QeKK2eq2awEFtgg0JOwHg6VQrDLh/mhcueuMDCnPC2/fwIfUsEeuScF9+He8AVanW
 VfwqzZWhIj1m+JTvKBg==
X-Proofpoint-GUID: u2lyCvo9vtmdwdoUSzGznFb6o1M3bcpb
X-Proofpoint-ORIG-GUID: 7ZUgzm6nJCh0fEGHvSCApWjhJzYHoV4l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180066

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


