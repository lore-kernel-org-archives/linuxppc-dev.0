Return-Path: <stripath@apm.com>
Received: from denmail01.amcc.com (unknown [192.195.68.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 59B8A1A0FEF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 22:01:46 +1000 (AEST)
From: Suman Tripathi <stripathi@apm.com>
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com,
 ulf.hansson@linaro.org, khilman@deeprootsystems.com, olof@lixom.net
Cc: linux-mmc@vger.kernel.org, arm@kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com,
 patches@apm.com, Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v8 2/2] mmc: host: sdhci: Disable 1.8V signaling for arasan
 4.9a version of SDHCI controller.
Date: Fri, 19 Jun 2015 17:30:27 +0530
Message-Id: <1434715227-27399-3-git-send-email-stripathi@apm.com>
In-Reply-To: <1434715227-27399-1-git-send-email-stripathi@apm.com>
References: <1434715227-27399-1-git-send-email-stripathi@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch disables the 1.8V signaling for arasan 4.9a version
of SDHCI controller with the help SDHCI_QUIRK2_NO_1_8_V quirk.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
---
 drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 21c0c08..4c99ea4 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -171,7 +171,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)

 	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
 		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
-		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
+		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23 |
+				 SDHCI_QUIRK2_NO_1_8_V;
 	}

 	sdhci_get_of_property(pdev);
--
1.8.2.1
