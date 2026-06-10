Return-Path: <linuxppc-dev+bounces-22377-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76493CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 03:27:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZrnl020kz2xjN;
	Wed, 10 Jun 2026 13:27:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781062074;
	cv=none; b=Nupr3Gr3WeSCYWM3hPIJxvIz96DpAbkSZZJIJJSiYSpu/L/r/rYoSUjPhkNZbMg4+ZyucHDB9BLNZ9FRkEZgKDtkHFtJMcie4cvGgP+3czHelJAX5tfqdwEYBBbcggyq7DlnAxpv2ugUE0Ki0xvHDemAkJdql0DO1qmOVm7IsmsbiuIneV7GDifn85Ax4qlGHmMmvNmyzSmeEJihPgw6Ltr/gOyLnWh3DL3Akn7olKYnlqC3S8lwdMlplRcRCKh3Lf133VfWad0aeikQ4cUfuQqIbcPa3Wi6xS0kt07O+JbvYuZHg88TFK/DXTfC/F7Rl1cquSR44a/rdy/qYy0oYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781062074; c=relaxed/relaxed;
	bh=t7XENIVf0zxZMc5dYQEhCjed03kxPleg5s3aznuIQKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bK3B2x2GbeH0VRjGwIMjSYZo6vBJbg2b24EC6f80vEoeN7v+GCkugXuzJ6NbQyF/vCFWS3W88Hzs0gEpxaV2DpR8swP9PYsS8p0gYrAe9p3e9DnE4zg+de1IQVObAW9XjdXgQA3zvPqG1r7F4/Q5K0PNpdT8OSyP8XdTQC/umBQH7UkGlNhicCKPMcZuv68zv3TH4wHRoBXsj+2BopgfIP39pBbbDsr+hN+EciyJBNIMf72BQN4Eep6LY+iZ6Eli0YXVg5DvMiiMzwhHrLb/j9Kz4ZQ9oLAPpjqJwnDBGdJJir0dEPSkQ3hi2AJwNYoTkR1QPmhqn6X12ZR39zTM5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m0t5W4Sa; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m0t5W4Sa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZrnj2yB2z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 13:27:52 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659KOurP1207171;
	Wed, 10 Jun 2026 03:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t7XENI
	Vf0zxZMc5dYQEhCjed03kxPleg5s3aznuIQKI=; b=m0t5W4SaXnWGY6yFpEkh9y
	tk2aZi1FplDb6l0j0RlGOTsULarc3hSDcIkW7w/aeOH29laNiBgYqJB6c+mSnBGO
	LfZFotizpdzxZzMrlgeVtwV9+rbDKciHiacFOiFHuaaKAKqwte331lK2YlN1ur2l
	kui4TzSdTuncuA02K5vK33NqHeHD5o+xKDy/qX3oOrKOsAu0TYJPwhaF0N4dBrtn
	aMvDEsyQheh6av6fnJd8tG8RIA/KMmUrlg/uZj/uUKdO6yAkr/UIs9KXXSOMp53n
	LNlYdUHdnHfiF/OZXKH6AJsonMQpqUY5VFgnbU6vcq5bXuU7MAMQNI0BWP+ZvlIA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sxub8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 03:27:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A3Ja2b001326;
	Wed, 10 Jun 2026 03:27:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g4q2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 03:27:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A3RSw913500788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 03:27:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 598ED20043;
	Wed, 10 Jun 2026 03:27:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 147F520040;
	Wed, 10 Jun 2026 03:27:25 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 03:27:24 +0000 (GMT)
Message-ID: <fd32da15-9952-4d46-9c28-5c2aa87fad0c@linux.ibm.com>
Date: Wed, 10 Jun 2026 08:57:16 +0530
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
Subject: Re: [PATCH v2 2/5] powerpc/pseries: Add RTAS error injection buffer
 infrastructure
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
 <20260527072433.94510-3-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260527072433.94510-3-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Rte-Ya6BT5T-kDB2zWOQz-S6bAuDn2FS
X-Proofpoint-GUID: Lr8Gg_g1RzjGkY32IhuujpCQF74zzeBT
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a28d9a5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=-4-zj0xmguQsN-WDZPEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDAyNiBTYWx0ZWRfX5Nh8bKYVZ/SJ
 bbVujHEwiARN7YLS1ej2t/H93LitrWIUtGsiav/G/Kjs3RWIrlmVqJRImE+bihV4gunMlg22pdk
 zymQamH+owHhdx28Co2M95kI1S0TM0krH/hztjsYxANUUJSkRoJxLyRoVk85gMcV2m5VzsiXTw6
 PKMbxI/QW70sUUrzam7kAC/j1rBo8Wi69oaXysxmjSEKcH4riIn5UmTdM+QQbn+QibEzWrnnkbU
 dTUAhAfYabX4jqeQs2NRzrl4lZPX2u9c1JDJEELmQTaIvmS6p199SC7GO1Xj3CWQCsyg+OulvkB
 LrV65gOf1PfEHLIbVHfukk0FsJN1DzE1g0/XYJw27+/QyWt9J2wG/n7ShP1amJMNNpnN97pz3dV
 Ngu0zie2RAQITlh3BQibs0NjaiYlaizqCbRIkIUP0rx0ouqu7qNjT9F/zqWUWsiGoYS8NKGzVlE
 JH1hxZUl6V0UKC37sKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100026



