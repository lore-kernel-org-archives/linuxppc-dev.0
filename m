Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id D6CCDB6F16
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 00:19:34 +1000 (EST)
Subject: Re: 2.6.35-rc4 ppc crash when loading radeon modeset=1
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: jjDaNiMoTh <jjdanimoth@gmail.com>
In-Reply-To: <AANLkTikdlwl6VxdbkHP0TveQ3SPO0w4RD-onoG3QPyCO@mail.gmail.com>
References: <AANLkTikdlwl6VxdbkHP0TveQ3SPO0w4RD-onoG3QPyCO@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Jul 2010 16:19:27 +0200
Message-ID: <1279030767.515.15.camel@thor.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, xorg-driver-ati@lists.x.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Die, 2010-07-13 at 16:03 +0200, jjDaNiMoTh wrote:=20
>=20
> When trying new 2.6.35-rc4, our kernel team (ArchLinuxPPC) has tried
> to setup KMS acceleration for radeon based machine.
> We have removed radeonfb, and all others framebuffer driver, and added
> fbcon and KMS enabled by default for radeon driver.
>=20
> With a clean start, the screen freeze, when the control pass from
> yaboot to kernel.
>=20
> If we start with video=3Dfbcon (or video=3Dradeondrmfb), we could reach
> the loading modules point, [...]

Which framebuffer device (if any) is it trying to initialize otherwise?
OFfb? The first paragraph above implies none, but then I'm not sure why
the video=3D parameters would make any difference.


> Jul 13 15:31:39 jim kernel: [drm] Initialized drm 1.1.0 20060810
> Jul 13 15:31:39 jim kernel: [drm] radeon kernel modesetting enabled.
> Jul 13 15:31:39 jim kernel: [drm] initializing kernel modesetting
> (RV350 0x1002:0x4E50).
> Jul 13 15:31:39 jim kernel: [drm] register mmio base: 0xB0000000
> Jul 13 15:31:39 jim kernel: [drm] register mmio size: 65536
> Jul 13 15:31:39 jim kernel: [drm] Using generic clock info
> Jul 13 15:31:39 jim kernel: agpgart-uninorth 0000:00:0b.0: putting AGP
> V2 device into 4x mode
> Jul 13 15:31:39 jim kernel: radeon 0000:00:10.0: putting AGP V2 device
> into 4x mode
> Jul 13 15:31:39 jim kernel: radeon 0000:00:10.0: GTT: 256M 0x00000000
> - 0x0FFFFFFF
> Jul 13 15:31:39 jim kernel: [drm] Generation 2 PCI interface, using
> max accessible memory
> Jul 13 15:31:39 jim kernel: radeon 0000:00:10.0: VRAM: 64M 0xB8000000
> - 0xBBFFFFFF (64M used)
> Jul 13 15:31:39 jim kernel: [drm] radeon: irq initialized.
> Jul 13 15:31:39 jim kernel: [drm] Detected VRAM RAM=3D64M, BAR=3D128M
> Jul 13 15:31:39 jim kernel: [drm] RAM width 128bits DDR
> Jul 13 15:31:39 jim kernel: [TTM] Zone  kernel: Available graphics
> memory: 384990 kiB.
> Jul 13 15:31:39 jim kernel: [TTM] Zone highmem: Available graphics
> memory: 516062 kiB.
> Jul 13 15:31:39 jim kernel: [TTM] Initializing pool allocator.
> Jul 13 15:31:39 jim kernel: [drm] radeon: 64M of VRAM memory ready
> Jul 13 15:31:39 jim kernel: [drm] radeon: 256M of GTT memory ready.
> Jul 13 15:31:39 jim kernel: [drm] radeon: 1 quad pipes, 1 Z pipes initial=
ized.
> Jul 13 15:31:39 jim kernel: [drm] Loading R300 Microcode
> Jul 13 15:31:39 jim kernel: [drm] radeon: ring at 0x0000000000000000
> Jul 13 15:31:39 jim kernel: [drm] ring test succeeded in 3 usecs
> Jul 13 15:31:39 jim kernel: [drm] radeon: ib pool ready.

So far, so good.

> Jul 13 15:31:40 jim kernel: GPU lockup (waiting for 0x00000001 last
> fence id 0x00000000)

The GPU locks up, and things go downhill from there...

Does KMS work better with radeon.agpmode=3D1 (or 2 or -1)?


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
