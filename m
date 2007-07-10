Return-Path: <bunk@stusta.de>
Received: from mailhub.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with ESMTP id 0FF00DDECB
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:18:48 +1000 (EST)
Date: Tue, 10 Jul 2007 02:19:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mikael Pettersson <mikpe@it.uu.se>, adaplas@gmail.com
Subject: [2.6 patch] drivers/video/macmodes.c:mac_find_mode() mustn't be
	__devinit
Message-ID: <20070710001918.GP3492@stusta.de>
References: <200707092347.l69NlElB023451@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200707092347.l69NlElB023451@harpo.it.uu.se>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 10, 2007 at 01:47:14AM +0200, Mikael Pettersson wrote:
> A vanilla 2.6.22 built for ppc32 and configured with CONFIG_FB_MACMODES=y, CONFIG_HOTPLUG=n,
> and CONFIG_MODULES=y, triggers the following warning from modpost:
> 
> WARNING: drivers/built-in.o(__ksymtab+0x3b0): Section mismatch: reference to .init.text:mac_find_mode (between '__ksymtab_mac_find_mode' and '__ksymtab_mac_map_monitor_sense')
> 
> There's an EXPORT_SYMBOL(mac_find_mode), but mac_find_mode() is __devinit
> and thus __init in this kernel.

So let's fix it.  ;-)

> /Mikael

cu
Adrian


<--  snip  -->


If it's EXPORT_SYMBOL'ed it can't be __devinit.

Reported by Mikael Pettersson.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

@stable:
Fixes a real bug on ppc.

 drivers/video/macmodes.c |    5 ++---
 drivers/video/macmodes.h |    8 ++++----
 2 files changed, 6 insertions(+), 7 deletions(-)

--- linux-2.6.22-rc6-mm1/drivers/video/macmodes.h.old	2007-07-10 01:55:14.000000000 +0200
+++ linux-2.6.22-rc6-mm1/drivers/video/macmodes.h	2007-07-10 01:55:29.000000000 +0200
@@ -55,10 +55,10 @@
 extern int mac_var_to_vmode(const struct fb_var_screeninfo *var, int *vmode,
 			    int *cmode);
 extern int mac_map_monitor_sense(int sense);
-extern int __devinit mac_find_mode(struct fb_var_screeninfo *var,
-				   struct fb_info *info,
-				   const char *mode_option,
-				   unsigned int default_bpp);
+extern int mac_find_mode(struct fb_var_screeninfo *var,
+			 struct fb_info *info,
+			 const char *mode_option,
+			 unsigned int default_bpp);
 
 
     /*
--- linux-2.6.22-rc6-mm1/drivers/video/macmodes.c.old	2007-07-10 01:54:36.000000000 +0200
+++ linux-2.6.22-rc6-mm1/drivers/video/macmodes.c	2007-07-10 01:55:04.000000000 +0200
@@ -369,9 +369,8 @@
  *
  */
 
-int __devinit mac_find_mode(struct fb_var_screeninfo *var,
-			    struct fb_info *info, const char *mode_option,
-			    unsigned int default_bpp)
+int mac_find_mode(struct fb_var_screeninfo *var, struct fb_info *info,
+		  const char *mode_option, unsigned int default_bpp)
 {
     const struct fb_videomode *db = NULL;
     unsigned int dbsize = 0;
