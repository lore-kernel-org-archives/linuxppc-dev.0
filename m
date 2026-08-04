Return-Path: <linuxppc-dev+bounces-25336-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB70C55ABA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 07:22:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDlPS52P6z2xyk;
	Tue, 04 Aug 2026 17:22:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785828172;
	cv=none; b=K5sjS2YN8EX/h6M8qwIzyinYeNBz7m1hitzN1nNl3iJ87x6uCCGIXj3cNpPYRtgwpCFs20+vUrovLJbUVAuVcBoBRGereTcUj46XPNE6czuKek2Ugt8gRQPk2oGD/LzgmdeeZPlOLW0ZFfPbRNkSutpJbRUnPJKuykkOK8BNzPmijxuiZEy3IZOb8xRa1Z2apyOB6rd0tuOuo05iWktvtu91fEuksY6nNuTVnCspos13SO+uX/o2keaQicB29QtZpcHUJvLKtZh3QKjflQUCe+WZbkcvQq/51uLGYcOpqbImwv4r9fqADHXF5//KDBC4xZ/W4+oBlI+ydsFAoPhGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785828172; c=relaxed/relaxed;
	bh=FF4mte/YAvCiWPVv4NUHVQAwQXlO96DfYKG+GS5xQjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUvohMTLjuPGraRyZRs5D1z9sc5SrsbCMMwHAWll83zKZ+ehJ95+UtCZn1BXr+7WdOIWK0aw7h2WueQLSYA7WxKqcVaHha6n2Z5K7ebWPgGvZwMd+IMeBXDrXcKy/Nll8TyxC7W2rwjBneQpdTncoimFopMCiajxfvpfTp//lR1kqxAVZgfX/2U8JWHiLkG6sGHnwlcL8s4C46+E0Q/daJbHFFCCDVMdo1mmdmPwEt88wEz80wdRYcTu4jNNZwb7YWhC0RM3eWKnkDe9hCIbVST+HvOE8TriXOf14VlRX0cwvAzJuFU642XPFbXRhSa2U263oeA7P6RcC5DwZrrxrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S12QK4xO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S12QK4xO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDlPR1Xznz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 17:22:50 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741HxRK3656474;
	Tue, 4 Aug 2026 07:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FF4mte
	/YAvCiWPVv4NUHVQAwQXlO96DfYKG+GS5xQjs=; b=S12QK4xOW99ldMM3wqL7kp
	vH6Yd1uok9chW3IkHmcqs7Y2OAkL4Bd9Ue6SuOgGa/jGWdMn9pT75oIKQGYpXN/0
	XgX8mg5D2404YcqNz6frGHnSZG4MV1mKOZNus1g8dZrTeSjjZCRE+UbTXoW6u074
	vC25ofWxRGAAvK7mY1uYd0MTQT8PG1JwAbBCA0K6lIizhlW41Tl58RVUCaMSC8He
	OivLzB1DGls1NZbXm23M0rzuQmtYcWDZI53zxJJKJxrtVvmCIZ5a7D8/CfwpqdMu
	1I5lQ5CwJlK/19HPIvAsl1w3ri8Y7lMhYmEOuNcmWXKq+SrEiS5s1AUL/zavlJ9g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4vnft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:22:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6747BIJD003950;
	Tue, 4 Aug 2026 07:22:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh8uyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:22:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6747MVCq47710622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:22:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8830E2004E;
	Tue,  4 Aug 2026 07:22:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD1432004D;
	Tue,  4 Aug 2026 07:22:26 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 07:22:26 +0000 (GMT)
Message-ID: <9c12964a-f35a-464a-8e65-e0e9fa674819@linux.ibm.com>
Date: Tue, 4 Aug 2026 12:52:25 +0530
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
Subject: Re: [PATCH v3 2/5] powerpc/rtas: Allocate ibm,errinjct buffer below
 RTAS limit
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
 <20260721033815.5300-3-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260721033815.5300-3-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX7TZYi84FRuJ+
 uLgX21O+RsCj3JONMRQNACVgogvkHvlMyAkjHjQH4TYaAs4kZVhSSbE2ROA/0yMYTUscpvIahMX
 9fFK5Vn9aOAT0waxv1hISGVHekWherI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfXwVXGZAL/F+PQ
 TuLdKzEpzZggbbDlS6qopeQW71RcFUo2aqQFMBWkEzzerFXsHyT5It0A0Pmvb9RPrdPAWYvgRN2
 gKgBblJhwORR5cBgYO6ahF4QaT1pVhvX/AWNLUWXiAQ8sN0b4CAxtA0eB9MFolIMLyz9flJzGq7
 VuTIWsUQPY2TvICo3Qmw5FmBlgIH1Cd8zH0smUp3fjLN/ABm/wkFazMU2xAJY83yjaNl3X/U1a7
 xKzYRCZ/tTIKcdndla0iBrfQBAq9p07mqp4WlWy+I3FVLK969+Ax2l4BTvyFiRktULcfN44h67j
 RJxyLjOqzCOBmy0r3jJ89ogO8p0mNAwnQcLFeGJZwrYsp0TMQeNORPC067FcXQUk4Hb9wVVd7yA
 WkWVKiLVJjzRGYjrIJjWAlWRULp7vZDXP03pwHhN24zgXpJlcAlEnAO8XswTWN4BrHhuJAdR+ZL
 eC3xwaBYGzWHgCrYBzg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a71933f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=AJuEv9vbMc6cggR83QoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: v55rQc8x0FR4cqG8W96SdwT3T1yV5-CI
X-Proofpoint-GUID: wnRX7nmYnQdnhPCMtxcDKhpXdOqHs1fv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040057

