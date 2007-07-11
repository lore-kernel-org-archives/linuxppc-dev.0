Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (shawidc-mo1.cg.shawcable.net
	[24.71.223.10]) by ozlabs.org (Postfix) with ESMTP id 61D78DDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jul 2007 07:41:46 +1000 (EST)
Received: from pd4mr4so.prod.shaw.ca
	(pd4mr4so-qfe3.prod.shaw.ca [10.0.141.215]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JL100CCE81GMS40@l-daemon> for
	linuxppc-embedded@ozlabs.org; Wed, 11 Jul 2007 14:39:16 -0600 (MDT)
Received: from pn2ml4so.prod.shaw.ca ([10.0.121.148])
	by pd4mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JL100ED4818KW00@pd4mr4so.prod.shaw.ca> for
	linuxppc-embedded@ozlabs.org; Wed, 11 Jul 2007 14:39:09 -0600 (MDT)
Received: from trillian.secretlab.ca ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004)) with ESMTP id <0JL1001BV817I200@l-daemon> for
	linuxppc-embedded@ozlabs.org; Wed, 11 Jul 2007 14:39:07 -0600 (MDT)
Date: Wed, 11 Jul 2007 14:38:52 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Setup default eth addr in embed_config for Xilinx Virtex
	platforms
To: khollan <khollan@daktronics.com>, Kevin Holland <KHollan@daktronics.com>,
	linuxppc-embedded@ozlabs.org, paulus@samba.org, galak@kernel.crashing.org
Message-id: <20070711203852.1839.38604.stgit@trillian>
Content-type: text/plain; charset=utf-8; format=fixed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/ppc/boot/simple/embed_config.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
index 46676d2..07f1bb5 100644
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
 }
 #endif /* CONFIG_XILINX_VIRTEX */
