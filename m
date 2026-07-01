Return-Path: <linuxppc-dev+bounces-23320-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED06C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:38:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gr81D5Dp0z2yfH;
	Thu, 02 Jul 2026 04:38:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782931136;
	cv=none; b=fP8D7RRJsL+NFAqJ5MAx4XxB838PFBu/uHh5F7Zi8MtUYOyWp0DzBWtWtnt9uAKwCI8esTkEdQnyG6raDHR+FasZKyRuJd6i46OAW0Fcmp4M52KfbpgfzYQs5n1e4BGxBV0GTZJkSkvj05RCuBgPzlkanlVHB9/RRFmrm2JS+WrexQfmNQlW+ow/AwNMPUc/Z1qr5ehxSziVvVmhE0xUR5ycEGU328xJRZ1hsgicE/xM101vEif8Oixn6nnMuAp7BwsTBQGsww1HN52LofxptTS9BqUUPGpMC+nH/paM8NVzhzXxR5D3afeTUnNSdIhi4N6pXujniuNKNR7kzfbfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782931136; c=relaxed/relaxed;
	bh=qcNtIGifG4Hp/8ZqyEi0D/qZ9+raXJwMBE9dL22kPOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcTU1aUEYac0d0rx5DmobNH2ruPKPEkFbGhIh7ti9V8E66GA/dARoH4RsK3lbJOjbP26AfrgrWIMSwKtYoZy+Dg/yO7Q5oicZZn13ls4S6gVCfpp5m28JHGLfeX73cQ9OEGBcYFBcwwXrF130yydWK/G/rt5yjzkvTjboxY4nsqDn4qaIcu29vB3a4raXdw+SNvCQnMo5Y3HqKAu/55mSYCDXB1dXHs+LJEbJDDEJRR23/e3jD36B+xaCwVAbyH38I6AEBUYOVfjRvJuYOm4UfaTaY/MOwUujDhbRMxO+g37bcLOeCDbgCMl69a+YROQBr6b9AvbLGpg34T0ryQP7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rCz1fga/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rCz1fga/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gr81C2mWnz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 04:38:55 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GmsLE1340876;
	Wed, 1 Jul 2026 18:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qcNtIG
	ifG4Hp/8ZqyEi0D/qZ9+raXJwMBE9dL22kPOg=; b=rCz1fga/lQgVAIocIcjLWT
	HoecazSiRHWo5Nv0N25uAPyNx1De3n5IWwUbn+Kg5+P0Vp9alISOd1l5MgHAoftW
	nQLzFz4hTFmpnzB6z6j9j45KC7dM9HW48acL31ptDLtWHnrdZ0mD0zYmErmifC9W
	Z0sBQGgvrc2YQOZhZSzD3OD4cQp++CM9UWn8giyEcgVufPyhQ7Oi9K/Un5o0xQFf
	TPxR1TUxrs4yhsUiZ2tzYbDMuUC2gVXnZxbXA5WXVplEesPLDOdzrWQGKUfBr03B
	IgeWCAnBehby+HK2xLuSfTejFsZwtx17cK0x3Ehh/6TEHZwtgMiAJzS70bLQn+FQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf5p1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 18:38:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661IYd50018392;
	Wed, 1 Jul 2026 18:38:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gggfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 18:38:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661IceaK13697318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 18:38:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D76EF2004B;
	Wed,  1 Jul 2026 18:38:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30C5B20043;
	Wed,  1 Jul 2026 18:38:38 +0000 (GMT)
