Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 27 Sep 2007 13:53:04 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [patch 0/8] PS3 AV Settings Driver patches for
	2.6.24
In-Reply-To: <1190860285.6502.6.camel@concordia>
Message-ID: <Pine.LNX.4.62.0709271344130.10467@pademelon.sonytel.be>
References: <20070926163308.772580000@pademelon.sonytel.be>
	<1190860285.6502.6.camel@concordia>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1091693748-1190893984=:10467"
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	cbe-oss-dev@ozlabs.org, "Antonino A. Daplas" <adaplas@gmail.com>
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

---584337861-1091693748-1190893984=:10467
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 27 Sep 2007, Michael Ellerman wrote:
> On Wed, 2007-09-26 at 18:33 +0200, Geert Uytterhoeven wrote:
> > Here are some new patches for the PS3 AV Settings Driver (ps3av), which is
> > used in close collaboration with the PS3 Virtual Frame Buffer Device Driver
> > (ps3fb):
> >   [1] ps3av: eliminate unneeded temporary variables
> >   [2] ps3av: eliminate PS3AV_DEBUG
> >   [3] ps3av: use PS3 video mode ids in autodetect code
> >   [4] ps3av: treat DVI-D like HDMI in autodetect
> >   [5] ps3av: add autodetection for VESA modes
> >   [6] ps3av: add quirk database for broken monitors
> >   [7] ps3av: remove unused ps3av_set_mode()
> >   [8] ps3av: don't distinguish between `boot' and `non-boot' autodetection
> > 
> > Please review, and queue for 2.6.24 if they're ok. Thanks!
> > 
> > Question: As several DVI-D displays advertise they support 1080i modes while
> > they actually don't (cfr. the quirk database), perhaps I should drop 1080i
> > modes completely from the ps3av_preferred_modes[] table? Usually 720p looks
> > better than 1080i anyway.  What do you think?
> 
> Definitely. If the autodetection fails Linux is basically unusable on
> PS3 unless you hack the kernel sources and build your own kboot and
> otheros.bld - not entirely trivial for novice users. So it's pretty
> important that it works 100%.

Well, this code has been in Geoff's git tree for a while, and it's been several
weeks ago I got complaints (which have been adressed by adding displays to the
quirk database). The new kboot (from Distro Kit 1.4.1) also uses it.

The only 100% (sic) mode is 480p (actual usable resolution is 576x384), which
is quite limited due to the very low resolution. This is what the current
mainline kernel uses by default, causing complaints from people who don't like
their shiny expensive full-HD displays being driven by 480p by default.

Furthermore Geoff is working on a way to configure the video mode for
otheros.bld (cfr. the tool to change the default kernel command line on an
ia32 kernel image ages ago), and petitboot (which is intended to replace the
current kboot boot loader environment) allows to change the video mode using
a simple key press if you get a blank screen.

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
---584337861-1091693748-1190893984=:10467--
