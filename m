Return-Path: <kernelfans@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415H1H3n8NzDrp0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 16:30:11 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id 31-v6so923787plc.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 23:30:11 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@infradead.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [patchV2 1/2] pci: introduce an extra method for matching in
 pci_driver
Date: Wed, 13 Jun 2018 14:29:56 +0800
Message-Id: <1528871397-17917-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1528871397-17917-1-git-send-email-kernelfans@gmail.com>
References: <1528871397-17917-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In __driver_attach(), if a driver matches a device, the device will
be appended to the tail of devices_kset, no matter what the probing
result of the device. Hence in order to prevent a driver to append
a probed device to devices_kset, it requires a correct matching.

As for pci, pci driver uses pci_device_id to match a device. But it may
be not enough, since there is need for extra info such as pcie, which
can not be provided in pci_device_id. Such info is driver specific, and
this patch introduces a new method "extra_match" in pci_driver.
This is used by next patch.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/pci/pci-driver.c | 4 ++++
 include/linux/pci.h      | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index b9a1311..151865f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -273,6 +273,10 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
 	if (!found_id && dev->driver_override)
 		found_id = &pci_device_id_any;
 
+	/* more strictly matching besides id_table */
+	if (drv->extra_match && drv->extra_match(dev) < 0)
+		found_id = NULL;
+
 	return found_id;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 73178a2..6ed960d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -738,10 +738,12 @@ struct pci_error_handlers {
 
 
 struct module;
+typedef int (*ematch)(struct pci_dev *pdev);
 struct pci_driver {
 	struct list_head	node;
 	const char		*name;
 	const struct pci_device_id *id_table;	/* Must be non-NULL for probe to be called */
+	ematch extra_match;	/* more strictly matching besides id_table */
 	int  (*probe)(struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove)(struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
-- 
2.7.4
