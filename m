Return-Path: <madalin.bucur@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0071.outbound.protection.outlook.com [104.47.32.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcHfD1HzrzDrCd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 03:31:14 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] Add RSS to DPAA 1.x Ethernet driver
Date: Tue, 22 Aug 2017 20:31:00 +0300
Message-ID: <1503423066-15420-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
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

This patch set introduces Receive Side Scaling for the DPAA Ethernet
driver. Documentation is updated with details related to the new
feature and limitations that apply.
Added also a small fix.

Change from v1: removed a C++ style comment

Iordache Florinel-R70177 (1):
  fsl/fman: enable FMan Keygen

Madalin Bucur (5):
  dpaa_eth: use multiple Rx frame queues
  dpaa_eth: enable Rx hashing control
  dpaa_eth: add NETIF_F_RXHASH
  Documentation: networking: add RSS information
  dpaa_eth: check allocation result

 Documentation/networking/dpaa.txt                  |  68 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |  76 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h     |   2 +
 .../net/ethernet/freescale/dpaa/dpaa_eth_sysfs.c   |   3 +
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c | 118 ++++
 drivers/net/ethernet/freescale/fman/Makefile       |   2 +-
 drivers/net/ethernet/freescale/fman/fman.c         |  26 +
 drivers/net/ethernet/freescale/fman/fman.h         |   2 +
 drivers/net/ethernet/freescale/fman/fman_keygen.c  | 783 +++++++++++++++++++++
 drivers/net/ethernet/freescale/fman/fman_keygen.h  |  46 ++
 drivers/net/ethernet/freescale/fman/fman_port.c    |  51 +-
 drivers/net/ethernet/freescale/fman/fman_port.h    |   7 +
 12 files changed, 1171 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_keygen.c
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_keygen.h

-- 
2.1.0
