Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6AC81A0E55
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2015 03:24:02 +1000 (AEST)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] i2c: powermac: don't workaround for keywest
Date: Sat,  9 May 2015 19:23:33 +0200
Message-Id: <1431192213-2904-1-git-send-email-wsa@the-dreams.de>
Cc: Mark Elliott <txlitebeer@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Dan DeVoto <dand1972@yahoo.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 3a3dd0186f619b ("i2c/powermac: Improve detection of devices from
device-tree") added a codec device instantiation workaround
unconditionally although it is only needed for onyx. Do it conditionally
since keywest has its own codec instantiation in the sound drivers.
Thanks must go to GrowlTiger from Gentoo bug report #469132 for
bisecting.

Reported-by: Dan DeVoto <dand1972@yahoo.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Tested-by: Dan DeVoto <dand1972@yahoo.com>
Tested-by: Mark Elliott <txlitebeer@gmail.com>
Fixes: 3a3dd0186f619b ("i2c/powermac: Improve detection of devices from device-tree")
---
 drivers/i2c/busses/i2c-powermac.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 6abcf696e3594b..cad5552c0cd4e4 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -285,7 +285,8 @@ static void i2c_powermac_add_missing(struct i2c_adapter *adap,
 
 static bool i2c_powermac_get_type(struct i2c_adapter *adap,
 					    struct device_node *node,
-					    u32 addr, char *type, int type_size)
+					    u32 addr, char *type, int type_size,
+					    bool found_onyx)
 {
 	char tmp[16];
 
@@ -305,8 +306,8 @@ static bool i2c_powermac_get_type(struct i2c_adapter *adap,
 		return true;
 	}
 
-	/* Now look for known workarounds */
-	if (!strcmp(node->name, "deq")) {
+	/* Now look for known workarounds for onyx/aoa */
+	if (found_onyx && !strcmp(node->name, "deq")) {
 		/* Apple uses address 0x34 for TAS3001 and 0x35 for TAS3004 */
 		if (addr == 0x34) {
 			snprintf(type, type_size, "MAC,tas3001");
@@ -362,7 +363,7 @@ static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 
 		/* Make up a modalias */
 		if (!i2c_powermac_get_type(adap, node, addr,
-					   info.type, sizeof(info.type))) {
+					   info.type, sizeof(info.type), found_onyx)) {
 			continue;
 		}
 
-- 
2.1.4
