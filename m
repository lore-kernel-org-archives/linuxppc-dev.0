Return-Path: <michael@ozlabs.org>
To: <linux-kernel@vger.kernel.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 29 Sep 2006 07:53:39 +1000
Subject: [RFC/PATCH 4/7] Allow for non-Intel MSI implementations
In-Reply-To: <1159480412.269240.988552559176.qpush@concordia>
Message-Id: <20060928215341.0AEDF67C5A@ozlabs.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/pci/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: to-merge/drivers/pci/Makefile
===================================================================
--- to-merge.orig/drivers/pci/Makefile
+++ to-merge/drivers/pci/Makefile
@@ -27,7 +27,8 @@ obj-$(CONFIG_PPC64) += setup-bus.o
 obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
 
-msiobj-y := msi.o msi-apic.o
+msiobj-$(CONFIG_X86) := msi.o msi-apic.o
+msiobj-$(CONFIG_IA64) := msi.o msi-apic.o
 msiobj-$(CONFIG_IA64_GENERIC) += msi-altix.o
 msiobj-$(CONFIG_IA64_SGI_SN2) += msi-altix.o
 obj-$(CONFIG_PCI_MSI) += $(msiobj-y)
