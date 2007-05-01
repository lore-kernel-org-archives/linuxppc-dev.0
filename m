Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17974.50094.70055.169529@cargo.ozlabs.ibm.com>
Date: Tue, 1 May 2007 14:35:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH] [5/5] [v2] pasemi: GPIO MDIO of_platform driver
In-Reply-To: <20070418063954.GB11480@lixom.net>
References: <20070416062634.GB20196@lixom.net>
	<20070416063139.GC20319@lixom.net>
	<20070418063954.GB11480@lixom.net>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just noticed this in arch/powerpc/platforms/pasemi/setup.c:

> --- powerpc.orig/arch/powerpc/platforms/pasemi/setup.c
> +++ powerpc/arch/powerpc/platforms/pasemi/setup.c
> @@ -209,6 +209,20 @@ static void __init pas_init_early(void)
>  	iommu_init_early_pasemi();
>  }
>  
> +static struct of_device_id pasemi_bus_ids[] = {
> +	{ .type = "sdc", },
> +	{},
> +};
> +
> +static int __init pasemi_publish_devices(void)
> +{
> +	/* Publish OF platform devices for southbridge IOs */
> +	of_platform_bus_probe(NULL, pasemi_bus_ids, NULL);
> +
> +	return 0;
> +}
> +device_initcall(pasemi_publish_devices);

Oof.  Please make sure you only call of_platform_bus_probe if you are
actually on a pasemi platform... :)

Paul.
