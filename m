Message-ID: <395059C7.25168900@pop.agri.ch>
Date: Wed, 21 Jun 2000 07:59:36 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Stefan Jeglinski <jeglin@4pi.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: can't build 2.4.0-test1; matroxfb parse error?
References: <v04220800b575b0dd6382@[192.168.0.1]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Stefan Jeglinski wrote:
>
> I just rsynced to the linux-pmac-devel tree to try the latest compile
> on my PM6500. I believe this is 2.4.0-test1. With all default config
> options, I get this error:
>
> matroxfb_base.c:1146: parse error before `matroxfb_set_cmap'
> make[4]: *** [matroxfb_base.o] Error 1
>
> I'm using /gcc version 2.95.2 19991024 (release/franzo)/ if that
> makes any difference. I don't know how to handle a "parse error."
> What is it and how might I fix it (or do I just not compile with
> matrox support for now)?

diff -u --recursive linux-2.4.0-test1-ac21.orig/drivers/video/matrox/matroxfb_base.c
linux-2.4.0-test1-ac21/drivers/video/matrox/matroxfb_base.c
--- linux-2.4.0-test1-ac21.orig/drivers/video/matrox/matroxfb_base.c
Sun Jun 18 17:41:02 2000
+++ linux-2.4.0-test1-ac21/drivers/video/matrox/matroxfb_base.c Sun Jun
18 18:24:44 2000
@@ -1143,7 +1143,7 @@
        fb_get_var:     matroxfb_get_var,
        fb_set_var:     matroxfb_set_var,
        fb_get_cmap:    matroxfb_get_cmap,
-       fb_set_cmap     matroxfb_set_cmap,
+       fb_set_cmap:    matroxfb_set_cmap,
        fb_pan_display: matroxfb_pan_display,
        fb_ioctl:       matroxfb_ioctl,
 };

If you get more look on the lkml there is a patch for that topic.
Subject:[PATCH] 2.4.0-test1-ac1 - misc typo in drivers/video II 18.6

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
