Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 275F8DE3D2
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 03:49:02 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l51HmwZj003580
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 10:48:59 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l51HmwVf021547
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 12:48:58 -0500 (CDT)
Subject: [PATCH 7/8] Export of_bus_pci_get_flags().
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180720138.14219.67.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 01 Jun 2007 12:48:58 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It will be needed by the following patch.

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
-- 
1.5.0.3
