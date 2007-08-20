Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Mon, 20 Aug 2007 16:00:00 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Stefan Assmann <sassmann@suse.de>
Subject: Re: PS3 improved video mode autodetection for HDMI/DVI
In-Reply-To: <46C405B3.2040401@suse.de>
Message-ID: <Pine.LNX.4.62.0708201541230.6197@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0707121029320.12797@pademelon.sonytel.be>
	<46C405B3.2040401@suse.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1544178799-1187617695=:6197"
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

---584337861-1544178799-1187617695=:6197
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.62.0708201548221.6197@pademelon.sonytel.be>

	Hi Stefan,

On Thu, 16 Aug 2007, Stefan Assmann wrote:
> Geert Uytterhoeven schrieb:
> > If it fails, please add `#define DEBUG' to drivers/ps3/ps3av.c, send me the
> > `Monitor Info' output in the kernel log (dmesg), and tell me which of the
> > PS3 video modes (1-13) work and which don't. ps3av has a quirk database for
> > monitors that advertise non-working modes, so it can probably be fixed.
> > (BTW, even if autodetect works fine, I always welcome this information)
> >   
> Samsung SyncMaster 226BW
> 
> The autodetection leaves me with an unsupported resolution. I tried

Thanks for the info!

> adding the monitor to the quirk list. Works fine now. Using 720p as

So this patch helps? I'll add it.

--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -731,6 +731,9 @@ static const struct ps3av_monitor_quirk 
 		.monitor_name	= "L226WTQ",
 		.clear_60	= PS3AV_RESBIT_1920x1080I |
 				  PS3AV_RESBIT_1920x1080P
+	}, {
+		.monitor_name	= "SyncMaster",
+		.clear_60	= PS3AV_RESBIT_1920x1080I
 	}
 };
 
> default  resolution might be worth a thought. This should work on all HD
> screen.

I'm considering to remove the 1080i modes from ps3av_preferred_modes[], as
many HDMI screens seem to have problems with interlaced modes.
That would decrease the size of psav_monitor_quirks[] (note that I currently
don't add screens that advertise broken modes if their best advertised video
mode does work).
In addition 1080i looks bad on most screens that support it anyway.

What do people think?

In contrast to this, many screens (like yours) seem to support 1080p, while
they don't advertise it. So perhaps we need .set* fields in
psav_monitor_quirks[], too? I'm a bit reluctant to do that, as many vendors
are not very specific when it comes to the monitor_name field (my collection
has e.g. `SAMSUNG', `SyncMaster', `SONY TV').

> btw, I get the following message while booting:
> PS3AV_CID_AV_VIDEO_DISABLE_SIG: failed 2 port 10
> 
> does this ring a bell? I'm using kernel 2.6.22 with ps3 patches

Do you put your kernel in FLASH ROM (otheros.bld)?
Does it still happen after upgrading to a kernel that has
ps3-wip/ps3av-vesa-stripes-workaround.diff applied (e.g. Geoff's current git
tree)?

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
---584337861-1544178799-1187617695=:6197--
