Return-Path: <marc.zyngier@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id DDC2D1A009B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 00:41:19 +1000 (AEST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Will Deacon <will.deacon@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: [PATCH 2/3] powerpc: PCI: Fix lookup of linux, pci-probe-only property
Date: Fri, 14 Aug 2015 15:41:07 +0100
Message-Id: <1439563268-13418-3-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1439563268-13418-1-git-send-email-marc.zyngier@arm.com>
References: <1439563268-13418-1-git-send-email-marc.zyngier@arm.com>
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

Instead, let's check for the validity of the property, and ignore
it if the firmware couldn't make up its mind.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/powerpc/platforms/pseries/setup.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index df6a704..6bdc1f9 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -490,14 +490,19 @@ static void __init find_and_init_phbs(void)
 	 */
 	if (of_chosen) {
 		const int *prop;
+		int len;
 
 		prop = of_get_property(of_chosen,
-				"linux,pci-probe-only", NULL);
+				"linux,pci-probe-only", &len);
 		if (prop) {
-			if (*prop)
-				pci_add_flags(PCI_PROBE_ONLY);
-			else
-				pci_clear_flags(PCI_PROBE_ONLY);
+			if (len) {
+				if (be32_to_cpup(prop))
+					pci_add_flags(PCI_PROBE_ONLY);
+				else
+					pci_clear_flags(PCI_PROBE_ONLY);
+			} else {
+				pr_warn("linux,pci-probe-only set without value, ignoring\n");
+			}
 		}
 	}
 }
-- 
2.1.4
