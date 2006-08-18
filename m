Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B90D067B59
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 08:20:43 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7IMKe4u011014
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 18:20:40 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7IMKddT296108
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 18:20:39 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7IMKdw7028485
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 18:20:39 -0400
Date: Fri, 18 Aug 2006 17:20:38 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 1/6]: powerpc/cell spidernet burst alignment patch
Message-ID: <20060818222038.GH26889@austin.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060818220700.GG26889@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, ens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



This patch increases the Burst Address alignment from 64 to 1024 in the
Spidernet driver. This improves transmit performance for arge packets
from about 100Mbps to 300-400Mbps.

From: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Utz Bacher <utz.bacher@de.ibm.com>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-rc3-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/spider_net.h	2006-08-07 14:37:10.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/spider_net.h	2006-08-11 11:09:57.000000000 -0500
@@ -209,7 +209,7 @@ extern char spider_net_driver_name[];
 #define SPIDER_NET_DMA_RX_FEND_VALUE	0x00030003
 /* to set TX_DMA_EN */
 #define SPIDER_NET_TX_DMA_EN		0x80000000
-#define SPIDER_NET_GDTDCEIDIS		0x00000002
+#define SPIDER_NET_GDTDCEIDIS		0x00000302
 #define SPIDER_NET_DMA_TX_VALUE		SPIDER_NET_TX_DMA_EN | \
 					SPIDER_NET_GDTDCEIDIS
 #define SPIDER_NET_DMA_TX_FEND_VALUE	0x00030003
