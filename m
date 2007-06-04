Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6521ADDEFC
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 06:24:24 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l54KOJ0u008134
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 13:24:19 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l54KOIaT003504
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 15:24:18 -0500 (CDT)
Subject: [PATCH] Replace use of GET_64BIT(prop, i) with of_read_number().
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180988658.9632.38.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 15:24:18 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove uses of hack GET_64BIT() property macro and use
the more general of_read_number() function from prom.h
as suggested by Milton.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

Someone in 64-bit land please check this!
I have no board on which to test this.  Sorry.

jdl


 arch/powerpc/kernel/pci_64.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 249cca2..b7cd53f 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -291,7 +291,6 @@ static unsigned int pci_parse_of_flags(u32 addr0)
 	return flags;
 }
 
-#define GET_64BIT(prop, i)	((((u64) (prop)[(i)]) << 32) | (prop)[(i)+1])
 
 static void pci_parse_of_addrs(struct device_node *node, struct pci_dev *dev)
 {
@@ -310,8 +309,8 @@ static void pci_parse_of_addrs(struct device_node *node, struct pci_dev *dev)
 		flags = pci_parse_of_flags(addrs[0]);
 		if (!flags)
 			continue;
-		base = GET_64BIT(addrs, 1);
-		size = GET_64BIT(addrs, 3);
+		base = of_read_number(&addrs[1], 2);
+		size = of_read_number(&addrs[3], 2);
 		if (!size)
 			continue;
 		i = addrs[0] & 0xff;
@@ -477,7 +476,7 @@ void __devinit of_scan_pci_bridge(struct device_node *node,
 	i = 1;
 	for (; len >= 32; len -= 32, ranges += 8) {
 		flags = pci_parse_of_flags(ranges[0]);
-		size = GET_64BIT(ranges, 6);
+		size = of_read_number(&ranges[6], 2);
 		if (flags == 0 || size == 0)
 			continue;
 		if (flags & IORESOURCE_IO) {
@@ -496,7 +495,7 @@ void __devinit of_scan_pci_bridge(struct device_node *node,
 			res = bus->resource[i];
 			++i;
 		}
-		res->start = GET_64BIT(ranges, 1);
+		res->start = of_read_number(&ranges[1], 2);
 		res->end = res->start + size - 1;
 		res->flags = flags;
 		fixup_resource(res, dev);
-- 
1.5.0.3
