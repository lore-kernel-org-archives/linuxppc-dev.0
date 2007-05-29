Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EFA7ADE149
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 04:22:59 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4TIMtrq015338
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 11:22:55 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4TIMsFR023090
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 13:22:54 -0500 (CDT)
Subject: [PATCH 1/3] Let subordinate transparent bridges be transparent.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180462974.13106.61.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 29 May 2007 13:22:54 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: York Sun <yorksun@freescale.com>

In pcibios_fixup_bus(), bridges that are subordinate
to transparent bridges were still relocating their
IORESOURCE_IO start and end values.

Fix this by preventing the transparent bridge from
relocating the start and end values, thus allowing the
subordinate non-transparent bridge full molestation rights.

Signed-off-by: York Sun <yorksun@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/kernel/pci_32.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index e66064b..102264c 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -1372,7 +1372,9 @@ void __init pcibios_fixup_bus(struct pci_bus *bus)
 				continue;
 			if (!res->flags)
 				continue;
-			if (io_offset && (res->flags & IORESOURCE_IO)) {
+			if (!bus->self->transparent
+			    && io_offset
+			    && (res->flags & IORESOURCE_IO)) {
 				res->start += io_offset;
 				res->end += io_offset;
 			} else if (hose->pci_mem_offset
