Return-Path: <wsa-dev@sang-engineering.com>
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKs776WhWzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 03:46:43 +1000 (AEST)
From: Wolfram Sang <wsa-dev@sang-engineering.com>
To: linux-usb@vger.kernel.org
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>,
 accessrunner-general@lists.sourceforge.net,
 legousb-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-tegra@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
Subject: [PATCH 00/44] usb: don't print on ENOMEM
Date: Thu, 25 Aug 2016 19:38:52 +0200
Message-Id: <20160825173947.26624-1-wsa-dev@sang-engineering.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is my next series to save memory by removing unneeded strings. It removes
in the usb subsystem all unspecific error messages after calling malloc-based
functions, i.e. (devm_)k[zcm]alloc. kmalloc prints enough information in that
case. If the message was specific (e.g. "can't save CLEAR_TT_BUFFER state"), I
left it. This series saves ~4.5KB of "out of memory" permutations in .text and
.rodata. For modified lines, (x == NULL) was replaced with (!NULL) as well.
This seems to be the dominant style in this subsystem and checkpatch recommends
it as well (and I prefer it, too).

Wolfram Sang (44):
  usb: atm: cxacru: don't print on ENOMEM
  usb: atm: speedtch: don't print on ENOMEM
  usb: atm: ueagle-atm: don't print on ENOMEM
  usb: atm: usbatm: don't print on ENOMEM
  usb: class: usbtmc: don't print on ENOMEM
  usb: core: hcd: don't print on ENOMEM
  usb: core: hub: don't print on ENOMEM
  usb: core: message: don't print on ENOMEM
  usb: core: urb: don't print on ENOMEM
  usb: dwc2: gadget: don't print on ENOMEM
  usb: gadget: udc: fsl_qe_udc: don't print on ENOMEM
  usb: gadget: udc: goku_udc: don't print on ENOMEM
  usb: gadget: udc: udc-xilinx: don't print on ENOMEM
  usb: host: fhci-hcd: don't print on ENOMEM
  usb: host: max3421-hcd: don't print on ENOMEM
  usb: host: uhci-hcd: don't print on ENOMEM
  usb: host: xhci-tegra: don't print on ENOMEM
  usb: host: xhci: don't print on ENOMEM
  usb: misc: adutux: don't print on ENOMEM
  usb: misc: appledisplay: don't print on ENOMEM
  usb: misc: cypress_cy7c63: don't print on ENOMEM
  usb: misc: cytherm: don't print on ENOMEM
  usb: misc: ftdi-elan: don't print on ENOMEM
  usb: misc: idmouse: don't print on ENOMEM
  usb: misc: iowarrior: don't print on ENOMEM
  usb: misc: ldusb: don't print on ENOMEM
  usb: misc: legousbtower: don't print on ENOMEM
  usb: misc: lvstest: don't print on ENOMEM
  usb: misc: trancevibrator: don't print on ENOMEM
  usb: misc: usblcd: don't print on ENOMEM
  usb: misc: usbsevseg: don't print on ENOMEM
  usb: misc: uss720: don't print on ENOMEM
  usb: misc: yurex: don't print on ENOMEM
  usb: musb: am35x: don't print on ENOMEM
  usb: musb: da8xx: don't print on ENOMEM
  usb: renesas_usbhs: mod_gadget: don't print on ENOMEM
  usb: renesas_usbhs: mod_host: don't print on ENOMEM
  usb: renesas_usbhs: pipe: don't print on ENOMEM
  usb: storage: alauda: don't print on ENOMEM
  usb: storage: sddr09: don't print on ENOMEM
  usb: usb-skeleton: don't print on ENOMEM
  usb: wusbcore: crypto: don't print on ENOMEM
  usb: wusbcore: security: don't print on ENOMEM
  usb: wusbcore: wa-nep: don't print on ENOMEM

 drivers/usb/atm/cxacru.c               |  4 +---
 drivers/usb/atm/speedtch.c             |  1 -
 drivers/usb/atm/ueagle-atm.c           |  9 ++-------
 drivers/usb/atm/usbatm.c               |  7 +------
 drivers/usb/class/usbtmc.c             |  4 +---
 drivers/usb/core/hcd.c                 |  4 +---
 drivers/usb/core/hub.c                 |  9 +++------
 drivers/usb/core/message.c             |  5 +----
 drivers/usb/core/urb.c                 |  4 +---
 drivers/usb/dwc2/gadget.c              |  8 ++------
 drivers/usb/gadget/udc/fsl_qe_udc.c    | 16 ++++------------
 drivers/usb/gadget/udc/goku_udc.c      |  3 +--
 drivers/usb/gadget/udc/udc-xilinx.c    |  4 +---
 drivers/usb/host/fhci-hcd.c            |  4 +---
 drivers/usb/host/max3421-hcd.c         |  8 ++------
 drivers/usb/host/uhci-hcd.c            |  5 +----
 drivers/usb/host/xhci-tegra.c          |  1 -
 drivers/usb/host/xhci.c                |  4 +---
 drivers/usb/misc/adutux.c              | 13 +++----------
 drivers/usb/misc/appledisplay.c        |  3 ---
 drivers/usb/misc/cypress_cy7c63.c      |  5 +----
 drivers/usb/misc/cytherm.c             | 32 ++++++++------------------------
 drivers/usb/misc/ftdi-elan.c           |  1 -
 drivers/usb/misc/idmouse.c             |  1 -
 drivers/usb/misc/iowarrior.c           | 20 ++++++--------------
 drivers/usb/misc/ldusb.c               | 20 +++++---------------
 drivers/usb/misc/legousbtower.c        | 16 ++++------------
 drivers/usb/misc/lvstest.c             |  4 +---
 drivers/usb/misc/trancevibrator.c      |  3 +--
 drivers/usb/misc/usblcd.c              |  9 ++-------
 drivers/usb/misc/usbsevseg.c           |  8 ++------
 drivers/usb/misc/uss720.c              |  4 +---
 drivers/usb/misc/yurex.c               |  8 ++------
 drivers/usb/musb/am35x.c               |  4 +---
 drivers/usb/musb/da8xx.c               |  4 +---
 drivers/usb/renesas_usbhs/mod_gadget.c |  6 +-----
 drivers/usb/renesas_usbhs/mod_host.c   | 10 ++--------
 drivers/usb/renesas_usbhs/pipe.c       |  4 +---
 drivers/usb/storage/alauda.c           | 11 +++--------
 drivers/usb/storage/sddr09.c           | 14 ++++----------
 drivers/usb/usb-skeleton.c             |  9 ++-------
 drivers/usb/wusbcore/crypto.c          |  4 +---
 drivers/usb/wusbcore/security.c        |  4 +---
 drivers/usb/wusbcore/wa-nep.c          |  5 +----
 44 files changed, 78 insertions(+), 244 deletions(-)

-- 
2.9.3
