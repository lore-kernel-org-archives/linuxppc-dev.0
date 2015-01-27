Return-Path: <stripath@apm.com>
Received: from denmail01.apm.com (unknown [192.195.68.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 27D031A0569
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 05:16:40 +1100 (AEDT)
From: Suman Tripathi <stripathi@apm.com>
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de
Subject: [PATCH v1 0/2] Add SDHCI support for APM X-Gene SoC using ARASAN
 SDHCI controller.
Date: Tue, 27 Jan 2015 22:50:58 +0530
Message-Id: <1422379260-10139-1-git-send-email-stripathi@apm.com>
Cc: devicetree@vger.kernel.org, mlangsdo@redhat.com,
 Suman Tripathi <stripathi@apm.com>, jcm@redhat.com, linux-mmc@vger.kernel.org,
 patches@apm.com, ddutile@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Due to the fact that the existing of-arasan driver works with 32-bit platforms.
This patch tweaks existing of-arasan driver to work with 64-bit X-Gene
platform using IOMMU translation.

v1 change:
 * Use the CONFIG_ARM64_DMA_HAS_IOMMU for dma-mapping.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---

Suman Tripathi (2):
  mmc: host: arasan: Add addition of-arasan quirks and IOMMU support for
    arasan SDHCI driver.
  arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.

 arch/arm64/boot/dts/apm-storm.dtsi  | 43 +++++++++++++++++++++++++++
 drivers/mmc/host/Makefile           |  2 ++
 drivers/mmc/host/sdhci-ahbc-xgene.c | 58 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-ahbc-xgene.h | 49 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-arasan.c  | 11 +++++++
 drivers/mmc/host/sdhci-pltfm.c      | 12 ++++++++
 6 files changed, 175 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-ahbc-xgene.c
 create mode 100644 drivers/mmc/host/sdhci-ahbc-xgene.h

--
1.8.2.1
