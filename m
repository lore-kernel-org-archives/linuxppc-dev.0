Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1B731007ED
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 May 2011 08:37:34 +1000 (EST)
Received: by iwc10 with SMTP id 10so6095091iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 02 May 2011 15:37:31 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20110502222716.GB15187@ponder.secretlab.ca>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1300782452-528-1-git-send-email-hs@denx.de>
	<1300782452-528-4-git-send-email-hs@denx.de>
	<20110502222716.GB15187@ponder.secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 2 May 2011 16:37:11 -0600
Message-ID: <BANLkTik3L28mmL=LGZ_0nV7vSOX9Miw3ow@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] video, sm501: add edid and commandline support
To: Heiko Schocher <hs@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Samuel Ortiz <sameo@linux.intel.com>, Vincent Sanders <vince@simtec.co.uk>,
	linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 2, 2011 at 4:27 PM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Tue, Mar 22, 2011 at 09:27:29AM +0100, Heiko Schocher wrote:
>> - add commandline options:
>> =A0 sm501fb.mode:
>> =A0 =A0 Specify resolution as "<xres>x<yres>[-<bpp>][@<refresh>]"
>> =A0 sm501fb.bpp:
>> =A0 =A0 Specify bit-per-pixel if not specified mode
>>
>> - Add support for encoding display mode information
>> =A0 in the device tree using verbatim EDID block.
>>
>> =A0 If the "edid" entry in the "smi,sm501" node is present,
>> =A0 the driver will build mode database using EDID data
>> =A0 and allow setting the display modes from this database.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>
> Merged, thanks.

This patch causes the following build warning:

  MODPOST vmlinux.o
WARNING: vmlinux.o(.text+0x1d5572): Section mismatch in reference from
the function sm501fb_init_fb() to the variable
.devinit.data:sm501_default_mode
The function sm501fb_init_fb() references
the variable __devinitdata sm501_default_mode.
This is often because sm501fb_init_fb lacks a __devinitdata
annotation or the annotation of sm501_default_mode is wrong.

WARNING: vmlinux.o(.text+0x1d557a): Section mismatch in reference from
the function sm501fb_init_fb() to the variable
.devinit.data:sm501_default_mode
The function sm501fb_init_fb() references
the variable __devinitdata sm501_default_mode.
This is often because sm501fb_init_fb lacks a __devinitdata
annotation or the annotation of sm501_default_mode is wrong.

I've dropped the __devinitdata declaration in what I committed; can
you investigate and post a fixup patch?

>
> g.
>
>> cc: Wolfram Sang <w.sang@pengutronix.de>
>> cc: Grant Likely <grant.likely@secretlab.ca>
>> cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> cc: linux-fbdev@vger.kernel.org
>> cc: devicetree-discuss@ozlabs.org
>> cc: Ben Dooks <ben@simtec.co.uk>
>> cc: Vincent Sanders <vince@simtec.co.uk>
>> cc: Samuel Ortiz <sameo@linux.intel.com>
>> cc: linux-kernel@vger.kernel.org
>> cc: Randy Dunlap <rdunlap@xenotime.net>
>> cc: Wolfgang Denk <wd@denx.de>
>> cc: Paul Mundt <lethal@linux-sh.org>
>> ---
>> - changes since v1:
>> =A0 add Ben Dooks, Vincent Sanders and Samuel Ortiz to cc, as suggested =
from
>> =A0 Paul Mundt.
>> - changes since v2:
>> =A0 add comments from Randy Dunlap:
>> =A0 - move parameter documentation to Documentation/fb/sm501.txt
>> - changes since v3:
>> =A0 - rebased against v2.6.38-rc2
>> =A0 - split in 3 patches
>> =A0 =A0 - of support patch
>> =A0 =A0 - i/o routine patch
>> =A0 =A0 - edid support patch
>> - changes since v4:
>> =A0 - add "info->pdata =3D &sm501fb_def_pdata;" in sm501fb_probe()
>> =A0 =A0 as Paul Mundt suggested (and I wrongly deleted)
>> =A0 - move kfree(info->edid_data); to patch 3/4
>> =A0 =A0 as edid_data is only allocated in the CONFIG_OF case
>> - changes for v6:
>> =A0 - repost complete patchserie
>> =A0 - rebased against current head
>>
>> =A0Documentation/fb/sm501.txt | =A0 10 +++++++
>> =A0drivers/video/sm501fb.c =A0 =A0| =A0 65 +++++++++++++++++++++++++++++=
+++++++++++---
>> =A02 files changed, 70 insertions(+), 5 deletions(-)
>> =A0create mode 100644 Documentation/fb/sm501.txt
>>
>> diff --git a/Documentation/fb/sm501.txt b/Documentation/fb/sm501.txt
>> new file mode 100644
>> index 0000000..8d17aeb
>> --- /dev/null
>> +++ b/Documentation/fb/sm501.txt
>> @@ -0,0 +1,10 @@
>> +Configuration:
>> +
>> +You can pass the following kernel command line options to sm501 videofr=
amebuffer:
>> +
>> + =A0 =A0 sm501fb.bpp=3D =A0 =A0SM501 Display driver:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Specifiy bits-per-pixel if not=
 specified by 'mode'
