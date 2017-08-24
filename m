Return-Path: <madalin.bucur@nxp.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0071.outbound.protection.outlook.com [104.47.42.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdG9x0hwPzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 17:28:36 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/7]  Add RSS to DPAA 1.x Ethernet driver
Date: Thu, 24 Aug 2017 10:28:21 +0300
Message-ID: <1503559708-13405-1-git-send-email-madalin.bucur@nxp.com>
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

v2: removed a C++ style comment
v3: move struct fman to header file to avoid exporting a function

Iordache Florinel-R70177 (1):
  fsl/fman: enable FMan Keygen

Madalin Bucur (6):
  fsl/fman: move struct fman to header file
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
 drivers/net/ethernet/freescale/fman/fman.c         |  82 +--
 drivers/net/ethernet/freescale/fman/fman.h         |  75 ++
 drivers/net/ethernet/freescale/fman/fman_keygen.c  | 783 +++++++++++++++++++++
 drivers/net/ethernet/freescale/fman/fman_keygen.h  |  46 ++
 drivers/net/ethernet/freescale/fman/fman_port.c    |  51 +-
 drivers/net/ethernet/freescale/fman/fman_port.h    |   7 +
 12 files changed, 1226 insertions(+), 87 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_keygen.c
 create mode 100644 drivers/net/ethernet/freescale/fman/fman_keygen.h

-- 
2.1.0
