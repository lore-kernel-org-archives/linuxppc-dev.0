Return-Path: <marc.zyngier@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id E3A6C1A2753
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 22:16:43 +1000 (AEST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Will Deacon <will.deacon@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 3/4] powerpc: PCI: Fix lookup of linux,
 pci-probe-only property
Date: Thu,  3 Sep 2015 13:16:15 +0100
Message-Id: <1441282576-7304-4-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1441282576-7304-1-git-send-email-marc.zyngier@arm.com>
References: <1441282576-7304-1-git-send-email-marc.zyngier@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When find_and_init_phbs() looks for the probe-only property, it seems
to trust the firmware to be correctly written, and assumes that there
is a parameter to the property.

It is conceivable that the firmware could not be that perfect, and it
could expose this property naked (at least one arm64 platform seems to
exhibit this exact behaviour). The setup code the ends up making
a decision based on whatever the property pointer points to, which
is likely to be junk.

Instead, switch to the common of_pci.c implementation that doesn't
suffer from this problem and ignore the property if the firmware
couldn't make up its mind.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/powerpc/platforms/pseries/setup.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 39a74fa..412531f 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -40,6 +40,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/of.h>
+#include <linux/of_pci.h>
 #include <linux/kexec.h>
 
 #include <asm/mmu.h>
@@ -495,18 +496,7 @@ static void __init find_and_init_phbs(void)
 	 * PCI_PROBE_ONLY and PCI_REASSIGN_ALL_BUS can be set via properties
 	 * in chosen.
 	 */
-	if (of_chosen) {
-		const int *prop;
-
-		prop = of_get_property(of_chosen,
-				"linux,pci-probe-only", NULL);
-		if (prop) {
-			if (*prop)
-				pci_add_flags(PCI_PROBE_ONLY);
-			else
-				pci_clear_flags(PCI_PROBE_ONLY);
-		}
-	}
+	of_pci_check_probe_only(of_chosen);
 }
 
 static void __init pSeries_setup_arch(void)
-- 
2.1.4
