Return-Path: <dragos.carp@toptica.com>
Received: from hypercube.tuioptics.com (gateway.tuioptics.com [213.183.22.85])
	by ozlabs.org (Postfix) with ESMTP id 45320DDE24
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 May 2007 17:31:32 +1000 (EST)
Message-ID: <46514AC6.8080704@toptica.com>
Date: Mon, 21 May 2007 09:31:18 +0200
From: Dragos Carp <dragos.carp@toptica.com>
MIME-Version: 1.0
To: Domen Puncer <domen@coderock.org>
Subject: Re: [PATCH] mpc52xx_psc_spi: fix it for CONFIG_PPC_MERGE
References: <20070516073707.GD9667@nd47.coderock.org>
In-Reply-To: <20070516073707.GD9667@nd47.coderock.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Acked-by: Dragos Carp <dragos.carp@toptica.com>

Domen Puncer wrote:
> Fix mpc5200 PSC SPI driver to actually work for CONFIG_PPC_MERGE
> - s/mpc52xx/mpc5200/, as this was changed in device tree some time ago
> - fix spi id detection
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
>
> ---
>  drivers/spi/mpc52xx_psc_spi.c |   25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> Index: work-powerpc.git/drivers/spi/mpc52xx_psc_spi.c
> ===================================================================
> --- work-powerpc.git.orig/drivers/spi/mpc52xx_psc_spi.c
> +++ work-powerpc.git/drivers/spi/mpc52xx_psc_spi.c
> @@ -329,8 +329,8 @@ static int mpc52xx_psc_spi_port_config(i
>  	int ret = 0;
>  
>  #if defined(CONFIG_PPC_MERGE)
> -	cdm = mpc52xx_find_and_map("mpc52xx-cdm");
> -	gpio = mpc52xx_find_and_map("mpc52xx-gpio");
> +	cdm = mpc52xx_find_and_map("mpc5200-cdm");
> +	gpio = mpc52xx_find_and_map("mpc5200-gpio");
>  #else
>  	cdm = ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);
>  	gpio = ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
> @@ -445,9 +445,6 @@ static int __init mpc52xx_psc_spi_do_pro
>  	struct spi_master *master;
>  	int ret;
>  
> -	if (pdata == NULL)
> -		return -ENODEV;
> -
>  	master = spi_alloc_master(dev, sizeof *mps);
>  	if (master == NULL)
>  		return -ENOMEM;
> @@ -594,17 +591,17 @@ static int __init mpc52xx_psc_spi_of_pro
>  	}
>  	regaddr64 = of_translate_address(op->node, regaddr_p);
>  
> +	/* get PSC id (1..6, used by port_config) */
>  	if (op->dev.platform_data == NULL) {
> -		struct device_node *np;
> -		int i = 0;
> +		const u32 *psc_nump;
>  
> -		for_each_node_by_type(np, "spi") {
> -			if (of_find_device_by_node(np) == op) {
> -				id = i;
> -				break;
> -			}
> -			i++;
> +		psc_nump = of_get_property(op->node, "cell-index", NULL);
> +		if (!psc_nump || *psc_nump > 5) {
> +			printk(KERN_ERR "mpc52xx_psc_spi: Device node %s has invalid "
> +					"cell-index property\n", op->node->full_name);
> +			return -EINVAL;
>  		}
> +		id = *psc_nump + 1;
>  	}
>  
>  	return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
> @@ -617,7 +614,7 @@ static int __exit mpc52xx_psc_spi_of_rem
>  }
>  
>  static struct of_device_id mpc52xx_psc_spi_of_match[] = {
> -	{ .type = "spi", .compatible = "mpc52xx-psc-spi", },
> +	{ .type = "spi", .compatible = "mpc5200-psc-spi", },
>  	{},
>  };
>  
>
>
>   


-- 

Dragos Carp
Research & Development

Phone: +49 89 85837-159, Fax: +49 89 85837-200
Address: TOPTICA Photonics AG, Lochhamer Schlag 19, D-82166 Graefelfing, Germany

TOPTICA – A Passion for Precision
TOPTICA Photonics AG, Registered Office: 82166 Graefelfing, Germany
Companies' Register: Amtsgericht München, HRB 137368
Executive Directors: Dr. Wilhelm Kaenders, Dr. Thomas Weber
Chairman of the Supervisory Board: Dr. Kristian Hohla
www.toptica.com
