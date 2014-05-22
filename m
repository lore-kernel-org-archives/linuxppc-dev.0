Return-Path: <f.fainelli@gmail.com>
Received: from mail-ie0-x230.google.com (mail-ie0-x230.google.com
 [IPv6:2607:f8b0:4001:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D49761A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 02:48:14 +1000 (EST)
Received: by mail-ie0-f176.google.com with SMTP id rl12so3848506iec.35
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 09:48:11 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/9] net: of_phy_connect_fixed_link removal
Date: Thu, 22 May 2014 09:47:42 -0700
Message-Id: <1400777271-32199-1-git-send-email-f.fainelli@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Aida Mynzhasova <aida.mynzhasova@skitlab.ru>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Richard Cochran <richardcochran@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, Grant Likely <grant.likely@linaro.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

This patch set removes of_phy_connect_fixed_link() from the tree now that
we have a better solution for dealing with fixed PHY (emulated PHY) devices
for drivers that require them.

First two patches update the 'fixed-link' Device Tree binding and drivers to
refere to it.

Patches 3 to 7 update the in-tree network drivers that use
of_phy_connect_fixed_link()

Patch 8 removes of_phy_connect_fixed_link

Patch 9 removes the PowerPC code that parsed the 'fixed-link' property.

Patch 9 can be merged via the net-next tree if the PowerPC folks ack it,
but it really has to be merged after the first 8 patches in order to avoid
breakage.

Florian Fainelli (9):
  Documentation: devicetree: add old and deprecated 'fixed-link'
  Documentation: devicetree: net: refer to fixed-link.txt
  net: bcmgenet: use the new fixed PHY helpers
  net: systemport: use the new fixed PHY helpers
  fs_enet: use the new fixed PHY helpers
  gianfar: use the new fixed PHY helpers
  ucc_geth: use the new fixed PHY helpers
  of: mdio: remove of_phy_connect_fixed_link
  powerpc/fsl: fsl_soc: remove 'fixed-link' parsing code

 .../devicetree/bindings/net/broadcom-bcmgenet.txt  |  2 +-
 .../bindings/net/broadcom-systemport.txt           |  2 +-
 .../devicetree/bindings/net/fixed-link.txt         | 12 +++++++
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |  5 +--
 arch/powerpc/sysdev/fsl_soc.c                      | 32 ------------------
 drivers/net/ethernet/broadcom/bcmsysport.c         | 17 ++++++++--
 drivers/net/ethernet/broadcom/bcmsysport.h         |  1 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c       | 21 +++++++-----
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  | 17 ++++++----
 drivers/net/ethernet/freescale/gianfar.c           | 14 ++++++--
 drivers/net/ethernet/freescale/ucc_geth.c          | 14 ++++++--
 drivers/of/of_mdio.c                               | 38 ----------------------
 include/linux/of_mdio.h                            | 10 ------
 13 files changed, 76 insertions(+), 109 deletions(-)

-- 
1.9.1
