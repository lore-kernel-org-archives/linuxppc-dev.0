Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 138FB67BED
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 00:38:32 +1100 (EST)
From: marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: fix dmasound compile error for tas300x
Date: Sun, 17 Dec 2006 14:38:22 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PhUhFQKGBim765y"
Message-Id: <200612171438.23435.marvin24@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_PhUhFQKGBim765y
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


hi,

I need the attached patch to compile the awacs/dmasound driver. There is still 
some warning, but I don't know how to fix it. Only build tested because I'm 
using alsa ...

Marc

--Boundary-00=_PhUhFQKGBim765y
Content-Type: text/x-diff;
  charset="utf-8";
  name="fix_compile_tas300x.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix_compile_tas300x.diff"

diff --git a/sound/oss/dmasound/tas3001c.c b/sound/oss/dmasound/tas3001c.c
index f227c9f..75a110e 100644
--- a/sound/oss/dmasound/tas3001c.c
+++ b/sound/oss/dmasound/tas3001c.c
@@ -823,7 +823,7 @@ tas3001c_init(struct i2c_client *client)
 			tas3001c_write_biquad_shadow(self, i, j,
 				&tas3001c_eq_unity);
 
-	INIT_WORK(&device_change, tas3001c_device_change_handler, self);
+	INIT_WORK(&device_change, tas3001c_device_change_handler);
 	return 0;
 }
 
diff --git a/sound/oss/dmasound/tas3004.c b/sound/oss/dmasound/tas3004.c
index 82eaaca..bf18d43 100644
--- a/sound/oss/dmasound/tas3004.c
+++ b/sound/oss/dmasound/tas3004.c
@@ -1112,7 +1112,7 @@ tas3004_init(struct i2c_client *client)
 	tas3004_write_register(self, TAS3004_REG_MCR2, &mcr2, WRITE_SHADOW);
 	tas3004_write_register(self, TAS3004_REG_DRC, drce_init, WRITE_SHADOW);
 
-	INIT_WORK(&device_change, tas3004_device_change_handler, self);
+	INIT_WORK(&device_change, tas3004_device_change_handler);
 	return 0;
 }
 

--Boundary-00=_PhUhFQKGBim765y--
