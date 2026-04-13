Return-Path: <linuxppc-dev+bounces-19697-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521F0F34C4E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 13:50:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvTM46R0xz2ydn;
	Mon, 13 Apr 2026 23:50:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776088240;
	cv=none; b=i4LJStY84rGis3IEe5ndIgF9SzGgpa1w03zkkQsYSlw48XGrGX+tAdw2F77/WRHdaobA8d6AaF4EfcLVfPD3IqCgk0phkkcDCaKLZHkzpDsbFmNIwI6OV2IvNh9D+w1gRdsZNqsHAQioHG2zZCmRKwxgprIm0eNtyuBgbO0iLdEfvQeMk9UWDBhGyNKI0+ZYfGs8pnRhLDGZY2ZH9LVjLt95tKEgVx6SelOK1+LKFzQOwGdPAJqU6NX0t7Er7+VHqHNVGHlA05gDr4lNbtI2Uot84drZj9aTJUAkhSE8/vqxIjeYkbnWn9lHXDXspyAYnqsrTYRnAsSn/k/zo/BW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776088240; c=relaxed/relaxed;
	bh=+EZ8gw8rtWTyUUKs/HrQK6QCUmH2fnCQqiuyyO080JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZVu3KsgiLTwypVoAEdXhzg1dBYs8hs3P88B+IYWBo52QYfgZ/dFEVjT0bz28cNqw5cmfghJ7wa/9+y3lI5gS86HvVQ+X2P1ZVRQBOHpf+2ssk24Nrz+1rItN3EH23gwrl3TQ0xQpq/roOYtxLhgzYF4uQ1x5GBuLG3rSlureaUl3jxqKjn2AXwm6L9GvcMsXBIEP59+0d2OF/tN+AVQKXu0Fwma/b45tE9clA4hhliNevor0kk9TCaaCzqcs7AOgrZD6zFU6fI9WSKWzVbAjb/ucdw7klrUOIAhsbO27iOqAov2j1mBQ/4h35KLAmwy8v3h2woNE9KijsEmi6elrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j1/oj4eS; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j1/oj4eS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvTM362mLz2yS9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 23:50:38 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D6dGeX1218977;
	Mon, 13 Apr 2026 13:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+EZ8gw
	8rtWTyUUKs/HrQK6QCUmH2fnCQqiuyyO080JM=; b=j1/oj4eS0cwZmSvIzeYj14
	NAvroDziKfO8OD14ID6y+10qbS5mjfhJS6P8BvGXxLvUI2V9ssqX//y8KAJf1bAE
	EHtAomFILfPBJapkmt3UbGE4GMGAO+S3aJ03a/8L0DPgfDtNXyxzfCII4y8SnGtT
	k5daiJBqzqi70VvBIUmoCAwlrxCgLF0wYYBk9lnNoyFd13i5mJ2EBeh5W9xuEiE/
	zKU9jAOzH0tJaB6kWPUykkV9Yesx0SJb8LeSHaQPxk0OEVH0GY3uIFkK02/m0Ulh
	lP43QJVsvZklGY5BnCMLa//L1G/RxuUm14IaI9UkgSirmdRj7EY8YD+co80WkI1w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdyqqwt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 13:50:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DA9pJT025841;
	Mon, 13 Apr 2026 13:50:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1d4j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 13:50:27 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DDoPoH20578608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 13:50:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFB8320040;
	Mon, 13 Apr 2026 13:50:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1839E2004B;
	Mon, 13 Apr 2026 13:50:24 +0000 (GMT)
