Return-Path: <michal.simek@xilinx.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0056.outbound.protection.outlook.com [104.47.36.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymzRF2p9GzDrKS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 22:52:06 +1100 (AEDT)
Subject: Re: [PATCH] net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on
 64-bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Michal Simek
 <michal.simek@xilinx.com>, "David S . Miller" <davem@davemloft.net>
CC: Arnd Bergmann <arnd@arndb.de>, <netdev@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
References: <1511949669-30379-1-git-send-email-geert+renesas@glider.be>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <c69c2f1f-0f22-2baf-41a5-d30e2f6d96a0@xilinx.com>
Date: Wed, 29 Nov 2017 12:51:45 +0100
MIME-Version: 1.0
In-Reply-To: <1511949669-30379-1-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29.11.2017 11:01, Geert Uytterhoeven wrote:
> On 64-bit (e.g. powerpc64/allmodconfig):
> 
>     drivers/net/ethernet/xilinx/ll_temac_main.c: In function 'temac_start_xmit_done':
>     drivers/net/ethernet/xilinx/ll_temac_main.c:633:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> 	dev_kfree_skb_irq((struct sk_buff *)cur_p->app4);
> 			  ^
> 
> cdmac_bd.app4 is u32, so it is too small to hold a kernel pointer.
> 
> Note that several other fields in struct cdmac_bd are also too small to
> hold physical addresses on 64-bit platforms.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/net/ethernet/xilinx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
> index 6d68c8a8f4f2ac7f..da4ec575ccf9ba4a 100644
> --- a/drivers/net/ethernet/xilinx/Kconfig
> +++ b/drivers/net/ethernet/xilinx/Kconfig
> @@ -34,6 +34,7 @@ config XILINX_AXI_EMAC
>  config XILINX_LL_TEMAC
>  	tristate "Xilinx LL TEMAC (LocalLink Tri-mode Ethernet MAC) driver"
>  	depends on (PPC || MICROBLAZE)
> +	depends on !64BIT || BROKEN
>  	select PHYLIB
>  	---help---
>  	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC
> 

Yes. This IP is available only on big endian 32bit systems.

Thanks,
Michal
