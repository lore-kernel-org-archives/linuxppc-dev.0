Return-Path: <michel@daenzer.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1547CB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 07:51:14 +1000 (EST)
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 0E016DDDA2
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 07:51:12 +1000 (EST)
From: =?utf-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Dave Airlie <airlied@linux.ie>
Subject: [PATCH 1/3] agp/uninorth: Allow larger aperture sizes on pre-U3
	bridges.
Date: Tue,  4 Aug 2009 23:51:03 +0200
Message-Id: <1249422665-24437-1-git-send-email-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michel Dänzer <daenzer@vmware.com>

Using the radeon KMS test functionality, I verified that the AGP bridge of the
Intrepid2 chipset in my PowerBook supports aperture sizes up to 256M. So allow
aperture sizes up to 256M on pre-U3 bridges as well, and bump the default size
to 256M. It's possible that older revisions only support smaller sizes, but
it'll be easy to verify that with the raden KMS test functionality. Also,
there's only a problem on an actual attempt to access the aperture beyond the
maximum size supported by the hardware, and non-KMS X still defaults to using
only 32M.

Also use ARRAY_SIZE for the aperture size arrays.

Signed-off-by: Michel Dänzer <daenzer@vmware.com>
---
 drivers/char/agp/uninorth-agp.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 7d0a93e..eed2195 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -27,6 +27,8 @@
 static int uninorth_rev;
 static int is_u3;
 
+#define DEFAULT_APERTURE_SIZE 256
+#define DEFAULT_APERTURE_STRING "256"
 static char *aperture = NULL;
 
 static int uninorth_fetch_size(void)
@@ -55,7 +57,7 @@ static int uninorth_fetch_size(void)
 
 	if (!size) {
 		for (i = 0; i < agp_bridge->driver->num_aperture_sizes; i++)
-			if (values[i].size == 32)
+			if (values[i].size == DEFAULT_APERTURE_SIZE)
 				break;
 	}
 
@@ -489,13 +491,11 @@ void null_cache_flush(void)
 
 /* Setup function */
 
-static const struct aper_size_info_32 uninorth_sizes[7] =
+static const struct aper_size_info_32 uninorth_sizes[] =
 {
-#if 0 /* Not sure uninorth supports that high aperture sizes */
 	{256, 65536, 6, 64},
 	{128, 32768, 5, 32},
 	{64, 16384, 4, 16},
-#endif
 	{32, 8192, 3, 8},
 	{16, 4096, 2, 4},
 	{8, 2048, 1, 2},
@@ -506,7 +506,7 @@ static const struct aper_size_info_32 uninorth_sizes[7] =
  * Not sure that u3 supports that high aperture sizes but it
  * would strange if it did not :)
  */
-static const struct aper_size_info_32 u3_sizes[8] =
+static const struct aper_size_info_32 u3_sizes[] =
 {
 	{512, 131072, 7, 128},
 	{256, 65536, 6, 64},
@@ -522,7 +522,7 @@ const struct agp_bridge_driver uninorth_agp_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= (void *)uninorth_sizes,
 	.size_type		= U32_APER_SIZE,
-	.num_aperture_sizes	= 4,
+	.num_aperture_sizes	= ARRAY_SIZE(uninorth_sizes),
 	.configure		= uninorth_configure,
 	.fetch_size		= uninorth_fetch_size,
 	.cleanup		= uninorth_cleanup,
@@ -549,7 +549,7 @@ const struct agp_bridge_driver u3_agp_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= (void *)u3_sizes,
 	.size_type		= U32_APER_SIZE,
-	.num_aperture_sizes	= 8,
+	.num_aperture_sizes	= ARRAY_SIZE(u3_sizes),
 	.configure		= uninorth_configure,
 	.fetch_size		= uninorth_fetch_size,
 	.cleanup		= uninorth_cleanup,
@@ -732,7 +732,7 @@ module_param(aperture, charp, 0);
 MODULE_PARM_DESC(aperture,
 		 "Aperture size, must be power of two between 4MB and an\n"
 		 "\t\tupper limit specific to the UniNorth revision.\n"
-		 "\t\tDefault: 32M");
+		 "\t\tDefault: " DEFAULT_APERTURE_STRING "M");
 
 MODULE_AUTHOR("Ben Herrenschmidt & Paul Mackerras");
 MODULE_LICENSE("GPL");
-- 
1.6.3.3
