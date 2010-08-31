Return-Path: <mita@dhcpa11143.tky.aist.go.jp>
Received: from dhcpa11143.tky.aist.go.jp (unknown [150.82.175.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F680B713D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 19:01:10 +1000 (EST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/512x: fix clk_get() return value
Date: Tue, 31 Aug 2010 17:43:51 +0900
Message-Id: <1283244231-23659-1-git-send-email-akinobu.mita@gmail.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

clk_get() should return an ERR_PTR value on error, not NULL.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/512x/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
index 5b243bd..3dc2a8d 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -57,7 +57,7 @@ static struct clk *mpc5121_clk_get(struct device *dev, const char *id)
 	int id_match = 0;
 
 	if (dev == NULL || id == NULL)
-		return NULL;
+		return clk;
 
 	mutex_lock(&clocks_mutex);
 	list_for_each_entry(p, &clocks, node) {
-- 
1.7.1.231.gd0b16
