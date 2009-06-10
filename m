Return-Path: <akpm@linux-foundation.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5FE61B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 05:45:00 +1000 (EST)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF873DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 05:44:59 +1000 (EST)
Message-Id: <200906101942.n5AJgVPU030230@imap1.linux-foundation.org>
Subject: [patch 1/1] drivers/hvc: add missing __devexit_p()
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Wed, 10 Jun 2009 12:42:30 -0700
Cc: sfr@canb.auug.org.au, vapier@gentoo.org, miltonm@bga.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mike Frysinger <vapier@gentoo.org>

The remove function uses __devexit, so the .remove assignment needs
__devexit_p() to fix a build error with hotplug disabled.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Milton Miller <miltonm@bga.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/char/hvc_iseries.c |    2 +-
 drivers/char/hvc_vio.c     |    2 +-
 drivers/char/hvcs.c        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/char/hvc_iseries.c~drivers-hvc-add-missing-__devexit_p drivers/char/hvc_iseries.c
--- a/drivers/char/hvc_iseries.c~drivers-hvc-add-missing-__devexit_p
+++ a/drivers/char/hvc_iseries.c
@@ -241,7 +241,7 @@ static int __devexit hvc_vio_remove(stru
 static struct vio_driver hvc_vio_driver = {
 	.id_table	= hvc_driver_table,
 	.probe		= hvc_vio_probe,
-	.remove		= hvc_vio_remove,
+	.remove		= __devexit_p(hvc_vio_remove),
 	.driver		= {
 		.name	= hvc_driver_name,
 		.owner	= THIS_MODULE,
diff -puN drivers/char/hvc_vio.c~drivers-hvc-add-missing-__devexit_p drivers/char/hvc_vio.c
--- a/drivers/char/hvc_vio.c~drivers-hvc-add-missing-__devexit_p
+++ a/drivers/char/hvc_vio.c
@@ -113,7 +113,7 @@ static int __devexit hvc_vio_remove(stru
 static struct vio_driver hvc_vio_driver = {
 	.id_table	= hvc_driver_table,
 	.probe		= hvc_vio_probe,
-	.remove		= hvc_vio_remove,
+	.remove		= __devexit_p(hvc_vio_remove),
 	.driver		= {
 		.name	= hvc_driver_name,
 		.owner	= THIS_MODULE,
diff -puN drivers/char/hvcs.c~drivers-hvc-add-missing-__devexit_p drivers/char/hvcs.c
--- a/drivers/char/hvcs.c~drivers-hvc-add-missing-__devexit_p
+++ a/drivers/char/hvcs.c
@@ -868,7 +868,7 @@ static int __devexit hvcs_remove(struct 
 static struct vio_driver hvcs_vio_driver = {
 	.id_table	= hvcs_driver_table,
 	.probe		= hvcs_probe,
-	.remove		= hvcs_remove,
+	.remove		= __devexit_p(hvcs_remove),
 	.driver		= {
 		.name	= hvcs_driver_name,
 		.owner	= THIS_MODULE,
_
