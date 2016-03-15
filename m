Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPhkR2pr2zDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 04:41:35 +1100 (AEDT)
Message-ID: <1458063685.12370.28.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 15 Mar 2016 12:41:25 -0500
In-Reply-To: <20160315130750.0E43C1A2375@localhost.localdomain>
References: <20160315130750.0E43C1A2375@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2] powerpc/8xx: Fix do_mtspr_cpu6 build on older compilers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-15 at 14:07 +0100, Christophe Leroy wrote:
> Some versions of GCC, reportedly before 4.8, fail with
> arch/powerpc/mm/8xx_mmu.c:139:2: error: memory input 1 is not directly
> addressable

"before 4.8" means "< 4.8", not "<= 4.8" -- did you mean "before 4.9"?

> Change the one-element array into a simple variable to avoid this.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Scott Wood <oss@buserror.net>
> ---
> Verified with GCC 4.4.4 and GCC 4.8.3
> 
> v2: compilation result is compliant with CPU6 ERRATA
>     (using stw/lwz and not stwx/lwzx)
> 
>  arch/powerpc/include/asm/reg_8xx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/reg_8xx.h
> b/arch/powerpc/include/asm/reg_8xx.h
> index d41412c..94d01f8 100644
> --- a/arch/powerpc/include/asm/reg_8xx.h
> +++ b/arch/powerpc/include/asm/reg_8xx.h
> @@ -53,7 +53,7 @@
>  #ifdef CONFIG_8xx_CPU6
>  #define do_mtspr_cpu6(rn, rn_addr, v)	\
>  	do {								
> \
> -		int _reg_cpu6 = rn_addr, _tmp_cpu6[1];		\
> +		int _reg_cpu6 = rn_addr, _tmp_cpu6;		\
>  		asm volatile("stw %0, %1;"				\
>  			     "lwz %0, %1;"				\
>  			     "mtspr " __stringify(rn) ",%2" :		
> \

I thought I tried this with 4.7.2 without success, but now it seems to be
working...

-Scott