Received: from [9.39.26.130] (unknown [9.39.26.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 13:50:23 +0000 (GMT)
Message-ID: <98adc953-322b-45fa-9128-cdbe831006e1@linux.ibm.com>
Date: Mon, 13 Apr 2026 19:20:22 +0530
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
Subject: Re: [PATCH] powerpc/fadump: Add timeout to RTAS busy-wait loops
To: Adriano Vero <litaliano00.contact@gmail.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20260406061542.22354-1-litaliano00.contact@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260406061542.22354-1-litaliano00.contact@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ErTiaycA c=1 sm=1 tr=0 ts=69dcf4a4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=hkdMDd2yh4g0e7eiTwAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hws__Er0x7uFV0QJyU8OpKINCy5HnT93
X-Proofpoint-GUID: _3r5wMp-h4abPJobeBpjCJ8rp9G7CzxU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzNiBTYWx0ZWRfX8QdJF8kEEDDu
 r71dMxW++telCV/xbSue6kpadKwkh/zNepO+Qv2packDY0gey8LnwxUELtV0+LhNbtpOd9F9HrU
 yji2mnhVEy9BJax01MHsLVlZQ8GVm5VZOub6sC49vJ2WCMnR37OMb2WkO8owxze9QARrGh4cuYs
 AbaqUtjJZjd9IWFfHAfORlQL39bm96cngLTZGmmVJxIPQ+y5lEFox9NcjPcflOhwSWudo6VQ1eN
 FjP0C1NATrIh2IyobbjQ/SKMigd4hV3aQHhFSuwGsDiwDuQ2qbD6Y2pNMuaRJym/rNfm0Ly+Edv
 NwpT/f5i/s/A+9AcRzAxh8DNRsDfH84yXim4GtD2x74XMTbNH+ZZpDn5M877IPbqV3pIU3zkvNk
 otsuiNrkk2KCZDFxClVBV3E8md72fdFKlokluUPLMYm8lqBliodNON6O8yNlpcmq+RKbwRoN4Rh
 sQOriIk+q8fW2tCt6Cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130136

Hello Adriano

On 06/04/26 11:45, Adriano Vero wrote:
> The ibm,configure-kernel-dump RTAS call sites in
> rtas_fadump_register(), rtas_fadump_unregister(), and
> rtas_fadump_invalidate() polled indefinitely while firmware returned
> a busy status. A misbehaving or hung firmware could stall these paths
> forever, blocking fadump registration at boot or preventing clean
> teardown.

I agree that it is a good idea to avoid calling rtas_call for
fadump operations indefinitely. However, so far I have not come
across a case where the kernel gets stuck during fadump
registration, unregistration, or invalidation due to phyp/RTAS
continuously returning a wait time on an LPAR.

That said, since fadump support has recently been extended to
QEMU, this change might possibly prove useful in that environment.

>
> Track the accumulated delay in a total_wait counter and bail out with
> -ETIMEDOUT if it reaches RTAS_FADUMP_MAX_WAIT_MS (60 seconds)

What is the rationale behind choosing a 60-second limit?


> before
> firmware signals completion. This follows the bounded busy-wait pattern
> used in rtas-rtc.c.
>
> Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
> ---
>   arch/powerpc/platforms/pseries/rtas-fadump.c | 37 ++++++++++++++------
>   arch/powerpc/platforms/pseries/rtas-fadump.h |  6 ++++
>   2 files changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
> index eceb32893..b165f165c 100644
> --- a/arch/powerpc/platforms/pseries/rtas-fadump.c
> +++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
> @@ -181,7 +181,7 @@ static u64 rtas_fadump_get_bootmem_min(void)
>   
>   static int rtas_fadump_register(struct fw_dump *fadump_conf)
>   {
> -	unsigned int wait_time, fdm_size;
> +	unsigned int wait_time, total_wait, fdm_size;
>   	int rc, err = -EIO;
>   
>   	/*
> @@ -192,15 +192,20 @@ static int rtas_fadump_register(struct fw_dump *fadump_conf)
>   	fdm_size = sizeof(struct rtas_fadump_section_header);
>   	fdm_size += be16_to_cpu(fdm.header.dump_num_sections) * sizeof(struct rtas_fadump_section);
>   
> -	/* TODO: Add upper time limit for the delay */
> +	total_wait = 0;
>   	do {
>   		rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
>   				NULL, FADUMP_REGISTER, &fdm, fdm_size);
>   
>   		wait_time = rtas_busy_delay_time(rc);
> -		if (wait_time)
> +		if (wait_time) {
> +			if (total_wait >= RTAS_FADUMP_MAX_WAIT_MS) {
> +				pr_err("Timed out waiting for firmware to register fadump\n");
> +				return -ETIMEDOUT;
> +			}
> +			total_wait += wait_time;
>   			mdelay(wait_time);
> -
> +		}
>   	} while (wait_time);
>   
>   	switch (rc) {
> @@ -234,18 +239,24 @@ static int rtas_fadump_register(struct fw_dump *fadump_conf)
>   
>   static int rtas_fadump_unregister(struct fw_dump *fadump_conf)
>   {
> -	unsigned int wait_time;
> +	unsigned int wait_time, total_wait;
>   	int rc;
>   
> -	/* TODO: Add upper time limit for the delay */
> +	total_wait = 0;
>   	do {
>   		rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
>   				NULL, FADUMP_UNREGISTER, &fdm,
>   				sizeof(struct rtas_fadump_mem_struct));
>   
>   		wait_time = rtas_busy_delay_time(rc);
> -		if (wait_time)
> +		if (wait_time) {
> +			if (total_wait >= RTAS_FADUMP_MAX_WAIT_MS) {
> +				pr_err("Timed out waiting for firmware to unregister fadump\n");
> +				return -ETIMEDOUT;
> +			}
> +			total_wait += wait_time;
>   			mdelay(wait_time);
> +		}
>   	} while (wait_time);
>   
>   	if (rc) {
> @@ -259,18 +270,24 @@ static int rtas_fadump_unregister(struct fw_dump *fadump_conf)
>   
>   static int rtas_fadump_invalidate(struct fw_dump *fadump_conf)
>   {
> -	unsigned int wait_time;
> +	unsigned int wait_time, total_wait;
>   	int rc;
>   
> -	/* TODO: Add upper time limit for the delay */
> +	total_wait = 0;
>   	do {
>   		rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
>   				NULL, FADUMP_INVALIDATE, fdm_active,
>   				sizeof(struct rtas_fadump_mem_struct));
>   
>   		wait_time = rtas_busy_delay_time(rc);
> -		if (wait_time)
> +		if (wait_time) {
> +			if (total_wait >= RTAS_FADUMP_MAX_WAIT_MS) {
> +				pr_err("Timed out waiting for firmware to invalidate fadump\n");
> +				return -ETIMEDOUT;
> +			}
> +			total_wait += wait_time;
>   			mdelay(wait_time);
> +		}
>   	} while (wait_time);

This do...while loop is almost identical in all three places.
Would it make sense to introduce a helper function to wrap the
rtas_call, along with handling the wait time and timeout?

- Sourabh Jain

>   	if (rc) {
> diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.h b/arch/powerpc/platforms/pseries/rtas-fadump.h
> index c109abf6b..65fdab7b5 100644
> --- a/arch/powerpc/platforms/pseries/rtas-fadump.h
> +++ b/arch/powerpc/platforms/pseries/rtas-fadump.h
> @@ -41,6 +41,12 @@
>   #define MAX_SECTIONS				10
>   #define RTAS_FADUMP_MAX_BOOT_MEM_REGS		7
>   
> +/*
> + * Maximum time to wait for firmware to respond to an
> + * ibm,configure-kernel-dump RTAS call before giving up.
> + */
> +#define RTAS_FADUMP_MAX_WAIT_MS			60000U
> +
>   /* Kernel Dump section info */
>   struct rtas_fadump_section {
>   	__be32	request_flag;



