Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D747BDDF14
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 00:07:50 +1000 (EST)
In-Reply-To: <46484110.5020607@freescale.com>
References: <46484110.5020607@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4575ED11-C144-49CF-9FBA-0613B61EFCE3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: Fix Section mismatch warnings
Date: Tue, 15 May 2007 09:06:53 -0500
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 14, 2007, at 5:59 AM, Li Yang wrote:

> This patch fix the following Section mismatch warnings
> in powerpc code.
>
> WARNING: arch/powerpc/platforms/built-in.o - Section mismatch:  
> reference to .init.data:mv643xx_eth_pd_devs from .text between  
> 'mv643xx_eth_add_pds' (at offset 0x9ed2) and 'gg2_read_config'
> WARNING: arch/powerpc/platforms/built-in.o - Section mismatch:  
> reference to .init.data:mv643xx_eth_pd_devs from .text between  
> 'mv643xx_eth_add_pds' (at offset 0x9ed6) and 'gg2_read_config'
> WARNING: arch/powerpc/platforms/built-in.o - Section mismatch:  
> reference to .init.text:note_scsi_host from __ksymtab between  
> '__ksymtab_note_scsi_host' (at offset 0x8) and '__ksymtab_sys_ctrler'
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/platforms/chrp/pegasos_eth.c |    2 +-
>  arch/powerpc/platforms/powermac/setup.c   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Did you change anything?

- k

> diff --git a/arch/powerpc/platforms/chrp/pegasos_eth.c b/arch/ 
> powerpc/platforms/chrp/pegasos_eth.c
> index 7104567..5c9f135 100644
> --- a/arch/powerpc/platforms/chrp/pegasos_eth.c
> +++ b/arch/powerpc/platforms/chrp/pegasos_eth.c
> @@ -169,7 +169,7 @@ static int Enable_SRAM(void)
>
>  /***********/
>  /***********/
> -int mv643xx_eth_add_pds(void)
> +int __init mv643xx_eth_add_pds(void)
>  {
>  	int ret = 0;
>  	static struct pci_device_id pci_marvell_mv64360[] = {
> diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/ 
> platforms/powermac/setup.c
> index a410bc7..07b1c4e 100644
> --- a/arch/powerpc/platforms/powermac/setup.c
> +++ b/arch/powerpc/platforms/powermac/setup.c
> @@ -384,7 +384,7 @@ int boot_part;
>  static dev_t boot_dev;
>
>  #ifdef CONFIG_SCSI
> -void __init note_scsi_host(struct device_node *node, void *host)
> +void note_scsi_host(struct device_node *node, void *host)
>  {
>  	int l;
>  	char *p;
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
