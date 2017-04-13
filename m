Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3hkS25qpzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 23:40:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3w3hkR72S3z9s83
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2017 23:40:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH 1/3] powerpc: Allow platforms to force-enable
 CONFIG_SMP
In-Reply-To: <1491360291-30299-1-git-send-email-mpe@ellerman.id.au>
References: <1491360291-30299-1-git-send-email-mpe@ellerman.id.au>
Date: Thu, 13 Apr 2017 23:40:31 +1000
Message-ID: <874lxs8lyo.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> Of the 64-bit Book3S platforms, only powermac supports booting on an
> actual non-SMP system. The other platforms can be built with SMP
> disabled, but it doesn't make a lot of sense given the CPUs they support
> are all multicore or multithreaded.
>
> So give platforms the option of forcing SMP=y.

For the record I'm planning to merge this.

cheers

> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 99b0ae8acb78..5c011e4baf0b 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -371,9 +371,15 @@ config PPC_PERF_CTRS
>         help
>           This enables the powerpc-specific perf_event back-end.
>  
> +config FORCE_SMP
> +	# Allow platforms to force SMP=y by selecting this
> +	bool
> +	default n
> +	select SMP
> +
>  config SMP
>  	depends on PPC_BOOK3S || PPC_BOOK3E || FSL_BOOKE || PPC_47x
> -	bool "Symmetric multi-processing support"
> +	bool "Symmetric multi-processing support" if !FORCE_SMP
>  	---help---
>  	  This enables support for systems with more than one CPU. If you have
>  	  a system with only one CPU, say N. If you have a system with more
> -- 
> 2.7.4