On 27/05/26 12:54, Narayana Murty N wrote:
> Adds global infrastructure required by the injection engine:
>   - a 1KB aligned RTAS working buffer in rtas.c
>   - a spinlock to serialize buffer access
>   - UAPI definitions for error-injection tokens (added to eeh.h)
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/rtas.h     | 21 +++++++++++++++++++++
>   arch/powerpc/include/uapi/asm/eeh.h | 18 ++++++++++++++++++
>   arch/powerpc/kernel/rtas.c          | 12 ++++++++++++
>   3 files changed, 51 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index d046bbd5017d..82512f822c7a 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -519,6 +519,27 @@ int rtas_get_error_log_max(void);
>   extern spinlock_t rtas_data_buf_lock;
>   extern char rtas_data_buf[RTAS_DATA_BUF_SIZE];
>   
> +/*
> + * RTAS Error Injection Buffer (PAPR-compliant)
> + * ============================================
> + *
> + * 1KB aligned, zero-initialized buffer for ibm,errinjct RTAS work area.
> + * Protected by rtas_errinjct_buf_lock for concurrent access safety.
> + *
> + * PAPR Requirement: ibm,errinjct requires a caller-allocated buffer passed
> + * via physical address. Buffer must accommodate largest error type layouts:
> + * - IOA bus error (64-bit): 8x32-bit words (32 bytes)
> + * - All other types: <=4x32-bit words (16 bytes)
> + *
> + * Usage:
> + * prepare_errinjct_buffer() -> spin_lock() -> rtas_call() -> spin_unlock()
> + *
> + * Alignment: SZ_1K ensures PAPR firmware requirements and cache-line safety.
> + */
> +#define RTAS_ERRINJCT_BUF_SIZE 1024
> +extern spinlock_t rtas_errinjct_buf_lock;
> +extern char rtas_errinjct_buf[RTAS_ERRINJCT_BUF_SIZE];

The kernel has a similar buffer for userspace (named rtas_rmo_buf),
which is allocated in the range (0, min(ppc64_rma_size, 
RTAS_INSTANTIATE_MAX)).

Whereas, the base address of the statically allocated rtas_errinjct_buf 
array
depends on the location at which the kernel is loaded, which could be 
higher than
RTAS_INSTANTIATE_MAX.

Also, things will break if the base address of rtas_errinjct_buf is 
greater than
4 GB. In that case, the kernel will send a truncated address, and RTAS may
corrupt memory as a result.

Why don't we allocate rtas_errinjct_buf in the same range where
rtas_rmo_buf is allocated?
> +
>   /* RMO buffer reserved for user-space RTAS use */
>   extern unsigned long rtas_rmo_buf;
>   
> diff --git a/arch/powerpc/include/uapi/asm/eeh.h b/arch/powerpc/include/uapi/asm/eeh.h
> index 3b5c47ff3fc4..86645cab2827 100644
> --- a/arch/powerpc/include/uapi/asm/eeh.h
> +++ b/arch/powerpc/include/uapi/asm/eeh.h
> @@ -41,4 +41,22 @@
>   #define EEH_ERR_FUNC_DMA_WR_TARGET	19
>   #define EEH_ERR_FUNC_MAX		19
>   
> +/* RTAS PCI Error Injection Token Types */
> +#define RTAS_ERR_TYPE_FATAL                     0x1
> +#define RTAS_ERR_TYPE_RECOVERED_RANDOM_EVENT    0x2
> +#define RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT   0x3
> +#define RTAS_ERR_TYPE_CORRUPTED_PAGE            0x4
> +#define RTAS_ERR_TYPE_CORRUPTED_SLB             0x5
> +#define RTAS_ERR_TYPE_TRANSLATOR_FAILURE        0x6
> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR             0x7
> +#define RTAS_ERR_TYPE_PLATFORM_SPECIFIC         0x8
> +#define RTAS_ERR_TYPE_CORRUPTED_DCACHE_START    0x9
> +#define RTAS_ERR_TYPE_CORRUPTED_DCACHE_END      0xA
> +#define RTAS_ERR_TYPE_CORRUPTED_ICACHE_START    0xB
> +#define RTAS_ERR_TYPE_CORRUPTED_ICACHE_END      0xC
> +#define RTAS_ERR_TYPE_CORRUPTED_TLB_START       0xD
> +#define RTAS_ERR_TYPE_CORRUPTED_TLB_END         0xE
> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR_64          0xF
> +#define RTAS_ERR_TYPE_UPSTREAM_IO_ERROR         0x10
> +
>   #endif /* _ASM_POWERPC_EEH_H */
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index a2dd94eed9d0..c110965ea1d9 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -769,6 +769,18 @@ EXPORT_SYMBOL_GPL(rtas_data_buf);
>   
>   unsigned long rtas_rmo_buf;
>   
> +/*
> + * RTAS Error Injection Buffer - Global Definitions
> + * Global 1KB buffer and spinlock for ibm,errinjct RTAS service.
> + * Exported for pseries EEH error injection usage.
> + */
> +
> +DEFINE_SPINLOCK(rtas_errinjct_buf_lock);
> +EXPORT_SYMBOL_GPL(rtas_errinjct_buf_lock);
> +
> +char rtas_errinjct_buf[1024] __aligned(SZ_1K);
> +EXPORT_SYMBOL_GPL(rtas_errinjct_buf);
> +
>   /*
>    * If non-NULL, this gets called when the kernel terminates.
>    * This is done like this so rtas_flash can be a module.


