Return-Path: <madalin.bucur@nxp.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0060.outbound.protection.outlook.com [104.47.42.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thwS22MLszDwJS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 20:22:42 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <scott.wood@nxp.com>, <mpe@ellerman.id.au>
Subject: [PATCH net v2 0/5] fsl/fman: fixes for ARM
Date: Mon, 19 Dec 2016 11:22:18 +0200
Message-ID: <1482139343-8975-1-git-send-email-madalin.bucur@nxp.com>
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

The patch set fixes advertised speeds for QSGMII interfaces, disables
A007273 erratum workaround on non-PowerPC platforms where it does not
apply, enables compilation on ARM64 and addresses a probing issue on
non PPC platforms.

Changes from v1: unifying probing on all supported platforms

Igal Liberman (1):
  fsl/fman: call of_platform_populate()

Madalin Bucur (4):
  fsl/fman: fix 1G support for QSGMII interfaces
  powerpc: remove fsl,fman from of_device_ids[]
  fsl/fman: A007273 only applies to PPC SoCs
  fsl/fman: enable compilation on ARM64

 arch/powerpc/platforms/85xx/corenet_generic.c |  3 ---
 drivers/net/ethernet/freescale/fman/Kconfig   |  2 +-
 drivers/net/ethernet/freescale/fman/fman.c    | 16 ++++++++++++++++
 drivers/net/ethernet/freescale/fman/mac.c     |  1 +
 4 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.1.0
