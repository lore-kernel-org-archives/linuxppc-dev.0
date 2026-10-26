Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E04606A31F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 04:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iHgLqTPO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCgYt2TpKz2yDs;
	Mon, 26 Oct 2026 15:26:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792988802;
	cv=none; b=N3wZEbwfVLAG44iOlQEjTT7GPvPc/0crIgS09OUL8Ece+mVzY0YDGs9SgEMgoqENHYTTT1MRluw+XBJdqUZ+Lw2aiESGcI6CtJvPPxvRyZwYTDJ75vwf0NgMsBzjKMy8wQSREYyO1aoa5hAjxa8TYZHh9CcUX8rRDc30mD4XCNCkEMv/bVrP8kGWzB6ZCpUGrVmAAxoL3TyfN4E2CFsfVXnKVRY4my/lYlTCznq2awGcay+EbPP/dHAVJO/l9CkGRDFzzD71TDbloJX+tDpxyC0PYG283T9k3X8Gjju+6Lb5Tlguee8YDGcGlq/cNLdgG1PWfIRO/aQFhzhD4lp7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792988802; c=relaxed/relaxed;
	bh=4jxPmGPQHAD1Q6IoVK7PNqr4uQjZpTbBraFDOuc+3pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzFkL32uh+cG92u7DRvqFeayRRlkyRJHQVwJ7m2HkFT4xY/8UvtZjQq09rr5QLlW7PASxAR7d9eF0XWfi6g4KqRHpjPNE09WyAgdJbGKygZQ1+5ymiARO3owhXLADR84m2+Y/nPCn9x7AtYYLEHZMzOb205PDiIhSDvbmx3/SwIiuTcuKXCDUvlDzHJWvXfrw8ZjFWvcodx9SgE9KEtMokMkyEFpNZy1JqaDIZiGVzDcQUXfdH8nOvTi5kAdGccrTY2womAIlarlEwESLIzn3DcE+gCQmBB4lNamBIg9L6CKjH+PfVrG+oxo2kXu1ra/v/wtn9pF1ntF64Ns4uk62Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iHgLqTPO; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iHgLqTPO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCgYs2sVKz2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 15:26:40 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2i6tc833002;
	Mon, 26 Oct 2026 04:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4jxPmG
	PQHAD1Q6IoVK7PNqr4uQjZpTbBraFDOuc+3pw=; b=iHgLqTPOCd3bZXsGq1XtYA
	NNdOAo7i8o3y0RreBq1t6HGg2FknhiBmwE1Su/bo4F4uuv+GcZQW+YFBbjzyOKVW
	tTz16ZYDzSzspLeP4E80IUYL4xnPsXxKuxssZIJQTgACP7oiXPvbbL5o0KbXbFXk
	raT1MHrMi8TEsV7qr25imOWrYsPRtjGHIQLAnKNi3zCTheX8ekT+GnXvkajywfB5
	oi21oWBXfiDnikdeGNOIBaUVP6GrUnP8A8kse9ZDImVXAP+oyN2mm5FEO1vAaXQc
	NPciyGc6ab03hIenwgvuGAmbNfbrZ84q04IITamxvYgdDJCxE74zsHGh5iYG8QBQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3fquuy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 04:26:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2KXtH1924565;
	Mon, 26 Oct 2026 04:26:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8ggv41a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 04:26:15 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69Q4QEFx31916602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 04:26:14 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 953145805D;
	Mon, 26 Oct 2026 04:26:14 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3548B5805E;
	Mon, 26 Oct 2026 04:26:11 +0000 (GMT)
Received: from [9.123.8.83] (unknown [9.123.8.83])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 04:26:10 +0000 (GMT)
Message-ID: <e3e7f96b-e23d-452a-a3fc-774d5b2e0ee7@linux.ibm.com>
Date: Mon, 26 Oct 2026 09:56:09 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/irq: Fix build with CONFIG_PROC_FS=n
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <2331292e-1a40-44ef-8776-9155e8e41f03@linux.ibm.com>
 <20261023211503.3764302-1-sashal@kernel.org>
 <CAHk-=wh7ZfsDA8Jh0+GSpLehCzfnyME_ztcpwebnvBMDnqjM6A@mail.gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <CAHk-=wh7ZfsDA8Jh0+GSpLehCzfnyME_ztcpwebnvBMDnqjM6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6aded668 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=0dio3GCuqh6ixl9tjnMA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
X-Proofpoint-ORIG-GUID: dMDfnuazhFj9l5PKGRHGNVCjDJs9AwUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAxNiBTYWx0ZWRfXy2Syv13vaJ6Z
 X14s4k6llu6UtAzLbLtCHSzn02kKldluIHU34Ryj4ZHC730gFQeJZwxCtL01cweCZe5bcSE3msl
 Nr+zSlRafGzACdhqDEvr3k5+uWsq5EIy2ebhTlIHNuVvcUmgNDUT0P59WrIJVEvF9U59sLClmbn
 cbZ4RtvQEz0XOFDDTCq7K0DLdIkJfLFGxnyjKiK3ocYVGeDFktnEuZF4CqnNUhaW5dStZS1AGf8
 HB2pMYuOABf78maIhqleF3ACkwhzWmg0iH7Mg0aoQNkCEgs2qfTFLziRFrpBV/Y00lk3bqLz/Wk
 apEzV9ThOZzeet3RROELabTRXZzqj2u7+eCFAaCzIntm29xMryfBcaNVFX06oo2gQtmR8jsiIJ0
 VCKmtqDUo0foLI5FqoJjUo6cGleT8DbifMfIxdTGHIeZ2pVX1uLtApOqVKPG0bYxNV5ZL1L4E0U
 KKBV0PrzgeHL9aXlCEw==
X-Proofpoint-GUID: WDkwEtVaTqWoioWUeySWVZghQzkWNy2H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAxNiBTYWx0ZWRfX9Olh8xrgo+vE
 GmwTlzIM+3BmXkqHRxAeJk21EBL1izrdQm+9VuqygmkqDDL2+6GdgX0GD6aTA0fnIIm9qdd1C1m
 A2DYi+e31fa/Cbz+qZw1eBWsU3Zoc+4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1011 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260016
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/24/26 5:20 AM, Linus Torvalds wrote:
> On Fri, 23 Oct 2026 at 11:15, Sasha Levin <sashal@kernel.org> wrote:
>> arch_show_interrupts() is only called from irq_seq_show(), which is in
>> kernel/irq/proc.c as well, so build it only with CONFIG_PROC_FS, as x86
>> already does.
> Thanks, applied.
>
>                      Linus

Sorry missed this. My bad.
Thanks Linus.

Maddy

