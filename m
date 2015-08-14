Return-Path: <marc.zyngier@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 8E7961A0779
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 00:41:17 +1000 (AEST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Will Deacon <will.deacon@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI: pci-host-generic: Fix lookup of linux,
 pci-probe-only property
Date: Fri, 14 Aug 2015 15:41:06 +0100
Message-Id: <1439563268-13418-2-git-send-email-marc.zyngier@arm.com>
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

When pci-host-generic looks for the probe-only property, it seems
to trust the DT to be correctly written, and assumes that there
is a parameter to the property.

Unfortunately, this is not always the case, and some firmware expose
this property naked. The driver ends up making a decision based on
whatever the property pointer points to, which is likely to be junk.

Instead, let's check for the validity of the property, and ignore
it if the firmware couldn't make up its mind.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/host/pci-host-generic.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 265dd25..2b2e2ff 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -211,6 +211,7 @@ static int gen_pci_probe(struct platform_device *pdev)
 	const char *type;
 	const struct of_device_id *of_id;
 	const int *prop;
+	int len;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
@@ -225,12 +226,16 @@ static int gen_pci_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	prop = of_get_property(of_chosen, "linux,pci-probe-only", NULL);
+	prop = of_get_property(of_chosen, "linux,pci-probe-only", &len);
 	if (prop) {
-		if (*prop)
-			pci_add_flags(PCI_PROBE_ONLY);
-		else
-			pci_clear_flags(PCI_PROBE_ONLY);
+		if (len) {
+			if (be32_to_cpup(prop))
+				pci_add_flags(PCI_PROBE_ONLY);
+			else
+				pci_clear_flags(PCI_PROBE_ONLY);
+		} else {
+			dev_warn(&pdev->dev, "linux,pci-probe-only set without value, ignoring\n");
+		}
 	}
 
 	of_id = of_match_node(gen_pci_of_match, np);
-- 
2.1.4
