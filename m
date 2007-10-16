Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Tue, 16 Oct 2007 09:18:34 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 12/13] fb: Move and rename extern declaration for
	global_mode_option
In-Reply-To: <20071015144340.167d1cda.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.62.0710160917500.5473@pademelon.sonytel.be>
References: <20071012145052.640177000@pademelon.sonytel.be>
	<20071012145130.867069000@pademelon.sonytel.be>
	<20071015144340.167d1cda.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-895355281-1192519114=:5473"
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	cbe-oss-dev@ozlabs.org, adaplas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-895355281-1192519114=:5473
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 15 Oct 2007, Andrew Morton wrote:
> On Fri, 12 Oct 2007 16:51:04 +0200
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> 
> > -    if (mode_option || (mode_option = global_mode_option)) {
> > +    if (mode_option || (mode_option = fb_mode_option)) {
> 
> I guess that equals-which-looks-like-it-should-be-equals-equals really
> is intended to be an assignment?
> 
> I guess.  After staring at it for a while.  It's a pretty obnoxious way
> of coding it, especially in kernel context where such things are unexpected...

Subject: fb modedb: Refactor confusing mode_option assignment

fb modedb: Refactor confusing mode_option assignment

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/modedb.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -510,7 +510,9 @@ int fb_find_mode(struct fb_var_screeninf
 	default_bpp = 8;
 
     /* Did the user specify a video mode? */
-    if (mode_option || (mode_option = fb_mode_option)) {
+    if (!mode_option)
+	mode_option = fb_mode_option;
+    if (mode_option) {
 	const char *name = mode_option;
 	unsigned int namelen = strlen(name);
 	int res_specified = 0, bpp_specified = 0, refresh_specified = 0;

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-895355281-1192519114=:5473--
