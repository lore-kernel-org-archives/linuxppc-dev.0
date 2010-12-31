Return-Path: <roel.kluin@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id 4959FB6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  1 Jan 2011 01:57:51 +1100 (EST)
Received: by ewy19 with SMTP id 19so5027655ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Dec 2010 06:57:48 -0800 (PST)
Message-ID: <4D1DEF6A.5090502@gmail.com>
Date: Fri, 31 Dec 2010 15:57:46 +0100
From: roel kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] macintosh: wrong test in fan_{read,write}_reg()
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix error test in fan_{read,write}_reg()

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/macintosh/therm_pm72.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

ENODEV and EIO are positive (22 and 8), so the tests did not work.

diff --git a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
index 4454927..6256a08 100644
--- a/drivers/macintosh/therm_pm72.c
+++ b/drivers/macintosh/therm_pm72.c
@@ -443,7 +443,7 @@ static int fan_read_reg(int reg, unsigned char *buf, int nb)
 	tries = 0;
 	for (;;) {
 		nr = i2c_master_recv(fcu, buf, nb);
-		if (nr > 0 || (nr < 0 && nr != ENODEV) || tries >= 100)
+		if (nr > 0 || (nr < 0 && nr != -ENODEV) || tries >= 100)
 			break;
 		msleep(10);
 		++tries;
@@ -464,7 +464,7 @@ static int fan_write_reg(int reg, const unsigned char *ptr, int nb)
 	tries = 0;
 	for (;;) {
 		nw = i2c_master_send(fcu, buf, nb);
-		if (nw > 0 || (nw < 0 && nw != EIO) || tries >= 100)
+		if (nw > 0 || (nw < 0 && nw != -EIO) || tries >= 100)
 			break;
 		msleep(10);
 		++tries;
