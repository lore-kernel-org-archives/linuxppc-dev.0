Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A07567B72
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 03:20:16 +1000 (EST)
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH] POWERPC: mpc82xx merge: board-specific/platform
	stuff(resend)
In-Reply-To: Your message of "Fri, 22 Sep 2006 17:50:57 +0400."
	<20060922135057.2859.29388.stgit@localhost.localdomain>
References: <20060922135057.2859.29388.stgit@localhost.localdomain> 
Date: Fri, 22 Sep 2006 12:20:10 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1GQoh8-00055h-Av@jdl.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Vitaly Bordug mumbled:
> 
> This intruduces 82xx family in arch/powerpc/platforms,
> and has all the board-specific code to represent regression-less
> transaction from ppc. The functionality is apparently the same, including
> PCI controller.
> 
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

Excellent!  Thanks!


> +++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c

> +/*
> + * Called very early, device-tree isn't unflattened
> + */
> +static int __init mpc82xx_ads_probe(void)
> +{
> +	/* We always match for now, eventually we should look at
> +	 * the flat dev tree to ensure this is the board we are
> +	 * supposed to run on
> +	 */
> +	return 1;
> +}

Please implement this routine fully.  Something down this line:

    {
        unsigned long root = of_get_flat_dt_root();

        if (of_flat_dt_is_compatible(root, "mpc82xx"))
            return 1;        /* Looks good */

        return 0;
    }


And with that, ACK me:

    Acked-by: Jon Loeliger <jdl@freescale.com>

Thanks,
jdl
