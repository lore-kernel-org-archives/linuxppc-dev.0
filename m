Date: Thu, 27 Apr 2000 16:57:54 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: "W. Taylor Holliday" <wtholliday@ucdavis.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
In-Reply-To: <Pine.LNX.4.21.0004271613030.8585-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.21.0004271656110.8718-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 27 Apr 2000, Kostas Gewrgiou wrote:

> Here is a small patch (untested) that changes r128 to use the "fbdev"

 It seems that i forgot my brain at home today, here is the patch for real
this time

 Kostas

--- r128_driver.c	Thu Apr 27 16:09:06 2000
+++ r128_driver.c-orij	Thu Apr 27 15:54:38 2000
@@ -1131,8 +1131,7 @@
 	/* check for linux framebuffer device */
 	if (!xf86LoadSubModule(pScrn, "fbdevhw")) return FALSE;
 	xf86LoaderReqSymLists(fbdevHWSymbols, NULL);
-	if (!fbdevHWInit(pScrn,NULL,xf86FindOptionValue(info->pEnt->device->options,"fbdev")))
-		return FALSE;
+	if (!fbdevHWInit(pScrn, info->PciInfo, NULL)) return FALSE;
 	pScrn->SwitchMode    = fbdevHWSwitchMode;
 	pScrn->AdjustFrame   = fbdevHWAdjustFrame;
 	pScrn->EnterVT       = R128EnterVTFBDev;


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
