Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 88D51B6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Apr 2011 01:33:12 +1000 (EST)
Subject: Re: Revert 737a3bb9416ce2a7c7a4170852473a4fcc9c67e8 ?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20110411133128.GA24344@iram.es>
References: <20110404235259.GA30132@iram.es>
	<20110406084101.GB13963@pengutronix.de>
	<BANLkTimAJ-s_3A3L1YGfoFLmd4bpu2jWVA@mail.gmail.com>
	<20110406204327.GA11148@iram.es>
	<1302185075.24704.143.camel@thor.local>
	<20110411133128.GA24344@iram.es>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Apr 2011 17:32:43 +0200
Message-ID: <1302535963.24704.268.camel@thor.local>
Mime-Version: 1.0
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Dave Airlie <airlied@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ Adding the dri-devel list ]

On Mon, 2011-04-11 at 15:31 +0200, Gabriel Paubert wrote:=20
> On Thu, Apr 07, 2011 at 04:04:35PM +0200, Michel D=C3=A4nzer wrote:
> > On Mit, 2011-04-06 at 22:43 +0200, Gabriel Paubert wrote:=20
> > >=20
> > > The probem is that, at least on one of my machines, the new driver
> > > does not work: the system hangs (apparently solid, but it's before
> > > networking starts up and I've not yet hooked up a serial console),=
=20
> > > after the "radeon: ib pool ready" message.
> >=20
> > Does radeon.agpmode=3D-1 radeon.no_wb=3D1 help?
> >=20
> > You might be able to get more information via netconsole if you prevent
> > the radeon module from loading automatically (or load it with
> > radeon.modeset=3D0 first) and then load it e.g. via ssh with modeset=3D=
1.
>=20
> Loading the module with modeset=3D1 results in insmod blocked in
> kernel state (not consuming CPU cycles either). The last kernel=20
> message is always the same (ib pool ready). This seems to be=20
> independent of agpmode and no_wb. The kernel messages when
> loading the driver are:
>=20
> kernel: [drm] radeon kernel modesetting enabled.
> kernel: checking generic (c0000000 140000) vs hw (c0000000 10000000)
> kernel: fb: conflicting fb hw usage radeondrmfb vs OFfb vga,Displa - remo=
ving generic driver
> kernel: [drm] initializing kernel modesetting (RV530 0x1002:0x71C7).
> kernel: radeon 0000:f1:00.0: Using 64-bit DMA iommu bypass
> kernel: [drm] register mmio base: 0xE8000000
> kernel: [drm] register mmio size: 65536
> kernel: radeon 0000:f1:00.0: Invalid ROM contents
> kernel: ATOM BIOS: X1650PRO
> kernel: [drm] Generation 2 PCI interface, using max accessible memory
> kernel: radeon 0000:f1:00.0: VRAM: 512M 0x0000000000000000 - 0x000000001F=
FFFFFF (512M used)
> kernel: radeon 0000:f1:00.0: GTT: 512M 0x0000000020000000 - 0x000000003FF=
FFFFF
> kernel: [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
> kernel: [drm] Driver supports precise vblank timestamp query.
> kernel: irq: irq 9 on host /mpic mapped to virtual irq 24
> kernel: u3msi: allocated virq 0x18 (hw 0x9) addr 0xf8004090
> kernel: radeon 0000:f1:00.0: radeon: using MSI.

Have you ruled out any MSI related problems? I think the IRQ not working
could explain the symptoms...

> kernel: [drm] radeon: irq initialized.
> kernel: [drm] Detected VRAM RAM=3D512M, BAR=3D256M
> kernel: [drm] RAM width 128bits DDR
> kernel: [TTM] Zone  kernel: Available graphics memory: 1002914 kiB.
> kernel: [TTM] Initializing pool allocator.
> kernel: [drm] radeon: 512M of VRAM memory ready
> kernel: [drm] radeon: 512M of GTT memory ready.
> kernel: [drm] GART: num cpu pages 131072, num gpu pages 131072
> kernel: [drm] radeon: 1 quad pipes, 2 z pipes initialized.
> kernel: [drm] PCIE GART of 512M enabled (table at 0x00040000).
> kernel: radeon 0000:f1:00.0: WB enabled

Make sure this line changes to 'WB disabled' with no_wb=3D1. There's a
writeback endianness bug with modeset=3D1, see
http://lists.freedesktop.org/archives/dri-devel/2011-April/009960.html .

> kernel: [drm] Loading R500 Microcode
> kernel: [drm] radeon: ring at 0x0000000020001000
> kernel: [drm] ring test succeeded in 6 usecs
> kernel: [drm] radeon: ib pool ready.


> For now, with modeset=3D0, agpmode=3D-1 and no_wb=3D1, the driver
> seems to work.

The agpmode and no_wb options only have an effect with modeset=3D1, and
you don't seem to be using AGP anyway. :)


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
