Return-Path: <linuxppc-dev+bounces-26366-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0314CC624C6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 09:22:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ0kd1mK1z2xGt;
	Tue, 01 Sep 2026 19:22:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788254553;
	cv=none; b=AysPu4ipALwUxFeGoxloYZxF8kK/9ezQnnt4XUQx7zIAzTE0xEZd11E3G8GnyndnFcJihj4780xEbLQLWvJNsE9B1+vN/pfg1MR05L8bgHNQeWrhEcl5JgzJV3EuvqxsNr4FOule5eUTKqNyda3d62gCqJpheCQnOJgFCvI+ZpLZ27kkgeBpB0wepbaxQlIlgSTFZwgb1jGV+jUXs5EgLGb7l9SS0bEl2EqnZt3KWUgPE1zA5+UYEwTBGT2EjpVX1AjDNDGU+tKHZgyYXURzBT63ewhwAYFchHP1KydzGI79Ee0dmCy0TUoNJuhMqvlvU1Lqa2OyMy3r7xWjwdlQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788254553; c=relaxed/relaxed;
	bh=Cszh5prrL1zyQXAPeN3bqmwaFZvGTsP+Y3ukAG08csQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWjd2kuUexrpVvuwBzvToBmnnGcYLgCfKsPY5u873RUEwg9XFBHqjQmK51VCotXAcllx9CK5jX/LmNe7k7nsJD4SL+Kp+Zyt/Nm2kX6jC99B27bsKr6ZJ3adt6CX/clCLIzSZZAXhzlcy9vnJL4QWURsW4hFT5gaRYFuHIbD1z31tULWw1RqQlD5jI7fzaPL0VoZHNhMxdHrzZGucyQpvFT7m2YhDXAzEcJjXpg9Umc7m7mmEViAX8loW9JZWFxyDrnW0UoXJwMjDwnJFwbMIR6IeMcfGRYiYnlvMeSnUgC26/hGpRmlfDJeLS0QFUZRQZIYhmCyJRvVcjqK38/m6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cFjKAgpa; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cFjKAgpa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ0kb5K3sz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 19:22:31 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6817VVI9579083;
	Tue, 1 Sep 2026 09:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cszh5p
	rrL1zyQXAPeN3bqmwaFZvGTsP+Y3ukAG08csQ=; b=cFjKAgpaI0g0GmBC1vuMvK
	3AUmqF+EzSYroWEHyIYsblNEEue+/oNfJqVcoFbrZq2PzbmPcGXfx7oCnuMuGaEg
	a7NIBarU2NYQCdfY3gy/0HK5CAhHEBaV8TAfD4/PbPFkKlTqjbaRxntIi6j+n/nr
	9GQdeq7LAlZbRTfpVLOrvXScmgHAG80aBYdfCvaHgkU+/th7VCqrtx0Z/VJy9Igy
	6Zul6lCnXsrJek706RaiVrdf2KcGZPmGhI6ZCp7js3OTAn2j3BND8Quu4nSbt6/N
	3kYF3YKB1c7HtZvC1tO/Hw6McAMCa75gvYUjYImI5WIfGAtdYhziV/Tly8d06c0A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5evb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 09:22:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6819BOxO005108;
	Tue, 1 Sep 2026 09:22:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcark2vju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 09:22:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6819M7ur15335872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 09:22:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA8EB20043;
	Tue,  1 Sep 2026 09:22:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F381E20040;
	Tue,  1 Sep 2026 09:22:04 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 09:22:04 +0000 (GMT)
Message-ID: <1abcf248-0d93-4d2d-a3e2-867b0b3dea16@linux.ibm.com>
Date: Tue, 1 Sep 2026 14:52:04 +0530
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
Subject: Re: [PATCH v4 1/5] powerpc/rtas: Handle ibm,open-errinjct return
 format
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        oohall@gmail.com, npiggin@gmail.com, tpearson@raptorengineering.com,
        alex@shazbot.org, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
References: <20260831065441.48654-1-nnmlinux@linux.ibm.com>
 <20260831065441.48654-2-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260831065441.48654-2-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a969945 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1mVJ_uiqAAAA:8
 a=gdoT5VGXAAAA:20 a=VnNF1IyMAAAA:8 a=RZXp2JS0KY0MtV1H3CIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=h67g7WpEjx8dfGT80pje:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: eGDBC5Gk52YprrQwdpj-kG76IkFeZBqJ
