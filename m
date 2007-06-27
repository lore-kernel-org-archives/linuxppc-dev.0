Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69AA5DDFC0
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:17:07 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/15] [POWERPC] Let subordinate transparent bridges be
	transparent.
Date: Tue, 26 Jun 2007 20:16:44 -0500
Message-Id: <1182907026390-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829070241688-git-send-email-galak@kernel.crashing.org>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
	<11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
	<11829070102887-git-send-email-galak@kernel.crashing.org>
	<11829070111239-git-send-email-galak@kernel.crashing.org>
	<1182907013252-git-send-email-galak@kernel.crashing.org>
	<1182907014549-git-send-email-galak@kernel.crashing.org>
	<1182907015126-git-send-email-galak@kernel.crashing.org>
	<11829070192461-git-send-email-galak@kernel.crashing.org>
	<1182907020965-git-send-email-galak@kernel.crashing.org>
	<11829070222511-git-send-email-galak@kernel.crashing.org>
	<11829070232635-git-send-email-galak@kernel.crashing.org>
	<11829070241688-git-send-email-galak@kernel.crashing.org>
Cc: York Sun <yorksun@freescale.com>
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
IORESOURCE_IO and IO_RESOURCE_MEM start and end values.

Fix this by preventing the transparent bridge from
relocating the start and end values, thus allowing the
subordinate non-transparent bridge full molestation rights.

Signed-off-by: York Sun <yorksun@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
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
1.5.2.1
