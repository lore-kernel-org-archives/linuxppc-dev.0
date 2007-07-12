Return-Path: <gus@ping.uio.no>
Date: Thu, 12 Jul 2007 16:06:20 +0200
From: =?iso-8859-1?Q?H=E5vard?= Espeland <gus@ping.uio.no>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [Cbe-oss-dev] PS3 improved video mode autodetection for HDMI/DVI
Message-ID: <20070712140620.GB507@ping.uio.no>
References: <Pine.LNX.4.62.0707121029320.12797@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.62.0707121029320.12797@pademelon.sonytel.be>
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

On Thu, Jul 12, 2007 at 10:40:47AM +0200, Geert Uytterhoeven wrote:
> 	Hi,
> 
> As of 8d28c70b27cb70cf01d21aab8e51a6dc43c10d70, Geoff's git tree[*] has
> improved support for video mode autodetection on both HDMI and DVI-D(+HDCP)
> monitors. By default the kernel will select the `best' videomode for your
> monitor, now also including VESA modes (e.g. 1920x1200). You can still override
> it with the traditional `video=' kernel command line option.
> 
> If you're using a PS3 with a HDMI or DVI-D(+HDCP) monitor, please give it a
> try.
> 
> If it fails, please add `#define DEBUG' to drivers/ps3/ps3av.c, send me the
> `Monitor Info' output in the kernel log (dmesg), and tell me which of the
> PS3 video modes (1-13) work and which don't. ps3av has a quirk database for
> monitors that advertise non-working modes, so it can probably be fixed.
> (BTW, even if autodetect works fine, I always welcome this information)
> 
> In case you have a big pile of monitors at your site, you don't have to reboot
> to try them all. Just plug in the new monitor and run `ps3videomode -v 0' to
> switch to the best resolution of the newly-connected monitor.

Hi, the autodetect code does not work correctly with a LG L226WTQ 
(native resolution 1680x1050). The detected mode (11) works fine without
fullscreen, but goes out of range with '-f'.

Resolutions w/o fullscreen:
OK: 2, 3, 7, 8, 11, 12
BAD: 1, 4, 5, 6, 9, 10, 13

Resolutions with fullscreen:
OK: 2, 3, 7, 8
BAD: 1, 4, 5, 6, 9, 10, 11, 12, 13

-- 
Håvard Espeland

Monitor Info: size 96
avport: 00
monitor_id:  1e 6d 4e 56 d7 2a 03 00 03 11
monitor_type: 02
monitor_name: L226WTQ
resolution_60: bits: 0000400d native: 00000000
resolution_50: bits: 00000000 native: 00000000
resolution_other: bits: 00000000 native: 00000000
resolution_vesa: bits: 00000001 native: 00000000
color space    rgb: 01
color space yuv444: 00
color space yuv422: 00
color info   red: X 028a Y 015e
color info green: X 012b Y 0272
color info  blue: X 0097 Y 0048
color info white: X 0141 Y 0151
color info gamma:  000000dc
supported_AI: 00
speaker_info: 00
num of audio: 00
ps3av_hdmi_get_vid: Using supported resolution 11
ps3_av vuart_01:  <- ps3av_probe:1016
 <- ps3_system_bus_probe:376: vuart_01
ps3_system_bus_match:354: dev=5(vuart_02), drv=4(ps3_av): miss
ps3_system_bus_match:354: dev=10(ioc0_01), drv=4(ps3_av): miss
ps3_system_bus_match:354: dev=3(sb_04), drv=4(ps3_av): miss
ps3_system_bus_match:354: dev=1(sb_05), drv=4(ps3_av): miss
ps3_system_bus_match:354: dev=2(sb_06), drv=4(ps3_av): miss
ps3_system_bus_match:354: dev=1(sb_07), drv=4(ps3_av): miss
ps3_system_bus_match:354: dev=2(sb_08), drv=4(ps3_av): miss
ps3_system_bus_match:354: dev=9(ioc0_02), drv=4(ps3_av): mis