Hello Narayana,

How about using the rtas_work_area_alloc() instead of allocating a new 
dedicated buffer
for errinjct only?

Checkout Commit 43033bc62d34 ("powerpc/pseries: add RTAS work area 
allocator") for
infrastructure to allocated working buffer.

Also checkout commit e27e14231eb5 ("powerpc/pseries/dlpar: use RTAS work 
area API")
on how to use work area API.

- Sourabh Jain

On 21/07/26 09:08, Narayana Murty N wrote:
> ibm,errinjct requires a caller-provided work buffer whose physical
> address is passed to RTAS firmware.
>
> A static C array such as:
>
>    char rtas_errinjct_buf[1024] __aligned(SZ_1K);
>
> only guarantees alignment, not physical placement.  If the array lands
> above the RTAS-safe range (RTAS_INSTANTIATE_MAX, 1 GB) or above 4 GB,
> RTAS receives a truncated or invalid address and the injection call
> will fail silently or corrupt memory.
>
> Instead, introduce rtas_errinjct_buf as a global unsigned long storing
> the physical address allocated during rtas_initialize() using
> memblock_phys_alloc_range() with the same rtas_region upper bound used
> for rtas_rmo_buf.  This matches the existing placement model for
> RTAS-accessible buffers and guarantees the physical address fits in 32
> bits.
>
>    Usage:
>      void *buf    = __va(rtas_errinjct_buf);       /* kernel VA to fill */
>      u32  buf_phys = lower_32_bits(rtas_errinjct_buf); /* PA for RTAS */
>
> Always check upper_32_bits(rtas_errinjct_buf) == 0 before passing the
> lower 32 bits to RTAS.
>
> Add rtas_errinjct_mutex to serialise the complete open-session /
> inject / close-session firmware call sequence.  A mutex is required
> because the sequence involves multiple rtas_call() invocations with
> possible busy/extended-delay retries that may sleep.
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/rtas.h | 26 ++++++++++++++++++++++++++
>   arch/powerpc/kernel/rtas.c      | 17 +++++++++++++++++
>   2 files changed, 43 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index d046bbd5017d..59e3c1296018 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -4,6 +4,7 @@
>   #ifdef __KERNEL__
>   
>   #include <linux/mutex.h>
> +#include <linux/sizes.h>
>   #include <linux/spinlock.h>
>   #include <asm/page.h>
>   #include <asm/rtas-types.h>
> @@ -519,6 +520,31 @@ int rtas_get_error_log_max(void);
>   extern spinlock_t rtas_data_buf_lock;
>   extern char rtas_data_buf[RTAS_DATA_BUF_SIZE];
>   
> +/*
> + * RTAS error-injection work buffer.
> + *
> + * ibm,errinjct requires a caller-provided work buffer whose physical
> + * address is passed to firmware.  A static C array only guarantees
> + * alignment, not physical placement; if it lands above the RTAS-safe
> + * range or above 4 GB, RTAS receives a truncated or bogus address.
> + *
> + * rtas_errinjct_buf stores the physical address allocated during
> + * rtas_initialize() using memblock_phys_alloc_range() with the same
> + * rtas_region upper bound used for rtas_rmo_buf, matching the existing
> + * placement model for RTAS-accessible buffers.
> + *
> + * Use __va(rtas_errinjct_buf) to obtain the kernel virtual address for
> + * filling the buffer, and lower_32_bits(rtas_errinjct_buf) to pass the
> + * physical address to RTAS (after checking upper_32_bits() == 0).
> + *
> + * rtas_errinjct_mutex must be held across the complete
> + * ibm,open-errinjct / ibm,errinjct / ibm,close-errinjct sequence.
> + */
> +#define RTAS_ERRINJCT_BUF_SIZE	SZ_1K
> +
> +extern unsigned long rtas_errinjct_buf;
> +extern struct mutex rtas_errinjct_mutex;
> +
>   /* RMO buffer reserved for user-space RTAS use */
>   extern unsigned long rtas_rmo_buf;
>   
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 27d53f34494d..7883f973e8c9 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -769,6 +769,17 @@ EXPORT_SYMBOL_GPL(rtas_data_buf);
>   
>   unsigned long rtas_rmo_buf;
>   
> +/*
> + * Physical address of the ibm,errinjct work buffer.  Allocated during
> + * rtas_initialize() using memblock_phys_alloc_range() below rtas_region
> + * so the address fits in 32 bits and is safe to pass to RTAS firmware.
> + */
> +unsigned long rtas_errinjct_buf;
> +EXPORT_SYMBOL_GPL(rtas_errinjct_buf);
> +
> +DEFINE_MUTEX(rtas_errinjct_mutex);
> +EXPORT_SYMBOL_GPL(rtas_errinjct_mutex);
> +
>   /*
>    * If non-NULL, this gets called when the kernel terminates.
>    * This is done like this so rtas_flash can be a module.
> @@ -2109,6 +2120,12 @@ void __init rtas_initialize(void)
>   		panic("ERROR: RTAS: Failed to allocate %lx bytes below %pa\n",
>   		      PAGE_SIZE, &rtas_region);
>   
> +	rtas_errinjct_buf = memblock_phys_alloc_range(RTAS_ERRINJCT_BUF_SIZE,
> +						      SZ_1K, 0, rtas_region);
> +	if (!rtas_errinjct_buf)
> +		panic("ERROR: RTAS: Failed to allocate %lu bytes below %pa\n",
> +		      (unsigned long)RTAS_ERRINJCT_BUF_SIZE, &rtas_region);
> +
>   	rtas_work_area_reserve_arena(rtas_region);
>   }
>   


