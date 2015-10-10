Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 258C51A05C5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2015 17:20:41 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 10 Oct 2015 16:20:39 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BCA4F357804F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2015 17:20:34 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9A6KPm841877694
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2015 17:20:34 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9A6K1Hv007096
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2015 17:20:01 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>, cmetcalf@ezchip.com,
 paulus@samba.org, scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Quick fix upstream main line build error on
 PowerPC
In-Reply-To: <1444359309-40375-1-git-send-email-dongsheng.wang@freescale.com>
References: <1444359309-40375-1-git-send-email-dongsheng.wang@freescale.com>
Date: Sat, 10 Oct 2015 11:49:40 +0530
Message-ID: <87pp0nz1mr.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dongsheng Wang <dongsheng.wang@freescale.com> writes:

> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>
> This issue caused on 'commit 990486c8af04 ("strscpy: zero any trailing
> garbage bytes in the destination")'.
>
> zero_bytemask is not implemented on PowerPC. So copy the zero_bytemask
> of BIG_ENDIAN implementation from include/asm-generic/word-at-a-time.h
> to arch/powerpc/include/asm/word-at-a-time.h.
>
> Build message:
> lib/string.c: In function 'strscpy':
> lib/string.c:209:4: error: implicit declaration of function
> 	'zero_bytemask' [-Werror=implicit-function-declaration]
> 	*(unsigned long *)(dest+res) = c & zero_bytemask(data);
> cc1: some warnings being treated as errors
> make[1]: *** [lib/string.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>
> diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
> index 5b3a903..d891456 100644
> --- a/arch/powerpc/include/asm/word-at-a-time.h
> +++ b/arch/powerpc/include/asm/word-at-a-time.h
> @@ -40,6 +40,10 @@ static inline bool has_zero(unsigned long val, unsigned long *data, const struct
>  	return (val + c->high_bits) & ~rhs;
>  }
>  
> +#ifndef zero_bytemask
> +#define zero_bytemask(mask) (~1ul << __fls(mask))
> +#endif
> +
>  #else


Why #ifndef zero_bytemask ?. What will override zero_bytemask defined in
arch headers. We generally do it such that generic code does #ifndef, but arch
headers doesn't need to do this.

-aneesh
  
