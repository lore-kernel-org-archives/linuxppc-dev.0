Return-Path: <vincent.yang.fujitsu@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 708661A014B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 16:23:45 +1000 (EST)
Received: by mail-pa0-f47.google.com with SMTP id kq14so2736012pab.34
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 23:23:43 -0700 (PDT)
From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
To: chris@printf.net,
	linux-mmc@vger.kernel.org
Subject: [RFC PATCH v2 1/6] mmc: sdhci: add quirk for voltage switch callback
Date: Thu, 26 Jun 2014 14:23:27 +0800
Message-Id: <1403763812-5495-2-git-send-email-Vincent.Yang@tw.fujitsu.com>
In-Reply-To: <1403763812-5495-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1403763812-5495-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Cc: devicetree@vger.kernel.org, andy.green@linaro.org, patches@linaro.org,
 anton@enomsg.org, Vincent.Yang@tw.fujitsu.com, jaswinder.singh@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch defines a quirk to do a callback when
switching voltages so do controller-specific
actions.
It is a preparation and will be used by Fujitsu
SDHCI controller f_sdh30 driver.

Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
---
 drivers/mmc/host/sdhci.c  | 5 +++++
 drivers/mmc/host/sdhci.h  | 1 +
 include/linux/mmc/sdhci.h | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 47055f3..d62262b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1763,6 +1763,11 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 		ctrl |= SDHCI_CTRL_VDD_180;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
+		/* Some controller need to do more when switching */
+		if ((host->quirks2 & SDHCI_QUIRK2_VOLTAGE_SWITCH) &&
+		    host->ops->voltage_switch)
+			host->ops->voltage_switch(host);
+
 		/* Wait for 5ms */
 		usleep_range(5000, 5500);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 4a5cd5e..63c7a46 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -292,6 +292,7 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
+	void	(*voltage_switch)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 08abe99..5433f04 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -98,6 +98,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_BROKEN_HS200			(1<<6)
 /* Controller does not support DDR50 */
 #define SDHCI_QUIRK2_BROKEN_DDR50			(1<<7)
+/* Do a callback when switching voltages so do controller-specific actions */
+#define SDHCI_QUIRK2_VOLTAGE_SWITCH			(1<<8)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.0
