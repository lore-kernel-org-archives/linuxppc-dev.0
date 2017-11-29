Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yn3G11ZdzzDrb3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 01:44:15 +1100 (AEDT)
Date: Wed, 29 Nov 2017 09:44:10 -0500 (EST)
Message-Id: <20171129.094410.1537008794654450709.davem@davemloft.net>
To: geert+renesas@glider.be
Cc: michal.simek@xilinx.com, arnd@arndb.de, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on
 64-bit
From: David Miller <davem@davemloft.net>
In-Reply-To: <1511949669-30379-1-git-send-email-geert+renesas@glider.be>
References: <1511949669-30379-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 29 Nov 2017 11:01:09 +0100

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

Yeah, I can't see much value in implementing a hash table converting between
32-bit cookies and 64-bit points just for this if it'll never be actually
used.

Applied, thanks Geert.
