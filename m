Return-Path: <linuxppc-dev+bounces-21937-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A96CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 03:53:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVYgv3DJPz2yRF;
	Wed, 03 Jun 2026 13:52:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780458779;
	cv=none; b=GoiKQ/XF1dSLCdFF0/8Dm8dLk2NZVNLLXGbEbbFdwDqTx68+4qyoXSRYgk9Kcg3y/1Df/MTIzjuT7bl42itJkematF+0ZIhsgE8Ecu88fdoHBvsIiff7tNzA3wFNaKsu1noc2qjvV2Yjaxex7TDcn4/b5G+7NNTk2ZXmsdP3MsWNc0RcaVpPBvVmI8GHuYMwcB0GTRvTpXxm6jHB7sdnwvwTaM/7oJflEfBHLBaWjophzrGgSojCX6yrMC8WxNjiAkwbB+5N60OdVJwi4lUN0xmVF30R8KRaTrc1mDnuqTNxLYl0Sxw5w3CQSSmz4hra4UGRSzp5n7DCJK2QpXJnGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780458779; c=relaxed/relaxed;
	bh=LB2d9i+3AgNt8gkonuNjph6Oh0dxdVE3FFHqiJs9LBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNDYkDWVxxUEy68ZC3wKlsVSsMDv29VP8LFqOcFlEtiCzRqGVO3uh/+dDPYWKNRj/c3VFVe8mgUpO4hfjS4qqsLHx3tmehm2WU6JJZDPr99Uakr37PjNvINk+O+xdKWAOf0rMbKPojxOqHROTAWxUXh/pR0AP3EddAHEXckm1VXGKPZitES4TIPuuB9ptfIoAJ0cTOfd4P0Uker9wMHKak03n04CrMYOh7lUEbHNJnXianQzmVXkJs2oJTlypVz6aRqZP/MKIWgmalRDG6/+iaS0Ku5T31ewAh4K0s21REjz+8Dbg7HF/oquz2j4DVpSMJOWV8B9YVUoh3XxrKFeoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZMXggPkW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZMXggPkW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVYgt4Z1Kz2xg3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 13:52:58 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652H7l9N1656097;
	Wed, 3 Jun 2026 03:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LB2d9i
	+3AgNt8gkonuNjph6Oh0dxdVE3FFHqiJs9LBs=; b=ZMXggPkWEmdC4DMaszITeE
	9o0O6YR4raxYr8wZOEUL0jo5a0cL27NWTBGKqQYB1w8rIWH7qcYD/FTa+7kYita1
	C4rxUm6EK6WYWgE515hTEr9k41g/fwT4qFSE8kQa3gaLuO5mFQsejQBbWT8/LFYy
	sR4N/TsqUUkV/C7JQH6kak4QXeAPA0HPcN2G8RUpKKC2qUHIZrEdeJNSk+ccb69t
	vBDYsBr8G87rJERWpB6FcaozUccO3Gaphd27xtkt6RptFhnPj88m6BcttVkPoMMt
	8nO2FKrMFgTa7/hT8A3UAX8DHPDOPhztAxBjiyQ4/d8wGWRy2nzxXLat6oSEfB0A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd493ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 03:52:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6533OGud017987;
	Wed, 3 Jun 2026 03:52:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwye39s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 03:52:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6533qabr56885688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 03:52:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F11C2004B;
	Wed,  3 Jun 2026 03:52:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 869AB20040;
	Wed,  3 Jun 2026 03:52:34 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 03:52:34 +0000 (GMT)
Message-ID: <31904199-2635-4c0d-a725-53665185fff8@linux.ibm.com>
Date: Wed, 3 Jun 2026 09:22:33 +0530
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
Subject: Re: [PATCH] powerpc/powernv: Cache OPAL check_token() results
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, thuth@redhat.com,
        Aditya Gupta <adityag@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
