Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A5280DDEBA
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 03:19:49 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4BHJdFT018281
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 10:19:40 -0700 (MST)
Received: from ld2052 (ld2052.am.freescale.net [10.82.18.5])
	by de01smr01.freescale.net (8.13.1/8.13.0) with SMTP id l4BHJdO7005799
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 12:19:39 -0500 (CDT)
Date: Fri, 11 May 2007 12:19:38 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: don't complain if size-cells == 0
Message-Id: <20070511121938.7d79f733.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

An mdio bus scan was added with ucc_geth phylib
migration patches, now machines complain on boot, saying:

prom_parse: Bad cell count for /qe@e0100000/mdio@2120/ethernet-phy@00
prom_parse: Bad cell count for /qe@e0100000/mdio@2120/ethernet-phy@01

since size-cells can indeed be 0, this patch fixes the check.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/kernel/prom_parse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index b5c96af..3786dcc 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -24,7 +24,7 @@
 /* Max address size we deal with */
 #define OF_MAX_ADDR_CELLS	4
 #define OF_CHECK_COUNTS(na, ns)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS && \
-			(ns) > 0)
+			(ns) >= 0)
 
 static struct of_bus *of_match_bus(struct device_node *np);
 static int __of_address_to_resource(struct device_node *dev,
-- 
1.5.0.3
