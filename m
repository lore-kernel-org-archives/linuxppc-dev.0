Return-Path: <Ganapatrao.Kulkarni@caviumnetworks.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0068.outbound.protection.outlook.com [65.55.169.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFF511A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 04:08:01 +1100 (AEDT)
From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
To: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-ia64@vger.kernel.org>, <linux-metag@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
 <linux-sh@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <Will.Deacon@arm.com>, <catalin.marinas@arm.com>, <grant.likely@linaro.org>,
 <leif.lindholm@linaro.org>, <rfranz@cavium.com>, <ard.biesheuvel@linaro.org>,
 <msalter@redhat.com>, <robh+dt@kernel.org>, <steve.capper@linaro.org>,
 <hanjun.guo@linaro.org>, <al.stone@linaro.org>, <arnd@arndb.de>,
 <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>, <rjw@rjwysocki.net>,
 <lenb@kernel.org>, <marc.zyngier@arm.com>, <lorenzo.pieralisi@arm.com>,
 <bhelgaas@google.com>, <tony.luck@intel.com>, <fenghua.yu@intel.com>,
 <james.hogan@imgtec.com>, <benh@kernel.crashing.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
 <jonathan@jonmasters.org>, <rrichter@cavium.com>,
 <Prasun.Kapoor@caviumnetworks.com>
CC: <gpkulkarni@gmail.com>
Subject: [PATCH v9 5/6] PCI: generic: Make pci-host-generic driver numa aware
Date: Mon, 18 Jan 2016 22:06:04 +0530
Message-ID: <1453134965-6125-6-git-send-email-gkulkarni@caviumnetworks.com>
In-Reply-To: <1453134965-6125-1-git-send-email-gkulkarni@caviumnetworks.com>
References: <1453134965-6125-1-git-send-email-gkulkarni@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

update numa_node of device associated with pci bus.
moved down devm_kzalloc to allocate from node memory.

Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
---
 drivers/pci/host/pci-host-generic.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 5434c90..0e1ce06 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -215,11 +215,9 @@ static int gen_pci_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	struct gen_pci *pci;
 	struct pci_bus *bus, *child;
 
-	if (!pci)
-		return -ENOMEM;
 
 	type = of_get_property(np, "device_type", NULL);
 	if (!type || strcmp(type, "pci")) {
@@ -230,6 +228,11 @@ static int gen_pci_probe(struct platform_device *pdev)
 	of_pci_check_probe_only();
 
 	of_id = of_match_node(gen_pci_of_match, np);
+	set_dev_node(dev, of_node_to_nid(np));
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
 	pci->cfg.ops = (struct gen_pci_cfg_bus_ops *)of_id->data;
 	pci->host.dev.parent = dev;
 	INIT_LIST_HEAD(&pci->host.windows);
-- 
1.8.1.4
