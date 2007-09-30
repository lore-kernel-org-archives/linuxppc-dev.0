Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 9CBFDDDEBE
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 07:47:48 +1000 (EST)
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP70000KB6MT970@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 15:47:10 -0600 (MDT)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
	by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP700FGQB6M3R60@pd2mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 30 Sep 2007 15:47:11 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP7006P6B6M4NR4@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 15:47:10 -0600 (MDT)
Date: Sun, 30 Sep 2007 15:47:05 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/3] Setup default eth addr in embed_config for Xilinx Virtex
	platforms
In-reply-to: <20070930214140.31899.55951.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20070930214705.31899.65293.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070930214140.31899.55951.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This simply adds the boilerplate default Ethernet address to embed_config
for the Xilinx platform (bug fix).

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/ppc/boot/simple/embed_config.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
index 840bff2..3b46792 100644
--- a/arch/ppc/boot/simple/embed_config.c
+++ b/arch/ppc/boot/simple/embed_config.c
@@ -752,7 +752,9 @@ embed_config(bd_t ** bdp)
 	static const unsigned long congruence_classes = 256;
 	unsigned long addr;
 	unsigned long dccr;
+	uint8_t* cp;
 	bd_t *bd;
+	int i;
 
 	/*
 	 * Invalidate the data cache if the data cache is turned off.
@@ -778,6 +780,12 @@ embed_config(bd_t ** bdp)
 	bd->bi_intfreq = XPAR_CORE_CLOCK_FREQ_HZ;
 	bd->bi_busfreq = XPAR_PLB_CLOCK_FREQ_HZ;
 	bd->bi_pci_busfreq = XPAR_PCI_0_CLOCK_FREQ_HZ;
+
+	/* Copy the default ethernet address */
+	cp = (u_char *)def_enet_addr;
+	for (i=0; i<6; i++)
+		bd->bi_enetaddr[i] = *cp++;
+
 	timebase_period_ns = 1000000000 / bd->bi_tbfreq;
 	/* see bi_tbfreq definition in arch/ppc/platforms/4xx/xilinx_ml300.h */
 }
