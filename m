Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id C4D8CDDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 23:16:43 +1100 (EST)
Date: Thu, 22 Feb 2007 13:16:41 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4 (final?)] ps3fb: thread updates
In-Reply-To: <20070221152047.0d3da74c.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.62.0702221315530.25919@pademelon.sonytel.be>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com>
	<20070215175007.GA10817@lst.de>
	<1171575817.5644.44.camel@localhost.localdomain>
	<20070215165916.de546f0d.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0702161658530.8263@pademelon.sonytel.be>
	<20070216163811.GB32051@lst.de>
	<Pine.LNX.4.62.0702161832200.22939@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702191505510.32160@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702201133080.6407@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702201141000.20432@pademelon.sonytel.be>
	<20070221152047.0d3da74c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 Feb 2007, Andrew Morton wrote:
> On Tue, 20 Feb 2007 11:42:04 +0100 (CET)
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> @@ -808,16 +807,13 @@ static int ps3fb_ioctl(struct fb_info *i
>  
>  static int ps3fbd(void *arg)
>  {
> -	DEFINE_WAIT(wait);
> -	DECLARE_WAIT_QUEUE_HEAD(wq);
> -
>  	while (!kthread_should_stop()) {
> -		prepare_to_wait(&wq, &wait, TASK_INTERRUPTIBLE);
> -		if (!ps3fb.is_kicked)
> -			schedule();
> -		finish_wait(&wq, &wait);
> -		ps3fb.is_kicked = 0;
> -		ps3fb_sync(0);	/* single buffer */
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		if (ps3fb.is_kicked) {
> +			ps3fb.is_kicked = 0;
> +			ps3fb_sync(0);	/* single buffer */
> +		}
> +		schedule();
>  	}
>  	return 0;
>  }
> _
> 
> There's still no try_to_freeze() in there.  Shouldn't we have one?

Here it is. I'll also resend the whole patch for completeness.

Subject: ps3fb: add missing try_to_freeze()

ps3fb: add missing try_to_freeze()

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |    2 ++
 1 files changed, 2 insertions(+)

--- ps3-linux-2.6.21-rc1.orig/drivers/video/ps3fb.c
+++ ps3-linux-2.6.21-rc1/drivers/video/ps3fb.c
@@ -33,6 +33,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/kthread.h>
+#include <linux/freezer.h>
 
 #include <asm/uaccess.h>
 #include <linux/fb.h>
@@ -808,6 +809,7 @@ static int ps3fb_ioctl(struct fb_info *i
 static int ps3fbd(void *arg)
 {
 	while (!kthread_should_stop()) {
+		try_to_freeze();
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (ps3fb.is_kicked) {
 			ps3fb.is_kicked = 0;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
