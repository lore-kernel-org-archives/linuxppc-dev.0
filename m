Return-Path: <linuxppc-dev+bounces-21560-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356C6CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 09:21:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQPJP6wLKz2xLs;
	Wed, 27 May 2026 19:21:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779873701;
	cv=none; b=a+M+z1WMXrtzFV5+157+XJFWu9w5YxBDFM8aT0EnZ3awWPUnNk7A+xGnJawCnuk20Q11HM2AWnOPcSA3rsCtpNXwy/GI/fpt/NIMWWWlUtN47GLpbRgpJ3PjiNrPlJ215+uHZoBHl2bKgqL7xzb1hX4pu7vVi9YuZBynqAiCEfK6is2f1jYEh+89Bv7ln3J6xV7IDI731/J6ka7H2okBvBMIAlbcmcUOA0KualQhYas8NWjcXw+T1vUVwyS08F3Yym7OPqPHhS0ci4Fpck/O3PVbq7dPd7L5T5HPE2oj8AHWtFN2A0nVEoMHx3CvMcCar1uzvE3cpnkwV+rxwTkRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779873701; c=relaxed/relaxed;
	bh=sBtVQtrG2D+f9Z/sho+DSeJtMa0aOiwSm/AF9v+I85o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jC6E5FeWo/ZrulyHbeQEWY2rOw6kKO+r7Fs1in32vTtXNzoaz8z2RaQY1rTT0xHP636nxpUbACIJyA6lngHy6X1gk/tONfFFVbBssqA/1N6k2ulCBIu0RA73+Zz0f0qQDc2cpc0O6qaGYTvAd2+72TSHpsLkgL2dizn2pEDnspSSnHCMOPZwkBGhcMWMcPchlrCQuqt/5xNu6jLJmBMRcG9DqX6fS3cOMJjqrx75ZX3/XStdUKUuJqU01CfQ9jP0HxrjIgPzCvCd/u9fhHikY0ZM3nNDcJaidTXXLtrwsP631fGKnETPcex/neVBeraDeIUXT2bhq04sR9tOz0dlEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L8uPVvfh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L8uPVvfh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQPJM5bDgz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 19:21:38 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779873695; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sBtVQtrG2D+f9Z/sho+DSeJtMa0aOiwSm/AF9v+I85o=;
	b=L8uPVvfhx/nSeIhE2t47pQjBVOkK6OhwvvT9tBzWv3ltdU3bncOqgQ76fLoHQ+s3Pfe9iuxuvmrWw7tMRHb3qE/xm1mylSRh8h7VjsdzAhp40/2pNla7BSBwWnvZHEoQZTDYTZVt8ZS3fzivXcJGcql8naXIAD0RX+O1vOkRsJs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=29;SR=0;TI=SMTPD_---0X3jFQTK_1779873377;
Received: from 30.246.179.14(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X3jFQTK_1779873377 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 17:16:19 +0800
Message-ID: <1cc534eb-b323-4cf3-9301-77e3925c613b@linux.alibaba.com>
Date: Wed, 27 May 2026 17:16:14 +0800
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
Subject: Re: [PATCH v14 1/8] uaccess: add generic fallback version of
 copy_mc_to_user()
To: Ruidong Tian <tianruidong@linux.alibaba.com>, catalin.marinas@arm.com,
 will@kernel.org, rafael@kernel.org, tony.luck@intel.com,
 guohanjun@huawei.com, mchehab@kernel.org, tongtiangen@huawei.com,
 james.morse@arm.com, robin.murphy@arm.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, ryabinin.a.a@gmail.com, glider@google.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260518084956.2538442-1-tianruidong@linux.alibaba.com>
 <20260518084956.2538442-2-tianruidong@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260518084956.2538442-2-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/18/26 4:49 PM, Ruidong Tian wrote:
> From: Tong Tiangen <tongtiangen@huawei.com>
> 
> x86/powerpc has it's implementation of copy_mc_to_user(), we add generic
> fallback in include/linux/uaccess.h prepare for other architechures to
> enable CONFIG_ARCH_HAS_COPY_MC.
> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   arch/powerpc/include/asm/uaccess.h | 1 +
>   arch/x86/include/asm/uaccess.h     | 1 +
>   include/linux/uaccess.h            | 8 ++++++++
>   3 files changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index e98c628e3899..073de098d45a 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -432,6 +432,7 @@ copy_mc_to_user(void __user *to, const void *from, unsigned long n)
>   
>   	return n;
>   }
> +#define copy_mc_to_user copy_mc_to_user
>   #endif
>   
>   extern size_t copy_from_user_flushcache(void *dst, const void __user *src, size_t size);
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 3a0dd3c2b233..308b0854d1d5 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -496,6 +496,7 @@ copy_mc_to_kernel(void *to, const void *from, unsigned len);
>   
>   unsigned long __must_check
>   copy_mc_to_user(void __user *to, const void *from, unsigned len);
> +#define copy_mc_to_user copy_mc_to_user
>   #endif
>   
>   /*
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 56328601218c..c53a65394f80 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -250,6 +250,14 @@ copy_mc_to_kernel(void *dst, const void *src, size_t cnt)
>   }
>   #endif
>   
> +#ifndef copy_mc_to_user
> +static inline unsigned long __must_check
> +copy_mc_to_user(void *dst, const void *src, size_t cnt)
> +{
The prototype of this generic fallback diverges from both copy_to_user()
and the existing arch implementations of copy_mc_to_user() in two
non-trivial ways:

   1. The destination pointer drops the __user annotation.

      copy_to_user() is declared as:

          unsigned long copy_to_user(void __user *to,
                                     const void *from,
                                     unsigned long n);

      and arch/x86/include/asm/uaccess.h declares the arch version as:

          unsigned long copy_mc_to_user(void __user *to,
                                        const void *from,
                                        unsigned long len);

      With this fallback typed as 'void *dst', sparse will silently
      accept a kernel pointer being passed in, and the address-space
      check is effectively lost for any architecture that ends up using
      the fallback. The annotation is the whole point of __user; please
      keep it.

   2. The size parameter is 'size_t cnt' instead of 'unsigned long n'.

      copy_to_user() and the x86/ppc copy_mc_to_user() implementations
      all use 'unsigned long'. On all supported arches this happens to
      be the same width as size_t, so it is not a functional bug, but
      the inconsistent signature is a foot-gun: when an arch later
      switches from the fallback to its own implementation, every
      caller signature has to be re-checked.

Please align the fallback prototype exactly with the arch versions:

     #ifndef copy_mc_to_user
     static inline unsigned long __must_check
     copy_mc_to_user(void __user *dst, const void *src, unsigned long cnt)
     {
         return copy_to_user(dst, src, cnt);
     }
     #endif

With that fixed:

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

