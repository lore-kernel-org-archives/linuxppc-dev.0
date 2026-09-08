Return-Path: <linuxppc-dev+bounces-26815-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18525C79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:31:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfTwp3FQ8z2yFW;
	Wed, 09 Sep 2026 02:31:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788885114;
	cv=none; b=ixDi8J1iJzAbpMWzPhZCQe9C0pVOIdH6ErS4OxpHxmuKiWaPwTAFqZMuse5dsX2xODSagW29sqzihQB9dlhWdks1Wp9EeqacIt3GpzVwtrQMdkirPRvU5fAdEbAlhQlWgMp29MJr799MH8dr43GBLlI4YHV0v+rsXieyatoxJVy1drEM0E7VGA4plROr4hr249OjWdyY4UEg71nmmXnUzoW7NPD4U5PfdSXmzuRfjOPN7w22XXl6YfEfH7z+JaFdYfXNz87Hzqf9/TyTBFzDEjJaSlz0CscNml4F89rnNmrdCM5vFWOfFQmvUMth4yjJo51Mwj7At/phCiIbWoaK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788885114; c=relaxed/relaxed;
	bh=+lLAxJEgDfz0IHluMf+QRQOiiEIZIavb79C9YQ/JbZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeSEljsO9sOJfphXFIXE7XV2MLnVCwaO7l3l7Ik70T67bC6rz/IXtmt8xtJN6CSuOrhEqkrZhMLTI1fMryE8XJXv17rAstkpePzs10CTvs3bataNowlR/OsojU5q/UqMPBnNjiffMIdJMuDANFSvrZ5RVbq0n694SSmUH8enFLZcedJGq/afJ+kEF/k8/+DfrW4SHQtx8QsQSU0lUxHiiXCwV46Dd36MOc1itTZXotxuCctp1ctQBj6sj2xIP/VZNCasCtJwiIpFcFJ9qQlXGGQmy2sgBQ3e9DTF6B/Huy5G0FjKQfXLilnj+vnYAAowqXFkJGTw4UvUqYh4kyy0Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o9P9LUPY; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o9P9LUPY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfTwn2fLSz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 02:31:53 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688F1VhG1094382;
	Tue, 8 Sep 2026 16:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+lLAxJ
	EgDfz0IHluMf+QRQOiiEIZIavb79C9YQ/JbZA=; b=o9P9LUPYMEcoJX/6FeMB7u
	LB6XON39XmaluxwKQNZ34c23LBhhw4xbvNDw5tmnL90ckGsCHuYXiXjD0OeI/pcZ
	+ALf8xCnFRLYj1UllWPsy3knqFGvY1snp1iqP6AtbqD/o0ifWbgqR9DOvuAFZA9j
	AxexOQ5ucHxhRtca0Lv6OucCGcAb/1lUdbWgjVB/yc55UMfEUsDPk+wgNfQshMqn
	70lHeU/0TBHOA37edMkUaq+hL/vjwrb0y9o/+QJm5upu9b7nwSM+pxAump9fVnIe
	Eg405ZPNJtdXRT4OBpOAtnROxTGD7QsVk5RPSkjL5e3NQnFHGc86VymGlT6ZWPYw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj884u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:31:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GQEdD031283;
	Tue, 8 Sep 2026 16:31:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw55yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:31:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688GVUrY52101438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 16:31:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E926D20043;
	Tue,  8 Sep 2026 16:31:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44D2420040;
	Tue,  8 Sep 2026 16:31:24 +0000 (GMT)
Received: from [9.61.253.97] (unknown [9.61.253.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 16:31:23 +0000 (GMT)
Message-ID: <ffecf223-fe43-462c-9f20-4128f762c90e@linux.ibm.com>
Date: Tue, 8 Sep 2026 22:01:20 +0530
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
Subject: Re: [PATCH v13 2/8] powerpc64/bpf: fix percpu private stack leak on
 JIT failure
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1788154635.git.skb99@linux.ibm.com>
 <a827e3ef81cd43f2aee7e9bdfe8683f2c77065da.1788154635.git.skb99@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <a827e3ef81cd43f2aee7e9bdfe8683f2c77065da.1788154635.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U9mP4fZrS65La30m8mF5DMZS24Q_PM7J
X-Proofpoint-ORIG-GUID: U9mP4fZrS65La30m8mF5DMZS24Q_PM7J
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6aa03866 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=SG3J2fsUutJ-UIamL3IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX18mwzR+Ck01x
 1nEFes6YQPBasCZK+0GMnprA7KQwtxYK9B5dBBV+fjyj+0qq6CiC4HSUgNrsKSCUYlKWI6cnysO
 5CsmanrKlNqu9ZeASxck5YPLuXpg4gc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX4HeuRJTI1Jji
 yPg6fcif8Huw0vBVewB0j8xNbILM0ISRLmsCDbbRwzzpvg7B9WSLDP/pEUbI7ZDt2zSJgIawDzh
 O5W0xUP4i1XwhEzafNf+BbtzaCJIyoDH00J7ZxJIt6Ky37nHlua9VhCTuDug7ALMbHAHgqJNcAF
 8WSNKRC57+LfJj/7ZbmnHrgIEHSa9ZvlVaREPX1CTZ0yenKB0Gsdp37UTu/Gz2TE5X3TGJGHn87
 3jAljva0rg3mMcEqJk91IjAvbxyOikoCVF5c0x5mlk1FmqgfCLMgSq9DWa3LoE/opG87igQyK7D
 DbB9N1tiWr5E+K/Xp/6azEqNas9ifYA2PPjG1BzGbUOv4nKlm/69qjF3cKS+BFhtHVjsxcoqCXI
 DuXNGNom7CJBBt2vpb1w8zW5xtj4Dy4pLRJtl6Bsc9b1jjWCyKaIzTagn6YPlweHT1vQFeRPYyp
 evJYMYQZ/eQ7S20AzeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1011 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178


On 31.08.2026 12:45 PM, Saket Kumar Bhaskar wrote:
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
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   arch/powerpc/net/bpf_jit_comp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index a875521ff904..8f7501954d9f 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -357,7 +357,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   				(void *)fimage + FUNCTION_DESCR_SIZE);
>   
>   out_addrs:
> -		if (!image && priv_stack_ptr) {
> +		if (!fp->jited && priv_stack_ptr) {
>   			fp->aux->priv_stack_ptr = NULL;
>   			free_percpu(priv_stack_ptr);
>   		}

-- 
Thanks and Regards
R.Nageswara Sastry


