Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [PATCH] powerpc/fsl-pci: fix warning when CONFIG_SWIOTLB is
 disabled
In-reply-to: <1347962268-25136-1-git-send-email-B38951@freescale.com>
References: <1347962268-25136-1-git-send-email-B38951@freescale.com>
Date: Wed, 19 Sep 2012 07:06:39 +1000
Message-ID: <24157.1348002399@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jia Hongtao <B38951@freescale.com> wrote:

> Fix the following warning:
> arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pci_probe':
> arch/powerpc/sysdev/fsl_pci.c:867:25: error: unused variable 'hose'
> 
> Signed-off-by: Jia Hongtao <B38951@freescale.com>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
>  arch/powerpc/sysdev/fsl_pci.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 2ff3576..3d6f4d8 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -864,7 +864,9 @@ static int __devinit fsl_pci_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  	struct device_node *node;
> +#ifdef CONFIG_SWIOTLB
>  	struct pci_controller *hose;
> +#endif
>  
>  	node = pdev->dev.of_node;
>  	ret = fsl_add_bridge(node, fsl_pci_primary == node);
> -- 
> 1.7.5.1
> 
> 
