Return-Path: <linuxppc-dev+bounces-25049-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B46C54FCD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 02:36:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9YHb3TjYz2xwH;
	Thu, 30 Jul 2026 12:36:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785379003;
	cv=none; b=D10prnYaWVY2EsHZ3rcHu8qabZdDTjiaI4s3cCPah2rUErjUi/qkErbGF6MlB87FKQMb8e1WbaIT+awFdbKqlpsneUAQQOzy+/M1/0OVNHan9dU0waxr4mzQqizMeVh/RPxP7QN/WvceOj7Vblvnynr7zBFZ8Ofz1oRce0NDFflD1I3PkWiKsazZpAF/eqDZ56kjreIVW1fiiW0QWhti5X9Mm3cuQTUVSITMbapp23EBv/czEwLCvaCTPD+xclfg+zsa7by9uQeyCq9xCNXMx9EuI4JYx8Gs+3oQCeVFVw8OsNQeZBAdGiTki7daY7JWIUJo7gFL+Z1UTqffF4xYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785379003; c=relaxed/relaxed;
	bh=JWmBmjCVDwZRVgRCNJvQM8+svXnp9KhE6SAWLtH/3TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATQEB+DKgxTayQ+Ei5MIPx4tG9u/vGpoc6yNmOcP0VovpTtR1dt298m0dIIiGIJ3uAiUIWUuvL5iQ11en9N6jfLVvfMPdVIKr8DwQwueaF7r9+6HsukG9CEvw9xYFOJvV/rBRvM5jMgQcpG4ITqe6cv6NjwSYqTQP/pujO0rKp2AubkAda5sMQJm9M/Au9s2V4CWmttALJ42ZSwi7IobyREDzUqKvMmAzVMkyi2OkeT5SGcXxWygsucLJD5kjTTnIVTGiN6NeD38bl2CKMaVx1piv0byMRuOw5NsQsmiAMp9CXm2u1sL++bNAWksLZq5m+ITCXu4zPa+vsf+57eOaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ScVuJ1Na; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ScVuJ1Na;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9YHZ1RzSz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 12:36:41 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U0lgIu1572893;
	Thu, 30 Jul 2026 02:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JWmBmj
	CVDwZRVgRCNJvQM8+svXnp9KhE6SAWLtH/3TE=; b=ScVuJ1NayI3lRygF+o6LEG
	TmvAoG0OT48oqr33uRetOXtafCqwT8zBHtNYHcfJAMMvVrAWZF22KEj3S5Zb0fQ0
	5cLNfus0Q++AmSCIq7xHuPxgP2179ZiOTus6muDOjCGvrgfxP07yPYcmc3tMzqp9
	N+/EkG6H4yj5tOkQUnqQMyOet/6PL5mREhBNi+0DyYo+pxv5WDbemPtrTFD6uZOs
	U5iC2qSRfXGhcrOgEhegvC00M48Q5k0lmLlDTV+gBqoZnVUdEp8EEC8LAdgZj8KE
	VTe8h/kdQ/V/kPsRtwhVcBMvb44GsMHvKklDbyejj/IsuFewqOvjv/5rZ7VXbovg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xwpbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 02:36:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U2QH3l017828;
	Thu, 30 Jul 2026 02:36:15 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk9e11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 02:36:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U2aD7u22151794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 02:36:14 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B04E258059;
	Thu, 30 Jul 2026 02:36:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2514358043;
	Thu, 30 Jul 2026 02:36:08 +0000 (GMT)
Received: from [9.43.84.46] (unknown [9.43.84.46])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 02:36:07 +0000 (GMT)
Message-ID: <4ae1d899-9948-4904-ac3f-9096722fec8b@linux.ibm.com>
Date: Thu, 30 Jul 2026 08:06:05 +0530
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
Subject: Re: [PATCH 1/2] powerpc64/bpf: Fix build break in
 bpf_jit_emit_func_call_rel()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, hbathini@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com
References: <cover.1785339155.git.skb99@linux.ibm.com>
 <aafc721911eefc4ee376e27a0f4cebb82e3ee336.1785339155.git.skb99@linux.ibm.com>
 <8e3aa8f3-c264-4568-a973-0595914f89df@kernel.org>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <8e3aa8f3-c264-4568-a973-0595914f89df@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: RMQB6wyc4ftPbs__6eTBf88MgEEngaiM
