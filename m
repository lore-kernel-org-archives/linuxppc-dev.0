Return-Path: <linuxppc-dev+bounces-25320-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6379C55172
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 05:52:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDjPR2lDlz2y1Y;
	Tue, 04 Aug 2026 15:52:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785822763;
	cv=none; b=lgdAWI9opcASysLxHK4xGl+c7jolDMlE+aSEet8HCKN88BCnMN4vWx0hfRJs2UVTuM0+pYEYNq7xqHRup9IZ7IPR5aFcY+n2MST4bDFXmZQvAjZNtMcnUXHR6+fmFe+l2O2fsKrrfaq2AKMuysl/eeJvKMKxPp46BL9yV9NmtkyY6GsQbDpmMEevrkJtGBBfCzQqbnCrB+MMz8tDJlQnJO77ExKIYTnfs8uJELqyD5EQ48qdJZEpRzzQcRW1CbLs8ho+bXunc3BZkRnhT/OypjSmRWSxRdZ0Z44tk+ttEh2aR3Zi9+wPY+fzTejuMMRMN+rDCahUY7eMvMBP2HBjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785822763; c=relaxed/relaxed;
	bh=EFBHc0U59OV1k7isfp/LX1NlAIUvR9KWi7OdfDuP7zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2Kckfxtr8JlUdBTUEcaJJNwoG/MZN2yfZ4w2nk9G5HDrV8TwAaHW2agc1oYC3OCZcCqZPIO6X2XVft/uMKCBp7/q3hnNg6C8btXX3vOEaGcKHvebtFnrp/TnZlnggi26nQxg2Ue+K417I41wENjdIq8vnSetfY9EoO+8hVrorgSGjuS3dtjmOhbZ6B2exBPkigEEce9CBD/KvBQzYkrD5ss6tn2Kdq61z7OKiozJhZL1qW9prqpz23gxRQpL7NXtLMysBKmFV9mJ4lxz/Wfeb3VFuzxsoxFea/KuZC5RmwXcqokhjokGH4+oFgF9qVoI6FY8xHEmZNSV6clYOWPyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nYWQC6+r; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nYWQC6+r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDjPQ1Mt7z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 15:52:41 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741JE7X3574076;
	Tue, 4 Aug 2026 05:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EFBHc0
	U59OV1k7isfp/LX1NlAIUvR9KWi7OdfDuP7zw=; b=nYWQC6+rXbvPdfEl3IJDJR
	sBfrjKDH2KoCkCv8VINIoeiJDXC4HEo59zn7p6I47pqarqudz2GHxcJ1Py+rPJTQ
	2euotMAYM9TEG3t95O5wDURQ0xGwgrFA6A1twrTvshIw+oiM+gklL6B8DKPwN0EV
	2t8y7uTMHrJsii2I+0oWRDsHVp4d4A5h9yMnP3gohoEougaUZKRBd2N+x6josJei
	y4jb0SDQ8HGe9RZw7EqFk25VZx0qaq18lVA1MN/6SSV2IERt0OUZtj9xdPn0b8A3
	4e4OAsIo1O5vtIu7EnycPzs3i/NXi+JIjBHt4x43yg83MJDkTDYEaLohfDLFNtXg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hm84f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 05:52:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6745fHQl009865;
	Tue, 4 Aug 2026 05:52:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qgt05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 05:52:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6745qGk532047536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 05:52:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89F0E20040;
	Tue,  4 Aug 2026 05:52:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44B2320043;
	Tue,  4 Aug 2026 05:52:13 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 05:52:13 +0000 (GMT)
Message-ID: <c4e58e48-a7a6-44b7-8984-7f03b3251160@linux.ibm.com>
Date: Tue, 4 Aug 2026 11:22:12 +0530
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
Subject: Re: [PATCH v3 1/5] powerpc/rtas: Handle ibm,open-errinjct return
 format
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
 <20260721033815.5300-2-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260721033815.5300-2-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX+hHdrHak03xg
 ZeBuPjqEcsh6bfvXfdfhFrAqTVrMJEx75IXeaKs300xp0/yhW/+OP5zLKTzHZVw9uDc+PMtz6RD
 AAKfevrfR6aZvYEcUE37eENAlQVTJ28=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a717e17 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=1mVJ_uiqAAAA:8
 a=VnNF1IyMAAAA:8 a=tNZqOhCZX4RMPwz2XQgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX67ZRRvPsIuiy
 43VnZk2iP/DlLG49GOxrHVfbw43VbRQudt+NMu26YkJ5AvKQPVb/GzOgT6NZqxi8t0oquUgEhr4
 K6hfnz/x6Ce13GGO9G2Q2K7pI4tFUZpDAwSRv6AiPj2j6ZMPKYJr432tr63bSZYHCkP54ucUsVr
 c/mOZWAd25RGxij/fe9mmuD0s6x/BcYYQL4DqM6nh/hgUmdqOwBTb6/94oh/DvmGNHNpxdh4g+5
 qAHzY4q/VW0G2vVOyvNA6Dr6QgrdZxsYP9XGOwdqMqrcg9QLAWPHRrknTnuag5UBeuQq1ejKp0l
 raW3NF1pTblPnmkPHeLaYBu+IYXG7W7MC0jfVjn1SHvY13h0q6Cltyr4NgGIvt0/z3cFj2Ljf4l
 QTFSPNPwC4AeqUz5Ioi+kftscbjlXs1V/ZK7AHJuhBv+D55siLBzzeA3ViSrV/9xkFZFY5DR6te
 eYaJpz5HMEsz7yDKXOQ==
