Return-Path: <linuxppc-dev+bounces-22155-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F34CD8C8C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jun 2026 11:20:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYCQJ4Kxbz2ySD;
	Sun, 07 Jun 2026 21:20:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780831224;
	cv=none; b=TaLJup7/3gy7UYXWZobm5C20x/k6dAjlGDJVdKA13bg5WcSoURhkp01J6L7Bzeoza+Ox4em3ZQUl9Ohi+PtrlRfoStwUy9Mbo50VKAUVTlZmW4Seqt+rN82Sr2mgbXRaQnJ6jxQkmILPjfaYfRs2SjSgK3taq2Oc8ZK8ULcBKwOx/1DeqD7KuMO49ur8BhTBk5TEkTDdSM4HdAu7WQYs4zUucEA9c+veWzCkdJHOJWr5/syL22RjodSa3JLHPD0zFtIXhD1HEpKX6r2Q5BdSOQ1DvbnpuaKLP8bmO9y59kg0mQRwblXx3U1aYSRKBy7vU9a1gvDzZPZhCgCWvDU9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780831224; c=relaxed/relaxed;
	bh=g+X+RJ6Dw+vo63EgytHIkdlKw0QsGtlTgryp0tEU9d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a64lZMgHT1WX77qxXmZVLp4WjCAQYaJdL2o2YdWDW+sF4WnIQlspKGxiiffCR/2XQ/NSkzXWkf4n2wZ++Td4A9/j6JXH79n2XPR3W6JGHeyC82EnaltLIqPY4cRK30/lPaVxocjH0dKGV7yX39ck1UI7rCp7U1MdIzML5YgipZpw/vaVkAPpQPgjP6OKIsjJgSyl2iYOL3vbfBiwFE3DuJKGa+oSmUQ0SlX45E68wjy57uPt4WYChdFQztzvQREy6Z+D1iSQUSnNmwYFjnlJyHh4trZzdrC4Jzl08SDt7F3DTybXncMh5vUEX+gemNk/8uXW8Jh6Nirwm+EYkJoVjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MHXextnH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MHXextnH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYCQG6n5xz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jun 2026 21:20:21 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657BK2b22046895;
	Sun, 7 Jun 2026 11:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g+X+RJ
	6Dw+vo63EgytHIkdlKw0QsGtlTgryp0tEU9d0=; b=MHXextnHkJyF77NY7UfH/U
	r49ropNygWKBiFxSUmL126LFsLKIf6TW6SHbwyMhFtHtQNOfAVSgixQrevYyxYFB
	BJHEpJzO6nn0YpAL4kHkhnxWeSzSyQMlxSju4fHsTy9etREXLnCXjy12OOGNujXM
	6tiBlsOencAa1uDuM93sGeEjecct4M740CJlidTRPD0IN9WGiaOZhdDHqaHB/ugr
	3Q7R6DpYPjxZqfEq4oMFUCWlvbLehHuKkgH0Jf43Uve0t/ipxjlcoiu/JrNPbMHx
	8RTVBqb0GS53C237699f6ozBthm72bwZ46O78hnXqPI4veuERPLxDUZVRV04C8VA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qbjcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 11:20:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657BJigX014515;
	Sun, 7 Jun 2026 11:20:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vsdqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 11:20:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657BJuav59310516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 11:19:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97F3220043;
	Sun,  7 Jun 2026 11:19:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7901520040;
	Sun,  7 Jun 2026 11:19:51 +0000 (GMT)
Received: from [9.39.26.1] (unknown [9.39.26.1])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jun 2026 11:19:51 +0000 (GMT)
Message-ID: <79ade62b-6e94-4219-b7fb-95cc3b80c957@linux.ibm.com>
Date: Sun, 7 Jun 2026 16:49:49 +0530
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
Subject: Re: [PATCH v2 1/5] powerpc/rtas: Handle special return format for
 RTAS_FN_IBM_OPEN_ERRINJCT
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
 <20260527072433.94510-2-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260527072433.94510-2-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a2553e2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=1mVJ_uiqAAAA:8
 a=VnNF1IyMAAAA:8 a=lVt0M31tXN6yAD1bP4AA:9 a=QEXdDO2ut3YA:10
 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-GUID: KN8Y_bYXA7NPYEYofsljfuctIFug8rRc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDEwOSBTYWx0ZWRfX/ft28ZOJ5AaK
 pupsUqoY1KuEHmyyn9R1GbRsxeCpAQzGNJ8ttLeDXiB1c06IRCZRu+JelN2PhNiG0L9GGPms5m5
 3vE+CUhfcixwpnuw4ZMYmYc5Y6/w61uFn8gfcrIhLdHaHvvFkPNp9WbjetRxulCtUrvX0Q+clWS
 iW8TIatoYh7bHyDDQvjfQ9P2WVwbKhS51s2Q4SpbJ1VQ2rTZVd16aR8MhSqk9yVO8teFd1bfEOA
 BN2q7DkzKBJMdba/GOs38fPfg4LL4OXsdVxJoF315BIO57Eu6MifcaKGKfXiMgvZ7CSqE+ljsrA
 2E54aJFUzc35jBV+nKKiXkkMZQRJ20aRfReznEh1Qo3Bf1MOwo5Edl0FnOovDYFQv0/jwLG54Em
 y+AkM4VS90YcCLFwQZdxwt0Li7Q9mI5xwMfeAT00StLKX0AAUOF14m3AEkclLtTgDAft5bvQQIO
 gEuGUUFXaecIZHpxjEw==
