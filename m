Return-Path: <rdunlap@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Xz9h6CsszDql5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jul 2018 05:59:36 +1000 (AEST)
To: PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 David Miller <davem@davemloft.net>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] net: prevent ISA drivers from building on PPC32
Message-ID: <b7e66624-a077-048a-d8f5-52a3722157df@infradead.org>
Date: Sat, 21 Jul 2018 12:59:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Randy Dunlap <rdunlap@infradead.org>

Prevent drivers from building on PPC32 if they use isa_bus_to_virt(),
isa_virt_to_bus(), or isa_page_to_bus(), which are not available and
thus cause build errors.

../drivers/net/ethernet/3com/3c515.c: In function 'corkscrew_open':
../drivers/net/ethernet/3com/3c515.c:824:9: error: implicit declaration of function 'isa_virt_to_bus'; did you mean 'virt_to_bus'? [-Werror=implicit-function-declaration]

../drivers/net/ethernet/amd/lance.c: In function 'lance_rx':
../drivers/net/ethernet/amd/lance.c:1203:23: error: implicit declaration of function 'isa_bus_to_virt'; did you mean 'bus_to_virt'? [-Werror=implicit-function-declaration]

../drivers/net/ethernet/amd/ni65.c: In function 'ni65_init_lance':
../drivers/net/ethernet/amd/ni65.c:585:20: error: implicit declaration of function 'isa_virt_to_bus'; did you mean 'virt_to_bus'? [-Werror=implicit-function-declaration]

../drivers/net/ethernet/cirrus/cs89x0.c: In function 'net_open':
../drivers/net/ethernet/cirrus/cs89x0.c:897:20: error: implicit declaration of function 'isa_virt_to_bus'; did you mean 'virt_to_bus'? [-Werror=implicit-function-declaration]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
---
in cirrus/Kconfig, CS89x0 should probably also depend on ISA_DMA_API.

 drivers/net/ethernet/3com/Kconfig   |    2 +-
 drivers/net/ethernet/amd/Kconfig    |    4 ++--
 drivers/net/ethernet/cirrus/Kconfig |    1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

--- linux-next-20180720.orig/drivers/net/ethernet/3com/Kconfig
+++ linux-next-20180720/drivers/net/ethernet/3com/Kconfig
@@ -32,7 +32,7 @@ config EL3
 
 config 3C515
 	tristate "3c515 ISA \"Fast EtherLink\""
-	depends on ISA && ISA_DMA_API
+	depends on ISA && ISA_DMA_API && !PPC32
 	---help---
 	  If you have a 3Com ISA EtherLink XL "Corkscrew" 3c515 Fast Ethernet
 	  network card, say Y here.
--- linux-next-20180720.orig/drivers/net/ethernet/amd/Kconfig
+++ linux-next-20180720/drivers/net/ethernet/amd/Kconfig
@@ -44,7 +44,7 @@ config AMD8111_ETH
 
 config LANCE
 	tristate "AMD LANCE and PCnet (AT1500 and NE2100) support"
-	depends on ISA && ISA_DMA_API && !ARM
+	depends on ISA && ISA_DMA_API && !ARM && !PPC32
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y here.
 	  Some LinkSys cards are of this type.
@@ -138,7 +138,7 @@ config PCMCIA_NMCLAN
 
 config NI65
 	tristate "NI6510 support"
-	depends on ISA && ISA_DMA_API && !ARM
+	depends on ISA && ISA_DMA_API && !ARM && !PPC32
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y here.
 
--- linux-next-20180720.orig/drivers/net/ethernet/cirrus/Kconfig
+++ linux-next-20180720/drivers/net/ethernet/cirrus/Kconfig
@@ -19,6 +19,7 @@ if NET_VENDOR_CIRRUS
 config CS89x0
 	tristate "CS89x0 support"
 	depends on ISA || EISA || ARM
+	depends on !PPC32
 	---help---
 	  Support for CS89x0 chipset based Ethernet cards. If you have a
 	  network (Ethernet) card of this type, say Y and read the file
