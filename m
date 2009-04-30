Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BDB3DE16A
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 23:10:22 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/9] powerpc/pci: clean up direct access to sysdata by 52xx
	platforms
Date: Thu, 30 Apr 2009 08:10:09 -0500
Message-Id: <1241097015-11208-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1241097015-11208-2-git-send-email-galak@kernel.crashing.org>
References: <1241097015-11208-1-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-2-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We shouldn't directly access sysdata to get the pci_controller.  Instead
use pci_bus_to_host() for this purpose.  In the future we might have
sysdata be a device_node to match ppc64 and unify the code between ppc32
& ppc64.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/52xx/efika.c       |    4 ++--
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index a2068fa..bcc69e1 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -34,7 +34,7 @@
 static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 			    int len, u32 * val)
 {
-	struct pci_controller *hose = bus->sysdata;
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
 	    | (((bus->number - hose->first_busno) & 0xff) << 16)
 	    | (hose->global_number << 24);
@@ -49,7 +49,7 @@ static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 static int rtas_write_config(struct pci_bus *bus, unsigned int devfn,
 			     int offset, int len, u32 val)
 {
-	struct pci_controller *hose = bus->sysdata;
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
 	    | (((bus->number - hose->first_busno) & 0xff) << 16)
 	    | (hose->global_number << 24);
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index 87ff522..dd43114 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -107,7 +107,7 @@ static int
 mpc52xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 				int offset, int len, u32 *val)
 {
-	struct pci_controller *hose = bus->sysdata;
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	u32 value;
 
 	if (ppc_md.pci_exclude_device)
@@ -164,7 +164,7 @@ static int
 mpc52xx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 				int offset, int len, u32 val)
 {
-	struct pci_controller *hose = bus->sysdata;
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	u32 value, mask;
 
 	if (ppc_md.pci_exclude_device)
-- 
1.6.0.6
