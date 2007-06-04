Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9FF50DDFBB
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 08:30:19 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l54MUEY1009189
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 15:30:15 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l54MUEcX021913
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 17:30:14 -0500 (CDT)
Subject: [PATCH v2 6/9] Let subordinate transparent bridges be transparent.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180996213.9632.74.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 17:30:13 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In pcibios_fixup_bus(), bridges that are subordinate
to transparent bridges were still relocating their
IORESOURCE_IO and IO_RESOURCE_MEM start and end values.

Fix this by preventing the transparent bridge from
relocating the start and end values, thus allowing the
subordinate non-transparent bridge full molestation rights.

Signed-off-by: York Sun <yorksun@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

This is the variant that was suggested by Ben H.

 arch/powerpc/kernel/pci_32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index e66064b..7738a28 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -1370,7 +1370,7 @@ void __init pcibios_fixup_bus(struct pci_bus *bus)
 		for (i = 0; i < 4; ++i) {
 			if ((res = bus->resource[i]) == NULL)
 				continue;
-			if (!res->flags)
+			if (!res->flags || bus->self->transparent)
 				continue;
 			if (io_offset && (res->flags & IORESOURCE_IO)) {
 				res->start += io_offset;
-- 
1.5.0.3
