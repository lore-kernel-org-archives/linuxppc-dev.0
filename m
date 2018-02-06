Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zbPHT1KFBzF0xv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 23:42:28 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id h129so2288726ita.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Feb 2018 04:42:28 -0800 (PST)
Subject: Re: [PATCH] powerpc/64s: Fix MASKABLE_RELON_EXCEPTION_HV_OOL macro
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <1517920597-14588-1-git-send-email-maddy@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8238543e-7027-010b-a6ab-95e87fdad693@ozlabs.ru>
Date: Tue, 6 Feb 2018 23:42:20 +1100
MIME-Version: 1.0
In-Reply-To: <1517920597-14588-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/18 23:36, Madhavan Srinivasan wrote:
> Commit f14e953b191f ("powerpc/64s: Add support to take additional parameter in MASKABLE_* macro")
> messed up MASKABLE_RELON_EXCEPTION_HV_OOL macro by adding the wrong
> __SOFTEN__ test which caused guest kernel trash at boot. Patch to fix
> the macro to use SOFTEN_TEST_HV instead of SOFTEN_NOTEST_HV.
> 
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Fix-Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/exception-64s.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 176dfb73d42c..471b2274fbeb 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -645,7 +645,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
>  					  EXC_HV, SOFTEN_TEST_HV, bitmask)
>  
>  #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label, bitmask)		\
> -	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec, bitmask);\
> +	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
>  	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_HV)
>  
>  /*
> 

Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>

-- 
Alexey
