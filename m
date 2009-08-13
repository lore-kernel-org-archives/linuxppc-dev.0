Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 585EDB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 16:44:16 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E681DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 16:44:14 +1000 (EST)
Subject: Re: [PATCH] Disable PowerMac cpufreq on SMP kernels
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bastian Blank <bastian@waldi.eu.org>
In-Reply-To: <20090811093931.GA15940@wavehammer.waldi.eu.org>
References: <20090811093931.GA15940@wavehammer.waldi.eu.org>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 16:14:58 +1000
Message-Id: <1250144098.3587.111.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-08-11 at 11:39 +0200, Bastian Blank wrote:
> The build of a PowerMac 32bit kernel currently fails with
> 
> error: #warning "WARNING, CPUFREQ not recommended on SMP kernels"
> 
> This patch just disables this driver on SMP kernels, as it is obviously
> not supported.
> 
> Signed-off-by: Bastian Blank <waldi@debian.org>

Why not remove the #error instead ? :-) I don't think it's still
meaningful, especially since we use the timebase for delays nowadays
which doesn't depend on the CPU frequency...

Ben.

> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index 04a8061..99d3564 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -149,7 +149,7 @@ menu "CPU Frequency drivers"
>  
>  config CPU_FREQ_PMAC
>  	bool "Support for Apple PowerBooks"
> -	depends on ADB_PMU && PPC32
> +	depends on ADB_PMU && PPC32 && !SMP
>  	select CPU_FREQ_TABLE
>  	help
>  	  This adds support for frequency switching on Apple PowerBooks,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
