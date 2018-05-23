Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rjmN0xRvzF132
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 05:50:27 +1000 (AEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linux-pci@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
Subject: [PATCH 0/5] add missing of_node_put
Date: Wed, 23 May 2018 21:07:11 +0200
Message-Id: <1527102436-13447-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The device node iterators perform an of_node_get on each iteration, so a
jump out of the loop requires an of_node_put.

---

 drivers/gpu/drm/rockchip/rockchip_lvds.c   |    4 +++-
 drivers/pci/hotplug/pnv_php.c              |    8 ++++++--
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c |    9 +++++++--
 drivers/pinctrl/pinctrl-at91-pio4.c        |    4 +++-
 drivers/soc/ti/knav_dma.c                  |    1 +
 5 files changed, 20 insertions(+), 6 deletions(-)
