Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 5399CDDDEE
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 23:32:26 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] cpm2: Round the baud-rate clock divider to the nearest
	integer.
Date: Thu, 20 Nov 2008 13:32:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811201332.24061.laurentp@cse-semaphore.com>
Cc: kumar.gala@freescale.com, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Instead of rounding the divider down, improve the baud-rate generators
accuracy by rounding to the nearest integer.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
---
 arch/powerpc/sysdev/cpm2.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index f1c3395..474d176 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -129,7 +129,8 @@ void __cpm2_setbrg(uint brg, uint rate, uint clk, int div16, int src)
 		brg -= 4;
 	}
 	bp += brg;
-	val = (((clk / rate) - 1) << 1) | CPM_BRG_EN | src;
+	/* Round the clock divider to the nearest integer. */
+	val = (((clk * 2 / rate) - 1) & ~1) | CPM_BRG_EN | src;
 	if (div16)
 		val |= CPM_BRG_DIV16;
 
-- 
1.5.6.3

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
