Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 23ADCB6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Sep 2011 04:45:58 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] RapidIO: fix potential null deref in rio_setup_device()
Date: Tue,  6 Sep 2011 14:44:15 -0400
Message-Id: <1315334655-12356-1-git-send-email-alexandre.bounine@idt.com>
Cc: Chul Kim <chul.kim@idt.com>, Alexandre Bounine <alexandre.bounine@idt.com>,
	Dan Carpenter <error27@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "goto cleanup" path can deference "rswitch" when it is NULL.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Dan Carpenter <error27@gmail.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Chul Kim <chul.kim@idt.com>
---
 drivers/rapidio/rio-scan.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index ebe77dd..5b2cb53 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -516,7 +516,7 @@ static struct rio_dev __devinit *rio_setup_device(struct rio_net *net,
 	return rdev;
 
 cleanup:
-	if (rio_is_switch(rdev))
+	if (rswitch)
 		kfree(rswitch->route_table);
 
 	kfree(rdev);
-- 
1.7.6
