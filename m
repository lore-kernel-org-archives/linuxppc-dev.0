Return-Path: <linuxppc-dev+bounces-19661-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0923CE9381A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 05:23:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvG5Z4cGgz2yjV;
	Mon, 13 Apr 2026 15:23:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776057794;
	cv=none; b=PopCslmglh4tQg1gDnJY02XAapnNakd5WwQZ9gz3aOxoSj50+OqSzCpv8D63XNCfKfdgKKHhx7RRByKhxJsNHmX1TJ1uG5EF10xmWSUsr4D2KRhvgL26H1dqSgypG9UtqJVao5kNQ0+6OfoDD3Ma8PdhY7YtujLivJheqDD5RCV/is86K2XvFMugJtt+HzNWH1jE0DicBsfMLJSnBW4LO2qA5Sx0FqyE5RMD5+CYfJfmMq2pQf9lgudNjlAfZy7KYrLY4+3K0I5CUijf2nlr0gcs2VfEXwDIMOXv3WeHTTttKnrReG+R2fb0SPW/arPuPVH3rKSWvsuRvjxheRUPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776057794; c=relaxed/relaxed;
	bh=UNt9bCxnTGM8jnsiit74ZajSXUFNNLBnJS/R7xGI86Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6O1eCU/qDWSOgv2kMUmQBjuxzNJaFDfmDed4jF9X4lHBclA1l6Y+DUDg2SZzRIxm6vWWGvG1os1SvlTNqG9yyerMcM5ZVXBD1uIBV1b/B5L41GYe2OJ6VpE72Kk22JY0qfhyDCHI5Zuu8ygJOMuERjcuNNqQ6QcBFHnbGbQnVgPlOiCnAW1RnAXbSbsKQDRpDBQeUFOtOOZ0pCUfiZn6FHcJyXMrhTk3EFi3PgF7ZYeeeRSaBKPzwhlw3jNalXZYAq8prvh1q8EnWqdIEg3vcWTxlEVElUYTZDjqpNpx2LkyzSVlEyqP2RkOgOM/eNNmtw6UjIdL28jiG/OWeI1LA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H3H3jg26; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H3H3jg26;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvG5Y29lwz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 15:23:12 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CBbPOL2314896;
	Mon, 13 Apr 2026 05:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UNt9bC
	xnTGM8jnsiit74ZajSXUFNNLBnJS/R7xGI86Y=; b=H3H3jg26ssDT9mvMI+fcx/
	RrBzIhiVpeopgV3/ZNUsWVhqYusUhpisKqHA9Fu8RoNg5TljgSnUUnb+mGfZeisn
	scg8/jv+SZQXJdfTRKHajRAMq6PdGnSxOUVVDlSKc6gJLGE6pLKQ60G0YMsbtOnI
	mxtJ+DgWfn21YKZzcnfkcXntJ8JuIO3JNiVSgRV6XpHUY/M+ZiaUKk0oeBe+i8Uc
	TbV0u77KKyWYuQJmFux5La1mWs1N74pARsGDGIoRjPdxncuejwkPO+fXebYj/ysI
	w/i0GdidFJiydcGryiUk7Ropq6V5Fb/YQDbwret+2NqNF4SwbBkc+GP67EfVY56w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdt3p4m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 05:22:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D2cOuG015149;
	Mon, 13 Apr 2026 05:22:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msbwpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 05:22:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63D5MmJN50987314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 05:22:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8F3720043;
	Mon, 13 Apr 2026 05:22:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0E8320040;
	Mon, 13 Apr 2026 05:22:45 +0000 (GMT)
