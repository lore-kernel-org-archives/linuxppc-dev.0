Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31E2606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BEvApsCQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTzWB1Xd7z2xns;
	Wed, 18 Nov 2026 22:13:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795000438;
	cv=none; b=EhJwcwg85Dqz4d5gqt39BP+hUpi4O9KAjnXxLV5fxMhmiFGkM9E4jbg+6jSCwQ9RxYph2u3ZlQW5DUX6FNJwpUepPv5CNsZWlGQdzZFpTBSMFZlakq+S7JqFCqpTgBTMcJLKJpkBnzBM9X1OyS1j1CeaFRvSmdWbmsl6Y1aPAaeKLaaVZWUL/zsIuyedYm0/j92a5q00EtQz5Fz4w7zspbjNyDRqkr/igZBkptGmEZIx1nNGnYiecXOhbgY4KHjfy2GqF+pEvdFrOuOkH/TwD2/lMk9BIjM1MCTVdPV0xI8orgWo4Ud6+KP8uO59eDiwRKEr/olhoCkKeabdwDuTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795000438; c=relaxed/relaxed;
	bh=sCiJ08V+bGznwwS5+rlG2xx5khApZdRnfSKzbGyAZ2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEgky7oremC9HowbJ+MjS8rET/XF6A0aBGX1HZ1SqK41UNb/omXLuhe0qh0jYEB/DNauQF7UFGuqDk1OiRe6hDCTZiUi2mCBXcnkSaXnSL7h2qltprTG9nMt24F6dm2qsVcmKZseicpAedENiINcl4m7S3/I28AIRpbrCnyfSQWh7v/FGF6XsWTf+jXM2QnCJJzldH5V+18vzTRSX6L6PMjUwRkiKd70TEYTVhtEsm+BPxmuGxSCKsB6O0R7N5BhMp2nswMDvRsIU4+G6QpEbCt1x4taApjjcha8qv9KCV2E0WK9TFAXk2wHL+qnJa+BlwcIRIDcwMMOTgANsiww1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BEvApsCQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BEvApsCQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTzW9062hz2xdV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 22:13:56 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9uHbl952767;
	Wed, 18 Nov 2026 11:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sCiJ08
	V+bGznwwS5+rlG2xx5khApZdRnfSKzbGyAZ2M=; b=BEvApsCQBFiQcQSFxnFm6T
	EgPgjFVU/TFHqDcrZHvRvWZfLFGi/mD+usjY0wpCJ7U0CFX28vq+Y6uw7RrQpnax
	JMI+dQxwIiWKaiUZxuFoej7FjqaMR/O9Y/8p6HOq5PVffRUKR9WDe4qDhBxekrPE
	c9wcO2p9oJ3R1nQKX4DoyqaJV59a8lEFalaxHChnQ7CfLTXfqqZ4lG1hKRi1T5z2
	7fFjIdgIxe+Odh67SXDNRGJavweeHDDJm+QqTRe6dwGEhLaelTvqWuWtZ4VfCzCn
	btbGOlcqUMkWa208BjDMGMa0fRqA+JL9QWe01i2Iy6EdBjYkzKuzObBh3AeY+j9A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105na3ws-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 11:13:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9o4gD1832228;
	Wed, 18 Nov 2026 11:13:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4rn2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 11:13:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIBDeFg51511788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 11:13:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC0872004D;
	Wed, 18 Nov 2026 11:13:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C160520043;
	Wed, 18 Nov 2026 11:13:33 +0000 (GMT)
Received: from [9.124.217.34] (unknown [9.124.217.34])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 11:13:33 +0000 (GMT)
Message-ID: <67d2b322-9a6b-41d5-9920-33acb36cb76a@linux.ibm.com>
Date: Wed, 18 Nov 2026 16:43:31 +0530
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
Subject: Re: [PATCH v6 1/5] powerpc/rtas: Handle ibm,open-errinjct return
 format
To: Narayana Murty N <nnmlinux@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
 <20261023073642.59657-2-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20261023073642.59657-2-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA0MyBTYWx0ZWRfXzSi5/+6gn4fU
 q4INOmsMpUllCKrrlN8nTvjS6r/y6Bg0LeB0ylU3OA1EZKVFzMh5XOOs3L7Qq17mDDevQHWI4i1
 4F00DDaYSSN70RMIx7ztKVEmZo6f8Bb10OnYd3jFgUY4+qlriPZhNN3UuGVnBg7H/O2r8xy8t/S
 aFDZ42cLXTJ7FC2cnV3Hb1K11I81ies338Q5u5Nt1aecDsrnEXBJvAEcG55GFGwGQY5oNJWDCOJ
 3eavv66xuEaJPFKSbyplRh31e+T4lGwKnDoxGTpO5KnGdSwmN0cYprMoSfFdoOW9wFRhGaGdzoo
 4KIG0mMK28+R6dlHqqMYj3NC0E2j/ATF089ziayGe9yAHcEmrDaYAZkeHvA2qvtvKvNC1v/nOtd
 19Iw3BWwbYvuOlgi+1o1DwnxeWWkS5e45EjVaPRJuTtaVQfBNZkJyVb/BB0Z2c0Rkiiv0mmqfKu
 CQXU7WU3MyPV/+H9iuQ==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afd886a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1mVJ_uiqAAAA:8
 a=VnNF1IyMAAAA:8 a=R5LW5MnUpmvYC84hGPEA:9 a=QEXdDO2ut3YA:10
 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-GUID: ibzlfOJKHSqHkl3VA0GmRpE79_lvVk0u
