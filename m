Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7DCC5DDE21
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 08:24:42 +1100 (EST)
Message-ID: <48F50E17.7020801@denx.de>
Date: Tue, 14 Oct 2008 23:24:39 +0200
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: Matteo Fortini <m.fortini@selcomgroup.com>
Subject: Re: [PATCH] Add new framebuffer driver for Fujitsu MB862xx GDCs
References: <1223997906-19900-1-git-send-email-agust@denx.de>	<gd2f4s$82f$1@ger.gmane.org>
	<20081014170455.GA16338@oksana.dev.rtsoft.ru>
	<48F4D29F.6090909@selcomgroup.com>
In-Reply-To: <48F4D29F.6090909@selcomgroup.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, linuxppc-dev@ozlabs.org,
	linux-fbdev-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matteo Fortini wrote:

> Carminefb driver, though, supports 800x600 resolution.

if you use this patch below

diff --git a/drivers/video/mb862xx/mb862xxfb.c b/drivers/video/mb862xx/mb862xxfb.c
index 26b66cb..904a111 100644
--- a/drivers/video/mb862xx/mb862xxfb.c
+++ b/drivers/video/mb862xx/mb862xxfb.c
@@ -218,6 +218,8 @@ static int mb862xxfb_set_par(struct fb_info *fbi)
 	if (par->pre_init)
 		return 0;
 
+	fbi->fix.line_length = (fbi->var.xres_virtual *
+				fbi->var.bits_per_pixel) / 8;
 	/* disp off */
 	reg = inreg(disp, GC_DCM1);
 	reg &= ~GC_DCM01_DEN;

and something like this in user space:

int fd;
struct fb_var_screeninfo var_info;

if ((fd=open("/dev/fb0", O_RDWR))==-1) {
	fprintf(stderr, "Cannot open /dev/fb0\n");
	exit(1);
}
var_info.xres = 800;
var_info.yres = 600;
var_info.xres_virtual = 800;
var_info.yres_virtual = 600;
var_info.pixclock = 25000;
var_info.left_margin = 88;
var_info.right_margin = 40;
var_info.lower_margin = 1;
var_info.upper_margin = 23;
var_info.hsync_len = 128;
var_info.vsync_len = 4;

if (ioctl(fd, FBIOPUT_VSCREENINFO, &var_info)<0) {
	fprintf(stderr, "Cannot set fb var_info\n");
	exit(1);
}

than 800x600 resolution should be possible too. Also 1024x768
resolution should be possible with appropriate parameters.

> BTW, I tried this patch and I get wrong colors on a patched DirectFB
> which is changing the endianness on the fly. Is this driver already
> taking care of this?

I don't know how it behaves with DirectFB. But to get proper
framebuffer console colors with carmine/coralp GDCs I used a
small patch below:

diff --git a/include/linux/fb.h b/include/linux/fb.h
index ae4ecdf..e998048 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -891,11 +891,11 @@ struct fb_info {
 
 #define fb_readb __raw_readb
 #define fb_readw __raw_readw
-#define fb_readl __raw_readl
+#define fb_readl readl
 #define fb_readq __raw_readq
 #define fb_writeb __raw_writeb
 #define fb_writew __raw_writew
-#define fb_writel __raw_writel
+#define fb_writel writel
 #define fb_writeq __raw_writeq
 #define fb_memset memset_io
 
Best regards,
Anatolij

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
