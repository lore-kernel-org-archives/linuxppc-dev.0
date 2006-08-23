Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id B2FFB679E7
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 16:12:44 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7N6Chp5022614
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 23:12:43 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7N6CfM8016327
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 01:12:42 -0500 (CDT)
Message-ID: <44EBF1F4.9030907@freescale.com>
Date: Wed, 23 Aug 2006 14:13:08 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix compile problem without CONFIG_PCI
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Compile fails without defining CONFIG_PCI.  
The patch fix this.

Signed-off-by: Li Yang <leoli@freescale.com>
---

arch/powerpc/kernel/prom_parse.c |    5 ++++-
1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 6a7e997..f460b7d 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -598,10 +598,12 @@ static struct device_node *of_irq_find_p
    return p;
}

+#ifdef CONFIG_PCI
static u8 of_irq_pci_swizzle(u8 slot, u8 pin)
{
    return (((pin - 1) + slot) % 4) + 1;
}
+#endif

/* This doesn't need to be called if you don't have any special workaround
 * flags to pass
@@ -891,6 +893,7 @@ int of_irq_map_one(struct device_node *d
}
EXPORT_SYMBOL_GPL(of_irq_map_one);

+#ifdef CONFIG_PCI
int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
{
    struct device_node *dn, *ppnode;
@@ -967,4 +970,4 @@ #endif
    return of_irq_map_raw(ppnode, &lspec, laddr, out_irq);
}
EXPORT_SYMBOL_GPL(of_irq_map_pci);
-
+#endif
