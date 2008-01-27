Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Sun, 27 Jan 2008 10:53:24 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 09/11] ps3fb: Round up video modes
In-Reply-To: <20080126220143.16c8f821.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0801271046590.10193@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
	<20080125153107.478948955@vixen.sonytel.be>
	<20080126220143.16c8f821.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-2012663950-1201427604=:10193"
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

---584349381-2012663950-1201427604=:10193
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 26 Jan 2008, Andrew Morton wrote:
> > On Fri, 25 Jan 2008 16:06:32 +0100 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> >  static int ps3fb_cmp_mode(const struct fb_videomode *vmode,
> >  			  const struct fb_var_screeninfo *var)
> >  {
> > -	/* resolution + black border must match a native resolution */
> > -	if (vmode->left_margin + vmode->xres + vmode->right_margin !=
> > -	    var->left_margin + var->xres + var->right_margin ||
> > -	    vmode->upper_margin + vmode->yres + vmode->lower_margin !=
> > -	    var->upper_margin + var->yres + var->lower_margin)
> > +	long xres, yres, left_margin, right_margin, upper_margin, lower_margin;
> > +	long dx, dy;
> 
> I don't think these need to be longs?  And they probably don't need to be
> signed either.
> 
> If a switch to u32 improves the code any, it might be worth doing..
> 
> All the typecasting which this patch adds makes me wonder if the choice
> of types requires a general revisit...

The problems are:
  - Adding up the various fb_var_screeninfo.* timing fields (which are u32) may
    cause overflows. That's why I use `long' (which is 64-bit on ppc64).
    Perhaps I should change it to s64 for readability?
  - If I make xres, yres, left_margin, right_margin, upper_margin, lower_margin
    u32, I need more casts for calculating dx and dy. Probably u64 would be OK,
    though.
  - dx and dy are signed because they can be smaller than 0.

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
---584349381-2012663950-1201427604=:10193--
