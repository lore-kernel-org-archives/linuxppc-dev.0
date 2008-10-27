Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E42FDDE98
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 00:45:37 +1100 (EST)
Message-Id: <1D4ED273-13FB-4D2F-82B1-89D2F6F0B9A1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Mike Ditto <mditto@consentry.com>
In-Reply-To: <49027044.90509@consentry.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2] powerpc: Add missing irq free in fs_enet error path.
Date: Mon, 27 Oct 2008 08:45:27 -0500
References: <49027044.90509@consentry.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 24, 2008, at 8:03 PM, Mike Ditto wrote:

> If something goes wrong attaching to phy driver, we weren't freeing  
> the IRQ.
>
> Signed-off-by: Mike Ditto <mditto@consentry.com>
> ---
> I just noticed this file has already been touched in -rc1 so here is  
> the
> patch again, adjusted accordingly.
>
> diff -r -upN 2.6.28-rc1/drivers/net/fs_enet/fs_enet-main.c NEW/ 
> drivers/net/fs_enet/fs_enet-main.c
> --- 2.6.28-rc1/drivers/net/fs_enet/fs_enet-main.c       2008-10-24  
> 17:54:31.000000000 -0700
> +++ NEW/drivers/net/fs_enet/fs_enet-main.c      2008-10-24  
> 17:57:03.000000000 -0700
> @@ -795,6 +795,7 @@ static int fs_enet_open(struct net_devic
>
>        err = fs_init_phy(dev);
>        if (err) {
> +               free_irq(fep->interrupt, dev);
>                if (fep->fpi->use_napi)
>                        napi_disable(&fep->napi);
>                return err;

Please copy Jeff Garizk and the netdev list as such patches normally  
go though that path.

- k
