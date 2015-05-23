Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BAD7E1A0AA5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2015 02:15:32 +1000 (AEST)
From: Wolfram Sang <wsa@the-dreams.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan DeVoto <dand1972@yahoo.com>, Mark Elliott <txlitebeer@gmail.com>,
 Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC] sound: ppc: keywest: check if DEQ was already instantiated
Date: Sat, 23 May 2015 18:15:11 +0200
Message-Id: <1432397711-3186-1-git-send-email-wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Due to changes in i2c-powermac, for some Macs the DEQ is instantiated
now in i2c-powermac while some need the instantiation here in the
keywest sound driver. The proper fix is to convert this driver to AOA.
Until then support both ways of instantiation. Before this patch, some
Macs lost sound because the sound driver failed when instantiating the
DEQ for the second time.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Dan, Mark: I hope I found a generic but not too intrusive solution to the
doubled instantiation problem. Can you please test this patch on top of this
one "sound: ppc: keywest: drop using attach adapter" from last time? Check if
you have sound and send the dmesg output, please. I hope it compiles even,
couldn't test that this time.

 sound/ppc/keywest.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index d7627bae08362e..6120a067494a44 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -31,10 +31,15 @@
  */
 static struct pmac_keywest *keywest_ctx;
 
+static bool keywest_probed;
 
 static int keywest_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	keywest_probed = true;
+	/* If instantiated via i2c-powermac, we still need to set the client */
+	if (!keywest_ctx->client)
+		keywest_ctx->client = client;
 	i2c_set_clientdata(client, keywest_ctx);
 	return 0;
 }
@@ -92,7 +97,8 @@ static int keywest_remove(struct i2c_client *client)
 
 
 static const struct i2c_device_id keywest_i2c_id[] = {
-	{ "keywest", 0 },
+	{ "MAC,tas3004", 0 },		/* instantiated by i2c-powermac */
+	{ "keywest", 0 },		/* instantiated by us if needed */
 	{ }
 };
 
@@ -149,8 +155,13 @@ int snd_pmac_keywest_init(struct pmac_keywest *i2c)
 		return err;
 	}
 
+	/* There was already a device from i2c-powermac. Great, let's return */
+	if (keywest_probed)
+		return 0;
+
 	/* We assume Macs have consecutive I2C bus numbers starting at 0 */
 	while (adap) {
+		/* Scan for devices to be bound to */
 		err = keywest_attach_adapter(adap);
 		if (!err)
 			return 0;
-- 
2.1.4
