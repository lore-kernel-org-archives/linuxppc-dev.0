Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C803ADE0E9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 11:03:49 +1100 (EST)
Date: Wed, 7 Jan 2009 11:03:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/cell: fix some types
Message-Id: <20090107110344.5fbada03.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Molnar <mingo@elte.hu>, Ingo,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Ingo Molnar <mingo@elte.hu>

in/out_be64() work on u64s.

The first parameter to ppc_md.ioremap is a phys_addr_t.

[Split out from a large patch - sfr]
[A couple of updates - sfr]
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/cell/interrupt.c      |    2 +-
 arch/powerpc/platforms/cell/io-workarounds.c |    4 ++--
 arch/powerpc/platforms/cell/iommu.c          |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 2d5bb22..28c04da 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -148,7 +148,7 @@ static unsigned int iic_get_irq(void)
 
 	iic = &__get_cpu_var(iic);
 	*(unsigned long *) &pending =
-		in_be64((unsigned long __iomem *) &iic->regs->pending_destr);
+		in_be64((u64 __iomem *) &iic->regs->pending_destr);
 	if (!(pending.flags & CBE_IIC_IRQ_VALID))
 		return NO_IRQ;
 	virq = irq_linear_revmap(iic_host, iic_pending_to_hwnum(pending));
diff --git a/arch/powerpc/platforms/cell/io-workarounds.c b/arch/powerpc/platforms/cell/io-workarounds.c
index b5f84e8..059cad6 100644
--- a/arch/powerpc/platforms/cell/io-workarounds.c
+++ b/arch/powerpc/platforms/cell/io-workarounds.c
@@ -130,14 +130,14 @@ static const struct ppc_pci_io __devinitconst iowa_pci_io = {
 
 };
 
-static void __iomem *iowa_ioremap(unsigned long addr, unsigned long size,
+static void __iomem *iowa_ioremap(phys_addr_t addr, unsigned long size,
 						unsigned long flags)
 {
 	struct iowa_bus *bus;
 	void __iomem *res = __ioremap(addr, size, flags);
 	int busno;
 
-	bus = iowa_pci_find(0, addr);
+	bus = iowa_pci_find(0, (unsigned long)addr);
 	if (bus != NULL) {
 		busno = bus - iowa_busses;
 		PCI_SET_ADDR_TOKEN(res, busno + 1);
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 86db4dd..88d94b5 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -150,8 +150,8 @@ static int cbe_nr_iommus;
 static void invalidate_tce_cache(struct cbe_iommu *iommu, unsigned long *pte,
 		long n_ptes)
 {
-	unsigned long __iomem *reg;
-	unsigned long val;
+	u64 __iomem *reg;
+	u64 val;
 	long n;
 
 	reg = iommu->xlate_regs + IOC_IOPT_CacheInvd;
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
