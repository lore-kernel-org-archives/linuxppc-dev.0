Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2FB80DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 14:00:59 +1100 (EST)
Date: Mon, 14 Jan 2008 20:58:41 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Fixup use of phys_addr_t in mpic code
Message-ID: <Pine.LNX.4.64.0801142058100.32559@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Becky Bruce <becky.bruce@freescale.com>

The mpic_map() and __mpic_map_mmio() need to use phys_addr_t for the
physical address they are passed.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/mpic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index f88ff09..0da7069 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -267,7 +267,7 @@ static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no,
  */


-static void _mpic_map_mmio(struct mpic *mpic, unsigned long phys_addr,
+static void _mpic_map_mmio(struct mpic *mpic, phys_addr_t phys_addr,
 			   struct mpic_reg_bank *rb, unsigned int offset,
 			   unsigned int size)
 {
@@ -287,7 +287,7 @@ static void _mpic_map_dcr(struct mpic *mpic, struct mpic_reg_bank *rb,
 	BUG_ON(!DCR_MAP_OK(rb->dhost));
 }

-static inline void mpic_map(struct mpic *mpic, unsigned long phys_addr,
+static inline void mpic_map(struct mpic *mpic, phys_addr_t phys_addr,
 			    struct mpic_reg_bank *rb, unsigned int offset,
 			    unsigned int size)
 {
-- 
1.5.3.7
