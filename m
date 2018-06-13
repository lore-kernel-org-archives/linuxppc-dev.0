Return-Path: <kernelfans@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415H1F3bpgzDrp0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 16:30:09 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id w12-v6so763700pgc.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 23:30:09 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@infradead.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [patchV2 0/2] shpchp: no claim on pcie port device
Date: Wed, 13 Jun 2018 14:29:55 +0800
Message-Id: <1528871397-17917-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Linux Device Driver Model allows a physical device to be handled
by only a single driver. But at present, both shpchp and portdrv_pci
claim PCI_CLASS_BRIDGE_PCI. This cause problems, such as the wrong
shutdown seq. This series keeps shpchp driver away from pcie port device.

V1 -> V2:
implement the checking in the process of matching, instead of probing,
which is too late.

Pingfan Liu (2):
  pci: introduce an extra method for matching in pci_driver
  pci/shpchp: no claim on pcie port device

 drivers/pci/hotplug/shpchp_core.c | 13 +++++++++++++
 drivers/pci/pci-driver.c          |  4 ++++
 include/linux/pci.h               |  2 ++
 3 files changed, 19 insertions(+)

-- 
2.7.4
