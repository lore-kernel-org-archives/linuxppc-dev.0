Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3ABDADDF70
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 14:42:43 +1000 (EST)
Date: Mon, 30 Apr 2007 23:43:39 -0500
To: paulus@samba.org
Subject: [PATCH] pasemi: only call of_platform_bus_probe() on relevant
	platforms
Message-ID: <20070501044339.GA5194@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Only publish of_platform devices if running on a machine that has them.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index f88f0ec..38bd903 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -211,7 +211,10 @@ static struct of_device_id pasemi_bus_ids[] = {
 
 static int __init pasemi_publish_devices(void)
 {
-	/* Publish OF platform devices for southbridge IOs */
+	if (!machine_is(pasemi))
+		return 0;
+
+	/* Publish OF platform devices for SDC and other non-PCI devices */
 	of_platform_bus_probe(NULL, pasemi_bus_ids, NULL);
 
 	return 0;
