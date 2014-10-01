Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC40C1A1765
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:15 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/20] powerpc/mpc8349emitx: Use pm_power_off rather than
 ppc_md.power_off
Date: Wed,  1 Oct 2014 15:27:51 +0200
Message-Id: <1412170086-57971-6-git-send-email-agraf@suse.de>
In-Reply-To: <1412170086-57971-1-git-send-email-agraf@suse.de>
References: <1412170086-57971-1-git-send-email-agraf@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic power off callback is pm_power_off. Use that one rather than
the powerpc specific ppc_md.power_off.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index e238b6a..a3b7a1f 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -166,10 +166,10 @@ static int mcu_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (ret)
 		goto err;
 
-	/* XXX: this is potentially racy, but there is no lock for ppc_md */
-	if (!ppc_md.power_off) {
+	/* XXX: this is potentially racy, but there is no lock for pm_power_off */
+	if (!pm_power_off) {
 		glob_mcu = mcu;
-		ppc_md.power_off = mcu_power_off;
+		pm_power_off = mcu_power_off;
 		dev_info(&client->dev, "will provide power-off service\n");
 	}
 
@@ -196,7 +196,7 @@ static int mcu_remove(struct i2c_client *client)
 	device_remove_file(&client->dev, &dev_attr_status);
 
 	if (glob_mcu == mcu) {
-		ppc_md.power_off = NULL;
+		pm_power_off = NULL;
 		glob_mcu = NULL;
 	}
 
-- 
1.8.1.4