X-Proofpoint-ORIG-GUID: dR6o8elzLtdLXeAAayH8PQTskXNHloRe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAxMyBTYWx0ZWRfX2V+CTuSM/kUQ
 nu5kRf0buTv9k5mSCx1vdJQQhuGkgL0acZAnVmOF/ksgi0Hmb0m6BStpxxFCZ4FRKzb0OAHWYk/
 B2Grlzq1AZ2GcoRvVGlSeaSE1Vjit8o=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6ab8a0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=C62OpMNfUQH9adNov7cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAxMyBTYWx0ZWRfX1xXu4sh6ECLs
 zZlLmDP4JBwjnL+fVrLtOsvSTAe8ejelU+WY2D7iU+5R83JXCEekBUXHmpt6vGh9CmXmkUf1ci4
 bckvQUgaDL6oWIqR2FsotGKUe33PVJstDq0sshZcJ5PpYURjk3tlyOTVMX906GIan94irJwd/c2
 /Gwp3zqE0yxgkPwpCkOJjaQs6r4uQ/vD9MGJyMX91I1qLaDgiQSMB2hnkJB4DE9MVBWEiihUSZz
 ZZnMytpPglvTWOYjD39FHMbc5cEYNDc9MKBR37lV3iyRAhcAKcsfn8Qb3Y4ITnhz0YDjBFyHoUX
 bmntOnbPYm4Hx51AGQSiHCejLwVCLjVhU8krTxAh+o9mZwcSRr7w9wPO8V7nm6oZfiW6EAQL6Zv
 cK7f+oPh9vJqccrUVNcXw9gHIzsdzcQ/kYpU3a/Ij/Ry0O1zJK+PAcM//JlkdEnolkbJrxXkdaL
 y5uozkF6TRkY1lLfdvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_09,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300013


On 7/29/26 10:15 PM, Christophe Leroy (CS GROUP) wrote:
>
>
> Le 29/07/2026 à 18:03, Saket Kumar Bhaskar a écrit :
>> From: Madhavan Srinivasan <maddy@linux.ibm.com>
>>
>> With CONFIG_PPC_KERNEL_PCREL enabled, build breaks with below error:
>>
>>    CC      mm/dmapool.o
>>    CC      fs/readdir.o
>> arch/powerpc/net/bpf_jit_comp64.c: In function 
>> 'bpf_jit_emit_func_call_rel':
>> arch/powerpc/net/bpf_jit_comp64.c:475:13: error: unused variable 
>> 'ret' [-Werror=unused-variable]
>>    475 |         int ret;
>>        |             ^~~
>>
>> commit b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for 
>> timed may_goto")
>> introduced "ret" variable to bpf_jit_emit_func_call_rel() and it is 
>> used only in
>> else block of CONFIG_PPC_KERNEL_PCREL, fix by adding a "__maybe_unused"
>
> __maybe_unused doesn't fix the problem, it just hides it under the 
> carpet.
>
My bad, took the precedence from reladdr, may be it is better to change 
that too then

Maddy
> ret is used at only one place, move it's declaration their:
>
> #else
>     if (core_kernel_text(func_addr)) {
>         int ret = bpf_jit_emit_func_call(image, ctx, func_addr, _R12);
>         if (ret)
>             return ret;
>     } else {
>
>>
>> Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for 
>> timed may_goto")
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
>> ---
>>   arch/powerpc/net/bpf_jit_comp64.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/net/bpf_jit_comp64.c 
>> b/arch/powerpc/net/bpf_jit_comp64.c
>> index dab106cae22b..63952ef19256 100644
>> --- a/arch/powerpc/net/bpf_jit_comp64.c
>> +++ b/arch/powerpc/net/bpf_jit_comp64.c
>> @@ -472,7 +472,7 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 
>> *fimage, struct codegen_context *
>>   {
>>       unsigned long func_addr = func ? ppc_function_entry((void 
>> *)func) : 0;
>>       long __maybe_unused reladdr;
>> -    int ret;
>> +    int __maybe_unused ret;
>>         /* bpf to bpf call, func is not known in the initial pass. 
>> Emit 5 nops as a placeholder */
>>       if (!func) {
>

