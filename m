Date: Mon, 22 Oct 2001 09:33:38 -0700
From: Paul Mundt <pmundt@MVista.COM>
To: Stefan Wanner <stefan.wanner@gmx.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: invert lcd on mpc823l
Message-ID: <20011022093338.A2836@mvista.com>
References: <3BD3E484.1030909@gmx.ch>
Mime-Version: 1.0
In-Reply-To: <3BD3E484.1030909@gmx.ch>; from stefan.wanner@gmx.ch on Mon, Oct 22, 2001 at 11:19:00AM +0200
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Oct 22, 2001 at 11:19:00AM +0200, Stefan Wanner wrote:
> i'm using a sharp LQ64D341 tft lcd on a MPC823L board with the
> kernelsources from denx.de. now when i use /dev/tty0 (the frambuffer
> character device) the output apears inverse (white background, black
> text). the tux in the upper left corner has also strange colors (looks
> also like inverse). how can i fix that?
>
Try inverting your colormap. Try something like the following:

--- arch/ppc/8xx_io/lcd823.c.orig       Mon Oct 22 09:30:43 2001
+++ arch/ppc/8xx_io/lcd823.c    Mon Oct 22 09:30:46 2001
@@ -638,6 +638,7 @@
     }

     lcd823_init_dev();
+    fb_invert_cmaps();
     lcd823_install_cmap(0, &fb_info);

     if (register_framebuffer(&fb_info) == 0) {

Regards,

--
Paul Mundt <pmundt@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
