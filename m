Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by ozlabs.org (Postfix) with ESMTP id E22922C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 07:12:45 +1100 (EST)
Received: from georges.telenet-ops.be (georges.telenet-ops.be [195.130.137.68])
 by wilson.telenet-ops.be (Postfix) with ESMTP id 12F7934063
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 21:12:43 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] powerpc/windfarm: Remove superfluous name casts
Date: Tue, 12 Nov 2013 20:07:14 +0100
Message-Id: <1384283245-9419-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1384283245-9419-1-git-send-email-geert@linux-m68k.org>
References: <1384283245-9419-1-git-send-email-geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

wf_sensor.name is "const char *"

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/macintosh/windfarm_lm75_sensor.c    |    2 +-
 drivers/macintosh/windfarm_max6690_sensor.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index 9ef32b3df91f..590214ba736c 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -133,7 +133,7 @@ static int wf_lm75_probe(struct i2c_client *client,
 	lm->inited = 0;
 	lm->ds1775 = ds1775;
 	lm->i2c = client;
-	lm->sens.name = (char *)name; /* XXX fix constness in structure */
+	lm->sens.name = name;
 	lm->sens.ops = &wf_lm75_ops;
 	i2c_set_clientdata(client, lm);
 
diff --git a/drivers/macintosh/windfarm_max6690_sensor.c b/drivers/macintosh/windfarm_max6690_sensor.c
index 945a25b2f31e..87e439b10318 100644
--- a/drivers/macintosh/windfarm_max6690_sensor.c
+++ b/drivers/macintosh/windfarm_max6690_sensor.c
@@ -95,7 +95,7 @@ static int wf_max6690_probe(struct i2c_client *client,
 	}
 
 	max->i2c = client;
-	max->sens.name = (char *)name; /* XXX fix constness in structure */
+	max->sens.name = name;
 	max->sens.ops = &wf_max6690_ops;
 	i2c_set_clientdata(client, max);
 
-- 
1.7.9.5
