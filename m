Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x232.google.com (mail-yh0-x232.google.com
 [IPv6:2607:f8b0:4002:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B07B1A0E46
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:48:15 +1100 (AEDT)
Received: by mail-yh0-f50.google.com with SMTP id t59so12938040yho.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:48:13 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 01/15] PCI: introduce pci_device_to_OF_node() for !CONFIG_OF
Date: Sat, 31 Jan 2015 21:47:31 +0800
Message-Id: <1422712065-9403-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kevin Hao <haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So we can avoid the ugly #ifdef in some drivers.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8323cbf93913..421eb6a9e600 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1863,6 +1863,8 @@ static inline void pci_set_of_node(struct pci_dev *dev) { }
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
 static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
+static inline struct device_node *
+pci_device_to_OF_node(const struct pci_dev *pdev) { return NULL; }
 #endif  /* CONFIG_OF */
 
 #ifdef CONFIG_EEH
-- 
1.9.3
