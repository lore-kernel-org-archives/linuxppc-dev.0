Return-Path: <fenkes@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 50143DDE1B
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 23:14:46 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m0ECEch4332594
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 12:14:38 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m0ECEc2M3014674
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 13:14:39 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m0ECEcCS027564
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 13:14:38 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] make ibmebus use of_(un)register_driver
Date: Mon, 14 Jan 2008 13:14:37 +0100
References: <20080114174648.bca30b55.sfr@canb.auug.org.au>
In-Reply-To: <20080114174648.bca30b55.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801141314.38120.fenkes@de.ibm.com>
Cc: Heiko J Schick <schickhj@de.ibm.com>, ppc-dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, paulus@samba.org,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 January 2008 07:46, Stephen Rothwell wrote:

> diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
> index 1844359..2a6a388 100644
> --- a/arch/powerpc/kernel/ibmebus.c
> +++ b/arch/powerpc/kernel/ibmebus.c
> @@ -197,16 +197,13 @@ int ibmebus_register_driver(struct of_platform_driver *drv)
>  	/* If the driver uses devices that ibmebus doesn't know, add them */
>  	ibmebus_create_devices(drv->match_table);
> 
> -	drv->driver.name   = drv->name;
> -	drv->driver.bus    = &ibmebus_bus_type;
> -
> -	return driver_register(&drv->driver);
> +	return of_register_driver(drv, &ibmebus_bus_type);
>  }
>  EXPORT_SYMBOL(ibmebus_register_driver);
> 
>  void ibmebus_unregister_driver(struct of_platform_driver *drv)
>  {
> -	driver_unregister(&drv->driver);
> +	of_unregister_driver(drv);
>  }
>  EXPORT_SYMBOL(ibmebus_unregister_driver);

Looks like a transparent change to me. Good one.

Joachim

Acked-by: Joachim Fenkes <fenkes@de.ibm.com>
