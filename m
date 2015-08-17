Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 193331A0372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 13:52:45 +1000 (AEST)
Message-ID: <1439783558.14494.2.camel@ellerman.id.au>
Subject: Re: [PATCH v5 11/11] cxl: Add CONFIG_CXL_EEH symbol
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com
Date: Mon, 17 Aug 2015 13:52:38 +1000
In-Reply-To: <1439538087-32137-12-git-send-email-dja@axtens.net>
References: <1439538087-32137-1-git-send-email-dja@axtens.net>
 <1439538087-32137-12-git-send-email-dja@axtens.net>
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

On Fri, 2015-08-14 at 17:41 +1000, Daniel Axtens wrote:
> CONFIG_CXL_EEH is for CXL's EEH related code.
> 
> Other drivers can depend on or #ifdef on this symbol to configure
> PERST behaviour, allowing CXL to participate in the EEH process.
> 
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/misc/cxl/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
> index b6db9ebd52c2..c151fc1fe14c 100644
> --- a/drivers/misc/cxl/Kconfig
> +++ b/drivers/misc/cxl/Kconfig
> @@ -11,11 +11,17 @@ config CXL_KERNEL_API
>  	bool
>  	default n
>  
> +config CXL_EEH
> +	bool
> +	default n
> +	select EEH

I'd rather we didn't have select EEH here, instead ..

>  config CXL
>  	tristate "Support for IBM Coherent Accelerators (CXL)"
>  	depends on PPC_POWERNV && PCI_MSI

It should be a dependency here.

In practice it won't make any difference with the current way the options are
defined, but I think it's the right way to do it.

I'm happy to fix it up if you're OK with it.

>  	select CXL_BASE
>  	select CXL_KERNEL_API
> +	select CXL_EEH
>  	default m
>  	help
>  	  Select this option to enable driver support for IBM Coherent


cheers
