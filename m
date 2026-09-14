Return-Path: <linuxppc-dev+bounces-27209-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1EBC88E64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 07:22:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjxRB5mwCz3048;
	Mon, 14 Sep 2026 17:21:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789370502;
	cv=none; b=D5+wJZhPUvd60nrUTI19xU6wOe9ipZavbAbcnmiBKSqCOG8OwrFyG9lK/UG2CIq6YtQ7f9uQvMvXOMVGPOy2pAqlQOuu8t1Z+Inw6NGZvIId+Z/sXGnxSz+q9dWNveH8iGjO5PmGaURTz3AJ0uIcgenhYlkJoAynITKKMwHRd14Ei8qC47iAdHaJPJY3KckAGB0LcHZNyB7bPtK1ORy2A8oarGxn9X0rwGBF4RU71BYgMQzr5WA+p7QZ23cv5m1bM/4Cj6vYCphz6IOcM4kuJQzhxuAIa6d9YNyWY6OdTnwRx+bDfFYrLC48K6BDshUfgNynLsnAp1NNcPwdCH+GHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789370502; c=relaxed/relaxed;
	bh=aSrUavtWrPoutvo8Widw7jUErDEtIcp0dpPIVdX3eXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6IluURIidzOZQex2XQt2H5XoAkXVETzhAJEwYSNN+msIHpX0GrKWTAI9gze86+i6DfbpAGc8/XIrhTRR6Am8qV1Mwh1lsM+IWtS+ix+GXKKYKMYzpW4+YDhqkxnVEzPGrH+RkZM4NBbzD6IJLILGyD40slaIMWBF39egRobis6SDjM2eG70we1oOe35KQkvyvccQ2m5iYpWfcPy66Wn0kwURmoLNW2CF6tC2iVZDbcZ9KOhf8MRnA8h/dYg9Jy6pmQDMYtlUy6eb9RU2M6rx2P5NvDOcSrP6HV4Sw4FAaYSUXniT3sixMuKMxYbkQ5r6t2Q7i0/y48I1ewjp5B0jA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=riad50NH; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=riad50NH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjxR96y6cz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 17:21:41 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E61ZIX1243011;
	Mon, 14 Sep 2026 07:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aSrUav
	tWrPoutvo8Widw7jUErDEtIcp0dpPIVdX3eXk=; b=riad50NHXo6+I+VazMTrSK
	pw/Z9BjSWPsadrfwhS1VoyRDt3nFmRUXFq0cYwGfp8h9g5dSJIk84U3w8lAAzEeb
	1hTdsyqZcOiv+c6fmm9muizFByLPlPeaBmrzffN1FHv+5gjN3cv6qxYCVr0NPbmI
	gJyBx6MTAbX0LITFQ9/N8tbs4dw7HXkaEZB+IJFMJ0tebzILZbKnnZmJtikWbTms
	tZYVG3Cs72wjSJz7aS3JZNF1uX18/bYYANBF25CbTnnUtTVEiwwX64sKwBEzLgJx
	IW3s9KRqYHz+HYxS7vuEZHfQXU+9eRxJHz7ROeJQ2kQThj4OX5fAda6nRysed55g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcuqkab-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:21:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5o4VJ1775096;
	Mon, 14 Sep 2026 07:21:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnhevvp6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:21:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68E7LONR52298030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 07:21:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02E5320043;
	Mon, 14 Sep 2026 07:21:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8051C2004B;
	Mon, 14 Sep 2026 07:21:20 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.93.83])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 07:21:20 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, longlong yan <yanlonglong@kylinos.cn>
Cc: npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/powerpc: use MAP_FAILED instead of (void *)-1 in tm-signal-context-force-tm
Date: Mon, 14 Sep 2026 12:51:18 +0530
Message-ID: <178919368041.441103.208453892352199243.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722023428.932-1-yanlonglong@kylinos.cn>
References: <20260722023428.932-1-yanlonglong@kylinos.cn>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX2YKcleLpq/6b
 EYBj2joxXjDI3dPvzTrjakaAEZeLzPC7s9zauSPkN3qhTwcBobuJjwv8AxR/XFThvtf/V89khRn
 sqY60/pv5nKG4t0b/4XGUIuCyPQdHKE=
X-Proofpoint-ORIG-GUID: krgBYSi_lFhbe7FdT2mAxXhvJFkqvcb2
X-Proofpoint-GUID: St9xalCv9EvyCscc7RDcekdq2WZGIA3j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX/7p7cbieHdBj
 ucC0sRuIqMHgoI1Abr/qxl6MKEAT5ws9Bcm3g/9lFUSAtPW3jPJ0XjrZp8gnSRjBge1b1IMHndi
 QumEombF6cEv9Fm2TMQ8NsDUHT7+K1/tepw3tVxm1xQGIMXEGn69U7kMrkWPTqxHjJxAzcSSHub
 LLe2Jl/icfkpl8YWaLekyCpk+SlpW2HC4O1nQ/R1RgG2BDHRQBk57lD6FqSbQnvZ7Irgv/1Hnie
 ZX/R1LEKMXXejOBiZcA+5rxjgxGYkfuFz6Xkiv9ebxyjHCSmnSOn++45ykeLE5YAzgVjyMhmrlm
 Khp0NuYGwsodL1aQVgwkcQ316T9BuYL/y5e4BwfOVVO67hm2LBhpKDrnGdDs6hXP+hHq+M3PtnO
 fapCAaOY5o4S9FvvwXrdYHqdCVGgmrUCGKI8io6NPi6fi4TcjayejcKY38d9z2hWAom767R200x
 zUMjGhqsAnSO8MllALw==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa7a077 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=jyw6kHy9CTd0Shu9bYAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140098

On Wed, 22 Jul 2026 10:34:28 +0800, longlong yan wrote:
> mmap() is documented to return MAP_FAILED on error, but
> tm-signal-context-force-tm.c compares the return value against
> (void *)-1. Replace these with the standard MAP_FAILED macro for
> better readability and type safety.
> 
> 

Applied to powerpc/fixes.

[1/1] selftests/powerpc: use MAP_FAILED instead of (void *)-1 in tm-signal-context-force-tm
      https://git.kernel.org/powerpc/c/bf1d8287816194457c1a936056ad2d1e1e478944

cheers

