Return-Path: <geert@linux-m68k.org>
Received: from newton.telenet-ops.be (newton.telenet-ops.be [195.130.132.45])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymy2M3YkQzDqxn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 21:48:59 +1100 (AEDT)
Received: from michel.telenet-ops.be (michel.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:18])
 by newton.telenet-ops.be (Postfix) with ESMTPS id 3ymxrm0dGxzMrdcH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 11:40:40 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michal Simek <michal.simek@xilinx.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit
Date: Wed, 29 Nov 2017 11:01:09 +0100
Message-Id: <1511949669-30379-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 64-bit (e.g. powerpc64/allmodconfig):

    drivers/net/ethernet/xilinx/ll_temac_main.c: In function 'temac_start_xmit_done':
    drivers/net/ethernet/xilinx/ll_temac_main.c:633:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
	dev_kfree_skb_irq((struct sk_buff *)cur_p->app4);
			  ^

cdmac_bd.app4 is u32, so it is too small to hold a kernel pointer.

Note that several other fields in struct cdmac_bd are also too small to
hold physical addresses on 64-bit platforms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/xilinx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 6d68c8a8f4f2ac7f..da4ec575ccf9ba4a 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -34,6 +34,7 @@ config XILINX_AXI_EMAC
 config XILINX_LL_TEMAC
 	tristate "Xilinx LL TEMAC (LocalLink Tri-mode Ethernet MAC) driver"
 	depends on (PPC || MICROBLAZE)
+	depends on !64BIT || BROKEN
 	select PHYLIB
 	---help---
 	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC
-- 
2.7.4
