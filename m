Return-Path: <linuxppc-dev+bounces-20550-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32052CD342C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 04:16:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9zT75c6jz2yrD;
	Thu, 07 May 2026 14:16:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778127371;
	cv=none; b=IrCs6eGarYhNVt6zuu+rXkyhwdqJsicMbl28UzUmSPlehAQ2YCBrZxai+PQfVww5D8yI6ZnKHwSBNBFQEi9IfcwPaCf1xckZS1YegPvOV25LgChU7Mxq4twYlsKRfaPaKR60nifsBHaell3x0l50r7m4rLQesHNdUVwuwMBnc0/qwnjbTJJ7Hr2GOGpYkZZrzN4lUGvCOrrhXNJERbnJGSBodIU386zyMxkm8hER7wuk2lBCo8NMauMUoOVh12VQxEjgTVNMZ5QFjTYkJ90GZ/oJ1y56pw5ew7/lIXhqDvW54f8E7F5gBYZ8p+797+gnyba92nA9rB2dBH6nz6CmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778127371; c=relaxed/relaxed;
	bh=wwEL7Rmv29TE336O9VGxP41xRd1jP2eVaTq0SDkZBUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRiaQnOhxIbmiEeWdYQEIm2nByVHF0FmQBoXWKo8dcZvSeiNEA4GUDE5CGd7/LuJiTBudx05PQicUVN90DVRpct8fj8XYJR053pNa1mD9SA8vY4TBMpQqQn6MVYu4PpFnw+VBXD+3GWlvcphAX6U7NjEWVrkXGQv1hJtvUAo15LmaIy2Zpw896MEy5wtavdhYvJXuaGVJNNnfyhr1xIMUr8X81LmtCy9f7ta2LZMwIu0Y402gC01QN1eIkbexpigYVVBOr/xREIGdC8Rnc1MxVzRXN6NzYBLDYhlm9mhDdCy1hnD6jAor3NAdA/geCu+TKjbvivkjyEKJYv4pfmMVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BpkBbzdW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BpkBbzdW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9zT65j2wz2xlm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 14:16:10 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646K1qZF2235166;
	Thu, 7 May 2026 04:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wwEL7R
	mv29TE336O9VGxP41xRd1jP2eVaTq0SDkZBUA=; b=BpkBbzdW05D8nNi2gVEl4Y
	u9CIfEbjz+bT5cMX2xm0CYx+KMOlLufGmGbUCDTKG+OXc0FGD0SRLy8Kh756sE88
	/MmkwfxmJDb0DS187wjn2QqQVmyugLLc+RPzLQ+v8QW1aV6MN5EO79mbyGYh9844
	5+7G/rSmDVlXrtI09fGSSsdrY928OEDDoJqMl9p47+GSsN7oQWH1Cs7NdOD9vUZH
	ieetQZWGGpnHZZm1MiaUByKb5/DXz/tCcLCa4PXnCdJZclzeK0tMLPWJfrqhuEW2
	wtDdtmfx8PJ8gnJB6RvgfPPwV61X3x70deXdAne5JbfNZErShBBH1b6cFIbiCR5g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1m3q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 04:16:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64749Y1N019644;
	Thu, 7 May 2026 04:15:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk1cv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 04:15:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6474FvaC51970490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 04:15:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47AB520049;
	Thu,  7 May 2026 04:15:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0497120040;
	Thu,  7 May 2026 04:15:55 +0000 (GMT)
Received: from [9.39.23.70] (unknown [9.39.23.70])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 04:15:54 +0000 (GMT)
Message-ID: <a582e27b-fb51-473a-802c-6ffb83e7ce63@linux.ibm.com>
Date: Thu, 7 May 2026 09:45:53 +0530
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
Subject: Re: [PATCH v3] powerpc/fadump: Add timeout to RTAS busy-wait loops
To: Adriano Vero <adri.vero.dev@gmail.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20260419065039.23495-1-adri.vero.dev@gmail.com>
 <20260506222024.30352-1-adri.vero.dev@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260506222024.30352-1-adri.vero.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Ho0tM30KDKkwUpsgHa5Hr2MX9wnHY-4K
X-Proofpoint-GUID: NimJqW55oNkagq6F5PYdkq-Juda9dKbp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAzNyBTYWx0ZWRfX0Xv4gQIJHsqY
 IkMUZkEM387ZlItyXd25CC04CO/e0pe9/dQrK0/v/s2jlpI5VznX//6jnQypviavtO8PQtk7k0L
 0W7CRggMRsUVcpMRsKTcM5FKTKvap3VjX6SrTRI55V4e8fp89ONKoS2wpJv7+oUO3kfjD/A4uqW
 titXpiOL+kElBbSOidNcxaH+qeVGaA17+gLea8/6v4HM2ChDU6kjNzpN4Mfhy3WSSXUKpz6wcWk
 ongWCmVTa2KySsQWLZnUQq08CUfN860uO1q3NyC8r2esBFhE28cPjDyBu9X6J6/Et4hQ9lKHTZ7
 ueMtxr/5mQKHaOnyuBUwdhIQfn0rBAu+e8mL3r7V+nnVrRE8p5wfERPx+zWxeiBPsY9/IjYU7B0
 y/PHMjpaiNB8FXiG4vOwOyo1deLHaTsNWR+vhv8de4IyxHM9urmFaS8O0wPBs5xeS0cUbK0G73g
 17jlJ0PSSic/plSsGqw==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fc1200 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=ntDPK0L32HZQNU6beJgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070037

Hello Adriano,

On 07/05/26 03:50, Adriano Vero wrote:
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
>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

New line between tags is unnecessary.

Including a Changelog in subsequent versions of the same patch is
helpful for the maintainer and reviewers to understand what has changed
in this version compared to the previous version.

For example:
https://lore.kernel.org/all/20260407124349.1698552-1-sourabhjain@linux.ibm.com/

Thanks,
Sourabh Jain

> ---
>   arch/powerpc/platforms/pseries/rtas-fadump.c | 80 ++++++++++++--------
>   arch/powerpc/platforms/pseries/rtas-fadump.h |  6 ++
>   2 files changed, 53 insertions(+), 33 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
> index eceb3289383e..3bb4ac2ab6cc 100644
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
> index c109abf6befd..65fdab7b5b8d 100644
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


