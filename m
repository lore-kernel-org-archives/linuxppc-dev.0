Return-Path: <galak@freescale.com>
Date: Mon, 10 Oct 2005 14:55:13 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510101454470.1572@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: Fix building on non-MULTIPLATFORM machines
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On !CONFIG_PPC_MULTIPLATFORM _machine is defined as 0.  This is ok, but
we can't assign a value to _machine then.  Also, we may not have

CONFIG_PCI available, so only build in support for
find_parent_pci_resource(), request_OF_resource(), release_OF_resource()
if PCI is enabled.  This is probably not the long term fix but works out
for now.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit 00c61049131b483e217a7327f2f55dff40db8cbc
tree d1915b9b33372f5e89b6b8ef581681f49b24bab4
parent 56381a9f0765ba3ffa5f21a4cdcb93ac0279eeea
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 10 Oct 2005 14:54:32 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 10 Oct 2005 14:54:32 -0500

 arch/powerpc/kernel/prom.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1129,8 +1129,10 @@ static int __init early_init_dt_scan_cho
 #ifdef CONFIG_PPC64
 	systemcfg->platform = *prop;
 #else
+#ifdef CONFIG_PPC_MULTIPLATFORM
 	_machine = *prop;
 #endif
+#endif
 
 #ifdef CONFIG_PPC64
 	/* check if iommu is forced on or off */
@@ -1987,6 +1989,7 @@ bus_space_to_resource_flags(unsigned int
 	}
 }
 
+#ifdef CONFIG_PCI
 static struct resource *find_parent_pci_resource(struct pci_dev* pdev,
 						 struct address_range *range)
 {
@@ -2139,3 +2142,4 @@ int release_OF_resource(struct device_no
 	return 0;
 }
 EXPORT_SYMBOL(release_OF_resource);
+#endif /* CONFIG_PCI */
