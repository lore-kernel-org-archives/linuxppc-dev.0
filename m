Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 2DD01B6EFE
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 00:14:23 +1000 (EST)
Date: Sun, 8 Aug 2010 18:14:22 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mmc_spi: Fix unterminated of_match_table
Message-ID: <20100808141422.GA9670@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 2ffe8c5f323c3b9749bf7bc2375d909d20bdbb15 ("of: refactor
of_modalias_node() and remove explicit match table"), introduced
an unterminated of_match_table, which may cause kernel to oops.

This patch fixes the issue by adding an empty device ID.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 drivers/mmc/host/mmc_spi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 7b0f3ef..1145ea0 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1536,6 +1536,7 @@ static int __devexit mmc_spi_remove(struct spi_device *spi)
 #if defined(CONFIG_OF)
 static struct of_device_id mmc_spi_of_match_table[] __devinitdata = {
 	{ .compatible = "mmc-spi-slot", },
+	{},
 };
 #endif
 
-- 
1.7.0.5
