Date: Tue, 22 Jun 1999 12:45:30 -0500
From: anthony tong <atong@uiuc.edu>
To: Brad Midgley <brad@pht.com>
Cc: linuxppc-users@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: [Patch]: Re: [workaround] console-switch screws colors
Message-ID: <19990622124530.A20390@mango.aol.edu>
References: <199906220307.NAA01278@farrago.anu.edu.au> <Pine.LNX.3.95.990622110721.4570A-100000@pacific.pht.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.95.990622110721.4570A-100000@pacific.pht.com>; from Brad Midgley on Tue, Jun 22, 1999 at 11:11:51AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Midgley (Tue, Jun 22, 1999 at 11:11:51AM -0600):
> i've noticed (at least) with a couple of machines that use ati graphics
> that switching away from and back to X screws up the colors (using xfb). 
> fortunately, i left it that way long enough for the screensaver to kick in
> and realize it was fixed by the screensaver!
> 
> so if you switch back to x and the colors are screwed, invoke the
> screensaver:
> 
>  xset s activate
> 
> hopefully this is one of those things that will be fixed soon anyway.

This may help. I don't know if Tom built new rpms yet.


--- fbdev.c	Thu Jun 17 01:41:44 1999
+++ /home/atong/fbdev.c	Thu Jun 17 01:43:50 1999
@@ -1261,6 +1261,11 @@
 	}
 
 	if (!xf86Resetting) {
+#ifdef DIRECTCOLORHACK
+	    if (fb_fix.visual == FB_VISUAL_DIRECTCOLOR)
+		fbdevSetLinearColormap(&fb_var);
+	    else
+#endif
 	    /* Update the colormap */
 	    fbdevRestoreColors(pScreen);
 	}

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
