Return-Path: <SRS0=tFHQ=AG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBA9C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:17:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDBA206A1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDBA206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49t0sl5XHrzDqss
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 23:16:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=8bytes.org (client-ip=2a01:238:4383:600:38bc:a715:4b6d:a889;
 helo=theia.8bytes.org; envelope-from=joro@8bytes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=8bytes.org
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49t0hF48nrzDqcY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2020 23:08:45 +1000 (AEST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id F104136D; Thu, 25 Jun 2020 15:08:37 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 00/13] iommu: Remove usage of dev->archdata.iommu
Date: Thu, 25 Jun 2020 15:08:23 +0200
Message-Id: <20200625130836.1916-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-ia64@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Joerg Roedel <jroedel@suse.de>, intel-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Joerg Roedel <jroedel@suse.de>

Hi,

here is a patch-set to remove the usage of dev->archdata.iommu from
the IOMMU code in the kernel and replace its uses by the iommu per-device
private data field. The changes also remove the field entirely from
the architectures which no longer need it.

On PowerPC the field is called dev->archdata.iommu_domain and was only
used by the PAMU IOMMU driver. It gets removed as well.

The patches have been runtime tested on Intel VT-d and compile tested
with allyesconfig for:

	* x86 (32 and 64 bit)
	* arm and arm64
	* ia64 (only drivers/ because build failed for me in
	        arch/ia64)
	* PPC64

Besides that the changes also survived my IOMMU tree compile tests.

Please review.

Regards,

	Joerg

Joerg Roedel (13):
  iommu/exynos: Use dev_iommu_priv_get/set()
  iommu/vt-d: Use dev_iommu_priv_get/set()
  iommu/msm: Use dev_iommu_priv_get/set()
  iommu/omap: Use dev_iommu_priv_get/set()
  iommu/rockchip: Use dev_iommu_priv_get/set()
  iommu/tegra: Use dev_iommu_priv_get/set()
  iommu/pamu: Use dev_iommu_priv_get/set()
  iommu/mediatek: Do no use dev->archdata.iommu
  x86: Remove dev->archdata.iommu pointer
  ia64: Remove dev->archdata.iommu pointer
  arm: Remove dev->archdata.iommu pointer
  arm64: Remove dev->archdata.iommu pointer
  powerpc/dma: Remove dev->archdata.iommu_domain

 arch/arm/include/asm/device.h                 |  3 ---
 arch/arm64/include/asm/device.h               |  3 ---
 arch/ia64/include/asm/device.h                |  3 ---
 arch/powerpc/include/asm/device.h             |  3 ---
 arch/x86/include/asm/device.h                 |  3 ---
 .../gpu/drm/i915/selftests/mock_gem_device.c  | 10 ++++++++--
 drivers/iommu/exynos-iommu.c                  | 20 +++++++++----------
 drivers/iommu/fsl_pamu_domain.c               |  8 ++++----
 drivers/iommu/intel/iommu.c                   | 18 ++++++++---------
 drivers/iommu/msm_iommu.c                     |  4 ++--
 drivers/iommu/mtk_iommu.h                     |  2 ++
 drivers/iommu/mtk_iommu_v1.c                  | 10 ++++------
 drivers/iommu/omap-iommu.c                    | 20 +++++++++----------
 drivers/iommu/rockchip-iommu.c                |  8 ++++----
 drivers/iommu/tegra-gart.c                    |  8 ++++----
 drivers/iommu/tegra-smmu.c                    |  8 ++++----
 .../media/platform/s5p-mfc/s5p_mfc_iommu.h    |  4 +++-
 17 files changed, 64 insertions(+), 71 deletions(-)

-- 
2.27.0

