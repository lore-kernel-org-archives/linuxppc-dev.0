Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbC8B2WwSzDsXd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 21:03:54 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id 21so2078099pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 04:03:54 -0700 (PDT)
Date: Fri, 16 Sep 2016 21:03:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 10/13] powerpc: Add "bitmask" paramater to MASKABLE_*
 macros
Message-ID: <20160916210344.5689fbd8@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-11-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-11-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 15 Sep 2016 18:32:00 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Make it explicit the interrupt masking supported
> by a gievn interrupt handler. Patch correspondingly
> extends the MASKABLE_* macros with an addition's parameter.
> "bitmask" parameter is passed to SOFTEN_TEST macro to decide
> on masking the interrupt.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/exception-64s.h | 62 ++++++++++++++++----------------
>  arch/powerpc/kernel/exceptions-64s.S     | 36 ++++++++++++-------
>  2 files changed, 54 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 1eea4ab75607..41be0c2d7658 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -179,9 +179,9 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
>   * checking of the interrupt maskable level in the SOFTEN_TEST.
>   * Intended to be used in MASKABLE_EXCPETION_* macros.
>   */
> -#define __EXCEPTION_PROLOG_1(area, extra, vec)				\
> +#define __EXCEPTION_PROLOG_1(area, extra, vec, bitmask)			\
>  	__EXCEPTION_PROLOG_1_PRE(area);					\
> -	extra(vec);							\
> +	extra(vec, bitmask);						\
>  	__EXCEPTION_PROLOG_1_POST(area);
>  
>  /*

Is __EXCEPTION_PROLOG_1 now for maskable exceptions, and EXCEPTION_PROLOG_1
for unmaskable? Does it make sense to rename __EXCEPTION_PROLOG_1 to
MASKABLE_EXCEPTION_PROLOG_1? Reducing the mystery underscores in this file would
be nice!

This worked out nicely with mask bit being passed in by the exception handlers.
Very neat.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
