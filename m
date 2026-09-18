Return-Path: <linuxppc-dev+bounces-27667-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934C4C982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:12:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmP2C0y8wz2ygK;
	Fri, 18 Sep 2026 17:12:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789715523;
	cv=none; b=J0sWWUZOi9wio6uXtFwJsS72E/6qmKBla33bi4LbL9+eiMesFJTxRw2hIpLMcGZl/Ur6qiHqrNI3cUjZFBX6tGjNI8z5DD9vl5R1RN8I2vevLN9MpN6rxlKzz6WYTir/+ZYg2P50Wv0hCLQfYuB0GI8L40FP8iaUXMGG1swUCz8fBjFGgWQiigEOzyYPscbqyCk2XS/Q/NwgO9tUA7AJzZm2041D46kExNlM/6ceurCmTKMvXOExcBve96R3QrfTRuOJOY2gL/5qYn6HiLu7xW6Gr2V4s57u4S+TM2cH61pFfL84d5ESLu2/DmEut3LDIPASqDxilC3vNpwfEHgXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789715523; c=relaxed/relaxed;
	bh=1TIW2ATgsbYwHD+V3wTTo2oijK7cddC9TiGIuTFYaZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ko2wHOOzyqc2D0tZ64hw2M7z9hksHRobAz1H8Luu84jrMh9JVRjvaw6afVE8X9kpBEMH+E4cmQYbdQbFsuHDakGCh1+Xsi/r01mIDwLtZWYeFFbqv9gmHS+jya2we6ASnFFg1lbO+7XnwK4vWRs6dnhttr5SRgCXLkq7h0N4um4VSm4ji1cmMeXdZqAZxNgUc7kcGVE0NmbP02efK0mrBkTXFzYYHu4KZe497CofFG5tMzUWXZdw/5dGxPF/O/P1Y6eryIVVAHmGy+xJHl1d6ksBvyvSYsno7rrAAEW7iWBYk+4cdF6bUtZc5yrEXpV/YA+1V1CUX6hx8sdlkBVMiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JZoRVHR8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JZoRVHR8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmP2B22t6z2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:12:02 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61akH498279;
	Fri, 18 Sep 2026 07:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1TIW2A
	TgsbYwHD+V3wTTo2oijK7cddC9TiGIuTFYaZg=; b=JZoRVHR8OD8cZR0HBT5pWj
	dMUNhPxHSKkVEp8xTmM+CiCMJnWvgOREFWle+d53YWOHksOoxmDND6LWR6Z+0yhl
	e7fXdq/k5A0/iqSl1XfJ9qbcIs76yaFEzYFdabd9mj7a6GL+UHwo5llrJrUl3G/T
	59xyXm2jksMxeVOEDPi/vbzNc7tdIsdz7OpjCvwLwEKhXahqDVsxQXAIY1IO6QqV
	Q7HcUbQqm+A0Ia9csfgZyEN3sgBKi8Ptpe1IgenHmz453fFJtK59ACIhdL3AzGau
	FeqivaFC7HKGzGdNnC5v7IKD/CDkvZMxw5pOagTqe0HUE2lOCAczGpm2L2B/Bz+g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcve4bm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 07:11:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I653oE170853;
	Fri, 18 Sep 2026 07:11:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fda24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 07:11:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I7BnP734799892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 07:11:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EF2B20043;
	Fri, 18 Sep 2026 07:11:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C4F020040;
	Fri, 18 Sep 2026 07:11:47 +0000 (GMT)
Received: from [9.39.16.52] (unknown [9.39.16.52])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 07:11:47 +0000 (GMT)
Message-ID: <1f44b5fa-0238-4412-8742-07f17c06cc04@linux.ibm.com>
Date: Fri, 18 Sep 2026 12:41:46 +0530
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
Subject: Re: [PATCH] powerpc: remove unused audit_32.h header
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20260918030810.420490-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260918030810.420490-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA5NCBTYWx0ZWRfXxTsSnjEQuxp4
 r46otJqrmJbmC0oYH3w9f/GA5Z8GSQtVnHCFO9IlgFPQ1YGghAAj7mbHmVlfNFyYbjMSh7lSSP+
 r+7ViJ8mnWwOCXWXtOoIDWDGQ9oFfx8=
X-Proofpoint-ORIG-GUID: 0HODbB0OzsAOUrNMxTuTgrBm4vm6yx_g
X-Proofpoint-GUID: Ft2tQc5Q_g62zR1ih7pjIyo_V1QHF0eU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA5NCBTYWx0ZWRfXwwGb7KRg23IO
 MeysK88FAYOz1Cw4X0V+5VtEqWjEA2vlX7zt+WvfyxBoAlvrqQvRBN5xxc3LQsI+Gz+gW6REJFb
 SiYJJKTgAvloQyFMcvqOCWyl23gXCgxc4MIF9VWIsNcXyG+EZZ30ig5Gx3GRmn/Qm7m3JQ8Wnz9
 WK9L3yu5zu5o96c3KlTHqGFYvlpwKy4jVo1L1QOqWaAFj1gH6rC0PjK+HbFMQsVcO/g8YxqCqUF
 9bX6H0I4z2udNLkVs7rzex9MNOPf57cJsYcCK/IQeimYDb8+sqLQfPMHyUYKmQnbWPbkjqpQt3X
 4P/0hJkmGqotq8fm6VZ12Z9Txz8ZrImBFtBHjIXjQDAM4j+P1TDBLYgQgw0uBhdHbUJJQlnUFOj
 g/kyi6BabCyW+3CLy4wStovYA2vX6esbUAPmQEK6MCKjuoUO4FT2mzr2X+HqBY4HJDwEUi7Ppjx
 IsX/Z1aJGtsMp/9A3Vg==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aace438 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=M3_7wxToKFD-CYzEIBUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180094



On 9/18/26 8:38 AM, Ethan Nelson-Moore wrote:
> The last use of arch/powerpc/kernel/audit_32.h was removed in
> commit f26ad12356a2 ("powerpc/audit: Convert powerpc to
> AUDIT_ARCH_COMPAT_GENERIC"), but it was left behind. Remove it.
> 

Does it need fixes tag, So that it can propagate correctly?

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>   arch/powerpc/kernel/audit_32.h | 7 -------
>   1 file changed, 7 deletions(-)
>   delete mode 100644 arch/powerpc/kernel/audit_32.h
> 
> diff --git a/arch/powerpc/kernel/audit_32.h b/arch/powerpc/kernel/audit_32.h
> deleted file mode 100644
> index c6c79c3041ab..000000000000
> --- a/arch/powerpc/kernel/audit_32.h
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#ifndef __AUDIT_32_H__
> -#define __AUDIT_32_H__
> -
> -extern int ppc32_classify_syscall(unsigned);
> -
> -#endif


