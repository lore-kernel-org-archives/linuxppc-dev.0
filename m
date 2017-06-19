Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrg0s5k7MzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 15:45:01 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id u62so8545160pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Jun 2017 22:45:01 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: benh@kernel.crashing.org,
	mingo@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] macintosh: rack-meter: make of_device_ids const.
Date: Mon, 19 Jun 2017 11:14:25 +0530
Message-Id: <7ce0e2734a7e95d3341c7424d124ddfd4bc82034.1497850925.git.arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
    407	    576	      0	    983	    3d7	drivers/macintosh/rack-meter.o

File size after constify rackmeter_match.
   text	   data	    bss	    dec	    hex	filename
    807	    176	      0	    983	    3d7	drivers/macintosh/rack-meter.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
Changes in v1:
              Subject was wrong. It should be constify rackmeter_match.

 drivers/macintosh/rack-meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index e199fd6..35582eb 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -579,7 +579,7 @@ static int rackmeter_shutdown(struct macio_dev* mdev)
 	return 0;
 }
 
-static struct of_device_id rackmeter_match[] = {
+static const struct of_device_id rackmeter_match[] = {
 	{ .name = "i2s" },
 	{ }
 };
-- 
1.9.1
