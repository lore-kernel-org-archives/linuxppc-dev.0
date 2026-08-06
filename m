Return-Path: <linuxppc-dev+bounces-25511-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF1BC5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:27:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGDkf43Sfz30C0;
	Fri, 07 Aug 2026 03:27:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786037274;
	cv=none; b=GF/h65bV7/u8jeZrD4BNAyJ0RBYZDOG95r7Ag45Udz/hqEbIZ3JlSEz/tFk5vvQcqJvdeuhVoCOezMu49qwW/IRArNmOWQTqp67g0x8wqPJmISqllc/K9PUK9LCzHJWh7na22zBCtEGHJbWZRWWqDGmcupo2OHHv03NtInAGPhlML4H7AZlmaRS6dHrrDKh4CZsG64s6wAzJOxDpUf6dmSfpk24Ubroqc+A6rqBA+ErRlwiTiSwD3Qd16U9Anc1/gSF8RRYOIfPWKa2+xii0YUH1XibJ4JLlP735gyvbUbA4j/WfbPNzQ+sgIK5xcfCZmdFQkjEX8nSTGQjnU8OC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786037274; c=relaxed/relaxed;
	bh=tlKXwmhFIi6vjCxMPL1AbbqV2Px3o+udTGkDDYwkgQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=If8a88Q7pTy11XNC3JMSvP6EeY06knHMlpvOY3DSANpHwAGzUUn6zGZoBmDVhzI91XJrgXq7y6zBY++X/3clmE9QEKSUY8wqRV6SAA8aWa2VXQ4/5OD2VKSDLA+z+HPFC0aA/AopBJuScVY8FcSmAeAo1IjSMGYp3wdNc9xb1OEfOQVGZevQD5N/ZhTKYtSQ0us4RdGhQFrU+0qu2TUDDPRdiZTyQPS4hQEQIeCx71jmMoGxXMOGLhj/PemS1+fJ/Bj/nBgeXrc86W0r81ZoR20BxJQkf69N0NVXdNoTiPmuq2xqcWVx89FoIpbzNNS8SBS8Vzx/WzqQucHb0ATUnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HSFk9EBQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HSFk9EBQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGDkd6CKyz30B0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 03:27:53 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676HHv5j3290775;
	Thu, 6 Aug 2026 17:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tlKXwm
	hFIi6vjCxMPL1AbbqV2Px3o+udTGkDDYwkgQw=; b=HSFk9EBQ3PgeS5zbObw1ud
	/axaP7vUTV5oh/gXpdXclaALlCS9rv4gG3yK4mid7wtXOqlhUGQYaY2hTNC97lwc
	H37mqvtcmqJJvUcw+6P8F9C2vPVDm+YyYdTpjfZr36Lh0QnXttytyqc1N+1kGGWP
	OVaFTqvT6eO6Ni25g3/ZfZbJtwNY3+4RidtuGezoshrl/+YlGnljKdJb3GDVl4FA
	DJRfU5TLzmmq8vadkTrE2E/+qqp9OJrwMVmvOeOIrqqSLR24xYHYAbhUPilouPQZ
	0HmtrMlG7AcaVEYKRyy5gcdbrD8gDDAR1GX+NEiZWm4o5KGyd2fIXN0dFp9bDCvQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h59krh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:27:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HQjT6002635;
	Thu, 6 Aug 2026 17:27:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgm02m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:27:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676HRUV033292722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:27:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCDFF20043;
	Thu,  6 Aug 2026 17:27:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 381EF2004B;
	Thu,  6 Aug 2026 17:27:27 +0000 (GMT)
Received: from [9.124.215.184] (unknown [9.124.215.184])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:27:26 +0000 (GMT)
Message-ID: <23512326-2cee-43fb-97de-d1b8628d4d6d@linux.ibm.com>
Date: Thu, 6 Aug 2026 22:57:25 +0530
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
Subject: Re: [PATCH v10 8/8] powerpc64/bpf: fix percpu private stack leak on
 JIT failure
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1785906979.git.skb99@linux.ibm.com>
 <cf132f76a7af898af9f9690952067e213430c43f.1785906979.git.skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <cf132f76a7af898af9f9690952067e213430c43f.1785906979.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX+hQwbQ4df4Wo
 W9hRuKjJ6E0g7LZDBCTO8+5vudGLhiDGjS0tfTSCTxuhmNIJ0ULqhea/td2CVcM/jB79y61+Kjg
 8fedJxFcjNEoQWHvp3PqUONn04HK8TA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfXyDRDPBH+wpdD
 BpW3kfwBhPdbwOdqsnBy5nBDeGDCp6r0170OS8XKKbCakKsMUe+O4SoTCX7TLCtn6XHpAkbHk4H
 DthBZZPifxuA/tWUACx2G4Hvd1LA6frFDxh7P8DdQvMVo2jssPAH7lQ7ac02HZvDG51RS9MN+/Q
 UkT8XCoFbfiIqM+OMf3TiW1V7bn21K25v0ZtAwvn39+95ywO1mRaxpwB0H0l+yAy2mX+Ox3uALD
 XuhYbiljrg0LnJtnwyom7x5Iv8FduBuMiWhm97X4kHOX3cHMFUaOCGPxlsRMiLyw9GRbY0os/e2
 r0plmfSThCVAPVZkCqdz3JKMtvMrIPaDfO0QyAXfX3H3Ry9VOSvKL0oa4+5X8SyXDTPNxi3sSRr
 7LHe5RvaP2ao63d8ZPAIwuLRLM09dxjg1ewsA9zIUvqtz7TiOVoxQfePHH163PX9WsWIlYS8UHR
 FO5aX4riJVW83tipAKw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a74c407 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=SG3J2fsUutJ-UIamL3IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: u0ktx7i_Q8MS4AeZMgzBthGCqPzeri1u
X-Proofpoint-GUID: u0ktx7i_Q8MS4AeZMgzBthGCqPzeri1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060135



On 05/08/26 11:37 am, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> The existing conditional statement in bpf_int_jit_compile() frees the
> percpu private stack at out_addrs only when the image buffer was never
> allocated.
> 
> If bpf_jit_build_body() fails during a code-generation pass, the
> image buffer has already been allocated, so !image is false and the
> percpu stack is not freed.
> 
> Because JIT compilation failed, fp->jited remains at 0. The subsequent
> bpf_jit_free() path only frees priv_stack_ptr when fp->jited is set, so
> freeing is skipped here too, leaking the percpu allocation.
> 
> Fix implements freeing the private stack whenever fp->jited was not set,
> i.e. compilation did not succeed, instead of keying off !image. !fp->jited
> already covers the !image case, since image is only NULL on early-failure
> paths where fp->jited is likewise 0.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/bpf/20260616135426.A06B71F000E9@smtp.kernel.org
> Fixes: 156d985123b6 ("powerpc64/bpf: Implement JIT support for private stack")
> Cc: stable@vger.kernel.org

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 3c20bb13cfd7..825999f8717b 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -404,7 +404,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   				(void *)fimage + FUNCTION_DESCR_SIZE);
>   
>   out_addrs:
> -		if (!image && priv_stack_ptr) {
> +		if (!fp->jited && priv_stack_ptr) {
>   			fp->aux->priv_stack_ptr = NULL;
>   			free_percpu(priv_stack_ptr);
>   		}


