Return-Path: <michel@tungstengraphics.com>
Received: from admin.zirkelwireless.com (admin.zirkelwireless.com
	[209.216.203.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71DBE67C03
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 02:09:24 +1000 (EST)
Received: from [192.168.9.2] (80-218-118-103.dclient.hispeed.ch
	[80.218.118.103]) (authenticated bits=0)
	by admin.zirkelwireless.com (8.12.10/8.12.10) with ESMTP id
	k7LG74dM014978
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 10:07:05 -0600
Subject: [PATCH 1/2] uninorth: Use same sizes array everywhere
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <115608447678-git-send-email->
References: <115608447678-git-send-email->
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Aug 2006 18:09:17 +0200
Message-Id: <1156176557.16513.76.camel@thor.lorrainebruecke.local>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Until we have evidence of the opposite, we'll just assume for the sake of
simplicity that all revisions of UniNorth support the same aperture sizes.

Also derive the number of supported sizes from the array definition.

Signed-off-by: Michel Dänzer <michel@tungstengraphics.com>
---
 drivers/char/agp/uninorth-agp.c |   27 ++++++---------------------
 1 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 91b71e7..78c8cb2 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -450,24 +450,7 @@ void null_cache_flush(void)
 
 /* Setup function */
 
-static struct aper_size_info_32 uninorth_sizes[7] =
-{
-#if 0 /* Not sure uninorth supports that high aperture sizes */
-	{256, 65536, 6, 64},
-	{128, 32768, 5, 32},
-	{64, 16384, 4, 16},
-#endif
-	{32, 8192, 3, 8},
-	{16, 4096, 2, 4},
-	{8, 2048, 1, 2},
-	{4, 1024, 0, 1}
-};
-
-/*
- * Not sure that u3 supports that high aperture sizes but it
- * would strange if it did not :)
- */
-static struct aper_size_info_32 u3_sizes[8] =
+static struct aper_size_info_32 uninorth_sizes[8] =
 {
 	{512, 131072, 7, 128},
 	{256, 65536, 6, 64},
@@ -483,7 +466,8 @@ struct agp_bridge_driver uninorth_agp_dr
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= (void *)uninorth_sizes,
 	.size_type		= U32_APER_SIZE,
-	.num_aperture_sizes	= 4,
+	.num_aperture_sizes	= sizeof(uninorth_sizes)
+				/ sizeof(struct aper_size_info_32),
 	.configure		= uninorth_configure,
 	.fetch_size		= uninorth_fetch_size,
 	.cleanup		= uninorth_cleanup,
@@ -505,9 +489,10 @@ struct agp_bridge_driver uninorth_agp_dr
 
 struct agp_bridge_driver u3_agp_driver = {
 	.owner			= THIS_MODULE,
-	.aperture_sizes		= (void *)u3_sizes,
+	.aperture_sizes		= (void *)uninorth_sizes,
 	.size_type		= U32_APER_SIZE,
-	.num_aperture_sizes	= 8,
+	.num_aperture_sizes	= sizeof(uninorth_sizes)
+				/ sizeof(struct aper_size_info_32),
 	.configure		= uninorth_configure,
 	.fetch_size		= uninorth_fetch_size,
 	.cleanup		= uninorth_cleanup,


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
