Return-Path: <stripath@apm.com>
Received: from denmail01.amcc.com (unknown [192.195.68.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 5589D1A0F98
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 22:01:38 +1000 (AEST)
From: Suman Tripathi <stripathi@apm.com>
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com,
 ulf.hansson@linaro.org, khilman@deeprootsystems.com, olof@lixom.net
Cc: linux-mmc@vger.kernel.org, arm@kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com,
 patches@apm.com, Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v8 0/2] Add SDHCI support for APM X-Gene SoC using ARASAN
 SDHCI controller.
Date: Fri, 19 Jun 2015 17:30:25 +0530
Message-Id: <1434715227-27399-1-git-send-email-stripathi@apm.com>
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

v8 change:
 * Drop the support to disable timming using capability register read.
 * Add SDHCI_QUIRK2_NO_1_8_V for 4.9a version of arasan.

Suman Tripathi (2):
  arm64: dts: Add the arasan mmc nodes in apm-storm.dtsi
  mmc: host: sdhci: Disable 1.8V signaling for arasan 4.9a version of
    SDHCI controller.

 arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
 arch/arm64/boot/dts/apm/apm-storm.dtsi  | 43 +++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-arasan.c      |  3 ++-
 3 files changed, 49 insertions(+), 1 deletion(-)

--
1.8.2.1