X-Proofpoint-ORIG-GUID: -o-qD3rsNYY1o7EnCkYFXMH2SxQOzo9B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4MCBTYWx0ZWRfX4B/IesFi+VOs
 9F2prsAl6JP2AXnlS15zzjeTyo/n3VaLKwmk+Uu7idv83qzpe4bB+yyvFKvyaQcBUvPwqIr7X9f
 TJ5cI3Ulqu8KVt6GHZbZ2eLZ/5ctJtc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4MCBTYWx0ZWRfXw/QsRJEwRrtn
 V9eCdxsxgS7Tjz+9WmcvbZsJQnr70pzqKBORCDMdrXXfgIknG3LGhQPj6lHuUW1lPyv90V7aIkT
 G6tgRn4ga+PO63HfBZK73sSbVJv8RNpL+jDQplzK2pM41Q+0E+ZLBuGDu8QBWB4EPO8SbkDS/W5
 t2VlOVIrqIevVQ5Nqckb5lH3oz/P40EjANSgGDWfAHF2BjfpogcS9OaFzeIZEZdTDuvm+mEgqBJ
 1abhxj0HigHFVeGvC2ce/6zGIihNrleaAPNnUu8ikvP7s9szZxUZd1Wru+yFj1wekT786kROogp
 BYVMUPchcak5PHiKS1avT0Oi7Y5PNkXvuFEyiuCmAK6TSvzKf17EJxjSzrU4jNHa9ieiL/EvOS9
 rbHwPjwpVbcDViEWq0fspqg4IACHlCvOL6JEsuYbZnxKEGLwQzyEs4XI2Ew8hYyle0oNSmPQJVC
 9D2MQtIEz2JT2mogXKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010080


