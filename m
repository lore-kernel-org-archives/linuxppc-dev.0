Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5LjV04xHzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 19:14:34 +1000 (AEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-serial@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 00/11] use of_property_read_bool
Date: Fri,  5 Aug 2016 10:56:40 +0200
Message-Id: <1470387411-15879-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use of_property_read_bool to check for the existence of a property.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e1,e2;
statement S2,S1;
@@
-       if (of_get_property(e1,e2,NULL))
+       if (of_property_read_bool(e1,e2))
        S1 else S2
// </smpl>

---

 arch/powerpc/sysdev/mpic.c                  |    2 +-
 drivers/i2c/busses/i2c-mpc.c                |    2 +-
 drivers/mmc/host/sdhci-of-esdhc.c           |    2 +-
 drivers/net/ethernet/freescale/xgmac_mdio.c |    3 +--
 drivers/phy/phy-qcom-ufs.c                  |    2 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c   |    2 +-
 drivers/soc/fsl/qe/qe_tdm.c                 |    2 +-
 drivers/soc/ti/knav_qmss_queue.c            |    2 +-
 drivers/tty/serial/atmel_serial.c           |    8 ++++----
 drivers/usb/host/fsl-mph-dr-of.c            |    6 +++---
 sound/soc/codecs/ab8500-codec.c             |   10 +++++-----
 sound/soc/sh/rcar/ssi.c                     |    2 +-
 sound/soc/soc-core.c                        |    2 +-
 13 files changed, 22 insertions(+), 23 deletions(-)
