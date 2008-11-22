Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26360DDE19
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Nov 2008 04:35:28 +1100 (EST)
To: torvalds@linux-foundation.org
Subject: [PATCH 13/32] rackmeter section fixes
Message-Id: <E1L3wOC-0006T5-Ji@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 22 Nov 2008 17:35:24 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* rackmeter_remove() reference needs devexit_p
* rackmeter_setup() is calls devinit and is called only from devinit

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/macintosh/rack-meter.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -288,7 +288,7 @@ static void __devexit rackmeter_stop_cpu_sniffer(struct rackmeter *rm)
 	cancel_rearming_delayed_work(&rm->cpu[1].sniffer);
 }
 
-static int rackmeter_setup(struct rackmeter *rm)
+static int __devinit rackmeter_setup(struct rackmeter *rm)
 {
 	pr_debug("rackmeter: setting up i2s..\n");
 	rackmeter_setup_i2s(rm);
@@ -582,12 +582,12 @@ static struct of_device_id rackmeter_match[] = {
 	{ }
 };
 
-static struct macio_driver rackmeter_drv = {
+static struct macio_driver rackmeter_driver = {
 	.name = "rackmeter",
 	.owner = THIS_MODULE,
 	.match_table = rackmeter_match,
 	.probe = rackmeter_probe,
-	.remove = rackmeter_remove,
+	.remove = __devexit_p(rackmeter_remove),
 	.shutdown = rackmeter_shutdown,
 };
 
@@ -596,14 +596,14 @@ static int __init rackmeter_init(void)
 {
 	pr_debug("rackmeter_init()\n");
 
-	return macio_register_driver(&rackmeter_drv);
+	return macio_register_driver(&rackmeter_driver);
 }
 
 static void __exit rackmeter_exit(void)
 {
 	pr_debug("rackmeter_exit()\n");
 
-	macio_unregister_driver(&rackmeter_drv);
+	macio_unregister_driver(&rackmeter_driver);
 }
 
 module_init(rackmeter_init);
