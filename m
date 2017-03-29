Return-Path: <roy.pledge@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0054.outbound.protection.outlook.com [104.47.36.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtgVj45VrzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 08:14:05 +1100 (AEDT)
From: Roy Pledge <roy.pledge@nxp.com>
To: <robin.murphy@arm.com>, <oss@buserror.net>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>
CC: <madalin.bucur@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [RFC PATCH 0/5] soc/fsl/qbman: Rework private memory allocations
Date: Wed, 29 Mar 2017 17:13:52 -0400
Message-ID: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
Reply-To: <roy.pledge@nxp.com>
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

The QBMan device requires three separate memory areas that are only
accessed by the device. These areas are reserved using the OF reserved
memory mechanism and associated to the device in the device trees
memory-region attribute. However in order to be allocatable using
the dma_alloc() APIs the reservations compatiable string must
include "shared-dma-pool" and specify "no-map".

This set of changes updates the QBMan driver, PPC device trees and
bindings to use the above mechasism. This work was encouraged as part
of preparing this driver to work on ARM processors.

Roy Pledge (5):
  soc/fsl/qbman: Use shared-dma-pool for BMan private memory allocations
  soc/fsl/qbman: Use shared-dma-pool for QMan private memory allocations
  dts: arch/powerpc: Update Freescale DTS for QBMan memory allocations
  dt-bindings: soc/fsl: Update reserved memory binding for QBMan
  powerpc: Add HAVE_GENERIC_DMA_COHERENT options to Kconfig

 Documentation/devicetree/bindings/soc/fsl/bman.txt |  10 +-
 Documentation/devicetree/bindings/soc/fsl/qman.txt |  16 +--
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/boot/dts/fsl/b4qds.dtsi               |   6 ++
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |  15 ---
 arch/powerpc/boot/dts/fsl/cyrus_p5020.dts          |   6 ++
 arch/powerpc/boot/dts/fsl/kmcent2.dts              |   6 ++
 arch/powerpc/boot/dts/fsl/kmcoge4.dts              |   6 ++
 arch/powerpc/boot/dts/fsl/oca4080.dts              |   6 ++
 arch/powerpc/boot/dts/fsl/p1023rdb.dts             |   6 ++
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi        |  15 ---
 arch/powerpc/boot/dts/fsl/p2041rdb.dts             |   6 ++
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  15 ---
 arch/powerpc/boot/dts/fsl/p3041ds.dts              |   6 ++
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |  15 ---
 arch/powerpc/boot/dts/fsl/p4080ds.dts              |   6 ++
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |  15 ---
 arch/powerpc/boot/dts/fsl/p5020ds.dts              |   6 ++
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |  15 ---
 arch/powerpc/boot/dts/fsl/p5040ds.dts              |   6 ++
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |  15 ---
 arch/powerpc/boot/dts/fsl/t1023rdb.dts             |   6 ++
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |  15 ---
 arch/powerpc/boot/dts/fsl/t1024qds.dts             |   6 ++
 arch/powerpc/boot/dts/fsl/t1024rdb.dts             |   6 ++
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  15 ---
 arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi          |   6 ++
 arch/powerpc/boot/dts/fsl/t104xqds.dtsi            |   6 ++
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi            |   6 ++
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        |  15 ---
 arch/powerpc/boot/dts/fsl/t208xqds.dtsi            |   6 ++
 arch/powerpc/boot/dts/fsl/t208xrdb.dtsi            |   6 ++
 arch/powerpc/boot/dts/fsl/t4240qds.dts             |   6 ++
 arch/powerpc/boot/dts/fsl/t4240rdb.dts             |   6 ++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |  15 ---
 drivers/soc/fsl/qbman/bman_ccsr.c                  |  27 ++++-
 drivers/soc/fsl/qbman/bman_priv.h                  |   3 +
 drivers/soc/fsl/qbman/qman_ccsr.c                  | 119 ++++++++++++---------
 drivers/soc/fsl/qbman/qman_priv.h                  |   4 +-
 drivers/soc/fsl/qbman/qman_test.h                  |   2 -
 40 files changed, 238 insertions(+), 235 deletions(-)

--
2.9.3