On 31/08/26 12:24, Narayana Murty N wrote:
> ibm,open-errinjct uses a non-standard RTAS return layout:
>
>    rets[0] = session token  (output parameter)
>    rets[1] = status code
>
> Unlike all other RTAS functions which use:
>
>    rets[0] = status code
>    rets[1..] = output parameters
>
> Add rtas_token_is_open_errinjct() to identify this call, and
> rtas_status_from_args() to extract status from the correct position.
>
> Add an early guard in rtas_call() that rejects ibm,open-errinjct
> invocations where nret < 2, since reading rets[1] would be out of
> bounds:
>
>    if (rtas_token_is_open_errinjct(token) && nret < 2) {
>            WARN_ON_ONCE(1);
>            return RTAS_INVALID_PARAMETER;
>    }
>
> Adjust the output-copy loop so that for ibm,open-errinjct:
>
>    return value = rets[1]   (status)
>    outputs[0]   = rets[0]   (session token)
>
> For all other functions the existing convention is preserved:
>
>    return value = rets[0]   (status)
>    outputs[0..] = rets[1..] (non-status outputs)
>
> Move the "/* A -1 return code... */" comment immediately before the
> ret == -1 check so it documents the check it guards.
>
> Also fix sys_rtas() last-error status detection: ibm,open-errinjct
> places status at rets[1], so the -1 sentinel check must use rets[1]
> for that function rather than always using rets[0].
>
> Reference: OpenPOWER PAPR documentation
>             https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/kernel/rtas.c | 78 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 68 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 8d81c1e7a8db..7131870655c6 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -1117,6 +1117,28 @@ static bool token_is_restricted_errinjct(s32 token)
>   	       token == rtas_function_token(RTAS_FN_IBM_ERRINJCT);
>   }
>   
> +/*
> + * ibm,open-errinjct uses a non-standard return layout:
> + *   rets[0] = session token  (output parameter)
> + *   rets[1] = status code
> + *
> + * All other RTAS functions use the standard layout:
> + *   rets[0] = status code
> + *   rets[1..] = output parameters
> + */
> +static inline bool rtas_token_is_open_errinjct(int token)
> +{
> +	return token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
> +}
> +
> +static int rtas_status_from_args(int token, struct rtas_args *args, int nret)
> +{
> +	if (rtas_token_is_open_errinjct(token))
> +		return be32_to_cpu(args->rets[1]);
> +
> +	return nret > 0 ? be32_to_cpu(args->rets[0]) : 0;
> +}
> +
>   /**
>    * rtas_call() - Invoke an RTAS firmware function.
>    * @token: Identifies the function being invoked.
> @@ -1198,6 +1220,16 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
>   			return -1;
>   	}
>   
> +	/*
> +	 * ibm,open-errinjct returns rets[0]=session_token, rets[1]=status.
> +	 * We need nret >= 2 to read status from rets[1].  Reject early if
> +	 * the caller forgot to account for the extra return cell.
> +	 */
> +	if (rtas_token_is_open_errinjct(token) && nret < 2) {
> +		WARN_ON_ONCE(1);
> +		return RTAS_INVALID_PARAMETER;

Nit: I would prefer -EINVAL instead. RTAS_INVALID_PARAMETER is RTAS 
error code but here kernel is validating the parameter so I think 
-EINVAL would be better.
> +	}
> +
>   	if ((mfmsr() & (MSR_IR|MSR_DR)) != (MSR_IR|MSR_DR)) {
>   		WARN_ON_ONCE(1);
>   		return -1;
> @@ -1213,15 +1245,33 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
>   	va_rtas_call_unlocked(args, token, nargs, nret, list);
>   	va_end(list);
>   
> +	ret = rtas_status_from_args(token, args, nret);
> +
>   	/* A -1 return code indicates that the last command couldn't
> -	   be completed due to a hardware error. */
> -	if (be32_to_cpu(args->rets[0]) == -1)
> +	 * be completed due to a hardware error.
> +	 */
> +	if (ret == -1)
>   		buff_copy = __fetch_rtas_last_error(NULL);
>   
> -	if (nret > 1 && outputs != NULL)
> -		for (i = 0; i < nret-1; ++i)
> -			outputs[i] = be32_to_cpu(args->rets[i + 1]);
> -	ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
> +	/*
> +	 * Copy non-status outputs to the caller's buffer.
> +	 *
> +	 * For ibm,open-errinjct the layout is:
> +	 *   rets[0] = session token  -> outputs[0]
> +	 *   rets[1] = status         (returned, not copied)
> +	 *
> +	 * For all other RTAS functions:
> +	 *   rets[0] = status         (returned, not copied)
> +	 *   rets[1..nret-1] -> outputs[0..nret-2]
> +	 */
> +	if (outputs != NULL) {
> +		if (rtas_token_is_open_errinjct(token)) {
> +			outputs[0] = be32_to_cpu(args->rets[0]);
> +		} else if (nret > 1) {
> +			for (i = 0; i < nret - 1; ++i)
> +				outputs[i] = be32_to_cpu(args->rets[i + 1]);
> +		}
> +	}
>   
>   	lockdep_unpin_lock(&rtas_lock, cookie);
>   	raw_spin_unlock_irqrestore(&rtas_lock, flags);
> @@ -1942,10 +1992,18 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
>   	do_enter_rtas(&rtas_args);
>   	args = rtas_args;
>   
> -	/* A -1 return code indicates that the last command couldn't
> -	   be completed due to a hardware error. */
> -	if (be32_to_cpu(args.rets[0]) == -1)
> -		errbuf = __fetch_rtas_last_error(buff_copy);
> +	/*
> +	 * A -1 return code indicates that the last command couldn't
> +	 * be completed due to a hardware error.  ibm,open-errinjct
> +	 * places status at rets[1] rather than rets[0]; check the
> +	 * correct position for the -1 sentinel.
> +	 */
> +	{
> +		__be32 status_cell = (token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT) &&
> +				      nret >= 2) ? args.rets[1] : args.rets[0];
> +		if (be32_to_cpu(status_cell) == -1)
> +			errbuf = __fetch_rtas_last_error(buff_copy);

Do we know what happens when the ibm,open-errinjct RTAS call is made
with nret < 2?

The reason I’m asking is that, even with the above changes,
args.rets[0] is used as the return code if the ibm,open-errinjct call
is made with nret < 2.

I like the approach you took in rtas_call() of pre-validating nret for
the ibm,open-errinjct RTAS call and returning early if it is less than
2. I think we can use a similar approach here as well. If we do that,
the above code changes will be much cleaner. In that case, we don't
have to figure out how RTAS processes ibm,open-errinjct with nret < 2.

The only concern I have is that this change would alter the system
call behavior. Right now, the kernel accepts nret < 2 for
ibm,open-errinjct and makes the RTAS call, but with the above suggested
change, the kernel would return early if nret < 2.

The prominent user of this system call is librtas, which passes
nret = 2 for ibm,open-errinjct:

https://github.com/ibm-power-utilities/librtas/blob/d321a1f5ae3d528ba027fc748d1cc1123dd4ae29/librtas_src/syscall_calls.c#L488

Also, as per PAPR, users are supposed to pass nret = 2 for this RTAS
call. So I think it should be fine to validate nret in sys_rtas for
ibm,open-errinjct and return early if it is found to be less than 2.

Since this is a change in system call behavior, I want to be a
little cautious. So, I’d like to hear your thoughts and would also
like to know what others think about making the above change.

Thanks, Sourabh Jain
> +	}
>   
>   	lockdep_unpin_lock(&rtas_lock, cookie);
>   	raw_spin_unlock_irqrestore(&rtas_lock, flags);


