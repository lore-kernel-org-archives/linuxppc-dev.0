Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 12 Jul 2007 10:40:47 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>
Subject: PS3 improved video mode autodetection for HDMI/DVI
Message-ID: <Pine.LNX.4.62.0707121029320.12797@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-156345285-1184229647=:12797"
Cc: Ben Collins <ben.collins@ubuntu.com>
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

---584337861-156345285-1184229647=:12797
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi,

As of 8d28c70b27cb70cf01d21aab8e51a6dc43c10d70, Geoff's git tree[*] has
improved support for video mode autodetection on both HDMI and DVI-D(+HDCP)
monitors. By default the kernel will select the `best' videomode for your
monitor, now also including VESA modes (e.g. 1920x1200). You can still override
it with the traditional `video=' kernel command line option.

If you're using a PS3 with a HDMI or DVI-D(+HDCP) monitor, please give it a
try.

If it fails, please add `#define DEBUG' to drivers/ps3/ps3av.c, send me the
`Monitor Info' output in the kernel log (dmesg), and tell me which of the
PS3 video modes (1-13) work and which don't. ps3av has a quirk database for
monitors that advertise non-working modes, so it can probably be fixed.
(BTW, even if autodetect works fine, I always welcome this information)

In case you have a big pile of monitors at your site, you don't have to reboot
to try them all. Just plug in the new monitor and run `ps3videomode -v 0' to
switch to the best resolution of the newly-connected monitor.

Thanks for your feedback!

[*] git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git/

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
---584337861-156345285-1184229647=:12797--
