Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13D606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FGoov2HK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPhrG4xScz2yDD;
	Wed, 11 Nov 2026 22:58:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794398334;
	cv=none; b=kCx/9anThb6mGvvhskyyCxNGimERpUHiwa71xCN5HfpPVCKaV0tSbLH+MCA02pUAqsolyZNNiBjKsQ8MN3kBtlyJr1bpyBApkVBbfY4YtIgQxwfuh8/5Zk0pMEYiWHLv75bEzgnsOSoM/AIbzxnq3tKYxQoFM32eCn+QqjbruUlonzzN+O7VAumtz4gMY5cuXHeJpmMHTxliG5Wh0LMDF25YZc4+0TULwqwAYjo7J6qes2Htloz3ugwZehIxadzFDJIYJHNg7x4YiJsYtDEcmxMbfaDZrkQOkvmT+Vl896e3ZYaBA70z3RSGviBlj8dyo0GVN3T3CxctEuMex4dMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794398334; c=relaxed/relaxed;
	bh=jxktCGBv+V3up5CY+FTdp8kWijHXM0fZDe1PzaZ3SIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIufBEC9ceNQQceMMM/JzbH/gSJNMhxZfJ2pBUfQazJjdMLPpOPXz4/MZc6RFUNZuXTOanKOUB/+wZo5PMwK5t7/286RB4kJDknpW9i2JM/6DirFZn3o/LNPE3PdGO1LyAmAgcPagSnAs6spl267pHfwW7kgpSX5Z87RAfUTaPRTUzK3o0QfmTO/tQ7y1752eqmgHAsaAUCb/mkNoQiP7Lu/rRqR4DdO2AYWgzfukCxpymetcuoaVaeRoyHidGIie2jsmp0XQTQI9IwkQMna0VhYHACIQe5LMJ61LxwqslkPi9OGsZ0PFLx3gfHg26LP9uSAg5W1Vr49QENzglGVKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FGoov2HK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FGoov2HK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPhrF4Zk7z2y2h
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 22:58:53 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5i8BO285027;
	Wed, 11 Nov 2026 11:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jxktCG
	Bv+V3up5CY+FTdp8kWijHXM0fZDe1PzaZ3SIc=; b=FGoov2HKeChADTZqnp4Ceh
	HIgIfh09/t3IQrUqRusNnd3SX3weONdLfm1gB9RxADvCe2lJR29+IaPUCMbFfR6E
	LFqVERIlVY3IilSHwmIQsatP8MUkYjKRTHaKvb9ozYM2osT3OHjKaVLG4nEMeqB+
	Drk8INoi64uc6AoX4+KCfjl2cAOVvu6F6hC8P4keSjAYfTxIQ7sGB7NYNpKRwiKv
	b6fxOL2q2EfqbjuKxto1u2MNjjdVFta6D/afYj2XlvySpLDhURVKUNZNtMF3ARoX
	Tcq+aol3+oSsflEjniWKvkRa8VdHu008TuajyZf2q5EwIoEoBqRmL814DXaeFXFQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq71ywt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 11:58:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABAP3Ox2859525;
	Wed, 11 Nov 2026 11:58:34 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309ma9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 11:58:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABBwXN326280498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 11:58:33 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9570B58059;
	Wed, 11 Nov 2026 11:58:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58F4D58055;
	Wed, 11 Nov 2026 11:58:30 +0000 (GMT)
Received: from [9.43.120.194] (unknown [9.43.120.194])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 11:58:30 +0000 (GMT)
Message-ID: <371108c3-0314-4015-9ca4-d96a11f1e597@linux.ibm.com>
Date: Wed, 11 Nov 2026 17:28:28 +0530
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
Subject: Re: [PATCH] powerpc32/modules: Reserve a PLT entry for
 ftrace_regs_caller
To: Bradley Morgan <bradley.morgan@linux.dev>, ritesh.list@gmail.com
Cc: brads@mainlining.org, chleroy@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com,
        sshegde@linux.ibm.com
