Return-Path: <linuxppc-dev+bounces-28647-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60A9CA5FB3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 11:59:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwVp62x57z30FB;
	Thu, 01 Oct 2026 21:59:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790855982;
	cv=none; b=faEX91gsm5SVWFnO/O1j/S+xwCTGBpsx4DNMpST9ub1uwywf+AkNoq1+l1pKi32EGgHyiP98rnUwvCzJcsXiaKmcBFpCMMZNOE80UHI29f/x4C8TAsvJyIJprMJ/H6LrMl/toFfIo/Y4QAd5RSasdbY+E9htHgrb9zq5qW/TeX4EBSexPTU8HKWpDGZYRmprhkjX1LeBplhPlPFaEasl8HAONsnK4YYmSaw0PbMHiSvnAIaK9UDEo+Jf9Sx5lxnaXo1Llcrp7EpBo+OqUsHOfNWKbHm3jzkzJoBJNCwQ+dAJoA1fuVa/qpf1oeqvRf++AaQMiYsIbEdUF570J+WO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790855982; c=relaxed/relaxed;
	bh=Zgb9yJHAX+S4Y74q0wZ5G5ouwF0U+pBVu1/qzzbWxRg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jBTjLZ9QufXNgB/rtWg5EgZGaCjO8MehMJZOCKvSDSspY4w7GJqJFEn4nkr4O0PAzaMPmoLl229PD0GZBzdUky6eCjDhxjNmDCNQX6hy/WfNv3kM2+9bbTdZbeOZrJE3izLFfJTXN6VP7RE9sTG5f81BxYm1ySuF4t1U46PUAda/4IfevPk5tYyvef+eR4x4vkXHtyNFOcNAYvr7FqUKtCLsY3qI/v+AbeSC/s4msieeUKYMs2zVP3/TN/RZLo+xqEbNKhMWc8hOUQod/OxILQoR5KXY3O0EGlACTiNkGbhDAVSZTAJ7xNQj7FH67yU4703Rb3eN9RVWidenU+f0JQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LmOHwI/o; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LmOHwI/o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwVp525Ftz2yYf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 21:59:40 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175tea908228;
	Thu, 1 Oct 2026 11:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zgb9yJ
	HAX+S4Y74q0wZ5G5ouwF0U+pBVu1/qzzbWxRg=; b=LmOHwI/olYj7iHlLcsH7kK
	B+XjuqlapzIIdhbC+7ldQJAMRYz8ZHcDPDGrVbixb9s1SfdRzXlwAvmsf3NijbWj
	W1ZMMOtEavoA/R3uKmvF89PFUhJFrIjnRl7DeJtC1sTatcfYfuLeAofCDu21sE7U
	wAQlNseW0OQC7DnTenia+2NH6GmFzunP8KJwMooMCZwlIill1hezLJmmofWmzq5R
	/nPAtkPKexsu/IH6lWBq5KldzhwS5aQ3l9y18kDXhEoBjmyeSQhojcrmPqL/vQAt
	qMCH5bSbC+UCPl1pnUlys77+WF+obxQTUDRLD1/f+Y6ClVIGaRTLv06/SFvYKXIQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkj4g2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:59:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 691BJQsG520704;
	Thu, 1 Oct 2026 11:59:29 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpgk3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:59:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691BxSKB21365358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 11:59:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C07B58050;
	Thu,  1 Oct 2026 11:59:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56C7A58045;
	Thu,  1 Oct 2026 11:59:27 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 11:59:27 +0000 (GMT)
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
Date: Thu, 01 Oct 2026 17:29:26 +0530
From: Jyoti Gupta <jyoti@linux.ibm.com>
To: amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, sourabhjain@linux.ibm.com, mkchauras@gmail.com
Subject: Re: [PATCH v2] powerpc/mpic: Fix memory leak of mpic on error paths
In-Reply-To: <20261001001512.d05b4c2a-13-amachhiw@linux.ibm.com>
References: <20260930180919.335930-1-jyoti@linux.ibm.com>
 <20261001001512.d05b4c2a-13-amachhiw@linux.ibm.com>
