Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1540DEB0F
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 02:02:15 +1000 (EST)
Date: Tue, 15 Apr 2008 11:02:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [RESEND PATCH] cuboot-pq2: PCI fixes
Message-ID: <20080415160231.GA2642@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1. Detect (and bail out on) more conditions that violate the
assumptions of the setup code -- we assume in such cases that the device
tree is correct and reflects what the firmware did.

2. The inbound memory mask calculation was wrong.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/cuboot-pq2.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/cuboot-pq2.c b/arch/powerpc/boot/cuboot-pq2.c
index f56ac6c..9c7d134 100644
--- a/arch/powerpc/boot/cuboot-pq2.c
+++ b/arch/powerpc/boot/cuboot-pq2.c
@@ -128,7 +128,7 @@ static void fixup_pci(void)
 	u8 *soc_regs;
 	int i, len;
 	void *node, *parent_node;
-	u32 naddr, nsize, mem_log2;
+	u32 naddr, nsize, mem_pow2, mem_mask;
 
 	node = finddevice("/pci");
 	if (!node || !dt_is_compatible(node, "fsl,pq2-pci"))
@@ -141,7 +141,7 @@ static void fixup_pci(void)
 
 	soc_regs = (u8 *)fsl_get_immr();
 	if (!soc_regs)
-		goto err;
+		goto unhandled;
 
 	dt_get_reg_format(node, &naddr, &nsize);
 	if (naddr != 3 || nsize != 2)
@@ -153,7 +153,7 @@ static void fixup_pci(void)
 
 	dt_get_reg_format(parent_node, &naddr, &nsize);
 	if (naddr != 1 || nsize != 1)
-		goto err;
+		goto unhandled;
 
 	len = getprop(node, "ranges", pci_ranges_buf,
 	              sizeof(pci_ranges_buf));
@@ -170,14 +170,20 @@ static void fixup_pci(void)
 	}
 
 	if (!mem || !mmio || !io)
-		goto err;
+		goto unhandled;
+	if (mem->size[1] != mmio->size[1])
+		goto unhandled;
+	if (mem->size[1] & (mem->size[1] - 1))
+		goto unhandled;
+	if (io->size[1] & (io->size[1] - 1))
+		goto unhandled;
 
 	if (mem->phys_addr + mem->size[1] == mmio->phys_addr)
 		mem_base = mem;
 	else if (mmio->phys_addr + mmio->size[1] == mem->phys_addr)
 		mem_base = mmio;
 	else
-		goto err;
+		goto unhandled;
 
 	out_be32(&pci_regs[1][0], mem_base->phys_addr | 1);
 	out_be32(&pci_regs[2][0], ~(mem->size[1] + mmio->size[1] - 1));
@@ -201,8 +207,9 @@ static void fixup_pci(void)
 	out_le32(&pci_regs[0][58], 0);
 	out_le32(&pci_regs[0][60], 0);
 
-	mem_log2 = 1 << (__ilog2_u32(bd.bi_memsize - 1) + 1);
-	out_le32(&pci_regs[0][62], 0xa0000000 | ~((1 << (mem_log2 - 12)) - 1));
+	mem_pow2 = 1 << (__ilog2_u32(bd.bi_memsize - 1) + 1);
+	mem_mask = ~(mem_pow2 - 1) >> 12;
+	out_le32(&pci_regs[0][62], 0xa0000000 | mem_mask);
 
 	/* If PCI is disabled, drive RST high to enable. */
 	if (!(in_le32(&pci_regs[0][32]) & 1)) {
@@ -228,7 +235,11 @@ static void fixup_pci(void)
 	return;
 
 err:
-	printf("Bad PCI node\r\n");
+	printf("Bad PCI node -- using existing firmware setup.\r\n");
+	return;
+
+unhandled:
+	printf("Unsupported PCI node -- using existing firmware setup.\r\n");
 }
 
 static void pq2_platform_fixups(void)
-- 
1.5.3.8
