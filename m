Return-Path: <linuxppc-dev+bounces-28932-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62E4CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:19:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hz32K07Vtz2yTP;
	Tue, 06 Oct 2026 02:19:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791213544;
	cv=none; b=XaJPiFktOfbKnOlxUo8QU7QIcGr/GMxMeFH80CauqJ4PM7FFHvYbPeGlp4RrvOmFSXrP7cuyE0/qXjDAYU80b9GBtDnAHCrYs69UNQVXwAarIq0U1s4b3zYSL4eXBZhOaOi9IvbL7xgk8EgviupIvyUc//t0HHBck55EXMC8QFVYK3Ah8uwBrfEKhkp0DYzmjClAiLBW6IHq3ceoPjTkpexblFzvy0YBOUomauTGpYWQg+0ABuClNCVVaH+kLudGuhfRkd/hOZ/84LnGkx0PgUJshnuaBXinvpIOrhG6bKmIyxGrs2SHUAqShfKHpu0MfCkT+HuYloZi3zMvRSkOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791213544; c=relaxed/relaxed;
	bh=GucTNhcWP4CelgbX097vCWqukMBRqPjmSY0J8iLmz5E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=k9eBejO+2IV5eiWttqB0S/QUYuEOt5Am96ES1mcITqeerQBy4avmjl3jqvDn8duNc0yxN3FDDf8bSv7gyz1O8KIWADafxoVa0/skeWqhoHoiYxAiL6qpk0pKVRKtq2NZ7Iy65KFwW5BZW1Q0KT5mli0E2SZz5w3thLhTxk02NOIE2hwMEBvDIag8QCn7r5bzqFu23RRSseYPxnl4BKRRVApj9R5gBo4T/6x2FfDHUPPPVAQ8Vowk514NCbyehwVI5C9v55oTsC1Mq7JAcTA3ApWsAuTOQmmDgsQy9Ca8PGXbqFnvILhkT8WvEnnclrznhBUgwYQUHuD/VXirn6npJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qr5y2JjW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qr5y2JjW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hz32H6mmTz2yMD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 02:19:03 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EZhRQ3285780;
	Mon, 5 Oct 2026 15:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GucTNh
	cWP4CelgbX097vCWqukMBRqPjmSY0J8iLmz5E=; b=qr5y2JjW9+Pc/ulCmsW+ec
	MbtfpYcNpIsR5o/J6nksGip48H/NBE0cEu4jJHEnyKOnndZBX1Mgem4Q8bkU6PGY
	ULK6w05NFQn7eLCBjssHuHpuCQ1Uxrjkk2kqmtVLIhzPagAKwcN+yRMe8wve/7IW
	SWqLK5MXs9zmMRcgzw2zkjqgmmAamjCzRfwVCazi3kZ7Av7oT2waMgQjuWPvmucY
	F9J1Maar6Y/79SU3gcPoCXOsZxmAqCfpfaoUnHiuJUJQcxVS1PVdM5Jz0KqcOd5I
	MWN9tefl0YyGNyHlMSGDg80IxygOhPz5a1Q6odIfSEOu2rjiFXSNMslJTDhHyx3g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrb0cm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:18:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695ElQsR3042151;
	Mon, 5 Oct 2026 15:18:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvp3he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:18:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695FIqkV38470162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 15:18:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E91365805D;
	Mon,  5 Oct 2026 15:18:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68A9E58056;
	Mon,  5 Oct 2026 15:18:51 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 15:18:51 +0000 (GMT)
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
Date: Mon, 05 Oct 2026 20:48:51 +0530
From: Jyoti Gupta <jyoti@linux.ibm.com>
To: amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, sourabhjain@linux.ibm.com, mkchauras@gmail.com
Subject: Re: [PATCH v2] powerpc/mpic: Fix memory leak of mpic on error paths
In-Reply-To: <20261005130342.de3acc9a-b0-amachhiw@linux.ibm.com>
References: <20260930180919.335930-1-jyoti@linux.ibm.com>
 <20261001001512.d05b4c2a-13-amachhiw@linux.ibm.com>
 <98cf7d072c8986bfdc5a28f577876503@linux.ibm.com>
 <20261005130342.de3acc9a-b0-amachhiw@linux.ibm.com>
