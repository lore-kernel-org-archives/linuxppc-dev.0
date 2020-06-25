Return-Path: <SRS0=tFHQ=AG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7921AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:38:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3348620672
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3348620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49t1Ll0z92zDqsN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 23:38:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=8bytes.org (client-ip=2a01:238:4383:600:38bc:a715:4b6d:a889;
 helo=theia.8bytes.org; envelope-from=joro@8bytes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=8bytes.org
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49t0hN3yGDzDqlB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2020 23:08:52 +1000 (AEST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 0044846A; Thu, 25 Jun 2020 15:08:38 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 06/13] iommu/tegra: Use dev_iommu_priv_get/set()
Date: Thu, 25 Jun 2020 15:08:29 +0200
Message-Id: <20200625130836.1916-7-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625130836.1916-1-joro@8bytes.org>
References: <20200625130836.1916-1-joro@8bytes.org>
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

Remove the use of dev->archdata.iommu and use the private per-device
pointer provided by IOMMU core code instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/tegra-gart.c | 8 ++++----
 drivers/iommu/tegra-smmu.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 5fbdff6ff41a..fac720273889 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -113,8 +113,8 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 
 	if (gart->active_domain && gart->active_domain != domain) {
 		ret = -EBUSY;
-	} else if (dev->archdata.iommu != domain) {
-		dev->archdata.iommu = domain;
+	} else if (dev_iommu_priv_get(dev) != domain) {
+		dev_iommu_priv_set(dev, domain);
 		gart->active_domain = domain;
 		gart->active_devices++;
 	}
@@ -131,8 +131,8 @@ static void gart_iommu_detach_dev(struct iommu_domain *domain,
 
 	spin_lock(&gart->dom_lock);
 
-	if (dev->archdata.iommu == domain) {
-		dev->archdata.iommu = NULL;
+	if (dev_iommu_priv_get(dev) == domain) {
+		dev_iommu_priv_set(dev, NULL);
 
 		if (--gart->active_devices == 0)
 			gart->active_domain = NULL;
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 7426b7666e2b..124c8848ab7e 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -465,7 +465,7 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
-	struct tegra_smmu *smmu = dev->archdata.iommu;
+	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args args;
@@ -780,7 +780,7 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 			 * supported by the Linux kernel, so abort after the
 			 * first match.
 			 */
-			dev->archdata.iommu = smmu;
+			dev_iommu_priv_set(dev, smmu);
 
 			break;
 		}
@@ -797,7 +797,7 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 
 static void tegra_smmu_release_device(struct device *dev)
 {
-	dev->archdata.iommu = NULL;
+	dev_iommu_priv_set(dev, NULL);
 }
 
 static const struct tegra_smmu_group_soc *
@@ -856,7 +856,7 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct tegra_smmu *smmu = dev->archdata.iommu;
+	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
 	struct iommu_group *group;
 
 	group = tegra_smmu_group_get(smmu, fwspec->ids[0]);
-- 
2.27.0

