Return-Path: <linuxppc-dev+bounces-20530-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C223CD3439
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 19:22:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9ld53x0Cz2xdL;
	Thu, 07 May 2026 05:22:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778095337;
	cv=none; b=h17oapPCmKut5r5PKqNDC2F8ThF46PsDsyBF084cHBWC4U5fPw4WjA/BYGqoiIlJHz+gBEjQFYv/MnLBWOeSGwH6DxljGtPpYO1RAiU+DKnfiQuR3j4dOxjOCPeNDZOy8RjDi6UJIQ3mRkICvOunskAf3Ea6sMNpcj05vW4XDMfy80D5z9LFD3PVMrLT8C+7r6zWyHDhFFRsy8knG+8fjNRc/2a4EA3JqhL/IMBAfebCO3Q472DQh/2OJi3uZyz4VUhCNMybTMK6x/w7FZ8FguBdiCCt0QU79uCBNgChXLePCKhRJNkkUW4BzndjiPcFgPRA8IND6bRwl2Bf1WIN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778095337; c=relaxed/relaxed;
	bh=qII2gNA/yTzZl5k1d2JjfcTWv1gsduBv0/XU8Z1//3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkGPjn9DrMjENsK0+Xwc55RSFZB+8x/yOyyqtSVQrRT5l0Wip9RpA6C+qwufGYRIkuocmyua3M6rTfRQ+nQXaXrXdNxBwX6DoUF7vKCbz3XXiFRZ7DiKcM77NLgaX7KFtR7a1FFtILwBSap2pu0YjByU++Xjc2n+2PegV20j+pFVAJvyRxzOOzRXB25tg1aKK/UHRd6N+OUl71b4fcxDkRKqoXQtaHEwxgA8dWu4dx0/C5ogoM5Z1kMEZjdh6nQlM04ZozkQEYawv5cWtMhrTP9rEa6t7Ey4YKyC+vyZtkE6AH6+rJ5FMorCggdny74sllQ9ZCvO18d1F3e9pMQT4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dvxPCuPv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dvxPCuPv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9ld45BNtz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 05:22:15 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646HjNjv1011760;
	Wed, 6 May 2026 19:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qII2gN
	A/yTzZl5k1d2JjfcTWv1gsduBv0/XU8Z1//3M=; b=dvxPCuPvSqoeqTHnKfxt/I
	RGkTRotVYpNqsZd5bxor/LquNZyL/8sYjaGt6TlfdLAzPyTVzf8oqXX0owc1yGQM
	4sQA9TZONDwo0I5l1e/RuFM4rsQmFanN/CfQdPGyWtuenTXC8k82zDN+gIl6n/Vf
	7vjIhZYlv2/ILD/ZsQPvXgjn0vuBlMqpI4vWRT+KmhPsErk1ft/Sm2YK3SdMx3Rn
	8DkSmRaitnJ4/BvsxcoqfXcstJZj9ErrHZxh1m5bbw0c3aLE8NcFMZU5SDb86Li6
	jdukiJYqqdcYFKZtNfRB0p9Y37S7MCxszc5niU9w3ouoI04SikwN5IoXRgopVMQA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4spj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 19:22:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646J9U7M005280;
	Wed, 6 May 2026 19:22:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw7srd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 19:22:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646JM0DV49414542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 19:22:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5342F20043;
	Wed,  6 May 2026 19:22:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C411920040;
	Wed,  6 May 2026 19:21:57 +0000 (GMT)
