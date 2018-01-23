Return-Path: <gustavo@embeddedor.com>
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com
 [192.185.149.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQx692rdgzDr2x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 05:05:05 +1100 (AEDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
 by gateway34.websitewelcome.com (Postfix) with ESMTP id 84AFAD82041
 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 23 Jan 2018 11:43:51 -0600 (CST)
Date: Tue, 23 Jan 2018 11:43:49 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] drivers/macintosh: Use true for boolean value
Message-ID: <20180123174349.GA19627@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/macintosh/windfarm_pm72.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_pm72.c b/drivers/macintosh/windfarm_pm72.c
index e88cfb3..8330215 100644
--- a/drivers/macintosh/windfarm_pm72.c
+++ b/drivers/macintosh/windfarm_pm72.c
@@ -611,7 +611,7 @@ static void pm72_tick(void)
 	int i, last_failure;
 
 	if (!started) {
-		started = 1;
+		started = true;
 		printk(KERN_INFO "windfarm: CPUs control loops started.\n");
 		for (i = 0; i < nr_chips; ++i) {
 			if (cpu_setup_pid(i) < 0) {
-- 
2.7.4
