Return-Path: <linuxppc-dev+bounces-26884-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CD8C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:19:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfrHs1WtBz2yrD;
	Wed, 09 Sep 2026 16:19:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788934777;
	cv=none; b=lsS2fwke5e56i+aSi8OLyYGkDRGeWKJejRHvxEbMgwdEagudGxaedYJn1srqSbCrtiNa5DobR9X1ipjSuzUIuxM0eGiknC9tp2nUrf4DiKsWbQp8qTGhBKqarFnWNm02XUgKIaxlIresSBPCNpvnFj6+6L93iJnNY5xF8Bct+MxrLwAc/9pJG3L0svn4DdjniluGMKUKBEmXJLMELBduOOLnEGNCn4WOyAtoe6nlf5FC6no1HVKj4HZmYR5HAPyNugdlSfgfx6gEFs/ynVRuvXhXNju7c4fXbNrjpfgk6FrK7dhOktIXsmVrh6o4psIYsbnqSM3xhHI2nAj6HgESOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788934777; c=relaxed/relaxed;
	bh=VVwAGqTsfyIIohsjdow+Yv89CL/AdDf7ML/fVNSrOzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVYa2bynrQgJc/O+xIJU/We0KVL8sdxrcMyC+4hnec3xRwz8VySpnlkzn696DxQynUiLm5F9O1wskAzZ3RpUJ48AaQrLWlQbrXCCiU+MjLeX94eObjUu6nea4Qin7XiLTuz6P1ch4NUsi1oJK48OSUU8B6MxmhmmAeFYtshkeKmsqKtL6sKUmGNLPNh8dB+QeZDZpSws+bPEfdbIFtORpJBSs0UHHA0NRglkyFvaJB9NB/WLhb2yB+U76CPRHTjs/u8BXb7Li5HZ2dK5Uotg2T+Mq+5bVpOQA98dCN+MjANtttj9pdzFIIu2glvyub7oBttqoS/Sc1e5l0hpevqpFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L+xO8KSH; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L+xO8KSH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfrHr2GD9z2yr9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 16:19:36 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1hvp1116759;
	Wed, 9 Sep 2026 06:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VVwAGq
	TsfyIIohsjdow+Yv89CL/AdDf7ML/fVNSrOzY=; b=L+xO8KSHLmf1hu/bilWH0E
	dNBYcFpZxSxq9bsKnfANXYr9qY9csP+FA3a5iW7AHgvgXRdvLsqeIVA77HAFdS1f
	xDatmeXGofriG5V4af/LNY5hXPC+bzmGtBW8oewVZ01c9VYkD2XBu5Ve+OePf1HV
	wzsYbuvwNn9pL/NPzPzHTHAE5DP8iFUS2JZOwLdpkWypFBUK5FTfO7lh213EdAzo
	3dA26a2MsWFNSLBu/rn2YzjZLT9gmwDEwzlgecB18aJ7nEWj+bFyBFpDQn8jx3am
	L0nFFpdoeI5niSRqvBEreIPsPGdj4sCIdUZx7P6J2MWmuU4xFNYXm3EfNhJs2xSQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjruqbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:19:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6896BEpg002278;
	Wed, 9 Sep 2026 06:19:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03ygdw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:19:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6896JAWb39780614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 06:19:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB97020043;
	Wed,  9 Sep 2026 06:19:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BE1820040;
	Wed,  9 Sep 2026 06:19:07 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.64.17])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 06:19:06 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix repository.c build failure
Date: Wed,  9 Sep 2026 11:49:06 +0530
Message-ID: <178893459274.174069.18403821215814298578.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703165834.137242-2-thorsten.blum@linux.dev>
References: <20260703165834.137242-2-thorsten.blum@linux.dev>
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
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa0fa61 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=18Nx75zNai4jtXO8pRAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX4eKtUB1LESBa
 TkdBL8/ivRdHq9Ra2v/udwa1mUMsQHWLYA9q45QCuq4agKUDB7886Ml+6wRX+T7Uae1hKd+4T1M
 5yCkIX2zMk3h8jZdpuO4Sms3CzT6lSo=
X-Proofpoint-ORIG-GUID: PpEPXpvKWjlyaQr24fpxfla5v7kQab6q
X-Proofpoint-GUID: 5AFmuyYlZ6bQ3Onhy3Nv1ftEXE3vTFki
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfXx2iw6HqE9nZh
 i3V8mPzMmtSYndl6bV8JFRDZfb/Ijw4gJsL8DRMKsTPOOOrO1o7vCAf7KczmY2DqhAnEqyLleji
 evr7we8YREx2wTPLrNxp4TwhSUQenF1Imc+5qiEZaE8sLAc79dMaRJ8nHY18Knz36z1OWLCNzGx
 H5/VKi4VoVL9i3AwuUUL5inVkLUJfLjlGZPvDuPUTkHiU1vxgbLkwk/Bt1rCsoA2u04bubR6rCb
 waMcJ7FBlbrHT2Cvzgh6FRsvdYBeqH+MJP91VagfvQ1hybkfEO+POPGeNPAgSI4rq+QcTceN/HE
 YBSi7vdUv0h2dYM5A/7pqWDjbrDhFq63EcmJtxR07RpCJL120wf1WokNtNZCkOyQWLpLP/WfcFb
 jKL7HR7yw+UYO0AVRJ7AlL+UK+vtVRR/jf/RITcUmKcJeow2eCuxfws7Gpec9neXa5wTvDkssYK
 +HyrUzWs+RPMND6idZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090066

On Fri, 03 Jul 2026 18:58:35 +0200, Thorsten Blum wrote:
> GCC fails to build ps3_defconfig with the following errors:
> 
>   arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
>   arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 3 [-Werror=stringop-overread]
>      78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
>   arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 4 [-Werror=stringop-overread]
>      78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/ps3: Fix repository.c build failure
      https://git.kernel.org/powerpc/c/5ba79d37403d86082ab4083b0f51ec3008a942cb

cheers

