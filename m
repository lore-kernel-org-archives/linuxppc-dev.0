Return-Path: <jonsmirl@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by ozlabs.org (Postfix) with ESMTP id BE4EFDDDEA
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 23:13:20 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id s6so1184135wxc.15
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 05:13:18 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by terra with esmtp (Exim 4.69) (envelope-from <jonsmirl@gmail.com>)
	id 1KrtdL-0002ig-GI
	for linuxppc-dev@ozlabs.org; Mon, 20 Oct 2008 08:13:15 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Format string bug in drivers/of/of_i2c.c
To: linuxppc-dev@ozlabs.org
Date: Mon, 20 Oct 2008 08:13:15 -0400
Message-ID: <20081020121315.10428.10730.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Format string bug.  Not exploitable, as this is only writable by root,
but worth fixing all the same.

See 326f6a5c9c9e1a62aec37bdc0c3f8d53adabe77b
---
 drivers/of/of_i2c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 6a98dc8..24bbef7 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -41,7 +41,7 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 
 		info.addr = *addr;
 
-		request_module(info.type);
+		request_module("%s", info.type);
 
 		result = i2c_new_device(adap, &info);
 		if (result == NULL) {
