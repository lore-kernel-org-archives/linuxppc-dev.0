Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E4D01007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 13:40:59 +1100 (EST)
Subject: Re: [PATCH 0/4] powerpc: Fix minor build issues on 2.6.32-rc7
	without CONFIG_XICS set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <20091118170510.GA1119@csn.ul.ie>
References: <1258459659-11770-1-git-send-email-mel@csn.ul.ie>
	<1258524332.2140.663.camel@pasglop> <20091118170510.GA1119@csn.ul.ie>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Nov 2009 13:40:26 +1100
Message-ID: <1259289626.2076.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-11-18 at 17:05 +0000, Mel Gorman wrote:

> 
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index 04a8061..a82c470 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -52,9 +52,9 @@ config PPC_UDBG_BEAT
>  	default n
>  
>  config XICS
> -	depends on PPC_PSERIES
> +	depends on PCI_MSI
>  	bool
> -	default y
> +	default n

Why the above ? XICS only exist on PSERIES and select bypass depends in
nasty ways anyways.

>  config IPIC
>  	bool
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index f0e6f28..81c2289 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -5,6 +5,8 @@ config PPC_PSERIES
>  	select PPC_I8259
>  	select PPC_RTAS
>  	select RTAS_ERROR_LOGGING
> +	select PCI_MSI
> +	select XICS
>  	select PPC_UDBG_16550
>  	select PPC_NATIVE
>  	select PPC_PCI_CHOICE if EMBEDDED

The above bits look plenty enough. Can you also stick it next to the
MPIC one ?

Cheers,
Ben.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
