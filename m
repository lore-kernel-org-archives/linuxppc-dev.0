Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C63EFDDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 19:47:11 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id n3U9kXfG010157
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 19:46:33 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3U9lAqD475298
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 19:47:10 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3U9lAUc014701
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 19:47:10 +1000
Message-ID: <49F973A0.8070106@in.ibm.com>
Date: Thu, 30 Apr 2009 15:17:12 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
Subject: Re: Next April 28: boot failure on PowerPC with SLQB
References: <20090428165343.2e357d7a.sfr@canb.auug.org.au>
	<49F6E421.401@in.ibm.com>
	<84144f020904280422s6a9a277fjc4619c904f37e5ca@mail.gmail.com>
	<20090429113604.GE3398@wotan.suse.de> <49F87FAB.9050408@in.ibm.com>
	<20090430041146.GB23746@wotan.suse.de>
	<49F938E4.2030703@in.ibm.com>
	<20090430064127.GF23746@wotan.suse.de>
In-Reply-To: <20090430064127.GF23746@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Christoph Lameter <cl@linux-foundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick Piggin wrote:
> Hmm, forget that. Actually my last patch had a silly mistake because I
> forgot MAX_ORDER shift is applied to PAGE_SIZE, rather than 1. So
> kmalloc(PAGE_SIZE) was failing as too large.
>
> This patch should do the trick I hope.
>   
Yes this patch fixed the issue for me. Thanks Nick.

Regards
-Sachin
> Thanks,
> Nick
> ---
>  include/linux/slqb_def.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Index: linux-2.6/include/linux/slqb_def.h
> ===================================================================
> --- linux-2.6.orig/include/linux/slqb_def.h
> +++ linux-2.6/include/linux/slqb_def.h
> @@ -172,7 +172,8 @@ struct kmem_cache {
>  #endif
>
>  #define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
> -#define KMALLOC_SHIFT_SLQB_HIGH (PAGE_SHIFT + 9)
> +#define KMALLOC_SHIFT_SLQB_HIGH (PAGE_SHIFT + 			\
> +				 ((9 <= (MAX_ORDER - 1)) ? 9 : (MAX_ORDER - 1)))
>
>  extern struct kmem_cache kmalloc_caches[KMALLOC_SHIFT_SLQB_HIGH + 1];
>  extern struct kmem_cache kmalloc_caches_dma[KMALLOC_SHIFT_SLQB_HIGH + 1];
> --
> To unsubscribe from this list: send the line "unsubscribe linux-next" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
