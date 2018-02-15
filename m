Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhlZg5vNMzF1JQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 16:44:11 +1100 (AEDT)
Received: by mail-it0-x241.google.com with SMTP id w63so4208567ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 21:44:11 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id k66sm14524126itd.8.2018.02.14.21.44.07
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Feb 2018 21:44:08 -0800 (PST)
Subject: Re: [PATCH kernel] powerpc/lpar/debug: Initialize flags before
 printing debug message
To: linuxppc-dev@lists.ozlabs.org
References: <20180109055214.32199-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <02c29823-8290-0f4b-b484-a9115a78e4b7@ozlabs.ru>
Date: Thu, 15 Feb 2018 16:44:05 +1100
MIME-Version: 1.0
In-Reply-To: <20180109055214.32199-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/01/18 16:52, Alexey Kardashevskiy wrote:
> With enabled DEBUG, there is a compile error:
> "error: ‘flags’ is used uninitialized in this function".
> 
> This moves pr_devel() little further where @flags are initialized.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Ping?


> ---
> 
> /home/aik/p/guest-kernel/arch/powerpc/platforms/pseries/lpar.c: In function ‘pSeries_lpar_hpte_updatepp’:
> /home/aik/p/guest-kernel/include/linux/printk.h:320:2: error: ‘flags’ is used uninitialized in this function [-Werror=un
> initialized]
>   printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>   ^
> /home/aik/p/guest-kernel/arch/powerpc/platforms/pseries/lpar.c:304:16: note: ‘flags’ was declared here
>   unsigned long flags;
>                 ^
> ---
>  arch/powerpc/platforms/pseries/lpar.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index 0ee4a46..1365424 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -306,14 +306,14 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
>  
>  	want_v = hpte_encode_avpn(vpn, psize, ssize);
>  
> +	flags = (newpp & 7) | H_AVPN;
> +	if (mmu_has_feature(MMU_FTR_KERNEL_RO))
> +		/* Move pp0 into bit 8 (IBM 55) */
> +		flags |= (newpp & HPTE_R_PP0) >> 55;
> +
>  	pr_devel("    update: avpnv=%016lx, hash=%016lx, f=%lx, psize: %d ...",
>  		 want_v, slot, flags, psize);
>  
> -	flags = (newpp & 7) | H_AVPN;
> -	if (mmu_has_feature(MMU_FTR_KERNEL_RO))
> -		/* Move pp0 into bit 8 (IBM 55) */
> -		flags |= (newpp & HPTE_R_PP0) >> 55;
> -
>  	lpar_rc = plpar_pte_protect(flags, slot, want_v);
>  
>  	if (lpar_rc == H_NOT_FOUND) {
> 


-- 
Alexey
