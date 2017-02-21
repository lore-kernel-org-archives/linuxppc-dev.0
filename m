Return-Path: <madalin.bucur@nxp.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0065.outbound.protection.outlook.com [104.47.42.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSJmD21FCzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 22:53:15 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <davem@davemloft.net>,
 <camelia.groza@nxp.com>, <linuxppc-dev@lists.ozlabs.org>, Madalin Bucur
 <madalin.bucur@nxp.com>
Subject: [PATCH 0/9] QorIQ DPAA 1 updates 
Date: Tue, 21 Feb 2017 13:52:45 +0200
Message-ID: <1487677974-13678-1-git-send-email-madalin.bucur@nxp.com>
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

This patch set introduces a series of fixes and features to the DPAA 1
drivers. Besides activating hardware Rx checksum offloading, four traffic
classes are added for Tx traffic prioritisation.

Camelia Groza (2):
  dpaa_eth: add four prioritised Tx traffic classes
  dpaa_eth: enable multiple Tx traffic classes

Madalin Bucur (7):
  fsl/fman: parse result data is big endian
  fsl/fman: set HW parser as BMI next engine
  fsl/fman: remove wrong free
  fsl/fman: enlarge FIFO to allow for the 5th port
  dpaa_eth: remove redundant initialization
  dpaa_eth: enable Rx checksum offload
  dpaa_eth: do not ignore port api return value

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c  | 175 +++++++++++++++++++-----
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h  |   8 +-
 drivers/net/ethernet/freescale/fman/fman.c      |  23 +++-
 drivers/net/ethernet/freescale/fman/fman.h      |  10 +-
 drivers/net/ethernet/freescale/fman/fman_port.c |  76 +++++++++-
 5 files changed, 246 insertions(+), 46 deletions(-)

-- 
2.1.0
