Return-Path: <linuxppc-dev+bounces-29619-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D8CCCA463
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 07:49:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6DVM5Fmrz2yLF;
	Sat, 17 Oct 2026 18:49:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792223387;
	cv=none; b=fNlBIJ/afrw7usaUB+/ShLOm8G599A2pAme3ZajxRQl3j1Dc2Wjc/19H9rj72GbMSedVB/NjB0EtxdcBxxgZHwgZCUbj2dvwXoSIG/Ed+dfGzeCcUe2D9c3of3QrO8B82ObEEfHpqph88PP6SeNrHUbxQoUoJZ8qtMp0iQdIQKF/7O9IBlHEE5I2Ncu4Iz4dLYfAe8uZkTFczaBGF21tUdYKawQ7q5HptcI981coD6KrngvDCJTsbPqteBd5mMDNA6XQBcXLTg4wzL82q+VaHky2Cxt8Hx9Cn3RZ6Da8rjKyh7s4FTgBWsVujttdYmMjvshHoDZnNvtq1r/lI7zgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792223387; c=relaxed/relaxed;
	bh=jOSTDu/LPV2hnD8ermLoXOjRDsEmLDyWj3fpyB7Btwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XziFH9eNTpeZmT+b6T3s5Ht53REbh6lmR3VtmaJ0W5Ef5AntWer6nwSGFFEVLoP3FOX+TKgbZNeXMXRsWa0x5wonkZLJ4457aDaEfMb5GFKYVWvzBmeHlwXW6PHgvY2aLsSmv/l7ttHoA8CXpW3H5MvLeqEdJ+V3hqEpi/Cn+vAP0g7vsvAiVdvUZMzKHRjVuzCSoxWwlflpckW73j9rKGZQ4tTuFSldQH/VM0Anvoi7lFDd4O3pg4pOEAQHz4kN4tNTQvVQNaGzL+43UT1riQa71VXbN1zdOk5++RnclXpU1PVWbE9bTBGusD7qalPiVNz650ggMOcyxE6EFdjqOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SRZb9CfU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SRZb9CfU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6DVL4krkz2y8Z
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 18:49:46 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H7EEF41820899;
	Sat, 17 Oct 2026 07:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jOSTDu/LPV2hnD8er
	mLoXOjRDsEmLDyWj3fpyB7Btwc=; b=SRZb9CfUke0wlCPA0i+0U6Bw+4PF+YmXg
	ZptgoYp1fMmQow59LJJiixWAb1nq2vb8DW0qntD8PRGuR3ksosRLoCnIbpwUuQMy
	5fZAXZJw+Cr/owwT0zfGHEOhmMxUOdoBq/Qt8sAabe+gxKgbxh018RBdqzlUucOV
	eMLvLyP9cPYrGnFyge30BWbGhC8nqOKeKJzpDBUeaRwaEl7KVS7dQlfcenwDgHOZ
	sjRW8SwcA6tFXXoYz0sOjpB0D6cYj7rwNFVX+kY9UwyfK6w+M3untl7P9xaIXevp
	FhrXIYqpGM90OFnalv8IUQJ4BSxlE/sd2R3Jmtw8Htdy3KOPrP0rw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0r78rhf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:49:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69H74qsk671685;
	Sat, 17 Oct 2026 07:49:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hbtqc9r6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:49:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69H7nSTo28115626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 07:49:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3B8120043;
	Sat, 17 Oct 2026 07:49:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E4B720040;
	Sat, 17 Oct 2026 07:49:21 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 07:49:20 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 2/6] keys/trusted_keys: propagate wrapping key generation errors
Date: Sat, 17 Oct 2026 13:18:46 +0530
Message-ID: <20261017074850.164031-3-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017074850.164031-1-ssrish@linux.ibm.com>
References: <20261017074850.164031-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfXxXjN7kHfRpap
 r30GWCGdPEF7Km18TCTT9MiCvqY9R4PI1+Mlx0yRNRhie5uvkDXl1tIfnH36ggsGisk5mZ0DalS
 luuEamLGkPfY9iTKZXSsRU8ut4tyckE=
X-Authority-Analysis: v=2.4 cv=PrUG/AM3 c=1 sm=1 tr=0 ts=6ad3288e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sFUY0Dm8-Bub5huaTLsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfX0DZBg/kuhC+s
 0zXFSiovi8b+aZMDHPS8ARyMzQUBMsP217Ny8e09rDqeJKRAbHEMJA7N2C0mWsoSNmcKiSmcMyx
 /gbgGeb71Fejx8HU0eWCbArA1oOyEefVc4RrToafSlzTxyPeDA4z8W1XXw+PaI+OapWzYcEmwXU
 lZ8wCGbNquu198dr1zx7xQuA1anLGqE56aBDuABHfZIK0v3JP+zBEWRgwk6CJJZKB14hvlQpbfN
 DMQWRjaL1th/M6QPve6MhBiWV0eW7nrjfLOtAv3rA+X20mv7qtuMaYWNqEG2l5PEiOvz10Xpcsf
 QOaHRWMv3P6oOKrwUYOrNAbPR9JlycN2AMlNtfibdJOFEiuT3Jg0yEOeFhGE6Gz1JoCDyfU1bwe
 IlTTrOxkNtwSBvqVlpWlmDDDIfvzZQjnrcUPk+UfT+EMeNz/TjF3PHjy21f91mPEi2EBTWLrcdU
 +JOIBYQl8BGtgK06MKw==
X-Proofpoint-GUID: xS1F05CcIzSUzSHTRLGjBb57jGsWFXq4
X-Proofpoint-ORIG-GUID: -yckf9MQBHfJghRYda_UJKq3bcBR6OUi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170030

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


