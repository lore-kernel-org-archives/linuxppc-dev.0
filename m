Return-Path: <stripath@apm.com>
Received: from denmail01.amcc.com (unknown [192.195.68.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 384641A0AD8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 18:44:35 +1000 (AEST)
From: Suman Tripathi <stripathi@apm.com>
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com,
 patches@apm.com, Suman Tripathi <stripathi@apm.com>
Subject: [PATCH RESEND v7 0/2] Add SDHCI support for APM X-Gene SoC using
 ARASAN SDHCI controller.
Date: Thu, 21 May 2015 14:13:35 +0530
Message-Id: <1432197817-22110-1-git-send-email-stripathi@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.

v1 change:
 * Use the CONFIG_ARM64_DMA_HAS_IOMMU for dma-mapping.

v2 change:
 * Drop the IOMMU support and switching to PIO mode for arasan.
   controller integrated inside APM X-Gene SoC.

v3 change:
 * Change the sdhci-of-arasan.c to support arasan4.9a.
 * Add quirks for arasan4.9a.

v4 change:
 * Cleanup the Documentation and dts.

v5 change:
 * Rebase the dts files.
 * Drop patch 2 and 3 as it is applied.

v6 change:
 * Clean the unrequired properties from dts.
 * Rename sdhc to sdhci.
 * support to disable timming using capability register read.

v7 change:
 * Rename sdhci nodes to mmc.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
Suman Tripathi (2):
  arm64: dts: Add the arasan mmc nodes in apm-storm.dtsi
  mmc: host: sdhci: Add support to disable SDR104/SDR50/DDR50 based on
    capability register 0.

 arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
 arch/arm64/boot/dts/apm/apm-storm.dtsi  | 43 +++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c                |  3 ++-
 3 files changed, 49 insertions(+), 1 deletion(-)

--
1.8.2.1