References: <80D9FEB3-9FB3-4878-BC66-74C13761CC9A@linux.dev>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <80D9FEB3-9FB3-4878-BC66-74C13761CC9A@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0NiBTYWx0ZWRfX3qV1DL2OHVag
 Zqlb9DqDPD0lGP/BWR/tRUCm1seYIO+NPpoII8OF5335q/E6h3wUlm80jRDw68/v5R6cde18T67
 ZsJtEI4R8nyRAXnVIySWxAoBNSgt0Yw=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af4586b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=OuZLqq7tAAAA:8 a=VwQbUJbxAAAA:8 a=FkolyUzucbp6SESKabkA:9 a=QEXdDO2ut3YA:10
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: 6jB0qBBVKKLf_LWT1BYIJF81JuJJB3kG
X-Proofpoint-GUID: ecDCVwa_RUsimFmT9_CUwxKBP-_SYvyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0NiBTYWx0ZWRfXxt2F+2/kQ+tU
 1VJJg2l/Orp7U/RosHTb45Y5vmws0yiv/AdkCvVvMQua0exK+OUI/Yf7RbL+PbPmEuLKuvzduuU
 ujZ1NqxQZjsx4JDnWTUvHPkU2dMvYTxDc23MY8Xqyto1E9m13dnyAvGDIMzTLqQ8q6vYqGGh1Kd
 r7qEnWJ5sODIa00PzVaKBuqKEv3YS+bQX7/dj1IvydYqcMop+6gI7ZWXIcXt5XHUqJ5kBQEhpvE
 btNhvzhkHLgCTrXqK8MjNL5LAaAzPISRDr+tfys6Jhu3nsGKZ0QtKdJaZmsDy6Ft5Ye8myX7qFV
 FcwCWvgcccqescpi+fSW7dsU6r33FJKXznmWeOr6sFK2tZI283aRyySvu89z9H3wyBO4UnfcCJc
 sXIPLRzMsVl0zWzBg1M0AgvaKKWZZGaHcRrHyee+hLFcFzVI4xfoyNEzS71ce0/QeMvr72qnn14
 /fL7jkKV2fw2aAXhsmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110046
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/11/26 12:58 PM, Bradley Morgan wrote:
> On 11 November 2026 03:48:41 GMT, Ritesh Harjani <ritesh.list@gmail.com>
> wrote:
>> Bradley Morgan <brads@mainlining.org> writes:
>>
>>> Commit 7dfbfb87c243 ("powerpc/ftrace: Activate
>>> HAVE_DYNAMIC_FTRACE_WITH_REGS on PPC32") made count_relocs()
>>> undercount the PLT entries the loader
>>> consumes: module_finalize_ftrace() now creates two trampolines
>>> (mod->arch.tramp for ftrace_caller() and mod->arch.tramp_regs for
>>> ftrace_regs_caller()), while count_relocs() reserves only one entry
>>> for ftrace.
>>>
>>> So the core .plt ends up one ppc_plt_entry (16 bytes) short. The
>>> walk in do_plt_call() scans for a free slot with
>>> "while (entry->jump[0])" and has no bound check, so once the last
>>> reserved slot is used up, the walk steps past the end of the section
>>> and patch_instruction() writes the 4-instruction trampoline into
>>> whatever module memory follows the .plt.
>>>
>>> Count the second entry, mirroring what module_64.c does for the same
>>> pair of stubs.
>>>
>>> Signed-off-by: Bradley Morgan <brads@mainlining.org>
>>> ---
>>>   arch/powerpc/kernel/module_32.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>> Do we also need fixes and stable tag here?
>>
>> Fixes: 7dfbfb87c243 ("powerpc/ftrace: Activate HAVE_DYNAMIC_FTRACE_WITH_REGS on PPC32")
>> Cc: stable@vger.kernel.org
> Hmm.. could the merger add that? If anyone merges.. :(
planned to be part of my fixes PR and will add it.
Thanks for the fix.

Maddy
>>
>> -ritesh
>>
> --- Thanks!