References: <20260601112520.161605-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260601112520.161605-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAzMCBTYWx0ZWRfX7rKpw/4dT3La
 612tjNmCRnlWUU766/2qst0ddqQ7q4JO6btpYVJU9Zzy6chA9kCN5Fs7p6QakwhSUBa5T/50jWl
 f8ieJ4RZtMboR8SvuSoIrD3jrouZMhktwbcTXOYJrbcRtH1+dX6UK4J7sYFrGt+1JgMxo6m9myy
 8jPrcbOh0IagJ1/Cd1D2Ms+twxZPZKoXf5GVccv21qAXwEDvA0fTQU8/pI7NPEtfP4UZtNdi0wh
 uSzm5a2TgxiEx45cgAT3Gr9QL+f49/TW1+H4Hl6Kq7TPO/FSke7AGyRHLnyCXeLEKApZosgYw9P
 dlTbqsCMy5BHvUI9svW9LForehs2KSQli+K8oC8qKiCFbfxb4adop9ZWJ1YUr2MbPzK/9V19D0f
 /rmpU8TCikPwc/Z/Cu5krqLd4KELdXJZajwm66OBsFoV3MYTPkkatxdtFdq+ucoali6UbNe0Jwt
 I2AW08CB8NsRHtgGArg==
X-Proofpoint-GUID: 4e3vW9--SeBlEP_9zAisvdzdAsSfVXyJ
X-Proofpoint-ORIG-GUID: yEYUXx70j-Pf5fcWD2GSUgQfM_bI6i_o
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1fa50a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=bRsBhSRQzHUE4VzFjH0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030030



On 01/06/26 16:55, Shivang Upadhyay wrote:
> Add a caching layer for the opal_check_token() OPAL call to avoid
> repeated firmware calls for token availability checks.
>
> The opal_check_token() function is used to determine if a specific
> OPAL firmware call is supported on the current platform. This check
> is performed frequently during boot and runtime, resulting in
> unnecessary firmware calls for the same token values.
>
> This reduces firmware call overhead during boot and runtime token
> checks while maintaining compatibility with existing code.
>
> Testing with buildroot images shows OPAL calls reduced from
> 35578 to 28983, before console bring-up.

Yes, it is a good idea to avoid making repetitive calls to check whether
an OPAL call is supported by the firmware.

But it feels like it would have been better if skiboot itself advertised
support for OPAL calls via the FDT, similar to how RTAS does.


