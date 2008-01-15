Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C7359DDF36
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 02:58:23 +1100 (EST)
Date: Tue, 15 Jan 2008 16:58:26 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: crash in kmem_cache_init
Message-ID: <20080115155826.GA14446@aepfle.de>
References: <20080115150949.GA14089@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080115150949.GA14089@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 15, Olaf Hering wrote:

> 
> Current linus tree crashes in kmem_cache_init, as shown below. The
> system is a 8cpu 2.2GHz POWER5 system, model 9117-570, with 4GB ram.
> Firmware is 240_332, 2.6.23 boots ok with the same config.
> 
> There is a series of mm related patches in 2.6.24-rc1:
> commit 04231b3002ac53f8a64a7bd142fde3fa4b6808c6 seems to break it,

2.6.24-rc6-mm1-ppc64 boots past this point, but crashes later.
Likely unrelated to the kmem_cache_init bug:

...
matroxfb: 640x480x8bpp (virtual: 640x26214)
matroxfb: framebuffer at 0x40178000000, mapped to 0xd000080080080000, size 33554432
Console: switching to colour frame buffer device 80x30
fb0: MATROX frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
vio_register_driver: driver hvc_console registering
HVSI: registered 0 devices
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
input: Macintosh mouse button emulation as /devices/virtual/input/input0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ehci_hcd 0000:c8:01.2: EHCI Host Controller
ehci_hcd 0000:c8:01.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:c8:01.2: irq 85, io mem 0x400a0002000
ehci_hcd 0000:c8:01.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
Unable to handle kernel paging request for data at address 0x00000050
Faulting instruction address: 0xc0000000000fa1c4
cpu 0x7: Vector: 300 (Data Access) at [c0000000d82e7a70]
    pc: c0000000000fa1c4: .cache_reap+0x74/0x29c
    lr: c0000000000fa198: .cache_reap+0x48/0x29c
    sp: c0000000d82e7cf0
   msr: 8000000000009032
   dar: 50
 dsisr: 40000000
  current = 0xc0000000d82d85c0
  paca    = 0xc000000000668e00
    pid   = 27, comm = events/7
enter ? for help
[c0000000d82e7cf0] c00000000070be98 vmstat_update+0x0/0x18 (unreliable)
[c0000000d82e7da0] c000000000092994 .run_workqueue+0x120/0x210
[c0000000d82e7e40] c000000000093bb8 .worker_thread+0xcc/0xf0
[c0000000d82e7f00] c000000000097b70 .kthread+0x78/0xc4
[c0000000d82e7f90] c00000000002ab74 .kernel_thread+0x4c/0x68
7:mon> 
...
