Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BA5C9DDF01
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 05:07:00 +1100 (EST)
Date: Fri, 6 Feb 2009 21:06:59 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH 09/11] sdhci: Add set_clock callback
Message-ID: <20090206180659.GI11548@oksana.dev.rtsoft.ru>
References: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FSL eSDHC hosts have incompatible register map to manage the SDCLK.
This patch adds set_clock callback so that drivers could overwrite
set_clock behaviour.

Similar patch[1] was posted by Ben Dooks, though in Ben's version the
callback is named change_clock, plus the patch has some unrelated bits
that makes the patch difficult to reuse.

[1] http://lkml.org/lkml/2008/12/2/160

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci.c |    5 +++++
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0293368..3c1f1d5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -969,6 +969,11 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock == host->clock)
 		return;
 
+	if (host->ops->set_clock) {
+		host->ops->set_clock(host, clock);
+		return;
+	}
+
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
 	if (clock == 0)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 2e8dfd1..497276b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -312,6 +312,8 @@ struct sdhci_ops {
 	void	(*writew)(struct sdhci_host *host, u16 val, sdhci_reg_t reg);
 	void	(*writeb)(struct sdhci_host *host, u8 val, sdhci_reg_t reg);
 
+	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
+
 	int	(*enable_dma)(struct sdhci_host *host);
 };
 
-- 
1.5.6.5