Received: from [9.124.209.73] (unknown [9.124.209.73])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 19:21:57 +0000 (GMT)
Message-ID: <7bef2ce2-1fd3-4648-8c78-d3c5e07a1f9f@linux.ibm.com>
Date: Thu, 7 May 2026 00:51:55 +0530
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
Subject: Re: [PATCH v2] powerpc/fadump: Add timeout to RTAS busy-wait loops
To: Adriano Vero <adri.vero.dev@gmail.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20260406061542.22354-1-litaliano00.contact@gmail.com>
 <20260419065039.23495-1-adri.vero.dev@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260419065039.23495-1-adri.vero.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4NyBTYWx0ZWRfX5KbN/bh6cT3T
 Yqk7zD21WyoYLGCR8h3OIJdGyXztvt+XYUEWwwh5Yr8iXQ3njCOYaNPTE3bJ+khL64EJe8OEGY2
 zzsG0os+ID+C58WM/XHrUx5/CyxJtoKOX7kcYB6FIW6sbLjldvkHpZwAEGC0cl4+rtlC45ZdBEW
 9EK5Rs7lYBH4QmRAeWUZz3a2t85Gk6hPNtrDqKdyLlyjQQ5bvpX0HpyFF6WMRd6U9rrjc6Tg9ZS
 K9XW90QwuA1S/+a2O2YEPTwPQz/ueRldK39T2lSgY070mpGFpiobbgU1usvchgTB7wRqbSzSmDG
 K5D4xWq2ugpf5fkWErof8aovALRG1JRzf6ivgyFokK1WydtBUrmasqlCtpacljb/vQw6kRZsZL6
 Cs6/1p+ADYIhmSATn0Tuz58EIDsZnx0q+wClWmkhFaqv3mEu3gyqwVSnCwopSB5v9d7PgoR+epq
 dPUiH1rahPFi8heP81Q==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fb94db cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=2weaD-oI5XvQ2TJmH0sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ia2UIzHSQ0ExLMhG53H9KQ7AEopCBSRm
X-Proofpoint-ORIG-GUID: 7Iat4JjmCeDpU60oFpuROP7TUkLOGCt8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060187



