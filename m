Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3hWx2MNNzDqB9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 23:31:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: Use relon prolog for
 EXC_VIRT_OOL_MASKABLE_HV handlers
In-Reply-To: <20170413094548.10616-1-npiggin@gmail.com>
References: <20170413094548.10616-1-npiggin@gmail.com>
Date: Thu, 13 Apr 2017 23:31:23 +1000
Message-ID: <877f2o8mdw.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> Hypervisor Virtualization and Directed Hypervisor Doorbell interrupt
> handlers use the macro EXC_VIRT_OOL_MASKABLE_HV for their relocation-on
> handlers, which calls MASKABLE_RELON_EXCEPTION_HV_OOL, which uses the
> real mode interrupt prolog.
>
> Use the RELON variant instead to reduce overhead.
>
> Fixes: 1707dd1613 ("powerpc: Save CFAR before branching in interrupt entry paths")
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>
> I was hesitant about using the Fixes: tag on this one because it's not
> a correctness bug as far as I can see.

Fixes can just mean "if you have this other commit you'll most likely
want this one too".

You can clarify the degree of Fixness in the change log, which then
allows a backporter to decide if they want it or not.

In this case I think it's entirely right, this is a fairly unfortunate
bug from a performance point of view if I'm reading it right.

cheers

> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 14752eee3d0c..b89c91e27dd0 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -522,7 +522,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
>  
>  #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label)			\
>  	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
> -	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
> +	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_HV)
>  
>  /*
>   * Our exception common code can be passed various "additions"
> -- 
> 2.11.0
