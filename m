Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 42205DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 04:45:31 +1100 (EST)
Date: Wed, 14 Mar 2007 18:45:29 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 13/13] fix ps3fb glue allowing a modular build
In-Reply-To: <Pine.LNX.4.64.0703141016060.9690@woody.linux-foundation.org>
Message-ID: <Pine.LNX.4.62.0703141838030.28462@pademelon.sonytel.be>
References: <E1HRPbU-0003Ha-Oq@ZenIV.linux.org.uk>
	<Pine.LNX.4.62.0703141040030.28462@pademelon.sonytel.be>
	<20070314160258.GK4095@ftp.linux.org.uk>
	<Pine.LNX.4.62.0703141715570.28462@pademelon.sonytel.be>
	<20070314170720.GL4095@ftp.linux.org.uk>
	<Pine.LNX.4.64.0703141016060.9690@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 14 Mar 2007, Linus Torvalds wrote:
> On Wed, 14 Mar 2007, Al Viro wrote:
> > Nope.  How can kconfig distinguish that from a boolean option in modular
> > driver?  bool *can* depend on tristate and be selected when tristate is
> > set to m.
> 
> Btw, this is one of those things that easily causes problems.

I just found another caveat: while `select' is some super-override-it-all that
ignores depends on non-existent symbols, it doesn't promote `m' to `y'.
E.g. `select FB_CFB_FILLRECT' from a bool still gives FB_CFB_FILLRECT=m if
FB=m.

Anyway, here's a fix for the 3 problematic cases I found.

Subject: bool fbdevs must depend on FB = y

Frame buffer device drivers that cannot be built as modules must depend on
`FB = y'.  Correct the 3 remaining offenders.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7f5a598..e4f0dd0 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1320,7 +1320,7 @@ config FB_AU1100
 
 config FB_AU1200
 	bool "Au1200 LCD Driver"
-	depends on FB && MIPS && SOC_AU1200
+	depends on (FB = y) && MIPS && SOC_AU1200
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1470,7 +1470,7 @@ config FB_G364
 
 config FB_68328
 	bool "Motorola 68328 native frame buffer support"
-	depends on FB && (M68328 || M68EZ328 || M68VZ328)
+	depends on (FB = y) && (M68328 || M68EZ328 || M68VZ328)
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
@@ -1616,7 +1616,7 @@ config FB_IBM_GXT4500
 
 config FB_PS3
 	bool "PS3 GPU framebuffer driver"
-	depends on FB && PS3_PS3AV
+	depends on (FB = y) && PS3_PS3AV
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
