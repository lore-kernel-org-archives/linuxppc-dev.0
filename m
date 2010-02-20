Return-Path: <bonbons@linux-vserver.org>
Received: from legolas.restena.lu (legolas.restena.lu [158.64.1.34])
	by ozlabs.org (Postfix) with ESMTP id 3A78DB7BFA
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Feb 2010 10:40:25 +1100 (EST)
Date: Sun, 21 Feb 2010 00:18:51 +0100
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
	<gregkh@suse.de>
Subject: [PATCH 2/3] backlight: mark struct backlight_ops const
Message-ID: <20100221001851.673db863@neptune.home>
In-Reply-To: <20100221001049.2f63f5d6@neptune.home>
References: <20100221001049.2f63f5d6@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org,
	acpi4asus-user@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-omap@vger.kernel.org, dri-devel@lists.sourceforge.net,
	ibm-acpi-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/acpi/video.c                            |    2 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c     |    4 ++--
 drivers/macintosh/via-pmu-backlight.c           |    4 ++--
 drivers/platform/x86/acer-wmi.c                 |    2 +-
 drivers/platform/x86/asus-laptop.c              |    2 +-
 drivers/platform/x86/asus_acpi.c                |    2 +-
 drivers/platform/x86/classmate-laptop.c         |    2 +-
 drivers/platform/x86/compal-laptop.c            |    2 +-
 drivers/platform/x86/dell-laptop.c              |    2 +-
 drivers/platform/x86/eeepc-laptop.c             |    2 +-
 drivers/platform/x86/fujitsu-laptop.c           |    2 +-
 drivers/platform/x86/msi-laptop.c               |    2 +-
 drivers/platform/x86/msi-wmi.c                  |    2 +-
 drivers/platform/x86/panasonic-laptop.c         |    2 +-
 drivers/platform/x86/sony-laptop.c              |    2 +-
 drivers/platform/x86/thinkpad_acpi.c            |    2 +-
 drivers/platform/x86/toshiba_acpi.c             |    2 +-
 drivers/staging/samsung-laptop/samsung-laptop.c |    2 +-
 drivers/usb/misc/appledisplay.c                 |    2 +-
 drivers/video/atmel_lcdfb.c                     |    2 +-
 drivers/video/aty/aty128fb.c                    |    2 +-
 drivers/video/aty/atyfb_base.c                  |    2 +-
 drivers/video/aty/radeon_backlight.c            |    2 +-
 drivers/video/bf54x-lq043fb.c                   |    2 +-
 drivers/video/bfin-t350mcqb-fb.c                |    2 +-
 drivers/video/nvidia/nv_backlight.c             |    2 +-
 drivers/video/omap2/displays/panel-taal.c       |    2 +-
 drivers/video/riva/fbdev.c                      |    2 +-
 28 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index b765790..c86c401 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -366,7 +366,7 @@ static int acpi_video_set_brightness(struct backlight_d=
evice *bd)
 				vd->brightness->levels[request_level]);
 }
=20
-static struct backlight_ops acpi_backlight_ops =3D {
+static const struct backlight_ops acpi_backlight_ops =3D {
 	.get_brightness =3D acpi_video_get_brightness,
 	.update_status  =3D acpi_video_set_brightness,
 };
diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/=
nouveau/nouveau_backlight.c
index 20564f8..9a8c990 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -58,7 +58,7 @@ static int nv40_set_intensity(struct backlight_device *bd)
 	return 0;
 }
