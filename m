Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AFA8ADDE0C
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Mar 2008 11:37:36 +1000 (EST)
Subject: Re: [PATCH][NEWEMAC] Fix section mismatch warnings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <20080302163732.7c3af536@vader.jdub.homelinux.org>
References: <20080302163732.7c3af536@vader.jdub.homelinux.org>
Content-Type: text/plain
Date: Sun, 30 Mar 2008 12:36:48 +1100
Message-Id: <1206841008.10388.110.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2008-03-02 at 16:37 -0600, Josh Boyer wrote:
> This patch fixes several section mismatch warnings in the
> ibm_newemac driver similar to:
> 
> WARNING: vmlinux.o(.devinit.text+0x3a04): Section mismatch in reference from the function emac_probe() to the function .devexit.text:tah_detach()
> The function __devinit emac_probe() references
> a function __devexit tah_detach().
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Ack.

> ---
>  drivers/net/ibm_newemac/core.c  |    2 +-
>  drivers/net/ibm_newemac/mal.c   |    4 ++--
>  drivers/net/ibm_newemac/rgmii.c |    2 +-
>  drivers/net/ibm_newemac/tah.c   |    2 +-
>  drivers/net/ibm_newemac/zmii.c  |    2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
> 
> --- linux-2.6.orig/drivers/net/ibm_newemac/core.c
> +++ linux-2.6/drivers/net/ibm_newemac/core.c
> @@ -2230,7 +2230,7 @@ static int __devinit emac_of_bus_notify(
>  	return 0;
>  }
>  
> -static struct notifier_block emac_of_bus_notifier = {
> +static struct notifier_block emac_of_bus_notifier __devinitdata = {
>  	.notifier_call = emac_of_bus_notify
>  };
>  
> --- linux-2.6.orig/drivers/net/ibm_newemac/mal.c
> +++ linux-2.6/drivers/net/ibm_newemac/mal.c
> @@ -61,8 +61,8 @@ int __devinit mal_register_commac(struct
>  	return 0;
>  }
>  
> -void __devexit mal_unregister_commac(struct mal_instance	*mal,
> -				     struct mal_commac		*commac)
> +void mal_unregister_commac(struct mal_instance	*mal,
> +		struct mal_commac *commac)
>  {
>  	unsigned long flags;
>  
> --- linux-2.6.orig/drivers/net/ibm_newemac/rgmii.c
> +++ linux-2.6/drivers/net/ibm_newemac/rgmii.c
> @@ -179,7 +179,7 @@ void rgmii_put_mdio(struct of_device *of
>  	mutex_unlock(&dev->lock);
>  }
>  
> -void __devexit rgmii_detach(struct of_device *ofdev, int input)
> +void rgmii_detach(struct of_device *ofdev, int input)
>  {
>  	struct rgmii_instance *dev = dev_get_drvdata(&ofdev->dev);
>  	struct rgmii_regs __iomem *p = dev->base;
> --- linux-2.6.orig/drivers/net/ibm_newemac/tah.c
> +++ linux-2.6/drivers/net/ibm_newemac/tah.c
> @@ -35,7 +35,7 @@ int __devinit tah_attach(struct of_devic
>  	return 0;
>  }
>  
> -void __devexit tah_detach(struct of_device *ofdev, int channel)
> +void tah_detach(struct of_device *ofdev, int channel)
>  {
>  	struct tah_instance *dev = dev_get_drvdata(&ofdev->dev);
>  
> --- linux-2.6.orig/drivers/net/ibm_newemac/zmii.c
> +++ linux-2.6/drivers/net/ibm_newemac/zmii.c
> @@ -189,7 +189,7 @@ void zmii_set_speed(struct of_device *of
>  	mutex_unlock(&dev->lock);
>  }
>  
> -void __devexit zmii_detach(struct of_device *ofdev, int input)
> +void zmii_detach(struct of_device *ofdev, int input)
>  {
>  	struct zmii_instance *dev = dev_get_drvdata(&ofdev->dev);
>  
