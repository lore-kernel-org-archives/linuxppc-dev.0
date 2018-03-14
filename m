Return-Path: <madalin.bucur@nxp.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10059.outbound.protection.outlook.com [40.107.1.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401XqW0CBgzF0nm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 00:38:23 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 camelia.groza@nxp.com, leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 0/5] DPAA Ethernet fixes
Date: Wed, 14 Mar 2018 08:37:27 -0500
Message-Id: <20180314133732.24068-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
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

Hi,

This patch set is addressing several issues in the DPAA Ethernet
driver suite:

 - module unload crash caused by wrong reference to device being left
   in the cleanup code after the DSA related changes
 - scheduling wile atomic bug in QMan code revealed during dpaa_eth
   module unload
 - a couple of error counter fixes, a duplicated init in dpaa_eth.

Madalin

Camelia Groza (3):
  dpaa_eth: remove duplicate initialization
  dpaa_eth: increment the RX dropped counter when needed
  dpaa_eth: remove duplicate increment of the tx_errors counter

Madalin Bucur (2):
  soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
  dpaa_eth: fix error in dpaa_remove()

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |  8 ++++----
 drivers/soc/fsl/qbman/qman.c                   | 28 +++++---------------------
 2 files changed, 9 insertions(+), 27 deletions(-)

-- 
2.1.0
