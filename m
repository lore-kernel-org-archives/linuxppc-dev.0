Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQ30n5S8FzDw0Y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 15:26:01 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tQ30n17lGz9t2C
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2016 15:26:00 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAP4Nemf074714
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2016 23:25:59 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26x7t04r7h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2016 23:25:58 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Fri, 25 Nov 2016 09:55:55 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2B8B2394004E
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2016 09:55:53 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAP4PrKT27984086
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2016 09:55:53 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAP4Pqd5015606
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2016 09:55:52 +0530
Subject: Re: [PATCH] powerpc: Fix __cmpxchg() to take a volatile ptr again
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1480043229-2363-1-git-send-email-mpe@ellerman.id.au>
Cc: xinhui.pan@linux.vnet.ibm.com, peterz@infradead.org
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Fri, 25 Nov 2016 12:26:04 +0800
MIME-Version: 1.0
In-Reply-To: <1480043229-2363-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <480bd5a3-1981-e716-9049-cbd5877cd122@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/11/25 11:07, Michael Ellerman 写道:
> In commit d0563a1297e2 ("powerpc: Implement {cmp}xchg for u8 and u16")
> we removed the volatile from __cmpxchg().
>
> This is leading to warnings such as:
>
>   drivers/gpu/drm/drm_lock.c: In function ‘drm_lock_take’:
>   arch/powerpc/include/asm/cmpxchg.h:484:37: warning: passing argument 1
>   of ‘__cmpxchg’ discards ‘volatile’ qualifier from pointer target
>      (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,   \
>
> There doesn't seem to be consensus across architectures whether the
> argument is volatile or not, so at least for now put the volatile back.
>
> Fixes: d0563a1297e2 ("powerpc: Implement {cmp}xchg for u8 and u16")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
Hi, mpe
	We implement __cmpxchg in asm so volatile maybe is not needed I think.
But seems compiler is not happy :(
I am okay with your patch. thanks!

>  arch/powerpc/include/asm/cmpxchg.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
> index c12f110261b2..fc46b664c49e 100644
> --- a/arch/powerpc/include/asm/cmpxchg.h
> +++ b/arch/powerpc/include/asm/cmpxchg.h
> @@ -14,7 +14,7 @@
>  #endif
>
>  #define XCHG_GEN(type, sfx, cl)				\
> -static inline u32 __xchg_##type##sfx(void *p, u32 val)		\
> +static inline u32 __xchg_##type##sfx(volatile void *p, u32 val)	\
>  {								\
>  	unsigned int prev, prev_mask, tmp, bitoff, off;		\
>  								\
> @@ -40,7 +40,7 @@ static inline u32 __xchg_##type##sfx(void *p, u32 val)		\
>
>  #define CMPXCHG_GEN(type, sfx, br, br2, cl)			\
>  static inline							\
> -u32 __cmpxchg_##type##sfx(void *p, u32 old, u32 new)		\
> +u32 __cmpxchg_##type##sfx(volatile void *p, u32 old, u32 new)	\
>  {								\
>  	unsigned int prev, prev_mask, tmp, bitoff, off;		\
>  								\
> @@ -399,7 +399,7 @@ __cmpxchg_u64_acquire(u64 *p, unsigned long old, unsigned long new)
>  #endif
>
>  static __always_inline unsigned long
> -__cmpxchg(void *ptr, unsigned long old, unsigned long new,
> +__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
>  	  unsigned int size)
>  {
>  	switch (size) {
>