>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <chleroy@kernel.org>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/opal.h            |  1 +
>   arch/powerpc/platforms/powernv/opal-call.c |  2 +-
>   arch/powerpc/platforms/powernv/opal.c      | 55 ++++++++++++++++++++++
>   3 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 0a398265ba04..e7e11479122b 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -156,6 +156,7 @@ int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
>   int64_t opal_pci_poll(uint64_t id);
>   int64_t opal_return_cpu(void);
>   int64_t opal_check_token(uint64_t token);
> +int64_t opal_check_token_call(uint64_t token);
>   int64_t opal_reinit_cpus(uint64_t flags);
>   
>   int64_t opal_xscom_read(uint32_t gcid, uint64_t pcb_addr, __be64 *val);
> diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
> index 021b0ec29e24..00325c189e69 100644
> --- a/arch/powerpc/platforms/powernv/opal-call.c
> +++ b/arch/powerpc/platforms/powernv/opal-call.c
> @@ -207,7 +207,7 @@ OPAL_CALL(opal_validate_flash,			OPAL_FLASH_VALIDATE);
>   OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
>   OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
>   OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEBASE);
> -OPAL_CALL(opal_check_token,			OPAL_CHECK_TOKEN);
> +OPAL_CALL(opal_check_token_call,		OPAL_CHECK_TOKEN);
>   OPAL_CALL(opal_dump_init,			OPAL_DUMP_INIT);
>   OPAL_CALL(opal_dump_info,			OPAL_DUMP_INFO);
>   OPAL_CALL(opal_dump_info2,			OPAL_DUMP_INFO2);
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 1946dbdc9fa1..c32035136efa 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -73,6 +73,12 @@ static struct task_struct *kopald_tsk;
>   static struct opal_msg *opal_msg;
>   static u32 opal_msg_size __ro_after_init;
>   
> +/* Token cache for opal_check_token() */
> +#define OPAL_TOKEN_CACHE_SIZE 256  /* Covers tokens 0-255, including OPAL_LAST (178) */
> +static unsigned long opal_token_cache[BITS_TO_LONGS(OPAL_TOKEN_CACHE_SIZE)] __ro_after_init;
> +static bool opal_token_cache_initialized __ro_after_init;
> +static void opal_token_cache_init(void);
> +
>   void __init opal_configure_cores(void)
>   {
>   	u64 reinit_flags = 0;
> @@ -1125,8 +1131,57 @@ EXPORT_SYMBOL_GPL(opal_flash_read);
>   EXPORT_SYMBOL_GPL(opal_flash_write);
>   EXPORT_SYMBOL_GPL(opal_flash_erase);
>   EXPORT_SYMBOL_GPL(opal_prd_msg);
> +
> +/**
> + * opal_check_token - Check if an OPAL call token is supported
> + * @token: OPAL token number to check
> + *
> + * Returns 1 if supported, 0 if not.
> + * Uses a cached bitmap for fast lookups after initialization.
> + */
> +int64_t opal_check_token(uint64_t token)
> +{
> +	/* Initialize if not done before */
> +	if (!opal_token_cache_initialized) {
> +		opal_token_cache_init();
> +	}
> +
> +	/* Use cached result */
> +	if (token < OPAL_TOKEN_CACHE_SIZE) {
> +		return test_bit(token, opal_token_cache);
> +	}
> +
> +	/* Fall back to direct OPAL call for out-of-range tokens */
> +	return opal_check_token_call(token);
> +}
>   EXPORT_SYMBOL_GPL(opal_check_token);

The current approach to finding supported OPAL calls is:

- Discover all supported OPAL calls during the first opal_check_token() 
call.
- From the second call onward, check whether discovery has already been
   done, and then test the token in opal_token_cache.

The approach looks reasonable, but how about doing it this way instead:

Maintain a tri-state value for each OPAL call:
0 - Status needs to be check
1 - Supported
-1 - Not supported

This would help in two ways:

1. No need to check opal_token_cache_initialized for every 
opal_check_token() call
2. No need to discover support for all OPAL calls at once, it can be 
done by need basis

With the tri-state approach, opal_check_token() could work like this:
1. Check the token status. If it is -1 or 1, return early.
2. Otherwise, query OPAL for support, update the status, and return

The only downside is that the array used to maintain OPAL call support
status would become slightly larger. 1 bit per opal call to 8 bit per 
opal call.

>   
> +/**
> + * opal_token_cache_init - Initialize the OPAL token cache
> + *
> + * Called during opal_init() to populate the token cache by querying
> + * OPAL firmware for all tokens in the supported range.

Seems like the above comment is not correct. I don't see below function
invoked from opal_init().

> + */
> +static void opal_token_cache_init(void)
> +{
> +	uint64_t token;
> +	int64_t result;
> +
> +	pr_debug("Initializing OPAL token cache\n");
> +
> +	/* Query OPAL for each token and cache the result */
> +	for (token = 0; token < OPAL_TOKEN_CACHE_SIZE; token++) {
> +		result = opal_check_token_call(token);
> +		if (result == 1)
> +			set_bit(token, opal_token_cache);
> +	}
> +
> +	/* Mark cache as initialized - enables fast path */
> +	opal_token_cache_initialized = true;
> +
> +	pr_info("OPAL token cache initialized\n");
> +}
> +
>   /* Convert a region of vmalloc memory to an opal sg list */
>   struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
>   					     unsigned long vmalloc_size)


