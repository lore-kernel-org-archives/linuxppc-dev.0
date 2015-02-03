Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x235.google.com (mail-yh0-x235.google.com
 [IPv6:2607:f8b0:4002:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE9621A0010
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 12:37:40 +1100 (AEDT)
Received: by mail-yh0-f53.google.com with SMTP id v1so17381805yhn.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Feb 2015 17:37:37 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 01/15] PCI: Add pci_device_to_OF_node() stub for !CONFIG_OF
Date: Tue,  3 Feb 2015 09:37:24 +0800
Message-Id: <1422927444-31292-1-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422923108.4625.2.camel@ellerman.id.au>
References: <1422923108.4625.2.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a stub for pci_device_to_OF_node() so drivers don't need to
use #ifdef CONFIG_OF around calls to it.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Hi Bjorn,

Here is the revised version with the update of the subject and commit log
in case that you want to take it for 3.20. Otherwise we will merge this
version to powerpc tree during the 3.21 cycle.

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