=20
-static struct backlight_ops nv40_bl_ops =3D {
+static const struct backlight_ops nv40_bl_ops =3D {
 	.options =3D BL_CORE_SUSPENDRESUME,
 	.get_brightness =3D nv40_get_intensity,
 	.update_status =3D nv40_set_intensity,
@@ -81,7 +81,7 @@ static int nv50_set_intensity(struct backlight_device *bd)
 	return 0;
 }
=20
-static struct backlight_ops nv50_bl_ops =3D {
+static const struct backlight_ops nv50_bl_ops =3D {
 	.options =3D BL_CORE_SUSPENDRESUME,
 	.get_brightness =3D nv50_get_intensity,
 	.update_status =3D nv50_set_intensity,
diff --git a/drivers/macintosh/via-pmu-backlight.c b/drivers/macintosh/via-=
pmu-backlight.c
index a348bb0..ecd9b3f 100644
--- a/drivers/macintosh/via-pmu-backlight.c
+++ b/drivers/macintosh/via-pmu-backlight.c
@@ -15,7 +15,7 @@
=20
 #define MAX_PMU_LEVEL 0xFF
=20
-static struct backlight_ops pmu_backlight_data;
+static const struct backlight_ops pmu_backlight_data;
 static DEFINE_SPINLOCK(pmu_backlight_lock);
 static int sleeping, uses_pmu_bl;
 static u8 bl_curve[FB_BACKLIGHT_LEVELS];
@@ -115,7 +115,7 @@ static int pmu_backlight_get_brightness(struct backligh=
t_device *bd)
 	return bd->props.brightness;
 }
=20
-static struct backlight_ops pmu_backlight_data =3D {
+static const struct backlight_ops pmu_backlight_data =3D {
 	.get_brightness	=3D pmu_backlight_get_brightness,
 	.update_status	=3D pmu_backlight_update_status,
=20
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wm=
i.c
index 07d14df..f70bd41 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -915,7 +915,7 @@ static int update_bl_status(struct backlight_device *bd)
 	return 0;
 }
=20
-static struct backlight_ops acer_bl_ops =3D {
+static const struct backlight_ops acer_bl_ops =3D {
 	.get_brightness =3D read_brightness,
 	.update_status =3D update_bl_status,
 };
diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus=
-laptop.c
index 61a1c75..88e8554 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -251,7 +251,7 @@ static struct backlight_device *asus_backlight_device;
  */
 static int read_brightness(struct backlight_device *bd);
 static int update_bl_status(struct backlight_device *bd);
-static struct backlight_ops asusbl_ops =3D {
+static const struct backlight_ops asusbl_ops =3D {
 	.get_brightness =3D read_brightness,
 	.update_status =3D update_bl_status,
 };
diff --git a/drivers/platform/x86/asus_acpi.c b/drivers/platform/x86/asus_a=
cpi.c
index c1d2aee..9980d51 100644
--- a/drivers/platform/x86/asus_acpi.c
+++ b/drivers/platform/x86/asus_acpi.c
@@ -1464,7 +1464,7 @@ static int asus_hotk_remove(struct acpi_device *devic=
e, int type)
 	return 0;
 }
=20
-static struct backlight_ops asus_backlight_data =3D {
+static const struct backlight_ops asus_backlight_data =3D {
 	.get_brightness =3D read_brightness,
 	.update_status  =3D set_brightness_status,
 };
diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86=
/classmate-laptop.c
index ed90082..bfae789 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -452,7 +452,7 @@ static int cmpc_bl_update_status(struct backlight_devic=
e *bd)
 		return -1;
 }
=20
-static struct backlight_ops cmpc_bl_ops =3D {
+static const struct backlight_ops cmpc_bl_ops =3D {
 	.get_brightness =3D cmpc_bl_get_brightness,
 	.update_status =3D cmpc_bl_update_status
 };
diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/co=
mpal-laptop.c
index 1a387e7..2bd6c65 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -162,7 +162,7 @@ static int bl_update_status(struct backlight_device *b)
 	return set_lcd_level(b->props.brightness);
 }
=20
-static struct backlight_ops compalbl_ops =3D {
+static const struct backlight_ops compalbl_ops =3D {
 	.get_brightness =3D bl_get_brightness,
 	.update_status	=3D bl_update_status,
 };
diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell=
-laptop.c
index 3780994..55640e5 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -333,7 +333,7 @@ static int dell_get_intensity(struct backlight_device *=
bd)
 	return buffer.output[1];
 }
=20
-static struct backlight_ops dell_ops =3D {
+static const struct backlight_ops dell_ops =3D {
 	.get_brightness =3D dell_get_intensity,
 	.update_status  =3D dell_send_intensity,
 };
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eee=
pc-laptop.c
index e2be6bb..4f77774 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1096,7 +1096,7 @@ static int update_bl_status(struct backlight_device *=
bd)
 	return set_brightness(bd, bd->props.brightness);
 }
=20
-static struct backlight_ops eeepcbl_ops =3D {
+static const struct backlight_ops eeepcbl_ops =3D {
 	.get_brightness =3D read_brightness,
 	.update_status =3D update_bl_status,
 };
diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/f=
ujitsu-laptop.c
index 5f3320d..b6a0941 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -436,7 +436,7 @@ static int bl_update_status(struct backlight_device *b)
 	return ret;
 }
=20
-static struct backlight_ops fujitsubl_ops =3D {
+static const struct backlight_ops fujitsubl_ops =3D {
 	.get_brightness =3D bl_get_brightness,
 	.update_status =3D bl_update_status,
 };
diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-l=
aptop.c
index 759763d..1093ba2 100644
--- a/drivers/platform/x86/msi-laptop.c
+++ b/drivers/platform/x86/msi-laptop.c
@@ -161,7 +161,7 @@ static int bl_update_status(struct backlight_device *b)
 	return set_lcd_level(b->props.brightness);
 }
=20
-static struct backlight_ops msibl_ops =3D {
+static const struct backlight_ops msibl_ops =3D {
 	.get_brightness =3D bl_get_brightness,
 	.update_status  =3D bl_update_status,
 };
diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi.c
index f5f70d4..5f7cff1 100644
--- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -138,7 +138,7 @@ static int bl_set_status(struct backlight_device *bd)
 	return msi_wmi_set_block(0, backlight_map[bright]);
 }
=20
-static struct backlight_ops msi_backlight_ops =3D {
+static const struct backlight_ops msi_backlight_ops =3D {
 	.get_brightness	=3D bl_get,
 	.update_status	=3D bl_set_status,
 };
diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86=
/panasonic-laptop.c
index fe7cf01..9012d8d 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -352,7 +352,7 @@ static int bl_set_status(struct backlight_device *bd)
 	return acpi_pcc_write_sset(pcc, SINF_DC_CUR_BRIGHT, bright);
 }
=20
-static struct backlight_ops pcc_backlight_ops =3D {
+static const struct backlight_ops pcc_backlight_ops =3D {
 	.get_brightness	=3D bl_get,
 	.update_status	=3D bl_set_status,
 };
diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony=
-laptop.c
index 3f71a60..75481e6 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -853,7 +853,7 @@ static int sony_backlight_get_brightness(struct backlig=
ht_device *bd)
 }
=20
 static struct backlight_device *sony_backlight_device;
-static struct backlight_ops sony_backlight_ops =3D {
+static const struct backlight_ops sony_backlight_ops =3D {
 	.update_status =3D sony_backlight_update_status,
 	.get_brightness =3D sony_backlight_get_brightness,
 };
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/th=
inkpad_acpi.c
index e67e4fe..950a2f7 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6112,7 +6112,7 @@ static void tpacpi_brightness_notify_change(void)
 			       BACKLIGHT_UPDATE_HOTKEY);
 }
=20
-static struct backlight_ops ibm_backlight_data =3D {
+static const struct backlight_ops ibm_backlight_data =3D {
 	.get_brightness =3D brightness_get,
 	.update_status  =3D brightness_update_status,
 };
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/tos=
hiba_acpi.c
index 77bf5d8..0f0b69e 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -706,7 +706,7 @@ static acpi_status remove_device(void)
 	return AE_OK;
 }
=20
-static struct backlight_ops toshiba_backlight_data =3D {
+static const struct backlight_ops toshiba_backlight_data =3D {
         .get_brightness =3D get_lcd,
         .update_status  =3D set_lcd_status,
 };
diff --git a/drivers/staging/samsung-laptop/samsung-laptop.c b/drivers/stag=
ing/samsung-laptop/samsung-laptop.c
index 4877138..0cf2d58 100644
--- a/drivers/staging/samsung-laptop/samsung-laptop.c
+++ b/drivers/staging/samsung-laptop/samsung-laptop.c
@@ -268,7 +268,7 @@ static int update_status(struct backlight_device *bd)
 	return 0;
 }
=20
-static struct backlight_ops backlight_ops =3D {
+static const struct backlight_ops backlight_ops =3D {
 	.get_brightness	=3D get_brightness,
 	.update_status	=3D update_status,
 };
diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledispla=
y.c
index 1eb9e41..ef79ca2 100644
--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -179,7 +179,7 @@ static int appledisplay_bl_get_brightness(struct backli=
ght_device *bd)
 		return pdata->msgdata[1];
 }
=20
-static struct backlight_ops appledisplay_bl_data =3D {
+static const struct backlight_ops appledisplay_bl_data =3D {
 	.get_brightness	=3D appledisplay_bl_get_brightness,
 	.update_status	=3D appledisplay_bl_update_status,
 };
diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 3d886c6..22ee7f8 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -110,7 +110,7 @@ static int atmel_bl_get_brightness(struct backlight_dev=
ice *bl)
 	return lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_VAL);
 }
=20
-static struct backlight_ops atmel_lcdc_bl_ops =3D {
+static const struct backlight_ops atmel_lcdc_bl_ops =3D {
 	.update_status =3D atmel_bl_update_status,
 	.get_brightness =3D atmel_bl_get_brightness,
 };
diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index e4e4d43..137cd34 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -1787,7 +1787,7 @@ static int aty128_bl_get_brightness(struct backlight_=
device *bd)
 	return bd->props.brightness;
 }
=20
-static struct backlight_ops aty128_bl_data =3D {
+static const struct backlight_ops aty128_bl_data =3D {
 	.get_brightness	=3D aty128_bl_get_brightness,
 	.update_status	=3D aty128_bl_update_status,
 };
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 1ddeb4c..fc4e221 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2225,7 +2225,7 @@ static int aty_bl_get_brightness(struct backlight_dev=
ice *bd)
 	return bd->props.brightness;
 }
=20
-static struct backlight_ops aty_bl_data =3D {
+static const struct backlight_ops aty_bl_data =3D {
 	.get_brightness =3D aty_bl_get_brightness,
 	.update_status	=3D aty_bl_update_status,
 };
diff --git a/drivers/video/aty/radeon_backlight.c b/drivers/video/aty/radeo=
n_backlight.c
index 1a056ad..221bd6a 100644
--- a/drivers/video/aty/radeon_backlight.c
+++ b/drivers/video/aty/radeon_backlight.c
@@ -127,7 +127,7 @@ static int radeon_bl_get_brightness(struct backlight_de=
vice *bd)
 	return bd->props.brightness;
 }
=20
-static struct backlight_ops radeon_bl_data =3D {
+static const struct backlight_ops radeon_bl_data =3D {
 	.get_brightness =3D radeon_bl_get_brightness,
 	.update_status	=3D radeon_bl_update_status,
 };
diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index e49ae5e..db4e6f7 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -463,7 +463,7 @@ static int bl_get_brightness(struct backlight_device *b=
d)
 	return 0;
 }
=20
-static struct backlight_ops bfin_lq043fb_bl_ops =3D {
+static const struct backlight_ops bfin_lq043fb_bl_ops =3D {
 	.get_brightness =3D bl_get_brightness,
 };
=20
diff --git a/drivers/video/bfin-t350mcqb-fb.c b/drivers/video/bfin-t350mcqb=
-fb.c
index 2549c53..bc204c6 100644
--- a/drivers/video/bfin-t350mcqb-fb.c
+++ b/drivers/video/bfin-t350mcqb-fb.c
@@ -381,7 +381,7 @@ static int bl_get_brightness(struct backlight_device *b=
d)
 	return 0;
 }
=20
-static struct backlight_ops bfin_lq043fb_bl_ops =3D {
+static const struct backlight_ops bfin_lq043fb_bl_ops =3D {
 	.get_brightness =3D bl_get_brightness,
 };
=20
diff --git a/drivers/video/nvidia/nv_backlight.c b/drivers/video/nvidia/nv_=
backlight.c
index 443e3c8..c443d6a 100644
--- a/drivers/video/nvidia/nv_backlight.c
+++ b/drivers/video/nvidia/nv_backlight.c
@@ -87,7 +87,7 @@ static int nvidia_bl_get_brightness(struct backlight_devi=
ce *bd)
 	return bd->props.brightness;
 }
=20
-static struct backlight_ops nvidia_bl_ops =3D {
+static const struct backlight_ops nvidia_bl_ops =3D {
 	.get_brightness =3D nvidia_bl_get_brightness,
 	.update_status	=3D nvidia_bl_update_status,
 };
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap=
2/displays/panel-taal.c
index 1f01dfc..a5f7f82 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -313,7 +313,7 @@ static int taal_bl_get_intensity(struct backlight_devic=
e *dev)
 	return 0;
 }
=20
-static struct backlight_ops taal_bl_ops =3D {
+static const struct backlight_ops taal_bl_ops =3D {
 	.get_brightness =3D taal_bl_get_intensity,
 	.update_status  =3D taal_bl_update_status,
 };
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index d94c57f..912984c 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -331,7 +331,7 @@ static int riva_bl_get_brightness(struct backlight_devi=
ce *bd)
 	return bd->props.brightness;
 }
=20
-static struct backlight_ops riva_bl_ops =3D {
+static const struct backlight_ops riva_bl_ops =3D {
 	.get_brightness =3D riva_bl_get_brightness,
 	.update_status	=3D riva_bl_update_status,
 };
--=20
1.6.4.4
