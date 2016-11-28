Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSFXK2fhpzDvhP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 05:27:29 +1100 (AEDT)
Received: by mail-lf0-x244.google.com with SMTP id o141so10368882lff.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 10:27:29 -0800 (PST)
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Vince Bridgers <vbridger@opensource.altera.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Fugang Duan <fugang.duan@nxp.com>,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Li Yang <leoli@freescale.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Felix Fietkau <nbd@openwrt.org>, John Crispin <blogic@openwrt.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Lars Persson <lars.persson@axis.com>, Mugunthan V N <mugunthanvnm@ti.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
 netdev@vger.kernel.org, nios2-dev@lists.rocketboards.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 Johan Hovold <johan@kernel.org>
Subject: [PATCH net 00/16] net: fix fixed-link phydev leaks
Date: Mon, 28 Nov 2016 19:24:53 +0100
Message-Id: <1480357509-28074-1-git-send-email-johan@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series fixes failures to deregister and free fixed-link phydevs
that have been registered using the of_phy_register_fixed_link()
interface.

All but two drivers currently fail to do this and this series fixes most
of them with the exception of a staging driver and the stmmac drivers
which will be fixed by follow-on patches.

Included are also a couple of fixes for related of-node leaks.

Note that all patches except the of_mdio one have been compile-tested
only.

Also note that the series is against net due to dependencies not yet in
net-next.

Johan


Johan Hovold (16):
  net: dsa: slave: fix of-node leak and phy priority
  of_mdio: add helper to deregister fixed-link PHYs
  net: ethernet: altera: fix fixed-link phydev leaks
  net: ethernet: aurora: nb8800: fix fixed-link phydev leaks
  net: ethernet: bcmsysport: fix fixed-link phydev leaks
  net: ethernet: bcmgenet: fix fixed-link phydev leaks
  net: ethernet: fec: fix fixed-link phydev leaks
  net: ethernet: fs_enet: fix fixed-link phydev leaks
  net: ethernet: gianfar: fix fixed-link phydev leaks
  net: ethernet: ucc_geth: fix fixed-link phydev leaks
  net: ethernet: marvell: mvneta: fix fixed-link phydev leaks
  net: ethernet: mediatek: fix fixed-link phydev leaks
  net: ethernet: renesas: ravb: fix fixed-link phydev leaks
  net: ethernet: dwc_eth_qos: fix fixed-link phydev leaks
  net: ethernet: ti: davinci_emac: fix fixed-link phydev and of-node
    leaks
  net: dsa: slave: fix fixed-link phydev leaks

 drivers/net/ethernet/altera/altera_tse_main.c      |  9 ++++++++-
 drivers/net/ethernet/aurora/nb8800.c               |  9 +++++++--
 drivers/net/ethernet/broadcom/bcmsysport.c         | 17 +++++++++++-----
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |  6 ++++++
 drivers/net/ethernet/freescale/fec_main.c          |  5 +++++
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |  7 ++++++-
 drivers/net/ethernet/freescale/gianfar.c           |  8 ++++++++
 drivers/net/ethernet/freescale/ucc_geth.c          | 23 +++++++++++++++-------
 drivers/net/ethernet/marvell/mvneta.c              |  5 +++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  4 ++++
 drivers/net/ethernet/renesas/ravb_main.c           | 17 +++++++++++++---
 drivers/net/ethernet/synopsys/dwc_eth_qos.c        | 20 ++++++++++++-------
 drivers/net/ethernet/ti/cpsw.c                     | 16 ++-------------
 drivers/net/ethernet/ti/davinci_emac.c             | 10 +++++++++-
 drivers/of/of_mdio.c                               | 15 ++++++++++++++
 include/linux/of_mdio.h                            |  4 ++++
 net/dsa/dsa.c                                      | 12 ++---------
 net/dsa/slave.c                                    | 19 +++++++++++++++---
 18 files changed, 152 insertions(+), 54 deletions(-)

-- 
2.7.3
