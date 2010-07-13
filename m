Return-Path: <jjdanimoth@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	by ozlabs.org (Postfix) with ESMTP id 59655B6F15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 00:51:52 +1000 (EST)
Received: by wwb22 with SMTP id 22so440307wwb.21
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 07:51:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1279030767.515.15.camel@thor.local>
References: <AANLkTikdlwl6VxdbkHP0TveQ3SPO0w4RD-onoG3QPyCO@mail.gmail.com>
	<1279030767.515.15.camel@thor.local>
From: jjDaNiMoTh <jjdanimoth@gmail.com>
Date: Tue, 13 Jul 2010 16:51:28 +0200
Message-ID: <AANLkTilk4-gIiJPQb5aqZ5v4YvgzsddexnsmrFBER5HO@mail.gmail.com>
Subject: Re: 2.6.35-rc4 ppc crash when loading radeon modeset=1
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, xorg-driver-ati@lists.x.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/7/13 Michel D=C3=A4nzer <michel@daenzer.net>:
[cut]
> Which framebuffer device (if any) is it trying to initialize otherwise?
> OFfb? The first paragraph above implies none, but then I'm not sure why
> the video=3D parameters would make any difference.
We tried and with 2.6.35-rc4 we could boot without video=3D. First good new=
s :)

[cut]
> Does KMS work better with radeon.agpmode=3D1 (or 2 or -1)?

with radeon.agpmode=3D-1, we could start X server (no black screen),
with both radeon.modeset=3D{0,1}. In all cases, Xorg works fine, except
when we try to load an OpenGL application (like glxgears), Xorg
freeze, we could move only the mouse, we couldn't switch to a backup
console. Same situations with glxgears in both modeset=3D0 and =3D1. In
the log (Xorg.0.log) we have found:

[.. other xorg log, no EE only WW]
[    65.238] (II) RADEON(0): Panel infos found from DDC detailed: 1280x854
[    65.238] (II) RADEON(0): EDID vendor "APP", prod id 39968
[    65.249] (II) RADEON(0): Output: DVI-0, Detected Monitor Type: 0
[    65.249] Unhandled monitor type 0
[    65.249] (II) RADEON(0): Output: S-video, Detected Monitor Type: 0
[   137.813] [mi] EQ overflowing. The server is probably stuck in an
infinite loop.
[   137.813]
Backtrace:
[   137.814] 0: /usr/bin/X (xorg_backtrace+0x58) [0x100582cc]
[   137.814] 1: /usr/bin/X (mieqEnqueue+0x1c8) [0x1004e5d8]
[   137.814] 2: /usr/bin/X (xf86PostButtonEventP+0xf4) [0x10061be8]
[   137.814] 3: /usr/bin/X (xf86PostButtonEvent+0xb4) [0x10061d2c]
[   137.814] 4: /usr/lib/xorg/modules/input/evdev_drv.so
(0xf380000+0x3d88) [0xf383d88]
[   137.814] 5: /usr/bin/X (0x10000000+0x68784) [0x10068784]
[   137.814] 6: /usr/bin/X (0x10000000+0x11a7e4) [0x1011a7e4]
[   137.814] 7: (vdso) (__kernel_sigtramp32+0x0) [0x100344]
[   137.814] 8: /usr/lib/xorg/modules/dri/r300_dri.so
(0xf3f5000+0x48534) [0xf43d534]
[   137.814] 9: /usr/lib/libdrm.so.2 (drmIoctl+0x40) [0xf8b8f64]
[   137.814] 10: /usr/lib/libdrm.so.2 (drmCommandWrite+0x24) [0xf8bbe60]
[   137.814] 11: /usr/lib/xorg/modules/dri/r300_dri.so
(0xf3f5000+0x46944) [0xf43b944]
[   137.814] 12: /usr/lib/xorg/modules/dri/r300_dri.so
(0xf3f5000+0x64d8c) [0xf459d8c]
[   137.814] 13: /usr/lib/xorg/modules/extensions/libglx.so
(0xf930000+0x40f78) [0xf970f78]
[   137.814] 14: /usr/lib/xorg/modules/extensions/libglx.so
(0xf930000+0x44be4) [0xf974be4]
[   137.814] 15: /usr/bin/X (0x10000000+0x34a24) [0x10034a24]
[   137.815] 16: /usr/bin/X (0x10000000+0x18bc4) [0x10018bc4]
[   137.815] 17: /lib/libc.so.6 (0xfb39000+0x1f544) [0xfb58544]
[   137.815] 18: /lib/libc.so.6 (0xfb39000+0x1f6d0) [0xfb586d0]

Do we need to compile mesa, ati-dri, x.org and xf86-video-ati from git?

Many thanks
