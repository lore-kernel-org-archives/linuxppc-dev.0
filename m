Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 4B9C8B6FBF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 01:14:16 +1000 (EST)
Date: Thu, 2 Jun 2011 19:14:13 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/2] ppc/85xx: create a platform node for PCI EDAC device
Message-ID: <20110602151413.GA6590@oksana.dev.rtsoft.ru>
References: <20110601114823.2e57c691@schlenkerla.am.freescale.net>
	<1307017502-3965-1-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1307017502-3965-1-git-send-email-dbaryshkov@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 02, 2011 at 04:25:02PM +0400, Dmitry Eremin-Solenikov wrote:
> As a device for pci node isn't created, create a special platform_device
> for PCI EDAC device on MPC85xx.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/powerpc/sysdev/fsl_pci.c |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 68ca929..0e37259 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -381,6 +381,39 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
>  	return 0;
>  }
>  
> +int __init fsl_add_pci_err(void)

static :-)

> +{
> +	struct device_node *np;
> +
> +	for_each_node_by_type(np, "pci") {
> +		/* Only PCI, not PCI Express! */
> +		if (of_device_is_compatible(np, "fsl,mpc8540-pci")) {
> +			struct resource r[2];

How about '= {};' initializer instead of the '= NULL's down below?

> +
> +			r[0].parent = NULL;
> +			r[1].parent = NULL;

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
