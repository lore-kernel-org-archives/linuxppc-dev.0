Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83B831A003D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 17:57:37 +1100 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D0E5814007B
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2014 17:57:36 +1100 (EST)
Message-ID: <1412656674.30859.120.camel@pasglop>
Subject: [PATCH v3 2/7] pci/msi: Add device flag indicating that 64-bit MSIs
 don't work
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 07 Oct 2014 15:37:54 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Anton Blanchard <anton@au1.ibm.com>,
 Yijing Wang <wangyijing@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This can be set by quirks/drivers to be used by the architecture code
that assigns the MSI addresses.

We additionally add verification in the core MSI code that the values
assigned by the architecture do satisfy the limitation in order to fail
gracefully if they don't (ie. the arch hasn't been updated to deal with
that quirk yet).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org>
---
 drivers/pci/msi.c   | 26 ++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 5a40516..6807edd 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -610,6 +610,20 @@ static struct msi_desc *msi_setup_entry(struct pci_dev *dev)
 	return entry;
 }
 
+static int msi_verify_entries(struct pci_dev *dev)
+{
+	struct msi_desc *entry;
+
+	list_for_each_entry(entry, &dev->msi_list, list) {
+		if (!dev->no_64bit_msi || !entry->msg.address_hi)
+			continue;
+		dev_err(&dev->dev, "Device has broken 64-bit MSI but arch"
+			" tried to assign one above 4G\n");
+		return -EIO;
+	}
+	return 0;
+}
+
 /**
  * msi_capability_init - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
@@ -647,6 +661,13 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 		return ret;
 	}
 
+	ret = msi_verify_entries(dev);
+	if (ret) {
+		msi_mask_irq(entry, mask, ~mask);
+		free_msi_irqs(dev);
+		return ret;
+	}
+
 	ret = populate_msi_sysfs(dev);
 	if (ret) {
 		msi_mask_irq(entry, mask, ~mask);
@@ -760,6 +781,11 @@ static int msix_capability_init(struct pci_dev *dev,
 	if (ret)
 		goto out_avail;
 
+	/* Check if all MSI entries honor device restrictions */
+	ret = msi_verify_entries(dev);
+	if (ret)
+		goto out_free;
+
 	/*
 	 * Some devices require MSI-X to be enabled before we can touch the
 	 * MSI-X registers.  We need to mask all the vectors to prevent
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 96453f9..6b6da8f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -331,6 +331,7 @@ struct pci_dev {
 	unsigned int	is_added:1;
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
+	unsigned int	no_64bit_msi:1; /* device may only use 32-bit MSIs */
 	unsigned int	block_cfg_access:1;	/* config space access is blocked */
 	unsigned int	broken_parity_status:1;	/* Device generates false positive parity */
 	unsigned int	irq_reroute_variant:2;	/* device needs IRQ rerouting variant */