X-Proofpoint-ORIG-GUID: YAK8SkCEPOy24coub5h_ZmpUS21HeFT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070109



On 27/05/26 12:54, Narayana Murty N wrote:
> RTAS_FN_IBM_OPEN_ERRINJCT returns results in special format:
>    rets[0] = session token (output)
>    rets[1] = status code
>    rets[2..] = additional outputs (if any)
>
> Unlike standard RTAS calls where:
>    rets[0] = status code
>    rets[1..] = outputs
>
> This patch adds special handling for OPEN_ERRINJCT to:
> 1. Check correct status position (rets[1]) for __fetch_rtas_last_error()

You can consider fixing the same for the RTAS syscall.
> 2. Copy all rets[0..nret-1] to outputs[] (including token at rets[0])
> 3. Return status from rets[1] instead of rets[0]
>
> Reference: OpenPOWER PAPR documentation
> 	   https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/kernel/rtas.c | 47 ++++++++++++++++++++++++++++++++------
>   1 file changed, 40 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 8d81c1e7a8db..a2dd94eed9d0 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -1183,7 +1183,7 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
>   	unsigned long flags;
>   	struct rtas_args *args;
>   	char *buff_copy = NULL;
> -	int ret;
> +	int ret = 0;
>   
>   	if (!rtas.entry || token == RTAS_UNKNOWN_SERVICE)
>   		return -1;
> @@ -1213,15 +1213,48 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
>   	va_rtas_call_unlocked(args, token, nargs, nret, list);
>   	va_end(list);
>   
> +	/*
> +	 * Special handling for RTAS_FN_IBM_OPEN_ERRINJCT:
> +	 * Per PAPR, ibm,open-errinjct has a unique return format:
> +	 *   rets[0] = injection session token (output parameter)
> +	 *   rets[1] = status code
> +	 *
> +	 * This differs from standard RTAS calls which return:
> +	 *   rets[0] = status code
> +	 *   rets[1..] = output parameters
> +	 *
> +	 * We must extract status from rets[1] (not rets[0]) to correctly
> +	 * detect errors and trigger __fetch_rtas_last_error() when status == -1.
> +	 */
>   	/* A -1 return code indicates that the last command couldn't
> -	   be completed due to a hardware error. */

The above comment should be moved to next if block, if (ret == -1).

> -	if (be32_to_cpu(args->rets[0]) == -1)
> +	 * be completed due to a hardware error.
> +	 */
> +	if (token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT) && nret > 1)
> +		ret = be32_to_cpu(args->rets[1]);
> +	else if (nret > 0)
> +		ret = be32_to_cpu(args->rets[0]);
> +
> +	if (ret == -1)
>   		buff_copy = __fetch_rtas_last_error(NULL);
>   
> -	if (nret > 1 && outputs != NULL)
> -		for (i = 0; i < nret-1; ++i)
> -			outputs[i] = be32_to_cpu(args->rets[i + 1]);
> -	ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
> +	/* Copy all return values to caller's outputs buffer if provided */
> +	if (nret > 1 && outputs != NULL) {
> +		if (token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT)) {
> +			/* Special case: rets[0]=token, rets[1]=status, rets[2..]=outputs */
> +			for (i = 0; i < nret; ++i)
> +				outputs[i] = be32_to_cpu(args->rets[i]);
> +		} else {
> +			/* Normal case: rets[0]=status, rets[1..]=outputs */
> +			for (i = 0; i < nret - 1; ++i)
> +				outputs[i] = be32_to_cpu(args->rets[i + 1]);

I am surprised that status is never copied to the output buffer even 
though it is part
of the output as per PAPR. But status is copied for ibm,open-errinjct, 
which is okay.

> +		}
> +	} else {
> +		/* Either no outputs to copy (nret <= 1) or caller
> +		 * didn't provide output buffer ensure ret contains
> +		 * the status code for standard RTAS calls.
> +		 */
> +		ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;

What is the need to find ret again? Isn't it already done above?


> +	}
>   
>   	lockdep_unpin_lock(&rtas_lock, cookie);
>   	raw_spin_unlock_irqrestore(&rtas_lock, flags);


