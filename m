Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0022ADDFA4
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 15:29:58 +1000 (EST)
Subject: Re: [PATCH] pasemi: only call of_platform_bus_probe() on relevant
	platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070501044339.GA5194@lixom.net>
References: <20070501044339.GA5194@lixom.net>
Content-Type: text/plain
Date: Tue, 01 May 2007 15:29:51 +1000
Message-Id: <1177997391.24962.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-04-30 at 23:43 -0500, Olof Johansson wrote:
> Only publish of_platform devices if running on a machine that has them.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
> index f88f0ec..38bd903 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -211,7 +211,10 @@ static struct of_device_id pasemi_bus_ids[] = {
>  
>  static int __init pasemi_publish_devices(void)
>  {
> -	/* Publish OF platform devices for southbridge IOs */
> +	if (!machine_is(pasemi))
> +		return 0;
> +
> +	/* Publish OF platform devices for SDC and other non-PCI devices */
>  	of_platform_bus_probe(NULL, pasemi_bus_ids, NULL);
>  
>  	return 0;
