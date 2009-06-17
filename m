Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 27EFAB7180
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 00:11:11 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E622DDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 00:11:10 +1000 (EST)
Message-Id: <A731338A-E954-46D9-8BF7-6E74C797209C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 1/6] perf_counter: powerpc: Enable use of software
	counters on 32-bit powerpc
Date: Wed, 17 Jun 2009 09:10:49 -0500
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 17, 2009, at 6:50 AM, Paul Mackerras wrote:

> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/ 
> platforms/Kconfig.cputype
> index cca6b4f..dd9f3ec 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -1,7 +1,7 @@
> config PPC64
> 	bool "64-bit kernel"
> 	default n
> -	select HAVE_PERF_COUNTERS
> +	select PPC_HAVE_PMU_SUPPORT
> 	help
> 	  This option selects whether a 32-bit or a 64-bit kernel
> 	  will be built.
> @@ -243,6 +243,15 @@ config VIRT_CPU_ACCOUNTING
>
> 	  If in doubt, say Y here.
>
> +config PPC_HAVE_PMU_SUPPORT
> +       bool

what does this mean?

> +
> +config PPC_PERF_CTRS
> +       def_bool y
> +       depends on PERF_COUNTERS && PPC_HAVE_PMU_SUPPORT
> +       help
> +         This enables the powerpc-specific perf_counter back-end.

Can we distinguish between the two different architected perf counters  
programming models to start with.  Maybe something like:

PPC_BOOK3S_PERF_CTRS and PPC_BOOK3E_PERF_CTRS (or  
PPC_SERVER_PERF_CTRS / PPC_EMB_PERF_CTRS)


>
> +
> config SMP
> 	depends on PPC_STD_MMU || FSL_BOOKE
> 	bool "Symmetric multi-processing support"
> -- 
> 1.6.0.4
>
