Return-Path: <stripath@apm.com>
Received: from denmail01.amcc.com (unknown [192.195.68.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 0EC6F1A0BF4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 18:44:42 +1000 (AEST)
From: Suman Tripathi <stripathi@apm.com>
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com,
 patches@apm.com, Suman Tripathi <stripathi@apm.com>
Subject: [PATCH RESEND v7 2/2] mmc: host: sdhci: Add support to disable
 SDR104/SDR50/DDR50 based on capability register 0.
Date: Thu, 21 May 2015 14:13:37 +0530
Message-Id: <1432197817-22110-3-git-send-email-stripathi@apm.com>
In-Reply-To: <1432197817-22110-1-git-send-email-stripathi@apm.com>
References: <1432197817-22110-1-git-send-email-stripathi@apm.com>
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