X-Proofpoint-ORIG-GUID: IGKmYnKKUmGv4t-icy3OvjqoclSSryvV
X-Proofpoint-GUID: 51MeP033Ikn1Ci91qiQ1xNY4QIzN_mmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040043



On 21/07/26 09:08, Narayana Murty N wrote:
> PAPR specifies that ibm,open-errinjct has a unique return-cell layout:
>
>    rets[0] = injection session token (output parameter)
>    rets[1] = status code
>
> This differs from every other RTAS call, where:
>
>    rets[0] = status code
>    rets[1..] = output parameters
>
> As a result, the existing rtas_call() convention — return value is the
> RTAS status, outputs[] receives the non-status output values — must be
> preserved while correctly extracting status from rets[1] for this one
> call.
>
> Add rtas_token_is_open_errinjct() and rtas_status_from_args() helpers.
> rtas_status_from_args() selects the correct status cell based on the
> token, and the output-copy loop in rtas_call() is updated so that for
> ibm,open-errinjct:
>
>    rtas_call() return = rets[1]   (RTAS status)
>    outputs[0]        = rets[0]   (session token)
>
> For all other calls the behaviour is unchanged: return value is rets[0]
> and outputs[] receives rets[1..nret-1].
>
> The sys_rtas userspace path is not modified: copy_to_user() still
> copies raw RTAS return cells (rets[0..nret-1]) to userspace.
>
> Callers passing a single output int (nret == 2) are safe because we
> write at most nret-1 values into outputs[], never all nret cells.
>
> Also move the '/* A -1 return code...*/' comment to immediately precede
> the if (ret == -1) check it describes, and remove the redundant stale
> else branch that re-assigned ret.
>
> Reference: OpenPOWER PAPR documentation
>             https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/kernel/rtas.c | 51 ++++++++++++++++++++++++++++++++------
>   1 file changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 8d81c1e7a8db..27d53f34494d 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -1117,6 +1117,29 @@ static bool token_is_restricted_errinjct(s32 token)
>   	       token == rtas_function_token(RTAS_FN_IBM_ERRINJCT);
>   }
>   
> +/**
> + * rtas_token_is_open_errinjct() - Test whether @token identifies ibm,open-errinjct.
> + */
> +static bool rtas_token_is_open_errinjct(int token)
> +{
> +	return token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
> +}

The above function is a god candidate for an inline function.

> +
> +/**
> + * rtas_status_from_args() - Extract the RTAS status code from a completed
> + *                           call's return-cell array.
> + *
> + * For ibm,open-errinjct the status lives in rets[1]; for every other
> + * RTAS function it lives in rets[0].
> + */
> +static int rtas_status_from_args(int token, struct rtas_args *args, int nret)
> +{
> +	if (rtas_token_is_open_errinjct(token) && nret > 1)

Do we know what RTAS returns when nret is less than 2 for the 
ibm,open-errinjct RTAS call?

I assume RTAS treats this as a parameter error. However, since there is 
no rets buffer available
to store the status code, I'm not sure how RTAS would convey the 
parameter error back to the kernel.

The way the RTAS status code is extracted when nret is less than 2 for 
the ibm,open-errinjct RTAS
call seems problematic me, especially when nret == 1. When nret == 1, 
this function returns args->rets[0],
which is supposed to contain the session token.

Are we sure that RTAS places the call status in rets[0] when nret == 1 
for the ibm,open-errinjct RTAS call?

- Sourabh Jain

> +		return be32_to_cpu(args->rets[1]);
> +
> +	return nret > 0 ? be32_to_cpu(args->rets[0]) : 0;
> +}
> +
>   /**
>    * rtas_call() - Invoke an RTAS firmware function.
>    * @token: Identifies the function being invoked.
> @@ -1213,15 +1236,29 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
>   	va_rtas_call_unlocked(args, token, nargs, nret, list);
>   	va_end(list);
>   
> -	/* A -1 return code indicates that the last command couldn't
> -	   be completed due to a hardware error. */
> -	if (be32_to_cpu(args->rets[0]) == -1)
> +	ret = rtas_status_from_args(token, args, nret);
> +
> +	/*
> +	 * A -1 return code indicates that the last command couldn't
> +	 * be completed due to a hardware error.
> +	 */
> +	if (ret == -1)
>   		buff_copy = __fetch_rtas_last_error(NULL);
>   
> -	if (nret > 1 && outputs != NULL)
> -		for (i = 0; i < nret-1; ++i)
> -			outputs[i] = be32_to_cpu(args->rets[i + 1]);
> -	ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
> +	if (nret > 1 && outputs != NULL) {
> +		if (rtas_token_is_open_errinjct(token)) {
> +			/*
> +			 * ibm,open-errinjct: rets[0]=session token, rets[1]=status.
> +			 * Expose session token in outputs[0]; skip rets[1] (status).
> +			 */
> +			outputs[0] = be32_to_cpu(args->rets[0]);
> +			for (i = 1; i < nret - 1; ++i)
> +				outputs[i] = be32_to_cpu(args->rets[i + 1]);
> +		} else {
> +			for (i = 0; i < nret - 1; ++i)
> +				outputs[i] = be32_to_cpu(args->rets[i + 1]);
> +		}
> +	}
>   
>   	lockdep_unpin_lock(&rtas_lock, cookie);
>   	raw_spin_unlock_irqrestore(&rtas_lock, flags);