Received: from [9.39.22.147] (unknown [9.39.22.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 18:38:37 +0000 (GMT)
Message-ID: <2baaed1b-38aa-4764-8249-34e688d747e2@linux.ibm.com>
Date: Thu, 2 Jul 2026 00:08:36 +0530
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
Subject: Re: [PATCH] powerpc/64s: Clarify copy_and_flush() cache sync loop
 comment
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, mahesh@linux.ibm.com
References: <20260701182756.273019-1-nikhilks@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260701182756.273019-1-nikhilks@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a455eb5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=k39Bn-rZO4FkpeY6yEkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RtZ3zGaBmHq6FEZveBFhBtPHAheOzE_u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5NiBTYWx0ZWRfX2tNYp9dnIP10
 ETD40uCqS4MJoZx+YWUMX3P2p5S7S1xoZtr/AO7/COLt7rFUSl/LFSPd30BpzUBjG750ZLx0keB
 ViijkVIE2lP0w1swI3AHZp9uL7ml4MUSkDqmfH6NoRUgF5tVIe17u26qH5HcqN/xCpOInSzsEV9
 2EIdutRuEQYf2QsZKGupRbBmK5zsxJ6Plx9XMoDYL2f0qt/9JhiRj9TgkhZtVXFlvjk183jM/hv
 vQj6HEwo1eGoV1XALrEW98DKHqDM/umUevL5IUvnjoy21UIHk/qkgHScdCCF2jsh13QRsboawkv
 ayvk3OlpfnEnM60OD5tfqcYphfBqsURykXlf8xAPujmz3pSk1rkSoANurljs50bznPyBZ560FKE
 wS6Jr3riVymMD5Bg7LjQpjtfBYXyQCPy5j+XVI6UZTKWbhNQz5WeTv3vkKCJ1IyB7IVDMZ/87bJ
 FpM3MrTmYayku029NBw==
X-Proofpoint-GUID: g8IJoDVlQcspC1TxsofXWBIfrt22jHK_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5NiBTYWx0ZWRfX+/hH/lZQ72XJ
 TT+YyYYI5929m2Q4jnnpjP4WtIotxNlrW1A0PsMcb0zvAolT3pW55IulwqEgmbmFjxJm8770071
 eMdxokOgSjjRhME2lSazBwd2cLOaA4g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010196


On 01/07/26 23:57, Nikhil Kumar Singh wrote:
> The value loaded into r0 in copy_and_flush() represents the number of
> 8-byte words processed between cache synchronization operations.
>
> The existing comment refers to cache line size, which can make it appear
> that the value is a cache line size in bytes rather than a loop count.
> Clarify the comment to explain that the loop processes 8 words (64 bytes)
> per cache synchronization iteration, and that increasing the value would
> skip cache maintenance for intermediate cache lines.
>
> This is a comment-only change with no functional impact.
>
> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> ---
>   arch/powerpc/kernel/head_64.S | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 63432a33ec49..e21c2bce8f7e 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -713,14 +713,14 @@ p_end: .8byte _end - copy_to_here
>   _GLOBAL(copy_and_flush)
>   	addi	r5,r5,-8
>   	addi	r6,r6,-8
> -4:	li	r0,8			/* Use the smallest common	*/
> -					/* denominator cache line	*/
> -					/* size.  This results in	*/
> -					/* extra cache line flushes	*/
> -					/* but operation is correct.	*/
> -					/* Can't get cache line size	*/
> -					/* from NACA as it is being	*/
> -					/* moved too.			*/
> +4:	li	r0,8			/* r0 is the number of 8-byte words       */
> +					/* to copy per cache sync iteration.      */
> +					/* 8 words * 8 bytes = 64 bytes. 64B is   */
> +					/* the current default cache line size.   */
> +					/* This is a loop count, not a byte       */
> +					/* count. Increasing it will skip         */
> +					/* dcbst/icbi for lines in between and    */
> +					/* leave stale instructions in icache.    */

Looks good to me, previous comment stating cache line size may make it 
look like
r0 is number of bytes being copied which isn't the case when the code is 
read.
Hence:

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>


Thanks,
- Aditya G

>   
>   	mtctr	r0			/* put # words/line in ctr	*/
>   3:	addi	r6,r6,8			/* copy a cache line		*/

