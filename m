Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLhvR1mRlzF0g2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 07:41:06 +1100 (AEDT)
Subject: [PATCH 2/2] macintosh/rack-meter: Improve a size determination in
 rackmeter_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c11e0a90-a7b2-dddd-7751-7dac3e62215b@users.sourceforge.net>
Message-ID: <862e3609-1010-95d8-0d64-0493f5759f78@users.sourceforge.net>
Date: Tue, 16 Jan 2018 21:40:57 +0100
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
Date: Tue, 16 Jan 2018 21:26:52 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/macintosh/rack-meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 0796b74174d4..800fc6822ad8 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -397,7 +397,7 @@ static int rackmeter_probe(struct macio_dev* mdev,
 	}
 
 	/* Create and initialize our instance data */
-	rm = kzalloc(sizeof(struct rackmeter), GFP_KERNEL);
+	rm = kzalloc(sizeof(*rm), GFP_KERNEL);
 	if (rm == NULL) {
 		rc = -ENOMEM;
 		goto bail_release;
-- 
2.15.1