Message-ID: <d4c6a3c4179296ecd250a329484a9cfc@linux.ibm.com>
X-Sender: jyoti@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1OSBTYWx0ZWRfXztj8xSKoo34G
 InOPz6dbUzToD8jNpeoopSeTWaQWZiA7PrdwJoVRU2S8wvuQ7kRhbA5RY9QqkRWMo+zodH0gJIs
 Ia0JWZ2it1NEZrHuL40dQJF2GJ0KoQs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1OSBTYWx0ZWRfX/E/x7jDp2Kfl
 BaVw5giaA8SFUKpy2XvXtihVPX8A1cgdadEFK18+hZCGf76Z1pCHNo6uoXhLYMcylVWfmGqnNI9
 lXNv6hx4LKELFxWxoqT8zrCDsx/n5JAJ3/LOYIupqVcRMRwYaUppmz4Ilgp4CriCN/jPfE/NdZd
 VEDQtX686yzMh+T2ZWW5GGmwvgceKRCF2ZCbXbgal/j7shiVWWxv3rIdtNLvevfPTU6phSD+4yf
 JRr7+mvp1cv/huTpv6COU2MRytugvHKUUIXH1NwwXaZMhbW7oK3n8/hYlpnWRq5pcfqMe2zmMQI
 ByJ9QBTDz29bcVYN05Vv2z4KnCaJ+ZOVqrzE3CpScDGz4okdYtnA30H//t+330qHg+p+KIkj9/P
 BPb3G+wBEvHqhdFxF18jVnYYxQZLS9rNrrEQBketVJ97ROKei8KtwXIrEvTLTXGbnM8/9D2eVMK
 pOY7g3NwVDweKbN3+kw==
X-Proofpoint-GUID: bnFON99yF5xjnxMyHvvhie2q0jnN9CXp
X-Proofpoint-ORIG-GUID: 99ojyKilT1snwn15DLsQgt60e-cEXTYm
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac3bfde cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=PT8jA0TAdADDqga4A4IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050059

Hi Amit ,

Please refer to my inline comments below.

