Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F0EBDDF08
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 06:43:32 +1100 (EST)
From: Trent Piepho <tpiepho@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] POWERPC/fsl-pci: Set relaxed ordering on prefetchable
	ranges
Date: Wed, 17 Dec 2008 11:43:26 -0800
Message-Id: <1229543006-8950-2-git-send-email-tpiepho@freescale.com>
In-Reply-To: <1229543006-8950-1-git-send-email-tpiepho@freescale.com>
References: <1229543006-8950-1-git-send-email-tpiepho@freescale.com>
Cc: Trent Piepho <xyzzy@speakeasy.org>, Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Provides a small speedup when accessing pefetchable ranges.  To indicate
that a memory range is prefetchable, mark it in the dts file with 42000000
instead of 02000000.

A powepc pci_controller is allowed three memory ranges, any of which may be
prefetchable.  However, the PCI-PCI bridge configuration space only has one
field for "non-prefetchable memory behind bridge", which has a 32 bit
address, and one field for "prefetchable memory behind bridge", which may
have a 64 bit address.  These are PCI bus addresses, not CPU physical
addresses.

So really you're only allowed one memory range of each type.  And if you
want the range at a PCI address above 32 bits you must make it
prefetchable.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 656f914..af0d7e3 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -41,6 +41,9 @@ static int __init setup_one_atmu(struct ccsr_pci __iomem *pci,
 	pr_debug("PCI MEM resource start 0x%016llx, size 0x%016llx.\n",
 		(u64)res->start, (u64)size);
 
+	if (res->flags & IORESOURCE_PREFETCH)
+		flags |= 0x10000000; /* enable relaxed ordering */
+
 	for (i = 0; size > 0; i++) {
 		unsigned int bits = min(__ilog2(size),
 					__ffs(pci_addr | phys_addr));
-- 
1.5.4.1
