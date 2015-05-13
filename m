Return-Path: <stripath@apm.com>
Received: from denmail01.amcc.com (unknown [192.195.68.30])
 by lists.ozlabs.org (Postfix) with ESMTP id B69181A033D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 21:53:09 +1000 (AEST)
From: Suman Tripathi <stripathi@apm.com>
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com
Subject: [PATCH v7 2/2] mmc: host: sdhci: Add support to disable
 SDR104/SDR50/DDR50 based on capability register 0.
Date: Wed, 13 May 2015 17:21:52 +0530
Message-Id: <1431517912-10322-3-git-send-email-stripathi@apm.com>
In-Reply-To: <1431517912-10322-1-git-send-email-stripathi@apm.com>
References: <1431517912-10322-1-git-send-email-stripathi@apm.com>
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

The sdhci framework disables SDR104/SDR50/DDR50 based on only quirk.
This patch adds the support to disable SDR104/SDR50/DDR50 based on
reading the capability register 0.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
---
 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 58c1770..a3d9b8a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3118,7 +3118,8 @@ int sdhci_add_host(struct sdhci_host *host)
 		}
 	}

-	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
+	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V ||
+	    !(caps[0] & SDHCI_CAN_VDD_180))
 		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 		       SDHCI_SUPPORT_DDR50);

--
1.8.2.1
