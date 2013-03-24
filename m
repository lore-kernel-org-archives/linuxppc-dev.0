Return-Path: <baatz@schnuecks.de>
Received: from mo6-p00-ob.rzone.de (mo6-p00-ob.rzone.de
 [IPv6:2a01:238:20a:202:5300::1])
 by ozlabs.org (Postfix) with ESMTP id F23902C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 07:40:58 +1100 (EST)
From: Simon Baatz <gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, florian@openwrt.org,
 thomas.petazzoni@free-electrons.com
Subject: [PATCH 0/2] Fix for mv643xx_eth built as module
Date: Sun, 24 Mar 2013 21:33:58 +0100
Message-Id: <1364157240-28883-1-git-send-email-gmbnomis@gmail.com>
Cc: Simon Baatz <gmbnomis@gmail.com>, andrew@lunn.ch, jason@lakedaemon.net,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recently [1], mv643xx_eth was changed to make use of mvmdio. However,
this change introduces two problems when mvmdio and mv643xx_eth are
built as modules:

- mvmdio is not loaded automatically by udev
- mv643xx_eth oopses when it can't find its PHY, i.e. when mvmdio is
  not yet loaded

The first problem can be fixed easily by adding a module alias for the
respective platform device.  The proposed fix for the second problem
uses EPROBE_DEFER as suggested by Thomas Petazzoni when the driver
can't find its PHY.

These patches apply on top of Florian Fainelli's patchset. They have
been tested on Marvel Kirkwood non-DT.

- Simon

[1] https://lkml.org/lkml/2013/3/22/247

Simon Baatz (2):
  net: mvmdio: define module alias for platform device
  mv643xx_eth: defer probing if Marvell Orion MDIO driver not loaded

 drivers/net/ethernet/marvell/mv643xx_eth.c |   12 +++++++++---
 drivers/net/ethernet/marvell/mvmdio.c      |    1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
1.7.9.5
