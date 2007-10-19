Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id BC97ADDEC5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 10:30:20 +1000 (EST)
Date: Thu, 18 Oct 2007 17:30:32 -0700 (PDT)
Message-Id: <20071018.173032.48505868.davem@davemloft.net>
To: Emilian.Medve@freescale.com
Subject: Re: [PATCH] [POWERPC] ucc_geth: Eliminate compile warnings
From: David Miller <davem@davemloft.net>
In-Reply-To: <1192745713-20829-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1192745713-20829-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, leoli@freescale.com, jgarzik@pobox.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Emil Medve <Emilian.Medve@freescale.com>
Date: Thu, 18 Oct 2007 17:15:13 -0500

> drivers/net/ucc_geth.c: In function 'ucc_geth_startup':
> drivers/net/ucc_geth.c:2614: warning: assignment makes integer from pointer without a cast
> drivers/net/ucc_geth.c:2651: warning: assignment makes integer from pointer without a cast
> 
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

It only kills the warning on 32-bit systems, the cast is wrong
either way.

>  			ugeth->tx_bd_ring_offset[j] =
> -				kmalloc((u32) (length + align), GFP_KERNEL);
> +				(u32)kmalloc(length + align, GFP_KERNEL);
>  
>  			if (ugeth->tx_bd_ring_offset[j] != 0)
>  				ugeth->p_tx_bd_ring[j] =

Pointers can be up to "unsigned long" in size, therefore that
is the minimal amount of storage you need to store them into
if they are needed in integer form for some reason.

Any cast from pointer to integer like this is a huge red flag.