X-Proofpoint-ORIG-GUID: VSD8Qx3mZx-kOY7AbjKzpy5ZF8eWUQGm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA0MyBTYWx0ZWRfX0uISw3wLutYc
 QXwcJoQTO43Qyu8FZh8/Z9bRQjM9MiCerRDszj1QHXZsgtQdC9N/aSlnSC6YkRTrPBoKq9zM3ap
 OT6VICzrL58xnaNSYQXVGey/nO1Vbyc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180043
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 23/10/26 13:06, Narayana Murty N wrote:
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
> bounds.  This is a kernel-side call-convention error, so -EINVAL is
> returned rather than an RTAS firmware status code:
>
>    if (rtas_token_is_open_errinjct(token) && nret < 2) {
>            WARN_ON_ONCE(1);
>            return -EINVAL;
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

Nit: I think we should not documenting a minor comment movement
in the commit message.

> Also fix sys_rtas() last-error status detection: add the same early
> nret < 2 validation at the syscall boundary (returning -EINVAL) to
> avoid entering RTAS with an invalid ibm,open-errinjct return layout.
> After that guard, use rtas_status_from_args() to obtain the RTAS
> status for last-error handling.
> The prominent user librtas already passes nret = 2 for this function
> as required by PAPR, so well-formed callers are unaffected.
>
> Reference: OpenPOWER PAPR documentation
>             https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/kernel/rtas.c | 78 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 69 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 8d81c1e7a8db..38f3d08d4228 100644
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

Nit: this comment describes rtas_status_from_args(), not 
rtas_token_is_open_errinjct().
Please move it down.

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

Nit: please switch WARN_ON_ONCE(1) to a WARN_ONCE() with a message, so 
the log
says what the caller got wrong. For example:

WARN_ONCE(1, "rtas: ibm,open-errinjct needs nret >= 2 (got %d)\n", nret);

> +		return -EINVAL;
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
[...]
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
> +	if (outputs) {
> +		if (rtas_token_is_open_errinjct(token)) {
> +			outputs[0] = be32_to_cpu(args->rets[0]);
> +		} else if (nret > 1) {
> +			for (i = 0; i < nret - 1; ++i)
> +				outputs[i] = be32_to_cpu(args->rets[i + 1]);
> +		}
> +	}

Just wondering, what is the need to copy the outputs when RTAS returns 
-1 (hardware error)?

However, since it has always been this way, I have no concerns regarding 
this aspect of the patch.

>   
>   	lockdep_unpin_lock(&rtas_lock, cookie);
>   	raw_spin_unlock_irqrestore(&rtas_lock, flags);
> @@ -1896,6 +1946,14 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
>   	if (block_rtas_call(func, nargs, &args))
>   		return -EINVAL;
>   
> +	/*
> +	 * ibm,open-errinjct places status at rets[1]; reject calls with
> +	 * fewer than 2 return cells before entering RTAS, since reading
> +	 * rets[1] for the -1 sentinel would be out of bounds.
> +	 */
> +	if (rtas_token_is_open_errinjct(token) && nret < 2)
> +		return -EINVAL;
> +

I think it makes sense to perform this check after the security lockdown 
check.

Otherwise, it would look confusing if the kernel first reports that the 
argument is
less than expected, and then, when the user passes the correct argument, 
kernel
reports that the operation cannot be executed because it is blocked by 
lockdown.

So, let's move this check below the security lockdown check.


- Sourabh Jain


>   	if (token_is_restricted_errinjct(token)) {
>   		int err;
>   
> @@ -1942,9 +2000,11 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
>   	do_enter_rtas(&rtas_args);
>   	args = rtas_args;
>   
> -	/* A -1 return code indicates that the last command couldn't
> -	   be completed due to a hardware error. */
> -	if (be32_to_cpu(args.rets[0]) == -1)
> +	/*
> +	 * A -1 return code indicates that the last command couldn't
> +	 * be completed due to a hardware error.
> +	 */
> +	if (rtas_status_from_args(token, &args, nret) == -1)
>   		errbuf = __fetch_rtas_last_error(buff_copy);
>   
>   	lockdep_unpin_lock(&rtas_lock, cookie);