On 19/04/26 12:20, Adriano Vero wrote:
> The ibm,configure-kernel-dump RTAS call sites in
> rtas_fadump_register(), rtas_fadump_unregister(), and
> rtas_fadump_invalidate() polled indefinitely while firmware returned
> a busy status. A misbehaving or hung firmware could stall these paths
> forever, blocking fadump registration at boot or preventing clean
> teardown.
>
> Introduce rtas_fadump_call(), a helper that wraps the common
> busy-wait pattern shared by all three sites. The helper accumulates
> the total delay and returns -ETIMEDOUT if firmware keeps returning a
> busy status beyond RTAS_FADUMP_MAX_WAIT_MS (60 seconds). A pr_debug()
> message is emitted on each busy iteration to aid diagnosis when the
> timeout is hit.
>
> Signed-off-by: Adriano Vero <adri.vero.dev@gmail.com>
> ---
>   arch/powerpc/platforms/pseries/rtas-fadump.c | 80 ++++++++++++--------
>   arch/powerpc/platforms/pseries/rtas-fadump.h |  6 ++
>   2 files changed, 53 insertions(+), 33 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
> index eceb32893..3bb4ac2ab 100644
> --- a/arch/powerpc/platforms/pseries/rtas-fadump.c
> +++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
> @@ -179,9 +179,42 @@ static u64 rtas_fadump_get_bootmem_min(void)
>   	return RTAS_FADUMP_MIN_BOOT_MEM;
>   }
>   
> +/*
> + * Helper to make an ibm,configure-kernel-dump RTAS call with a bounded
> + * busy-wait loop. Returns the RTAS return code on completion, or
> + * -ETIMEDOUT if firmware keeps returning a busy status beyond
> + * RTAS_FADUMP_MAX_WAIT_MS milliseconds.
> + */
> +static int rtas_fadump_call(struct fw_dump *fadump_conf, int operation,
> +			    void *fdm_ptr, unsigned int fdm_size,
> +			    const char *op_name)
> +{
> +	unsigned int wait_time, total_wait = 0;
> +	int rc;
> +
> +	do {
> +		rc = rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
> +			       NULL, operation, fdm_ptr, fdm_size);
> +		wait_time = rtas_busy_delay_time(rc);
> +		if (wait_time) {
> +			pr_debug("Firmware busy during fadump %s, waiting %ums (total %ums)\n",
> +				 op_name, wait_time, total_wait);
> +			if (total_wait >= RTAS_FADUMP_MAX_WAIT_MS) {
> +				pr_err("Timed out waiting for firmware to complete fadump %s\n",
> +				       op_name);
> +				return -ETIMEDOUT;
> +			}
> +			total_wait += wait_time;
> +			mdelay(wait_time);
> +		}
> +	} while (wait_time);
> +
> +	return rc;
> +}
> +
>   static int rtas_fadump_register(struct fw_dump *fadump_conf)
>   {
> -	unsigned int wait_time, fdm_size;
> +	unsigned int fdm_size;
>   	int rc, err = -EIO;
>   
>   	/*
> @@ -192,16 +225,10 @@ static int rtas_fadump_register(struct fw_dump *fadump_conf)
>   	fdm_size = sizeof(struct rtas_fadump_section_header);
>   	fdm_size += be16_to_cpu(fdm.header.dump_num_sections) * sizeof(struct rtas_fadump_section);
>   
> -	/* TODO: Add upper time limit for the delay */
> -	do {
> -		rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
> -				NULL, FADUMP_REGISTER, &fdm, fdm_size);
> -
> -		wait_time = rtas_busy_delay_time(rc);
> -		if (wait_time)
> -			mdelay(wait_time);
> -
> -	} while (wait_time);
> +	rc = rtas_fadump_call(fadump_conf, FADUMP_REGISTER, &fdm, fdm_size,
> +			      "register");
> +	if (rc == -ETIMEDOUT)
> +		return -ETIMEDOUT;
>   
>   	switch (rc) {
>   	case 0:
> @@ -234,19 +261,12 @@ static int rtas_fadump_register(struct fw_dump *fadump_conf)
>   
>   static int rtas_fadump_unregister(struct fw_dump *fadump_conf)
>   {
> -	unsigned int wait_time;
>   	int rc;
>   
> -	/* TODO: Add upper time limit for the delay */
> -	do {
> -		rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
> -				NULL, FADUMP_UNREGISTER, &fdm,
> -				sizeof(struct rtas_fadump_mem_struct));
> -
> -		wait_time = rtas_busy_delay_time(rc);
> -		if (wait_time)
> -			mdelay(wait_time);
> -	} while (wait_time);
> +	rc = rtas_fadump_call(fadump_conf, FADUMP_UNREGISTER, &fdm,
> +			      sizeof(struct rtas_fadump_mem_struct), "unregister");
> +	if (rc == -ETIMEDOUT)
> +		return -ETIMEDOUT;
>   
>   	if (rc) {
>   		pr_err("Failed to un-register - unexpected error(%d).\n", rc);
> @@ -259,19 +279,13 @@ static int rtas_fadump_unregister(struct fw_dump *fadump_conf)
>   
>   static int rtas_fadump_invalidate(struct fw_dump *fadump_conf)
>   {
> -	unsigned int wait_time;
>   	int rc;
>   
> -	/* TODO: Add upper time limit for the delay */
> -	do {
> -		rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
> -				NULL, FADUMP_INVALIDATE, fdm_active,
> -				sizeof(struct rtas_fadump_mem_struct));
> -
> -		wait_time = rtas_busy_delay_time(rc);
> -		if (wait_time)
> -			mdelay(wait_time);
> -	} while (wait_time);
> +	rc = rtas_fadump_call(fadump_conf, FADUMP_INVALIDATE,
> +			      (void *)fdm_active,
> +			      sizeof(struct rtas_fadump_mem_struct), "invalidate");
> +	if (rc == -ETIMEDOUT)
> +		return -ETIMEDOUT;
>   
>   	if (rc) {
>   		pr_err("Failed to invalidate - unexpected error (%d).\n", rc);
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

Changes look good to me.

Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

While testing this patch I realized that fadump prints below message 
when registered is successfully
<rtas/opal> fadump: Registration is successful

But there is no message when fadump is unregistered successfully. I 
think it is good to
log that event.  I will send a separate patch for this.

- Sourabh Jain

