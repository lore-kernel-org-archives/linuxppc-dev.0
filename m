Return-Path: <linuxppc-dev+bounces-22843-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1418CDB466
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:01:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs3k6Znlz3cC5;
	Sat, 20 Jun 2026 08:00:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906450;
	cv=none; b=Gl1SNFp7wA183wDSPm6MD76HKQBLSL79l6S6Nuzv8yVIOgtpEYIjp06/gG7htmV2v+kyJtg39AsYdBvkltMjkk8CjHmchv9fZs1TpKQ35vomgFrvDjD0XenqkQmbWgFh65ShvWQIsWa3NjUM1kyLWOsrrlMzVrh0ztQiDvV+Dq7w2JZTUr0PbEwz3M19Ct+Tncm8qM3isKUIFmrqgSxMPaPH6ISI9T0ecJUD5DRetmNCZE5she682A+GYL74iyRT4wF5RWQth9N5Mb+cSvwyjdy4Idljsk1B6e7N3mUtit9ZPWqJY7Ccuw6JqHqzAsu8tRUiGSZM/MPx09afVUyQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906450; c=relaxed/relaxed;
	bh=RGxzpqrPvNfaZrVRaGa3UJckt7eWXPaHjsewheIKEOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJN85dQWcgKuDAorFRNkkcKSYX1smQWMVZLKALHWGq0L3wY6VMYa8VO7+wf0WCDJLQCR4yyTrtylLJQre6P7TqmNibtNoMXHzPLEyPo1XedNKyKwk17t05e0KE5/5n6M+ZKe08aAJQ3/F68pZ4TLLepicy5bWj/rBmESK4mdqWiUcJ6Lg0c/sPMaP5zKsOVbl/xngb/FnqH5r7UhLoxed+XwprBbP38xM2eIsjoC0nqGuJ9/zLM6ZhhK3N6DDnKdYtoI9Gg3cL8GfYTNWgq4bWAtqGlu+WhAzzKBqVtlcryCJ+EsFgK+WfUS2A8BAhbryXeKAy/yv+JsHrMyKynfoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Un1bx4kf; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Un1bx4kf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs3j3fpSz3c7j
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 08:00:49 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLn6183393166;
	Fri, 19 Jun 2026 22:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RGxzpq
	rPvNfaZrVRaGa3UJckt7eWXPaHjsewheIKEOY=; b=Un1bx4kfaW6EsR3br2UO/k
	DjEVZXQSKLhRqFWMsxmPVtkMXPbcPaD/McN3BX/5XUERUs8jmgjLUV9gLiumcfcN
	v5Nxs7g6lZ4ZGBsDYDUSjMPFydDFjc9k7HuPdIsn01trU01mR8pcMpyvfJ44e9Uh
	kjY2T61LtwwFOrEXIz6EQbd0z6p+pRA7mkIBjT5/Dagfc9b3VZ5a8AhXq4PPq/Zv
	/6EwpUfkDdh7b86/4SFIiTR3y7tzhB+zkh81eb8YxhIqcXX/sqa9WwqGKl6JZIjS
	O0dahn32F2TVdmMlS19scCumAJZ6L1bvNYl1fpysoHJvmQfzhKYsYWc+vcUCWoew
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxqeu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLnsfn016909;
	Fri, 19 Jun 2026 22:00:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172js3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JM0Q4643450776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 22:00:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 855B02004B;
	Fri, 19 Jun 2026 22:00:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE48920040;
	Fri, 19 Jun 2026 22:00:23 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 22:00:23 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: powerpc: update VMX AES entries
Date: Sat, 20 Jun 2026 03:30:05 +0530
Message-ID: <178190618797.653308.17486087920312921654.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524212943.799757-3-thorsten.blum@linux.dev>
References: <20260524212943.799757-3-thorsten.blum@linux.dev>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a35bbfd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=WvaCuGcPcGSp2Jw2L04A:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX68p4YrCV0ApJ
 4zmQkcIfArMEZhlb06AtGutKJ5hix4B0x0ofIiTu50ypOfQcNs9EijFbEVgKkXtuLw3t+Ia/q3A
 AJFCyctr63NYK692O6vx65sMob5tYAfVAg6YKjxYzntN+gp3cKR4jLeV2mqCd+JP1wmWIf8uYvx
 FSpYywxFtSMRka3kBC1t+xCjr3CgvVY+ijuzJbvNIdvj7dBMinbMjUx7z2y2RyQs73VFgA8btJ1
 DrTG9gGyctmIPrEL+kofzpYULJtCAKmw20IitABD0av+5dKNOhYb2R6Qo94Upomk0sIyaYoaBxk
 edBf7CN8fAdZjDFegcyKz6FfqtaQDo/8h7nNCRVx8VGml4wrw1EhtYGDtlNECC/qolX4bZFGpKa
 DFoq3ZYm3sEVZa2Cmg3pvWMHmP+wzrLmqk5cGr2YnX0v9O6KCo3SKjezcFxz4eRc/ltK3qwcCvm
 lDM/FYNIBm/6yUFNADQ==
X-Proofpoint-GUID: JCDkzTyrtN1aqqCxMuSLcN8TQfAmldUa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfXzirTNlhSifXG
 E0PbMyPd9kqW1HK5N6AvNoRO9ublQxGaLs4e/oLLRP32qzbD9sk3Zx2a4ArTFOvZR5qknVLpxfQ
 SVCTL3TZ7aLFDZrqvLnDutHt4jAKA4Y=
X-Proofpoint-ORIG-GUID: r-9gheGHJBa1ZFuVD-nq_Piv7dls85WV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Sun, 24 May 2026 23:29:45 +0200, Thorsten Blum wrote:
> Commit 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized
> code into library") removed arch/powerpc/crypto/aes.c and moved
> arch/powerpc/crypto/aesp8-ppc.pl to lib/crypto/powerpc/.
> 
> However, the "IBM Power VMX Cryptographic instructions" entry still
> references the removed file and no longer covers the moved aesp8-ppc.pl.
> 
> [...]

Applied to powerpc/next.

[1/1] MAINTAINERS: powerpc: update VMX AES entries
      https://git.kernel.org/powerpc/c/a5779442addf487b8093b12e7acdb16a5aab2f11

cheers

