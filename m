Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43067DDF6E
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 04:40:35 +1000 (EST)
Date: Thu, 4 Sep 2008 22:40:18 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: hs@denx.de
Subject: Re: [FIX] fs_enet: Using mii-bitbang as module
Message-ID: <20080904224018.500188d1@vitb-lp>
In-Reply-To: <48BF79C2.6050902@denx.de>
References: <48BF79C2.6050902@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

В Thu, 04 Sep 2008 08:01:38 +0200
Heiko Schocher <hs@denx.de> пишет:

> Hello Vitaly,
> 
> I tried to use the mii-bitbang driver
> (drivers/net/fs_enet/mii-bitbang.c) as a module and got the following
> error, when inserting it with insmod:
> 
> ~ # insmod fs_enet
> eth0: fs_enet: a6:07:11:7f:de:26
> ~ # insmod mii-bitbang
> mii_bitbang: module license 'unspecified' taints kernel.
> mii_bitbang: Unknown symbol of_address_to_resource
> mii_bitbang: Unknown symbol of_irq_to_resource
> insmod: cannot insert
> '/lib/modules/2.6.27-rc5-01144-g967b424-dirty/kernel/drivers/net/fs_enet/mii-bitbang.ko':
> Unknown symbol in module (-1): No such file or directory ~ #
> 
> Following patch solves this. Maybe you add the other MODULE_ macros
> too?
Maybe _DESCRIPTION()... I'll combine my part with yours and will send it
to netdev.

Thanks,
-Vitaly
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
>  drivers/net/fs_enet/mii-bitbang.c                  |    2 +
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/fs_enet/mii-bitbang.c
> b/drivers/net/fs_enet/mii-bitbang.c index be4b72f..863ceed 100644
> --- a/drivers/net/fs_enet/mii-bitbang.c
> +++ b/drivers/net/fs_enet/mii-bitbang.c
> @@ -26,6 +26,8 @@
> 
>  #include "fs_enet.h"
> 
> +MODULE_LICENSE("GPL");
> +
>  struct bb_info {
>  	struct mdiobb_ctrl ctrl;
>  	__be32 __iomem *dir;
