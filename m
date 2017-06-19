Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrfjV422FzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 15:31:42 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id w12so15027493pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Jun 2017 22:31:42 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: benh@kernel.crashing.org,
	mingo@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh: rack-meter: make of_device_ids const.
Date: Mon, 19 Jun 2017 11:01:04 +0530
Message-Id: <f60762e875026ee28966bfd48a2f7e9a290b0e1a.1497850103.git.arvind.yadav.cs@gmail.com>
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

File size after constify keystone_qmss_of_match.
   text	   data	    bss	    dec	    hex	filename
    807	    176	      0	    983	    3d7	drivers/macintosh/rack-meter.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
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
