Return-Path: <linuxppc-dev+bounces-25234-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FFEC55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:57:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6tY0NcDz2yhP;
	Mon, 03 Aug 2026 16:57:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740244;
	cv=none; b=YwX5SUeY8vvK/SgPPwRu4qj6x8Qp+2Poef0xm/g+to5qWwcoMrpgME9XQJK9n53kDJF6Co/rOfBzkdjBsIyCblpaMNacLBydQ0Km/Q0Z+JNmtLKj9zw2ADTggFYsUYXSNN/aMEflHeurTupDV6Z8CAy0t4KRUaqyVnKtY1qGFgbx5s60IAkhIojnvjA+i/oVsGqSefTMHkZ3H1fWLrHfuKBi1x8XRSsDzyz6GRB1fqvSiHiLh0Hte0lYJpUdKoRCx3YcIbB2I6kI8HYRVNuofx8S6XETcE5otB2QOpDhe1Q1dvuULg3QYljjr6h/0LvIZMd/4Sndi0/TlEyk3d1Jsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740244; c=relaxed/relaxed;
	bh=qUMwf37wtwX/8FvdmUZT3KeznzjkDDINlIaOGgKr4Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apWy6bjk1DdCGkgmMKJdsXXdicW6cQc7TEV51fEjcR0Fz7PPpOHime39Zz2c0XLMbqT8VF9Q5YsFGLw1gE6oVYkpRBURkk0ccIg04IUJO2bWRMGDW1K7M/+bI9KT0uP+GKZdXEWSDqzuiE3s++EY8F9vP60pUOfXXunOYZFp4GJ+dvXXcI0ZkK8DcwW+xltwRHLN8A6a7e28ihZnFUcbLN+CmKiYABDEQfxsAwXZIN2tgbCf3uyq3uheyoumt2nHZWlLvW29rGBVbCqiJkKwWWY/2EvrOjShfND5apEbKdW6sNfxwtwPLxJ4l2xSHFYunyfzRfdyp0r7H0hh0nuIhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Iwx5Is75; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Iwx5Is75;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6tX0krqz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:57:23 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmQa9161457;
	Mon, 3 Aug 2026 06:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qUMwf3
	7wtwX/8FvdmUZT3KeznzjkDDINlIaOGgKr4Zo=; b=Iwx5Is75QFK9SvkycFpKlN
	o0mC1/esCnemFFgAR+yM+BHUeFNtZPuVcp4zd8mrE6BAXpqz/dHWqrwhxB85CPNT
	fX+DTOZBpJ8KB/sdJ8d3mnub2RQ7JjJjeYLxT/GgmLMmP7nz0lL6oqF1dcGSJ3Xx
	+KbB7y//vwa0jtoiSE6bVzCdoT8gnHjYJlF71AkzRIVcXglw2Vgk9P1+KT1l1D8+
	0XEZRQnhHhft34W0vBSPcok6SngOngRWnnM/FVgxTPtBezzR/uqpF3UFCC+DhvG1
	cWAwzoCpAPMmitE5vobOxuiUlbbI7QA3YID776Ph2OQgNLYDGMdMQAW9gnxbZoJg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hf9sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736us9g019488;
	Mon, 3 Aug 2026 06:57:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtybvtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vDIS31392158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8658E20040;
	Mon,  3 Aug 2026 06:57:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC3EA20043;
	Mon,  3 Aug 2026 06:57:11 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:11 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: RAGUENES Jean Noel <jean-noel.raguenes2@cs-soprasteria.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH] powerpc: implement get_direction() in cpm2
Date: Mon,  3 Aug 2026 12:27:10 +0530
Message-ID: <178574013466.29744.10436603426961250541.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c6eb70aa0e1ba6e15f947c827006aa79edace05c.1785318836.git.chleroy@kernel.org>
References: <2565e33e629d16d9e33086570834146bb1c962db.1785318831.git.chleroy@kernel.org> <c6eb70aa0e1ba6e15f947c827006aa79edace05c.1785318836.git.chleroy@kernel.org>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX9UzdI6Gib1e0
 7WmLbQXrJ7EDsVEq84LoyLSIEjKqifAWRn13cTbezmCTbf64/F3wyebhBZGvgIN3DPND+Sv4dOJ
 m2ZZVsm7flRvH1X4iXXu1KqzgSfOF7c=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a703bcc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=rczDo4_ZDh0Zxz2HFYsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX0s1D1BN603+g
 gsRQ0b9NfK6cbKogiYic2jPS9IXw5eb80iAVaWBWKxFgMpSR2HR8wzdAU2zvVTyXbclOsZYn6ti
 bwFlwvWIqOgjF2mrRiSzL8U5k0Jpb0/qdxTxsh6WCoCIuVWh2yPGmHVgNTYRAw2+/9e54p7aWmw
 CRe22LJheqlNId3Bfc6KT0j/zzdyFSTeiAFv5V+GaP4gXUIwys/eR1vNH6174IkjlJbV5ISThjY
 k7KQFNFB9IzCv2reaM4I5bb16u1J2A7wBREelHLPt2k3/pLJhiiCf6jIRrWUVtPOxNbGqZvP/6T
 xAG1f448R0MJ42KcOzw9ErYYX0tQ060YHf0oekckvyheOEII74dAN3SBJWik2aQWPpZfM5hbZxB
 IMJG4KeESK2rqOvP56PcYcXausHC9G5WLkI3BNcQGLCgJ4GC0N4bzdF7S2teFgsFbitWbNC0JDE
 CpFQgjbnHMNAL/ZwIXA==
X-Proofpoint-ORIG-GUID: iFqmfWw77nNejBnbP4OQnM4LzYVkFm6H
X-Proofpoint-GUID: iFqmfWw77nNejBnbP4OQnM4LzYVkFm6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030058

On Wed, 29 Jul 2026 11:56:48 +0200, Christophe Leroy (CS GROUP) wrote:
> The lack of get_direction() callback in this driver causes GPIOLIB to
> emit a warning. Implement it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: implement get_direction() in cpm2
      https://git.kernel.org/powerpc/c/ca16219e9babc874349a6ac307d56523871a9137

cheers

