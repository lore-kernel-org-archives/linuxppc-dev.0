Return-Path: <bhelgaas@google.com>
Received: from mail-oa0-x236.google.com (mail-oa0-x236.google.com
 [IPv6:2607:f8b0:4003:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E20AB2C00DF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 03:57:18 +1000 (EST)
Received: by mail-oa0-f54.google.com with SMTP id o6so5161578oag.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 10:57:15 -0700 (PDT)
Subject: [PATCH 0/2] PCI: Convert hotplug core and pciehp to be builtin only
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 25 Jul 2013 11:57:12 -0600
Message-ID: <20130725175242.6006.56007.stgit@bhelgaas-glaptop>
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

Yinghai is working on a regression fix ("PCI: Separate stop and remove
devices in pciehp") that needs to go into v3.11, and his fix will be
simpler if we remove the module option for pciehp in v3.11.  That will mean
he won't have to export pci_stop_bus_device() and pci_remove_bus_device()
for use by modules.

So these two patches convert CONFIG_HOTPLUG_PCI and CONFIG_HOTPLUG_PCI_PCIE
to be bool (not tristate) and update defconfig files that had
CONFIG_HOTPLUG_PCI=m.

The motivation was for CONFIG_HOTPLUG_PCI_PCIE, but I also converted
CONFIG_HOTPLUG_PCI to bool because the CONFIG_HOTPLUG_PCI=m and
CONFIG_HOTPLUG_PCI_PCIE=y combination was accepted by Kconfig and builds a
kernel, but pciehp doesn't actually work in that case (pointed out by
Yinghai, thanks!)

These are intended for v3.11.

---

Bjorn Helgaas (2):
      PCI: hotplug: Convert to be builtin only, not modular
      PCI: pciehp: Convert pciehp to be builtin only, not modular


 arch/ia64/configs/generic_defconfig    |    2 +-
 arch/ia64/configs/gensparse_defconfig  |    2 +-
 arch/ia64/configs/tiger_defconfig      |    2 +-
 arch/ia64/configs/xen_domu_defconfig   |    2 +-
 arch/powerpc/configs/ppc64_defconfig   |    2 +-
 arch/powerpc/configs/ppc64e_defconfig  |    2 +-
 arch/powerpc/configs/pseries_defconfig |    2 +-
 arch/sh/configs/sh03_defconfig         |    2 +-
 drivers/pci/hotplug/Kconfig            |    5 +----
 drivers/pci/pcie/Kconfig               |    5 +----
 10 files changed, 10 insertions(+), 16 deletions(-)
