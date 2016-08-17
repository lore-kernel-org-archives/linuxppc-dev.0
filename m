Return-Path: <cyrilbur@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDb215gw2zDsXN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 13:54:01 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id vy10so6178072pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 20:54:01 -0700 (PDT)
Message-ID: <1471406034.23206.2.camel@gmail.com>
Subject: Re: [PATCH v3 04/21] powerpc: Return the new MSR from
 msr_check_and_set()
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: Anton Blanchard <anton@samba.org>, Michael Neuling <mikey@neuling.org>
Date: Wed, 17 Aug 2016 13:53:54 +1000
In-Reply-To: <20160817034323.23053-5-cyrilbur@gmail.com>
References: <20160817034323.23053-1-cyrilbur@gmail.com>
 <20160817034323.23053-5-cyrilbur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-17 at 13:43 +1000, Cyril Bur wrote:

I obviously didn't proof read that one. This commit message should have
read:

mfmsr() is a fairly expensive call and callers of msr_check_and_set()
may want to make decisions based on the MSR bits that it did not change
but may not know the value of.

This patch would avoid two calls to mfmsr().

> mfmsr() is a fairly expensive call and callers of msr_check_and_set()
> may want to make decisions bits in the MSR that it did not change but
> may not know the value of.
> 
> This patch would avoid a two calls to mfmsr().
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  arch/powerpc/include/asm/reg.h | 2 +-
>  arch/powerpc/kernel/process.c  | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h
> b/arch/powerpc/include/asm/reg.h
> index f69f40f..0a3dde9 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1247,7 +1247,7 @@ static inline void mtmsr_isync(unsigned long
> val)
>  				     : "memory")
>  #endif
>  
> -extern void msr_check_and_set(unsigned long bits);
> +extern unsigned long msr_check_and_set(unsigned long bits);
>  extern bool strict_msr_control;
>  extern void __msr_check_and_clear(unsigned long bits);
>  static inline void msr_check_and_clear(unsigned long bits)
> diff --git a/arch/powerpc/kernel/process.c
> b/arch/powerpc/kernel/process.c
> index 82308fd..c42581b 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -110,7 +110,7 @@ static int __init enable_strict_msr_control(char
> *str)
>  }
>  early_param("ppc_strict_facility_enable",
> enable_strict_msr_control);
>  
> -void msr_check_and_set(unsigned long bits)
> +unsigned long msr_check_and_set(unsigned long bits)
>  {
>  	unsigned long oldmsr = mfmsr();
>  	unsigned long newmsr;
> @@ -124,6 +124,8 @@ void msr_check_and_set(unsigned long bits)
>  
>  	if (oldmsr != newmsr)
>  		mtmsr_isync(newmsr);
> +
> +	return newmsr;
>  }
>  
>  void __msr_check_and_clear(unsigned long bits)