Message-ID: <98cf7d072c8986bfdc5a28f577876503@linux.ibm.com>
X-Sender: jyoti@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: fc42Sp9EAmVYaUreNoCysf7Y9HU5IKLf
X-Proofpoint-GUID: 5JJTbnyr9cRjXtluKZNtoSD-Vm6G31LL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0NiBTYWx0ZWRfX7C8UUerp7cv1
 bNfC73xJnL8pKDI2Mf/xji1jzziLg7EL50uqomHnCmTLYIUVLoR2PUZ7guQPOa6caj1EVWqxJ+s
 Err6xojloAgB4OoqNHSpppT+EHQ9lC8=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abe4b22 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=cXRdzbsfVzSL3sqxKCEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0NiBTYWx0ZWRfX+O5G5kDofjMF
 dIar3OiC5ysHXRpbb8Y9qaQPY9XaCFwpqtdemMmPwlM4Jr81iIvb2UalYUlUOPPENqQ7huMv5SN
 lp4JlvzoHzEvG7UlyhgojSDCE5BTcQrnjb3lBMD1hbliDDWUO/6mSQVP8/wxEqAIj34wsrK8imM
 JExLbQyeZ8IXe1u1T1gkNMf7V7JDFRoNqqBo4Fn4+0IYb8CpYI7wp3Aro7NMxCp5lEl8tK6S2xr
 xvb78GolcvBdmlM9A0XhIifFrKcvz6+BQJJYYxWMcsdmbckwYBvTFm+CgXlWaqs/CHgSrCx+KfZ
 WRTqlJ+JcCIdVsxQJI7tTuDOJ/iFX2kRAkHUL3EOLt3c2kS+ipWDXrMMR8AjSgpaR+9ZlUm8sz1
 HGONoFQsyrHcm4jbU0dcDNnm2IoIxBY9/ikcpkWm8Z1L+RDixHMg//T8A4I5Q9KSgKUD5zSrEbn
 ap9fC8gfYRJqsPiqxKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010046

On 2026-10-01 00:20, Amit Machhiwal wrote:
> On 2026/09/30 11:39 PM, Jyoti Gupta wrote:
>> mpic_alloc() allocates struct mpic (and optionally the protected
>> sources bitmap) but does not free them when mpic_setup_error_int() or
>> irq_domain_create_linear() fails, leaking the memory.
>> 
>> Free the bitmap and the mpic in the common error path before dropping 
>> the
>> device node reference.
>> 
>> Fixes: 996983b75ceb ("powerpc/mpic: Search for open-pic device-tree 
>> node if NULL")
>> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
>> ---
>>  arch/powerpc/sysdev/mpic.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> Thanks for addressing the comments from v1.
> 
> A couple of minor suggestions:
> 
> 1. Changelog & Links: It is always a good practice to include a 
> changelog below
>    the "---" line detailing the changes made in this version (e.g. "v1 
> -> v2:
>    ...") along with a link to the previous version(s) on 
> lore.kernel.org. This
>    helps reviewers and maintainers quickly track the evolution of the 
> patch.
> 

Got it, thank you for the suggestion. I'll keep it in mind.

> 2. Minor nit in cleanup logic below:
> 
>> 
>> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
>> index 257886ec3f70..b21a880777cc 100644
>> --- a/arch/powerpc/sysdev/mpic.c
>> +++ b/arch/powerpc/sysdev/mpic.c
>> @@ -1389,7 +1389,7 @@ struct mpic * __init mpic_alloc(struct 
>> device_node *node,
>>  		if (fsl_version >= 0x401) {
>>  			ret = mpic_setup_error_int(mpic, intvec_top - 13);
>>  			if (ret)
>> -				return NULL;
>> +				goto err_of_node_put;
>>  		}
>> 
>>  	}
>> @@ -1488,12 +1488,8 @@ struct mpic * __init mpic_alloc(struct 
>> device_node *node,
>>  						 intvec_top,
>>  						 &mpic_host_ops, mpic);
>> 
>> -	/*
>> -	 * FIXME: The code leaks the MPIC object and mappings here; this
>> -	 * is very unlikely to fail but it ought to be fixed anyways.
>> -	 */
>>  	if (mpic->irqhost == NULL)
>> -		return NULL;
>> +		goto err_of_node_put;
>> 
>>  	/* Display version */
>>  	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
>> @@ -1527,6 +1523,9 @@ struct mpic * __init mpic_alloc(struct 
>> device_node *node,
>>  	return mpic;
>> 
>>  err_of_node_put:
>> +	if (mpic)
>> +		bitmap_free(mpic->protected);
>> +	kfree(mpic);
> 
> Both bitmap_free() and kfree() safely handle NULL pointers (and mpic is
> guaranteed to be non-NULL at this label anyway), so the 'if (mpic)' 
> check is
> redundant.
> 

Thanks for the review.

Regarding the 'if (mpic)' check, I think we may need to keep it. While
bitmap_free() and kfree() both safely handle NULL, the concern here is
dereferencing mpic to obtain mpic->protected. There are two paths that
reach err_of_node_put before mpic is allocated (line 1276):
of_address_to_resource() failure at line 1258 and kzalloc_obj() 
returning
NULL at line 1278. In both cases, mpic->protected would dereference a
NULL/garbage pointer and crash.

Please let me know if I am missing something!

Thanks,
Jyoti


> Other than that, the patch looks good to me.  So, with this fixed, 
> please feel
> free to add:
> 
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> Thanks,
> Amit

