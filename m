Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLhtJ4B3CzF0ff
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 07:40:08 +1100 (AEDT)
Subject: [PATCH 1/2] macintosh/rack-meter: Delete an error message for a
 failed memory allocation in rackmeter_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c11e0a90-a7b2-dddd-7751-7dac3e62215b@users.sourceforge.net>
Message-ID: <e8373573-fb9d-5a90-96e7-1faf5434e6e1@users.sourceforge.net>
Date: Tue, 16 Jan 2018 21:39:57 +0100
MIME-Version: 1.0
In-Reply-To: <c11e0a90-a7b2-dddd-7751-7dac3e62215b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 Jan 2018 21:23:36 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/macintosh/rack-meter.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 910b5b6f96b1..0796b74174d4 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -399,7 +399,6 @@ static int rackmeter_probe(struct macio_dev* mdev,
 	/* Create and initialize our instance data */
 	rm = kzalloc(sizeof(struct rackmeter), GFP_KERNEL);
 	if (rm == NULL) {
-		printk(KERN_ERR "rackmeter: failed to allocate memory !\n");
 		rc = -ENOMEM;
 		goto bail_release;
 	}
-- 
2.15.1
