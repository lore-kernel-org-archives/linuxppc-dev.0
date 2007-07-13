Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Fri, 13 Jul 2007 14:06:51 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: =?iso-8859-1?Q?H=E5vard?= Espeland <gus@ping.uio.no>
Subject: Re: [Cbe-oss-dev] PS3 improved video mode autodetection for HDMI/DVI
In-Reply-To: <20070713094814.GD507@ping.uio.no>
Message-ID: <Pine.LNX.4.62.0707131404320.18802@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0707121029320.12797@pademelon.sonytel.be>
	<20070712140620.GB507@ping.uio.no>
	<Pine.LNX.4.62.0707121704270.8368@pademelon.sonytel.be>
	<20070713094814.GD507@ping.uio.no>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-286998223-1184328411=:18802"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>,
	Ben Collins <ben.collins@ubuntu.com>
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

---584337861-286998223-1184328411=:18802
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi H鍁ard,

> On Thu, Jul 12, 2007 at 05:12:43PM +0200, Geert Uytterhoeven wrote:
> > On Thu, 12 Jul 2007, [iso-8859-1] H?vard Espeland wrote:
> > > On Thu, Jul 12, 2007 at 10:40:47AM +0200, Geert Uytterhoeven wrote:
> > > > If it fails, please add `#define DEBUG' to drivers/ps3/ps3av.c, send me the
> > > > `Monitor Info' output in the kernel log (dmesg), and tell me which of the
> > > > PS3 video modes (1-13) work and which don't. ps3av has a quirk database for
> > > > monitors that advertise non-working modes, so it can probably be fixed.
> > > > (BTW, even if autodetect works fine, I always welcome this information)
> > > > 
> > > > In case you have a big pile of monitors at your site, you don't have to reboot
> > > > to try them all. Just plug in the new monitor and run `ps3videomode -v 0' to
> > > > switch to the best resolution of the newly-connected monitor.
> > > 
> > > Hi, the autodetect code does not work correctly with a LG L226WTQ 

> > So your monitor advertises:
> > 
> >     Supported 60 Hz modes:   1080p 480p 720p 1080i (0000400d)
> >     Supported VESA modes:    VGA (00000001)
> > 
> > But 1080p and 1080i don't work. As 1080p is the best advertised mode, you don't
> > get anything to see :-(
> > 
> > Does this patch help? It should give you 720p by default.
> > 
> > Index: ps3-linux-2.6/drivers/ps3/ps3av.c
> > ===================================================================
> > --- ps3-linux-2.6.orig/drivers/ps3/ps3av.c	2007-07-12 10:26:33.000000000 +0200
> > +++ ps3-linux-2.6/drivers/ps3/ps3av.c	2007-07-12 16:57:39.000000000 +0200
> > @@ -720,6 +720,10 @@ static const struct ps3av_monitor_quirk 
> >  	{
> >  		.monitor_name	= "DELL 2007WFP",
> >  		.clear_60	= PS3AV_RESBIT_1920x1080I
> > +	}, {
> > +		.monitor_name	= "L226WTQ",
> > +		.clear_60	= PS3AV_RESBIT_1920x1080I |
> > +				  PS3AV_RESBIT_1920x1080P
> >  	}
> >  };
> >  
> 
> The patch gives me a picture, but it does not cover the whole screen.
> Ps3videomode returns mode 67, and if i add 128 to that number I get

Yep, 720p. Good.

> working fullscreen. Additionally, the break in ps3av_fixup_monitor_info

Since 720p is a broadcast mode, I can't make it default to fullscreen, as a
part of the image will fall off on most monitors.

> is misplaced and will only try the first quirk.

Woops, fixed, thanks!

> ps3av_hdmi_get_vid: Using supported resolution 9
> 
> -- 
> H鍁ard Espeland
> 

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village 路 Da Vincilaan 7-D1 路 B-1935 Zaventem 路 Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 路 B-1840 Londerzeel 路 Belgium	
VAT BE 0413.825.160 路 RPR Brussels	
Fortis Bank Zaventem 路 Swift GEBABEBB08A 路 IBAN BE39001382358619
---584337861-286998223-1184328411=:18802--
