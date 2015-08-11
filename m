Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA83D1A026C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 13:58:07 +1000 (AEST)
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com
 [IPv6:2607:f8b0:400e:c02::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 29B4614032B
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 13:58:07 +1000 (AEST)
Received: by pdrg1 with SMTP id g1so78685077pdr.2
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 20:58:05 -0700 (PDT)
Date: Tue, 11 Aug 2015 13:59:00 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com
Subject: Re: [PATCH v2 10/10] cxl: Add CONFIG_CXL_EEH symbol
Message-ID: <20150811135900.41b08808@camb691>
In-Reply-To: <1438061323-20710-11-git-send-email-dja@axtens.net>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
 <1438061323-20710-11-git-send-email-dja@axtens.net>
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

On Tue, 28 Jul 2015 15:28:43 +1000
Daniel Axtens <dja@axtens.net> wrote:

> CONFIG_CXL_EEH is for CXL's EEH related code.
> 
> As well as the EEH callbacks, it should guard sysfs and
> kernel API changes that are only required for CXL EEH.
> 
> We now have all the pieces in place, so add it now.
> 

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

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
> +
>  config CXL
>  	tristate "Support for IBM Coherent Accelerators (CXL)"
>  	depends on PPC_POWERNV && PCI_MSI
>  	select CXL_BASE
>  	select CXL_KERNEL_API
> +	select CXL_EEH
>  	default m
>  	help
>  	  Select this option to enable driver support for IBM Coherent
