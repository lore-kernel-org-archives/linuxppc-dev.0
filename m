Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5F8EADE3B0
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 04:23:11 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4TIN6Nt005583
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 11:23:06 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4TIN5Ux023120
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 13:23:06 -0500 (CDT)
Subject: [PATCH 2/3] Export of_bus_pci_get_flags().
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180462985.13106.63.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 29 May 2007 13:23:05 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jon Loeliger <jdl@freescale.com>

Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/kernel/prom_parse.c |    2 +-
 include/asm-powerpc/prom.h       |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 3786dcc..754926f 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -153,7 +153,7 @@ static int of_bus_pci_translate(u32 *addr, u64 offset, int na)
 	return of_bus_default_translate(addr + 1, offset, na - 1);
 }
 
-static unsigned int of_bus_pci_get_flags(const u32 *addr)
+unsigned int of_bus_pci_get_flags(const u32 *addr)
 {
 	unsigned int flags = 0;
 	u32 w = addr[0];
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 6845af9..0168373 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -185,6 +185,7 @@ extern int pci_device_from_OF_node(struct device_node *node,
 extern struct device_node* pci_busdev_to_OF_node(struct pci_bus *, int);
 extern struct device_node* pci_device_to_OF_node(struct pci_dev *);
 extern void pci_create_OF_bus_map(void);
+extern unsigned int of_bus_pci_get_flags(const u32 *addr);
 #endif
 
 extern struct resource *request_OF_resource(struct device_node* node,
