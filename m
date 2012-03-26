Return-Path: <richard@nod.at>
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "radon.swed.at", Issuer "neon.swed.at" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E6289B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2012 06:01:41 +1100 (EST)
From: Richard Weinberger <richard@nod.at>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: 512x: Fix mpc5121_clk_get()
Date: Mon, 26 Mar 2012 21:01:29 +0200
Message-Id: <1332788489-27435-1-git-send-email-richard@nod.at>
Cc: agust@denx.de, paulus@samba.org, linux-kernel@vger.kernel.org,
 Richard Weinberger <richard@nod.at>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If try_module_get() fails, mpc5121_clk_get() might return
a wrong clock.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/powerpc/platforms/512x/clock.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
index 1d8700f..9f771e0 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -54,14 +54,16 @@ static DEFINE_MUTEX(clocks_mutex);
 static struct clk *mpc5121_clk_get(struct device *dev, const char *id)
 {
 	struct clk *p, *clk = ERR_PTR(-ENOENT);
-	int dev_match = 0;
-	int id_match = 0;
+	int dev_match;
+	int id_match;
 
 	if (dev == NULL || id == NULL)
 		return clk;
 
 	mutex_lock(&clocks_mutex);
 	list_for_each_entry(p, &clocks, node) {
+		dev_match = id_match = 0;
+
 		if (dev == p->dev)
 			dev_match++;
 		if (strcmp(id, p->name) == 0)
-- 
1.7.7.3
