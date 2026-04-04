Return-Path: <linuxppc-dev+bounces-19303-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDCBE88D79
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 03:22:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fngr329B9z2yL8;
	Sat, 04 Apr 2026 14:22:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775272931;
	cv=none; b=evYUhoj3W1wFkigdNSyRPVOUy/PPkSZZnyY9X58w58WbNTumsiTu8OytofRFkL+MhBDpUKG5oXR2HYe4Klytwd0DgKIaI5fE13v3UBiybtXEMF86y4SPkddLJ+IXLoneXx4LCc63eiLPOQOnbNUi9YB2n1qiroXGCRCnEa2Uv4ejcFtFZXSuE0XP/F/uJGaA1uLPwLjhVNjTF3KD20VsVjJAPPAt7eyx1+zaW5DxtDPIxtsKn1g8pS5cWqXhrCYl9LHSF/o+IYp40XQN4kiUFHEXNr4ejhoc1qLappbuk6NOkc7AWmH2cB0Y5312zrfWZmA5fDTdJ6Uh76FvblH2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775272931; c=relaxed/relaxed;
	bh=yfQoA6KbryDg4fIMgiq1/OMsv57x+4IJDIVcB77NifA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPAx1m2mSW6h+YhKpNfR0fZZ2xtf4WJCEbrZAEWxLBlbUKrxTqbNisuL5hTG1ERYBUbYiTsuI6PtXDrvwkhgtT2774eD/RXbiF9beMgZ0Hivr8x6Yc4kaVVMNr7Cj+QyQWEsHvnxpws3w7yNGwZ63hsX99/sbnXcMI5pwfVFRSLxYApsF7c2miaBtxSgXzYPSIrWxPPfPYjPVCGxZZzk2itl2hBxjqnmoofRMabAjJSQFbv+30pG67Ya8X8sIzDsnPbx7Nz653yyzY75gBYT+aDzBy5BBdl3bad7jHoyGFqxymYCXfdp7cm7zXxkVsCTK9fz5vLD2zJljg1Djhzhcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TSHOZf84; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TSHOZf84;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fngr24B49z2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 14:22:10 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63431WSS3067657;
	Sat, 4 Apr 2026 03:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yfQoA6
	KbryDg4fIMgiq1/OMsv57x+4IJDIVcB77NifA=; b=TSHOZf84tl9+U324fsMVVp
	Rc7urZBsIhN/0653phycwrexZBP+bTGUxG4taGSg3s/NK3F3YBoz0xWQFQxrV5nI
	PFn0JEUPs5UcktlJWJNMYO4pejPvknDnwzL7/wCSjHmwZjfvNPRYcfeK3ji53GVD
	3/Mul8h+DFhUZBG8O3iR8RjP6Rp9Dlh9fUVk/6wSCftj/TvC3XAoO2f1lt6rXDbR
	MdErihVZjltlqy5di3HphXpldXl+GAZieQJS6iNddbG9mpVQDUCjtqCzgdhAIkDR
	bjE6EwiEfPIeLvYQ92fwUzdKMjHuWXmUwEyIi8kog8QXP6pHcNamgzVAJD3o4JkQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2g1a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 03:22:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6340eNBa005973;
	Sat, 4 Apr 2026 03:22:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spygdhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 03:22:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6343Lube53805386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 03:21:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E1C620043;
	Sat,  4 Apr 2026 03:21:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC87420040;
	Sat,  4 Apr 2026 03:21:52 +0000 (GMT)
Received: from [9.39.18.186] (unknown [9.39.18.186])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 03:21:52 +0000 (GMT)
Message-ID: <9551d2b5-1821-4aaf-a5d2-2be56f98f45c@linux.ibm.com>
Date: Sat, 4 Apr 2026 08:51:51 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] powerpc/vmx: avoid KASAN instrumentation in
 enter_vmx_ops() for kexec
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <20260403190123.1383198-1-sourabhjain@linux.ibm.com>
 <20260403190123.1383198-2-sourabhjain@linux.ibm.com>
 <cy0fmtdb.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <cy0fmtdb.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDAyNiBTYWx0ZWRfX/W5/QUfZuU0a
 A35G5+VYnQJc1UshTekKN8lk8AJRFn04946+oNXp174/elNY19pVWmFoZETAg5izqTQG5H67x1S
 Z7olVdFqYhxOTgIGuoqQcCB0IXjznJQLhXGQn/AiNe8HM+RGpx7hVpJTefIcXPkKmrOfQqysQqZ
 EK3epSIcZ76IffTyIyxWOZmATxwOXt2QGbJiLFaZA5ZtUg0QMGjNGw9BqSO+d8wrlM5EnCmk/oA
 6R3B6cRMrtDzriBzTfnlAWf4195Jl1Tis8eg6PrzzBeovtbgyuQ7QoLrcfIa7q4KmgRPT73JvWY
 mVjGGzvLRcqa4B524nv7q3eBvmLYtLHUGObCVQRPOlwoD+KoC0H7Lo7FTp1TT7SNQA8AxDs6Bgm
 dj3Piza4WmtdHpzFXne30J0i3C5yWdejb2b/qtcJcut+v7s1gMDujeZtry+8+lKIMQdlneYorKS
 2Kl88k48wvuL/UdE+5w==
X-Proofpoint-GUID: -EhTmvLWDnG5IF-IWVFiMyQoTvUfWvDu
X-Proofpoint-ORIG-GUID: azhPCGsONs67eW3VwqD9nGQD_EMYrCWS
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d083d9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=ZSKijxZ-s5Cc9RuwcvIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040026



On 04/04/26 06:31, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> The kexec sequence invokes enter_vmx_ops() via copy_page() with the MMU
>> disabled. In this context, code must not rely on normal virtual address
>> translations or trigger page faults.
>>
>> With KASAN enabled, functions get instrumented and may access shadow
>> memory using regular address translation. When executed with the MMU
>> off, this can lead to page faults (bad_page_fault) from which the
>> kernel cannot recover in the kexec path, resulting in a hang.
>>
>> The kexec path sets preempt_count to HARDIRQ_OFFSET before entering
>> the MMU-off copy sequence.
>>
>> current_thread_info()->preempt_count = HARDIRQ_OFFSET
>>    kexec_sequence(..., copy_with_mmu_off = 1)
>>      -> kexec_copy_flush(image)
>>           copy_segments()
>>             -> copy_page(dest, addr)
>> 	         bl enter_vmx_ops()
>>                     if (in_interrupt())
>>                       return 0
>> 	         beq .Lnonvmx_copy
>>
>> Since kexec sets preempt_count to HARDIRQ_OFFSET, in_interrupt()
>> evaluates to true and enter_vmx_ops() returns early.
>>
>> As in_interrupt() (and preempt_count()) are always inlined, mark
>> enter_vmx_ops() with __no_sanitize_address to avoid KASAN
>> instrumentation and shadow memory access with MMU disabled, helping
>> kexec boot fine with KASAN enabled.
>>
> Nice! LGTM. Please feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks, Ritesh!

Will add your Reviewed-by tag in the next version.

- Sourabh Jain


