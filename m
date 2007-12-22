Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AF0CCDDE26
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 03:07:44 +1100 (EST)
Message-ID: <476D366E.1030104@scram.de>
Date: Sat, 22 Dec 2007 17:08:14 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/4] [POWERPC] CPM1: implement GPIO API
References: <20071221202824.GA4607@localhost.localdomain>
	<20071221203431.GD4633@localhost.localdomain>
	<476CDECB.3010409@scram.de>
In-Reply-To: <476CDECB.3010409@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

> I also hope you'll test it. ;-)

yes.

> +int cpm_init_par_io(void)
> +{
> +       struct device_node *np;
> +       const u32 *num_ports;
> +
> +       np = of_find_node_by_name(NULL, "fsl,cpm1-pario");
> +       if (!np)
> +               return -ENOENT;
> +

I guess this should be:

 np = of_find_compatible_node(NULL, NULL, "fsl,cpm1-pario");

With this modification it works OK for me :)

Thanks,
Jochen
