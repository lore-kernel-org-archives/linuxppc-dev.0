Return-Path: <bhelgaas@google.com>
Received: from mail-oa0-x229.google.com (mail-oa0-x229.google.com
 [IPv6:2607:f8b0:4003:c02::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 888C62C0159
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 03:57:33 +1000 (EST)
Received: by mail-oa0-f41.google.com with SMTP id n10so5214951oag.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 10:57:30 -0700 (PDT)
Subject: [PATCH 2/2] PCI: pciehp: Convert pciehp to be builtin only,
 not modular
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 25 Jul 2013 11:57:27 -0600
Message-ID: <20130725175727.6006.98109.stgit@bhelgaas-glaptop>
In-Reply-To: <20130725175242.6006.56007.stgit@bhelgaas-glaptop>
References: <20130725175242.6006.56007.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
 Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>,
 Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert pciehp to be builtin only, with no module option.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pcie/Kconfig |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 569f82f..3b94cfc 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -14,15 +14,12 @@ config PCIEPORTBUS
 # Include service Kconfig here
 #
 config HOTPLUG_PCI_PCIE
-	tristate "PCI Express Hotplug driver"
+	bool "PCI Express Hotplug driver"
 	depends on HOTPLUG_PCI && PCIEPORTBUS
 	help
 	  Say Y here if you have a motherboard that supports PCI Express Native
 	  Hotplug
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called pciehp.
-
 	  When in doubt, say N.
 
 source "drivers/pci/pcie/aer/Kconfig"
