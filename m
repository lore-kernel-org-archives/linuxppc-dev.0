Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0l08S030038@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:30 -0700
Cc: akpm@osdl.org, linuxppc64-dev@ozlabs.org, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, det.nicolas@free.fr
Subject: [patch 17/43] mv643xx_eth_showsram: Added information message when
	using the SRAM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Nicolas DET <nd@bplan-gmbh.de>

Added information message when using the SRAM in mv643xx_eth_probe()

Signed-off-by: Nicolas DET <det.nicolas@free.fr>
Signed-off-by: Sven Luther <sl@bplan-gmbh.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/net/mv643xx_eth.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN drivers/net/mv643xx_eth.c~mv643xx_eth_showsram-added-information drivers/net/mv643xx_eth.c
--- devel/drivers/net/mv643xx_eth.c~mv643xx_eth_showsram-added-information	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/mv643xx_eth.c	2005-10-28 17:45:23.000000000 -0700
@@ -1533,6 +1533,9 @@ static int mv643xx_eth_probe(struct devi
 	printk(KERN_NOTICE "%s: RX NAPI Enabled \n", dev->name);
 #endif
 
+	if (mp->tx_sram_size > 0)
+		printk(KERN_NOTICE "%s: Using SRAM\n", dev->name);
+
 	return 0;
 
 out:
_
