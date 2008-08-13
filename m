Return-Path: <yorksun@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CC5B3DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 06:55:51 +1000 (EST)
From: York Sun <yorksun@freescale.com>
To: akpm@linux-foundation.org
Subject: [PATCH 2/2] Bug fix. Add sanity check for AOI position
Date: Wed, 13 Aug 2008 15:55:04 -0500
Message-Id: <1218660906446-git-send-email-yorksun@freescale.com>
In-Reply-To: <12186609063047-git-send-email-yorksun@freescale.com>
References: <12186609042933-git-send-email-yorksun@freescale.com>
	<12186609063047-git-send-email-yorksun@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

AOI position cannot be negative.

Signed-off-by: York Sun <yorksun@freescale.com>
---
 drivers/video/fsl-diu-fb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index d67e79b..8898d2a 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -479,6 +479,10 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 	base_plane_width = machine_data->fsl_diu_info[0]->var.xres;
 	base_plane_height = machine_data->fsl_diu_info[0]->var.yres;
 
+	if (mfbi->x_aoi_d < 0)
+		mfbi->x_aoi_d = 0;
+	if (mfbi->y_aoi_d < 0)
+		mfbi->y_aoi_d = 0;
 	switch (index) {
 	case 0:
 		if (mfbi->x_aoi_d != 0)
-- 
1.5.2.2
