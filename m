Return-Path: <kishon@ti.com>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPH8H3rbMzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 00:30:06 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>, <nsekhar@ti.com>, Kishon Vijay
 Abraham I <kishon@ti.com>
Subject: [PATCH 0/4] PCI: dwc: cleanup designware driver
Date: Thu, 16 Feb 2017 18:59:08 +0530
Message-ID: <1487251752-12478-1-git-send-email-kishon@ti.com>
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

This series does additional cleanup on top of [1] in preparation
for adding endpoint mode support to designware driver.

This series was previously sent as part of endpoint support series [2].

Once this series is merged, PCI endpoint series can be merged. I'll wait
for this series to be merged before sending the next revision of endpoint
series.

The entire endpoint support is pushed here:
git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git next

[1] -> https://lkml.org/lkml/2017/2/15/273
[2] -> https://lkml.org/lkml/2017/1/13/562

Kishon Vijay Abraham I (4):
  PCI: dwc: designware: Add new *ops* for cpu addr fixup
  PCI: dwc: dra7xx: Populate cpu_addr_fixup ops
  PCI: dwc: all: Modify dbi accessors to take dbi_base as argument
  PCI: dwc: all: Modify dbi accessors to access data of 4/2/1     
    bytes

 drivers/pci/dwc/pci-dra7xx.c           |   21 ++++---
 drivers/pci/dwc/pci-exynos.c           |   14 +++--
 drivers/pci/dwc/pci-imx6.c             |   67 +++++++++++---------
 drivers/pci/dwc/pci-keystone-dw.c      |   16 +++--
 drivers/pci/dwc/pcie-armada8k.c        |   39 +++++++-----
 drivers/pci/dwc/pcie-artpec6.c         |    7 ++-
 drivers/pci/dwc/pcie-designware-host.c |   20 +++---
 drivers/pci/dwc/pcie-designware.c      |  108 ++++++++++++++++++++------------
 drivers/pci/dwc/pcie-designware.h      |   13 ++--
 drivers/pci/dwc/pcie-hisi.c            |   17 ++---
 10 files changed, 192 insertions(+), 130 deletions(-)

-- 
1.7.9.5