Received: from [9.124.215.143] (unknown [9.124.215.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 05:22:45 +0000 (GMT)
Message-ID: <14329248-0c4a-46a6-ae32-a30dc10dc1d0@linux.ibm.com>
Date: Mon, 13 Apr 2026 10:52:44 +0530
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
Subject: Re: [PATCH v2] ppc/fadump: invoke kmsg_dump in fadump panic path
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, kees@kernel.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ritesh.list@gmail.com, rppt@kernel.org,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Shirisha G <shirisha@linux.ibm.com>
References: <20260412113057.46090-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260412113057.46090-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: IH7kdniHn2CQrGeMt-nnAP2bMNQD49cv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA0OCBTYWx0ZWRfX1KQbtbhDxdd7
 I3d0vR4GX7CcOAIMyDIb1DCpYv5hYsU6aOr50l9aeaMSRVhn+i6KZcTSlJ3S849S9YPWBkmTsUc
 HgXSIz3J+E1N3agwHmWwVeSnnikXip9sJ+YWAWwm49/55DmaEItwLcErnaeplYDvLYkGfvpR610
 vYphd1EujzNFtUYoXPeA9PqEkNB+nChphebUbOBauWILIg0GuqGzX8NCzmLyzN6ZJYsM7o2TqJM
 H7UFLcxelXYCvbbnLqeoftZnkrTOnNDk8T4psMd23rh9JsIxovpLkrbrXrTm9LajKco0ki9ZtjR
 XbkoUHVhKSWHkHRTv+SvSiRHY4JNceGpHj8LyNKG0LdNBz/fy6CcnoQmDgjDOwlubq8hsHq3t0o
 OF1Ba5SR2R2i2veCbei9x76D/8cq24nE9yNx3K0VSmaMfAgYRIXEkU3en9xph/2++hi2szaNiZT
 f4KIfKVRjAnx7pvyhAg==
X-Proofpoint-GUID: xhwX0rdguQ3Lv0PIA7PbzktUBpLH2gFo
X-Authority-Analysis: v=2.4 cv=WpEb99fv c=1 sm=1 tr=0 ts=69dc7dad cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=AFqkCBWJvsyecdCc_mkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_01,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130048



On 12/04/26 17:00, Shivang Upadhyay wrote:
> fadump is registered in panic_notifier_list and gets triggered before
> kmsg_dump_desc() in the panic path. As a result, kmsg_dumpers such as
> pstore are not executed during fadump crashes.
>
> This is problematic because pstore provides a critical fallback mechanism
> for crash analysis. When fadump fails to successfully reboot the system
> or capture a dump, pstore logs may be the only available information from
> the crashed kernel. Without invoking kmsg_dump_desc() in the fadump path,
> we lose this valuable diagnostic data.
>
> Invoke kmsg_dump_desc() from the fadump panic handler, but only when
> fadump is actually registered (checked via should_fadump_crash()). This
> ensures kmsg_dumpers are called without duplicating the call that occurs
> later in panic() when fadump is not active.
>
> The call is placed before crash_fadump() to ensure logs are captured
> before the system attempts to trigger the firmware-assisted dump.
>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reported-by: Shirisha G <shirisha@linux.ibm.com>
> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
> Changelog:
>
> v2:
>    address comments from Sourabh, and sashikio-ai
>    added should_fadump_crash()
>
> v1:
>    https://lore.kernel.org/all/20260407054341.308710-1-shivangu@linux.ibm.com/
> ---
>   arch/powerpc/kernel/setup-common.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index b1761909c23f..87afc8003a03 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -68,6 +68,7 @@
>   #include <asm/kasan.h>
>   #include <asm/mce.h>
>   #include <asm/systemcfg.h>
> +#include <linux/kmsg_dump.h>
>   
>   #include "setup.h"
>   
> @@ -744,6 +745,13 @@ static int ppc_panic_fadump_handler(struct notifier_block *this,
>   	 */
>   	hard_irq_disable();
>   
> +	/*
> +	 * Invoke kmsg_dump (e.g., pstore) before crash_fadump() as fadump
> +	 * runs before panic()'s kmsg_dump_desc() call.
> +	 */
> +	if (should_fadump_crash())
> +		kmsg_dump_desc(KMSG_DUMP_PANIC, (char *)ptr);
> +
>   	/*
>   	 * If firmware-assisted dump has been registered then trigger
>   	 * its callback and let the firmware handles everything else.

Changes look good to me.

Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

- Sourabh Jain

