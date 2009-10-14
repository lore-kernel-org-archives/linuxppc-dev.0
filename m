Return-Path: <khali@linux-fr.org>
Received: from bamako.nerim.net (bamako.nerim.net [62.4.17.28])
	by ozlabs.org (Postfix) with ESMTP id 90916B7B92
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 02:31:36 +1100 (EST)
Date: Wed, 14 Oct 2009 17:31:32 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Colin Leroy <colin@colino.net>, Tim Shepard <shep@alum.mit.edu>
Subject: [PATCH] therm_adt746x: Don't access non-existing register
Message-ID: <20091014173132.2894d0fd@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ADT746x don't have any register at sub-address 0, so better use an
existing register for the initial test read.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Colin Leroy <colin@colino.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
Tim, I don't really expect this to solve your problem, but who knows...
Care to give it a try, just in case?

 drivers/macintosh/therm_adt746x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.32-rc4.orig/drivers/macintosh/therm_adt746x.c	2009-10-12 11:53:59.000000000 +0200
+++ linux-2.6.32-rc4/drivers/macintosh/therm_adt746x.c	2009-10-14 17:27:46.000000000 +0200
@@ -387,7 +387,7 @@ static int probe_thermostat(struct i2c_c
 	i2c_set_clientdata(client, th);
 	th->clt = client;
 
-	rc = read_reg(th, 0);
+	rc = read_reg(th, CONFIG_REG);
 	if (rc < 0) {
 		dev_err(&client->dev, "Thermostat failed to read config!\n");
 		kfree(th);


-- 
Jean Delvare
