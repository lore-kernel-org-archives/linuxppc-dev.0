Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZPfr1w9fzDsWb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 13:54:12 +1000 (AEST)
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sZPfq5Ksxz9s8x
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 13:54:11 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id oz2so1548794pac.0
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2016 20:54:11 -0700 (PDT)
Date: Thu, 15 Sep 2016 13:54:03 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Don't change the section in _GLOBAL()
Message-ID: <20160915135403.172e2e3e@roar.ozlabs.ibm.com>
In-Reply-To: <1473900020-3281-1-git-send-email-mpe@ellerman.id.au>
References: <1473900020-3281-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 15 Sep 2016 10:40:20 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Currently the _GLOBAL() macro unilaterally sets the assembler section to
> ".text" at the start of the macro. This is rude as the caller may be
> using a different section.
> 
> So let the caller decide which section to emit the code into. On big
> endian we do need to switch to the ".opd" section to emit the OPD, but
> do that with pushsection/popsection, thereby leaving the original
> section intact.
> 
> The only place I could find where this requires changes to the code is
> in misc_32.S, where we need to switch back to ".text" after
> flush_icache_range() which is in ".kprobes.text".
> 
> I verified that the order of all entries in System.map is unchanged
> after this patch. The actual addresses shift around slightly so you
> can't just diff the System.map.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Excellent, thanks for going through it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
> 
> If anyone can think of a better method to verify we are still emitting
> everything in the same sections let me know.
> 
> 
>  arch/powerpc/include/asm/ppc_asm.h | 8 ++------
>  arch/powerpc/kernel/misc_32.S      | 3 +++
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> index d5d5b5e348f2..479287045166 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -201,14 +201,12 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
>  #ifdef PPC64_ELF_ABI_v2
>  
>  #define _GLOBAL(name) \
> -	.section ".text"; \
>  	.align 2 ; \
>  	.type name,@function; \
>  	.globl name; \
>  name:
>  
>  #define _GLOBAL_TOC(name) \
> -	.section ".text"; \
>  	.align 2 ; \
>  	.type name,@function; \
>  	.globl name; \
> @@ -232,16 +230,15 @@ name:
>  #define GLUE(a,b) XGLUE(a,b)
>  
>  #define _GLOBAL(name) \
> -	.section ".text"; \
>  	.align 2 ; \
>  	.globl name; \
>  	.globl GLUE(.,name); \
> -	.section ".opd","aw"; \
> +	.pushsection ".opd","aw"; \
>  name: \
>  	.quad GLUE(.,name); \
>  	.quad .TOC.@tocbase; \
>  	.quad 0; \
> -	.previous; \
> +	.popsection; \

I think you can still use .section and .previous here, but it's
much of a muchness.
