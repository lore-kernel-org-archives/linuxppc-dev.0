Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A279DDE22
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 12:45:44 +1100 (EST)
Subject: Re: [PATCH 1/2] Added support for the MPC8568E MDS board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0702081718400.507@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0702081718400.507@ld0175-tx32.am.freescale.net>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 12:45:30 +1100
Message-Id: <1170985530.2620.393.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +static int __init mpc8568_publish_devices(void)
> +{
> +	if (!machine_is(mpc8568_mds))
> +		return 0;
> +
> +	/* Publish the QE devices */
> +	of_platform_bus_probe(NULL,NULL,NULL);
> +
> +	return 0;
> +}
> +device_initcall(mpc8568_publish_devices);

Please provide an explicit list of bus types to of_platform_bus_probe(),
I intend to remove the "default" one.

Ben.