>> +
>> + =A0 =A0 sm501fb.mode=3D =A0 SM501 Display driver:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Specify resolution as
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<xres>x<yres>[-<bpp>][@<refre=
sh>]"
>> diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
>> index 5df406c..f31252c 100644
>> --- a/drivers/video/sm501fb.c
>> +++ b/drivers/video/sm501fb.c
>> @@ -41,6 +41,26 @@
>> =A0#include <linux/sm501.h>
>> =A0#include <linux/sm501-regs.h>
>>
>> +#include "edid.h"
>> +
>> +static char *fb_mode =3D "640x480-16@60";
>> +static unsigned long default_bpp =3D 16;
>> +
>> +static struct fb_videomode __devinitdata sm501_default_mode =3D {
>> + =A0 =A0 .refresh =A0 =A0 =A0 =A0=3D 60,
>> + =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D 640,
>> + =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D 480,
>> + =A0 =A0 .pixclock =A0 =A0 =A0 =3D 20833,
>> + =A0 =A0 .left_margin =A0 =A0=3D 142,
>> + =A0 =A0 .right_margin =A0 =3D 13,
>> + =A0 =A0 .upper_margin =A0 =3D 21,
>> + =A0 =A0 .lower_margin =A0 =3D 1,
>> + =A0 =A0 .hsync_len =A0 =A0 =A0=3D 69,
>> + =A0 =A0 .vsync_len =A0 =A0 =A0=3D 3,
>> + =A0 =A0 .sync =A0 =A0 =A0 =A0 =A0 =3D FB_SYNC_HOR_HIGH_ACT | FB_SYNC_V=
ERT_HIGH_ACT,
>> + =A0 =A0 .vmode =A0 =A0 =A0 =A0 =A0=3D FB_VMODE_NONINTERLACED
>> +};
>> +
>> =A0#define NR_PALETTE =A0 256
>>
>> =A0enum sm501_controller {
>> @@ -77,6 +97,7 @@ struct sm501fb_info {
>> =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*regs2d; =A0 =A0 =A0 =A0=
/* 2d remapped registers */
>> =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*fbmem; =A0 =A0 =A0 =A0 =
/* remapped framebuffer */
>> =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fbmem_len; =A0 =
=A0 /* length of remapped region */
>> + =A0 =A0 u8 *edid_data;
>> =A0};
>>
>> =A0/* per-framebuffer private data */
>> @@ -1725,9 +1746,16 @@ static int sm501fb_init_fb(struct fb_info *fb,
>> =A0 =A0 =A0 fb->var.vmode =A0 =A0 =A0 =A0 =A0 =3D FB_VMODE_NONINTERLACED=
;
>> =A0 =A0 =A0 fb->var.bits_per_pixel =A0=3D 16;
>>
>> + =A0 =A0 if (info->edid_data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Now build modedb from EDID =
*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb_edid_to_monspecs(info->edid=
_data, &fb->monspecs);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb_videomode_to_modelist(fb->m=
onspecs.modedb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0fb->monspecs.modedb_len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0&fb->modelist);
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 if (enable && (pd->flags & SM501FB_FLAG_USE_INIT_MODE) && 0)=
 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* TODO read the mode from the current displ=
ay */
>> -
>> =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pd->def_mode) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(info->dev, "using s=
upplied mode\n");
>> @@ -1737,12 +1765,34 @@ static int sm501fb_init_fb(struct fb_info *fb,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb->var.xres_virtual =3D fb-=
>var.xres;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb->var.yres_virtual =3D fb-=
>var.yres;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D fb_find_mode(&fb->var,=
 fb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->edid_data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D fb_fin=
d_mode(&fb->var, fb, fb_mode,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 fb->monspecs.modedb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 fb->monspecs.modedb_len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 &sm501_default_mode, default_bpp);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D fb_fin=
d_mode(&fb->var, fb,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0NULL, NULL, 0, NULL, 8);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D 0 || ret =3D=3D=
 4) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(info->=
dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "failed to get initial mode\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(info-=
>dev, "using mode specified in "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 "@mode\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(info-=
>dev, "using mode specified in "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "@mode with ignored refresh rate\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 3:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(info-=
>dev, "using mode default "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "mode\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 4:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(info-=
>dev, "using mode from list\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(info-=
>dev, "ret =3D %d\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(info-=
>dev, "failed to find mode\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINV=
AL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> @@ -2157,6 +2207,11 @@ static void __exit sm501fb_cleanup(void)
>> =A0module_init(sm501fb_init);
>> =A0module_exit(sm501fb_cleanup);
>>
>> +module_param_named(mode, fb_mode, charp, 0);
>> +MODULE_PARM_DESC(mode,
>> + =A0 =A0 "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" "=
);
>> +module_param_named(bpp, default_bpp, ulong, 0);
>> +MODULE_PARM_DESC(bpp, "Specify bit-per-pixel if not specified mode");
>> =A0MODULE_AUTHOR("Ben Dooks, Vincent Sanders");
>> =A0MODULE_DESCRIPTION("SM501 Framebuffer driver");
>> =A0MODULE_LICENSE("GPL v2");
>> --
>> 1.7.4
>>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
