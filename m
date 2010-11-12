Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 34522B712E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Nov 2010 08:38:13 +1100 (EST)
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>
Subject: [PATCH 03/14] arch/powerpc: Use printf extension %pR for struct
	resource
Date: Fri, 12 Nov 2010 13:37:53 -0800
Message-Id: <7654162f86bedd7d4cd5ccc883916157af6a2369.1289597644.git.joe@perches.com>
In-Reply-To: <cover.1289597644.git.joe@perches.com>
References: <cover.1289597644.git.joe@perches.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using %pR standardizes the struct resource output.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/kernel/pci_64.c     |    3 +--
 arch/powerpc/sysdev/tsi108_dev.c |    8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index d43fc65..2ecb1de 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -193,8 +193,7 @@ int __devinit pcibios_map_io_space(struct pci_bus *bus)
 	hose->io_resource.start += io_virt_offset;
 	hose->io_resource.end += io_virt_offset;
 
-	pr_debug("  hose->io_resource=0x%016llx...0x%016llx\n",
-		 hose->io_resource.start, hose->io_resource.end);
+	pr_debug("  hose->io_resource=%pR\n", &hose->io_resource.start);
 
 	return 0;
 }
diff --git a/arch/powerpc/sysdev/tsi108_dev.c b/arch/powerpc/sysdev/tsi108_dev.c
index d4d15aa..5e249a8 100644
--- a/arch/powerpc/sysdev/tsi108_dev.c
+++ b/arch/powerpc/sysdev/tsi108_dev.c
@@ -83,8 +83,8 @@ static int __init tsi108_eth_of_init(void)
 		memset(&tsi_eth_data, 0, sizeof(tsi_eth_data));
 
 		ret = of_address_to_resource(np, 0, &r[0]);
-		DBG("%s: name:start->end = %s:0x%lx-> 0x%lx\n",
-			__func__,r[0].name, r[0].start, r[0].end);
+		DBG("%s: name:start->end = %s:%pR\n",
+		    __func__, r[0].name, &r[0]);
 		if (ret)
 			goto err;
 
@@ -92,8 +92,8 @@ static int __init tsi108_eth_of_init(void)
 		r[1].start = irq_of_parse_and_map(np, 0);
 		r[1].end = irq_of_parse_and_map(np, 0);
 		r[1].flags = IORESOURCE_IRQ;
-		DBG("%s: name:start->end = %s:0x%lx-> 0x%lx\n",
-			__func__,r[1].name, r[1].start, r[1].end);
+		DBG("%s: name:start->end = %s:%pR\n",
+			__func__, r[1].name, &r[1]);
 
 		tsi_eth_dev =
 		    platform_device_register_simple("tsi-ethernet", i++, &r[0],
-- 
1.7.3.1.g432b3.dirty
