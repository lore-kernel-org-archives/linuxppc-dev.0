Return-Path: <djiang@mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 97DF1B707E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 02:21:11 +1000 (EST)
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 4ECA6DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 02:21:10 +1000 (EST)
Message-ID: <4A54C768.5000603@mvista.com>
Date: Wed, 08 Jul 2009 09:20:56 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH] edac: mpc85xx: fix warning when building without
	CONFIG_PCI
References: <20090708161543.GB14979@ovro.caltech.edu>
In-Reply-To: <20090708161543.GB14979@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Dave Jiang <djiang@mvista.com>

On 07/08/2009 09:15 AM, Ira W. Snyder wrote:
> When building without CONFIG_PCI the edac_pci_idx variable is unused,
> causing a build-time warning. Wrap the variable in #ifdef CONFIG_PCI, just
> like the rest of the PCI support.
>
> Signed-off-by: Ira W. Snyder<iws@ovro.caltech.edu>
> ---
>   drivers/edac/mpc85xx_edac.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index 3f2ccfc..b4f5c63 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -26,7 +26,9 @@
>   #include "mpc85xx_edac.h"
>
>   static int edac_dev_idx;
> +#ifdef CONFIG_PCI
>   static int edac_pci_idx;
> +#endif
>   static int edac_mc_idx;
>
>   static u32 orig_ddr_err_disable;
