Date: Sat, 5 Jun 2004 13:39:35 +0200
From: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: Error in drm with 2.6.7-rc2
Message-Id: <20040605133935.1e560a09.cedric.pradalier@inrialpes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

	I just tried 2.6.7-rc2 to solve some USB instabilities in 2.6.6.
I'm glad to say that my usb speedtouch modem is working perfectly now.
Unfortunately, this comes with a failure in drm  with the following messages in syslog

Jun  5 13:30:04 ceruse kernel: [drm] Initialized radeon 1.10.0 20020828 on minor 0: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
Jun  5 13:30:10 ceruse kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
Jun  5 13:30:10 ceruse kernel: [drm:radeon_unlock] *ERROR* Process 1387 using kernel context 0

And In Xfree86.0.log :
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 10, (OK)
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 10, (OK)
drmOpenByBusid: Searching for BusID pci:0000:00:10.0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 10, (OK)
drmOpenByBusid: drmOpenMinor returns 10
drmOpenByBusid: drmGetBusid reports pci:0000:00:10.0
(II) RADEON(0): [drm] DRM interface version 1.2
(II) RADEON(0): [drm] created "radeon" driver at busid "pci:0000:00:10.0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xda0d8000
(II) RADEON(0): [drm] mapped SAREA 0xda0d8000 to 0x320c7000
(II) RADEON(0): [drm] framebuffer handle = 0x98000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(WW) RADEON(0): [agp] AGP not available
(EE) RADEON(0): [agp] AGP failed to initialize. Disabling the DRI.
(II) RADEON(0): [agp] You may want to make sure the agpgart kernel module
is loaded before the radeon kernel module.

/etc/modules contains :
agpgart
uninorth_agp
radeon

lsmod gives (selected) :
radeon                155032  0
uninorth_agp            8544  1
agpgart                41900  2 uninorth_agp

Did I make something wrong ?

--
Cedric

"[Of course] I'm French! Why do think I have this outrageous
accent, you silly king-a?!"  Monty Python and the Holy Grail

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
