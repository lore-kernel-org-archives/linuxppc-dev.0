Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
In-Reply-To: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
Date: Wed, 17 Oct 2007 17:12:27 +1000 (EST)
Cc: sparclinux@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	"David S. Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use of_get_pci_dev_node() in axon_msi.c. Switch to including <linux/of.h>
so we get the prototype.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/axon_msi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 095988f..034041c 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -14,10 +14,10 @@
 #include <linux/pci.h>
 #include <linux/msi.h>
 #include <linux/reboot.h>
+#include <linux/of.h>
 
 #include <asm/dcr.h>
 #include <asm/machdep.h>
-#include <asm/prom.h>
 
 
 /*
@@ -119,7 +119,7 @@ static struct axon_msic *find_msi_translator(struct pci_dev *dev)
 	const phandle *ph;
 	struct axon_msic *msic = NULL;
 
-	dn = of_node_get(pci_device_to_OF_node(dev));
+	dn = of_get_pci_dev_node(dev);
 	if (!dn) {
 		dev_dbg(&dev->dev, "axon_msi: no pci_dn found\n");
 		return NULL;
@@ -176,7 +176,7 @@ static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 	int len;
 	const u32 *prop;
 
-	dn = of_node_get(pci_device_to_OF_node(dev));
+	dn = of_get_pci_dev_node(dev);
 	if (!dn) {
 		dev_dbg(&dev->dev, "axon_msi: no pci_dn found\n");
 		return -ENODEV;
-- 
1.5.1.3.g7a33b
