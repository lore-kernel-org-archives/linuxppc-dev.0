Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCd0X5cH7zDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 07:19:56 +1100 (AEDT)
Subject: [PATCH 1 0/4] PCI: Use of_device_get_match_data() to simplify probe
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: Scott Branden <sbranden@broadcom.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Simon Horman <horms@verge.net.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>,
 Shailendra Verma <shailendra.v@samsung.com>
Date: Tue, 31 Jan 2017 14:19:51 -0600
Message-ID: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This turned into much ado about nothing, but Shailendra's hisi patch
prompted similar cleanups in other drivers.  It's a minor simplification,
but I think worth doing consistently across drivers.

Basically this is Geert's observation that when the driver probe function
is called only as a result of matching something in <match_table>, a
subsequent of_match_device(<match_table>, dev) call should never fail.

Therefore, instead of this:

  struct of_device_id *match;

  match = of_match_device(<match_table>, dev);
  ... = match->data;

we can do this:

  ... = of_device_get_match_data(dev);

---

Bjorn Helgaas (3):
      PCI: iproc: Use of_device_get_match_data() to simplify probe
      PCI: layerscape: Use of_device_get_match_data() to simplify probe
      PCI: rcar: Use of_device_get_match_data() to simplify probe

Shailendra Verma (1):
      PCI: hisi: Use of_device_get_match_data() to simplify probe


 drivers/pci/host/pci-layerscape.c      |    7 +------
 drivers/pci/host/pcie-hisi.c           |    8 +++-----
 drivers/pci/host/pcie-iproc-platform.c |    7 +------
 drivers/pci/host/pcie-rcar.c           |    7 +------
 4 files changed, 6 insertions(+), 23 deletions(-)