On 2026-10-05 13:14, Amit Machhiwal wrote:
> Hi Jyoti,
> 
> Please find my responses inline below.
> 
> On 2026/10/01 05:29 PM, Jyoti Gupta wrote:
>> On 2026-10-01 00:20, Amit Machhiwal wrote:
>> > On 2026/09/30 11:39 PM, Jyoti Gupta wrote:
>> > > mpic_alloc() allocates struct mpic (and optionally the protected
>> > > sources bitmap) but does not free them when mpic_setup_error_int() or
>> > > irq_domain_create_linear() fails, leaking the memory.
>> > >
>> > > Free the bitmap and the mpic in the common error path before
>> > > dropping the
>> > > device node reference.
>> > >
>> > > Fixes: 996983b75ceb ("powerpc/mpic: Search for open-pic device-tree
>> > > node if NULL")
>> > > Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
>> > > ---
>> > >  arch/powerpc/sysdev/mpic.c | 11 +++++------
>> > >  1 file changed, 5 insertions(+), 6 deletions(-)
>> >
>> > Thanks for addressing the comments from v1.
>> >
>> > A couple of minor suggestions:
>> >
>> > 1. Changelog & Links: It is always a good practice to include a
>> > changelog below
>> >    the "---" line detailing the changes made in this version (e.g. "v1
>> > -> v2:
>> >    ...") along with a link to the previous version(s) on
>> > lore.kernel.org. This
>> >    helps reviewers and maintainers quickly track the evolution of the
>> > patch.
>> >
>> 
>> Got it, thank you for the suggestion. I'll keep it in mind.
>> 
>> > 2. Minor nit in cleanup logic below:
>> >
>> > >
>> > > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
>> > > index 257886ec3f70..b21a880777cc 100644
>> > > --- a/arch/powerpc/sysdev/mpic.c
>> > > +++ b/arch/powerpc/sysdev/mpic.c
>> > > @@ -1389,7 +1389,7 @@ struct mpic * __init mpic_alloc(struct
>> > > device_node *node,
>> > >  		if (fsl_version >= 0x401) {
>> > >  			ret = mpic_setup_error_int(mpic, intvec_top - 13);
>> > >  			if (ret)
>> > > -				return NULL;
>> > > +				goto err_of_node_put;
>> > >  		}
>> > >
>> > >  	}
>> > > @@ -1488,12 +1488,8 @@ struct mpic * __init mpic_alloc(struct
>> > > device_node *node,
>> > >  						 intvec_top,
>> > >  						 &mpic_host_ops, mpic);
>> > >
>> > > -	/*
>> > > -	 * FIXME: The code leaks the MPIC object and mappings here; this
>> > > -	 * is very unlikely to fail but it ought to be fixed anyways.
>> > > -	 */
>> > >  	if (mpic->irqhost == NULL)
>> > > -		return NULL;
>> > > +		goto err_of_node_put;
>> > >
>> > >  	/* Display version */
>> > >  	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
>> > > @@ -1527,6 +1523,9 @@ struct mpic * __init mpic_alloc(struct
>> > > device_node *node,
>> > >  	return mpic;
>> > >
>> > >  err_of_node_put:
>> > > +	if (mpic)
>> > > +		bitmap_free(mpic->protected);
>> > > +	kfree(mpic);
>> >
>> > Both bitmap_free() and kfree() safely handle NULL pointers (and mpic is
>> > guaranteed to be non-NULL at this label anyway), so the 'if (mpic)'
>> > check is
>> > redundant.
>> >
>> 
>> Thanks for the review.
>> 
>> Regarding the 'if (mpic)' check, I think we may need to keep it. While
>> bitmap_free() and kfree() both safely handle NULL, the concern here is
>> dereferencing mpic to obtain mpic->protected. There are two paths that
>> reach err_of_node_put before mpic is allocated (line 1276):
>> of_address_to_resource() failure at line 1258 and kzalloc_obj() 
>> returning
>> NULL at line 1278. In both cases, mpic->protected would dereference a
>> NULL/garbage pointer and crash.
> 
> Good catch on the early error paths before mpic allocation!
> 
> However, in v2, 'struct mpic *mpic' is left uninitialized at function 
> entry
> (since the '= NULL' initialization was dropped).
> 
> Looking more closely, if of_address_to_resource() fails at line 1258, 
> control
> jumps to err_of_node_put where 'mpic' contains uninitialized stack 
> garbage.  In
> that case, 'if (mpic)' evaluates to true, leading to an invalid pointer
> dereference when evaluating mpic->protected and a crash on kfree(mpic).
> 
> Rather than initializing mpic to NULL and checking 'if (mpic)' on error 
> paths,
> the preferred approach in Linux is to use layered error labels.  In 
> fact,
> Documentation/process/coding-style.rst (Section 7, "Centralized exiting 
> of
> functions") specifically describes this pattern when discussing "one 
> err bugs":
> 
> 
>   A common type of bug to be aware of is ``one err bugs`` which look 
> like this:
> 
>   .. code-block:: c
> 
>   	err:
>   		kfree(foo->bar);
>   		kfree(foo);
>   		return ret;
> 
>   The bug in this code is that on some exit paths ``foo`` is NULL.  
> Normally the
>   fix for this is to split it up into two error labels 
> ``err_free_bar:`` and
>   ``err_free_foo:``:
> 
>   .. code-block:: c
> 
>   	err_free_bar:
>   		kfree(foo->bar);
>   	err_free_foo:
>   		kfree(foo);
>   		return ret;
> 
> Applying that pattern here gives:
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 257886ec3f70..d799cf4da7bd 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1389,7 +1389,7 @@ struct mpic * __init mpic_alloc(struct 
> device_node *node,
>                 if (fsl_version >= 0x401) {
>                         ret = mpic_setup_error_int(mpic, intvec_top - 
> 13);
>                         if (ret)
> -                               return NULL;
> +                               goto err_free_mpic;
>                 }
> 
>         }
> @@ -1488,12 +1488,8 @@ struct mpic * __init mpic_alloc(struct 
> device_node *node,
>                                                  intvec_top,
>                                                  &mpic_host_ops, mpic);
> 
> -       /*
> -        * FIXME: The code leaks the MPIC object and mappings here; 
> this
> -        * is very unlikely to fail but it ought to be fixed anyways.
> -        */
>         if (mpic->irqhost == NULL)
> -               return NULL;
> +               goto err_free_mpic;
> 
>         /* Display version */
>         switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
> @@ -1526,6 +1522,9 @@ struct mpic * __init mpic_alloc(struct 
> device_node *node,
> 
>         return mpic;
> 
> +err_free_mpic:
> +       bitmap_free(mpic->protected);
> +       kfree(mpic);
>  err_of_node_put:
>         of_node_put(node);
>         return NULL;
> 
> This ensures:
> 
> 1. Early error paths (of_address_to_resource and kzalloc_obj failures) 
> jump
>    directly to err_of_node_put without touching mpic.
> 2. Later error paths jump to err_free_mpic where mpic is guaranteed to 
> be valid.
> 3. No 'if (mpic)' check or 'struct mpic *mpic = NULL;' is needed.
> 

Thank you for the detailed explanation.

> What do you think?
> 

Yes, this sounds more accurate — the layered error labels are clearly 
the right approach here. Will fix it in v3.


Thanks,
Jyoti

