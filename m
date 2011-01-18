Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3B88B70EF
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2011 08:09:44 +1100 (EST)
Message-Id: <201101182109.p0IL992W005451@imap1.linux-foundation.org>
Subject: [patch 1/2] macintosh: wrong test in fan_{read,write}_reg()
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Tue, 18 Jan 2011 13:09:09 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, roel.kluin@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: roel kluin <roel.kluin@gmail.com>

Fix error test in fan_{read,write}_reg()

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/macintosh/therm_pm72.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/macintosh/therm_pm72.c~macintosh-wrong-test-in-fan_readwrite_reg drivers/macintosh/therm_pm72.c
--- a/drivers/macintosh/therm_pm72.c~macintosh-wrong-test-in-fan_readwrite_reg
+++ a/drivers/macintosh/therm_pm72.c
@@ -443,7 +443,7 @@ static int fan_read_reg(int reg, unsigne
 	tries = 0;
 	for (;;) {
 		nr = i2c_master_recv(fcu, buf, nb);
-		if (nr > 0 || (nr < 0 && nr != ENODEV) || tries >= 100)
+		if (nr > 0 || (nr < 0 && nr != -ENODEV) || tries >= 100)
 			break;
 		msleep(10);
 		++tries;
@@ -464,7 +464,7 @@ static int fan_write_reg(int reg, const 
 	tries = 0;
 	for (;;) {
 		nw = i2c_master_send(fcu, buf, nb);
-		if (nw > 0 || (nw < 0 && nw != EIO) || tries >= 100)
+		if (nw > 0 || (nw < 0 && nw != -EIO) || tries >= 100)
 			break;
 		msleep(10);
 		++tries;
_
