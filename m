Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 11AFADE1EA
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 07:05:41 +1000 (EST)
From: =?utf-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Colin Leroy <colin@colino.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] therm_adt746x: Always clear hardware bit which inverts fan
	speed range.
Date: Fri, 22 May 2009 22:59:10 +0200
Message-Id: <1243025950-11037-1-git-send-email-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This bit would get enabled sometimes (probably after suspend/resume), so the
fan would run at full speed below the temperature thresholds, but slow down and
eventually stop if temperatures rose above the thresholds... not exactly what
you want.

Signed-off-by: Michel Dänzer <michel@daenzer.net>
---
 drivers/macintosh/therm_adt746x.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 82607ad..321eaad 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -37,6 +37,7 @@
 #define CONFIG_REG   0x40
 #define MANUAL_MASK  0xe0
 #define AUTO_MASK    0x20
+#define INVERT_MASK  0x10
 
 static u8 TEMP_REG[3]    = {0x26, 0x25, 0x27}; /* local, sensor1, sensor2 */
 static u8 LIMIT_REG[3]   = {0x6b, 0x6a, 0x6c}; /* local, sensor1, sensor2 */
@@ -229,7 +230,8 @@ static void write_fan_speed(struct thermostat *th, int speed, int fan)
 	
 	if (speed >= 0) {
 		manual = read_reg(th, MANUAL_MODE[fan]);
-		write_reg(th, MANUAL_MODE[fan], manual|MANUAL_MASK);
+		write_reg(th, MANUAL_MODE[fan],
+			(manual|MANUAL_MASK) & (~INVERT_MASK));
 		write_reg(th, FAN_SPD_SET[fan], speed);
 	} else {
 		/* back to automatic */
-- 
1.6.3
