Return-Path: <linuxppc-dev+bounces-23821-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA2EC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:09:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwKhX16hnz2xll;
	Thu, 09 Jul 2026 00:09:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783519740;
	cv=none; b=U+V8o2BPdMstHtApguj84Kx58pMnxR5vf1KNE/KAuCmAfmviF+T3TDZ7kmjrLZyRbrwtrySUIsUVihaZfKCWL+7vHvz8483Z7Z3BriHkFDw9ZCHERwozrwYwodRQc8WytzHkSypC5QElI3iTuquQQAM59n2UqylMm7O4/aYHxEG+P4DRWHgo/uwE9H5tEYkkhZ6zX9LbGb+jFAs0r5BRQlz8rnrj1pgeVKUCdVZ5aAvHJ8luYebQGOAKdX3yZgiDP2642tk+Q37QAncxDKug+5c+AdH9BDVJBH8Kem5KMTsoVA3/MXn+eZnIYQ1/HOPpkZ4kaZICZBD7e5n22OJ/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783519740; c=relaxed/relaxed;
	bh=GEjSURf+Oc47/KvAIRxIcmtLYIml26GEKQF9rwik+OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grzBEJBHmVh8qWgOeLLMFIbg/ryg1v/6GKoWSV5H3VR4uAv+hCRVRKFE8y9hJNV3EXYoYXR36IWLlMgcaIXqA8N3SIsSM6RrYA5HH2BsYyijlPoq6867gmw4TK9EhzlFEcdpckLBR5gX+U1efcPBOUtRD0pa3nF/bQ0ui6k+hQQHEYX4zt52S/BfoJf+YCg6lYuPqhY+gu22F9dlfcmY9lNwXgimrSK5V9EE1eAMwv2itdw6gWP92jvKJXjWMiNoqBPcrVB7GJh52L71qT/yByDRv3zt52dCezeyJ23e8f63whUoXl2h1j2ot2Pw4voyEiRiDCLTk5MwH78GkEVNVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=it1AC++S; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=it1AC++S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwKhW2gGGz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:08:58 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668CIYUk3243532;
	Wed, 8 Jul 2026 14:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GEjSUR
	f+Oc47/KvAIRxIcmtLYIml26GEKQF9rwik+OM=; b=it1AC++SiBIAqAcqiPq93t
	pjWkqrK605Ig+Fp+n6nyGY4MvyzTT6PVTI1d/QjJkcXBDkutS+kGZr/rMVLnsK20
	83Nf2F5IgcwxVpzlmCJx3J59iuz/ImvWoCglnlVb9KpAsAqGRC2XDl/YWK1+5eOp
	+BnXqWxI/05TkIjjB9RzIa/RPLO8v5Ce+RKot2wZXGgt+unxuZnOVkY/2cx6ABEy
	pDND8FrIXRdIESKhXHId05Wgv68LATT9kkNZiQhQN6JLtMmcnTyzSWeq/RWgrKZd
	4CNMJriX/u2aMZKyKFDeU3Xj3NqrL5l0d7VK7IFQCg9CIUGyvE7hFtSo7NlZk0Qw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3vt4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 14:08:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668E4aiX000987;
	Wed, 8 Jul 2026 14:08:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq8hub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 14:08:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668E87B552953472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 14:08:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5893220043;
	Wed,  8 Jul 2026 14:08:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31CB520040;
	Wed,  8 Jul 2026 14:07:52 +0000 (GMT)
Received: from [9.39.26.208] (unknown [9.39.26.208])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 14:07:51 +0000 (GMT)
Message-ID: <771d3150-7650-4ba6-b9d7-31a534f72cb5@linux.ibm.com>
Date: Wed, 8 Jul 2026 19:37:51 +0530
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
Subject: Re: [patch 01/18] powerpc: Move stack randomization after
 syscall_enter_from_user_mode()
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190253.718191130@kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260707190253.718191130@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4e59cb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=xoOMMzrzzHNEA0Jk9MYA:9 a=QEXdDO2ut3YA:10
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEzNSBTYWx0ZWRfX3Hbrj21CCLzB
 kKSW8jXH6Bj74UUfNzioqmwVCV/ijDVvhJAjSPEr0PRBP7f/C8rZNu60kYcZr5VFMnqEWqfDA++
 inZSpN3ruIS55U0sAZiMr1mp3yETXqg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEzNSBTYWx0ZWRfX1zZjIJAFUCrC
 DZZFHPLhsL8y5odyoK2G1FgYpxRt932tRoGDWK0fyKR4ICWQTR7y9CixTwoRlTEsJgHxYdDsxW/
 vDCytNNTBf9qGopcuoTa/AfoIYP5/zKMOESsc5h8MkN4K+Uf4AdxEGyFCI5+vOxHPIbB8IqmeJm
 pofTRmoVVtdakQlcUwa/5iQWPHLRHFh3nnXP7i2wdhEwKU50t4+I1IxbYK74aJOGz40WRB4Y+V4
 4L8Sbqh1GTuOEjLQb44e8SVXpvqwnYBDql+ViuMKMw7GgSmmOYeHOKcPR0lJvuu+XVbWRZ1EUzc
 6crZl+xqk34xyqm/WMIBKetDHnyOG4hsMvqdfd6LFN/EzEGxxsXwZFa2vrz4uXcEoEG8vRy8hAQ
 jQT68kRhg96HNn0D/8F1334ciC2LdYUUMBojPYYvDfcCxB6zftVE1+6IswOt2cm6NCMaXOgtD9o
 i6zmvswRSv/7ugcSyPw==
X-Proofpoint-ORIG-GUID: -jmj0fPWFB_5RGym_5okOoW04BYgxv97
X-Proofpoint-GUID: UewskUPBCDVeXb9KcNrW_7wrTfTPl4fV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080135



On 7/8/26 12:35 AM, Thomas Gleixner wrote:
> add_random_kstack_offset() is invoked before syscall_enter_from_user_mode()
> establishes state. That's wrong because add_random_kstack_offset() calls
> into instrumentable code.

Thanks for fixing that.

> 
> Move it after syscall_enter_from_user_mode() to ensure that state is
> correctly established.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>   arch/powerpc/kernel/syscall.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -19,8 +19,8 @@ notrace long system_call_exception(struc
>   	long ret;
>   	syscall_fn f;
>   
> -	add_random_kstack_offset();
>   	r0 = syscall_enter_from_user_mode(regs, r0);
> +	add_random_kstack_offset();
>   
>   	if (unlikely(r0 >= NR_syscalls)) {
>   		if (unlikely(trap_is_unsupported_scv(regs))) {
> 

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

