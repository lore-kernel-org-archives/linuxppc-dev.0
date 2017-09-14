Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtK4g4ZnpzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 23:24:17 +1000 (AEST)
Subject: Re: [PATCH] net/ethernet/freescale: fix warning for ucc_geth
To: Valentin Longchamp <valentin.longchamp@keymile.com>, leoli@freescale.com,
 netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
References: <20170914120514.31845-1-valentin.longchamp@keymile.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <f5c5c526-99d4-ff3d-1e2a-23d71bcafa4b@c-s.fr>
Date: Thu, 14 Sep 2017 15:24:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170914120514.31845-1-valentin.longchamp@keymile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Le 14/09/2017 à 14:05, Valentin Longchamp a écrit :
> Simple printk format warning for the the ucc registers address.

Did you test your patch with mpc83xx_defconfig ?

I get a new warning with your patch:

   CC      drivers/net/ethernet/freescale/ucc_geth.o
In file included from ./include/linux/printk.h:6:0,
                  from ./include/linux/kernel.h:13,
                  from drivers/net/ethernet/freescale/ucc_geth.c:18:
drivers/net/ethernet/freescale/ucc_geth.c: In function ‘ucc_geth_probe’:
./include/linux/kern_levels.h:4:18: warning: format ‘%llx’ expects 
argument of type ‘long long unsigned int’, but argument 3 has type 
‘resource_size_t {aka unsigned int}’ [-Wformat=]
  #define KERN_SOH "\001"  /* ASCII Start Of Header */
                   ^
./include/linux/kern_levels.h:13:19: note: in expansion of macro ‘KERN_SOH’
  #define KERN_INFO KERN_SOH "6" /* informational */
                    ^
./include/linux/printk.h:308:9: note: in expansion of macro ‘KERN_INFO’
   printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
          ^
drivers/net/ethernet/freescale/ucc_geth.c:3860:3: note: in expansion of 
macro ‘pr_info’
    pr_info("UCC%1d at 0x%8llx (irq = %d)\n",
    ^

Christophe

> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> ---
>   drivers/net/ethernet/freescale/ucc_geth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
> index f77ba9fa257b..56b8fdb35c3b 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth.c
> +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> @@ -3857,7 +3857,7 @@ static int ucc_geth_probe(struct platform_device* ofdev)
>   	}
>   
>   	if (netif_msg_probe(&debug))
> -		pr_info("UCC%1d at 0x%8x (irq = %d)\n",
> +		pr_info("UCC%1d at 0x%8llx (irq = %d)\n",
>   			ug_info->uf_info.ucc_num + 1, ug_info->uf_info.regs,
>   			ug_info->uf_info.irq);
>   
> 
