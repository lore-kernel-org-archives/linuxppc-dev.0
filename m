Return-Path: <r.baldyga@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 961281A18B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 21:19:50 +1000 (AEST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NR6002KU1O8W2C0@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 08 Jul 2015 20:09:44 +0900 (KST)
From: Robert Baldyga <r.baldyga@samsung.com>
To: gregkh@linuxfoundation.org
Cc: Peter.Chen@freescale.com, johnyoun@synopsys.com, balbi@ti.com,
 dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, cernekee@gmail.com,
 leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, michal.simek@xilinx.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-geode@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 andrzej.p@samsung.com, m.szyprowski@samsung.com,
 Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 00/37] usb: gadget: rework ep matching and claiming mechanism
Date: Wed, 08 Jul 2015 13:08:44 +0200
Message-id: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This patch series reworks endpoint matching and claiming mechanism in
epautoconf.

The patch (1) introduces new safer endpoint claiming method, basing on
new 'claimed' flag. It was discussed here [1]. I proposed this solution
over year ago and it was accepted, but apparently I forgot to send the
final version of patch.

Patches (2-3) add the 'capabilities flags' structure and helper macros.
This solution is inspired by the 'feature flags' originally proposed
by Felipe Balbi in 2013 [2], but unfortunately implementation of this
feature has never been completed.

Patches (4-36) add' capabilites flags' support to all UDC drivers present
in the kernel tree. It's needed to be done before replacing old endpoint
matching mechanism, otherwise UDC drivers which doesn't set 'capabilities
flags' won't work with new autoconfig.

Patch (37) finally replaces old endpoint matching method with the new
one basing on capabilities flags.

These changes aims to get rid of code, which guesses endpoint capabilities
basing on it's name, and introduce new better replacement. In result
we have better way to describe types and directions supported by each
endpoint.

For example the old name-based method didn't allow to have endpoint
supporing two types of transfers - there were only ability to support
one or all endpoint types. The 'capabilities flags' feature supply
precise, flexible and extendible mechanism of description of endpoint
hardware limitations, which is desired for proper endpoint matching.

Best regards,
Robert Baldyga

[1] https://lkml.org/lkml/2014/6/16/94
[2] http://www.spinics.net/lists/linux-usb/msg99662.html

Robert Baldyga (37):
  usb: gadget: encapsulate endpoint claiming mechanism
  usb: gadget: add endpoint capabilities flags
  usb: gadget: add endpoint capabilities helper macros
  staging: emxx_udc: add ep capabilities support
  usb: chipidea: udc: add ep capabilities support
  usb: dwc2: gadget: add ep capabilities support
  usb: dwc3: gadget: add ep capabilities support
  usb: gadget: amd5536udc: add ep capabilities support
  usb: gadget: at91_udc: add ep capabilities support
  usb: gadget: bcm63xx_udc: add ep capabilities support
  usb: gadget: bdc: add ep capabilities support
  usb: gadget: dummy-hcd: add ep capabilities support
  usb: gadget: fotg210-udc: add ep capabilities support
  usb: gadget: fsl_qe_udc: add ep capabilities support
  usb: gadget: fsl_udc_core: add ep capabilities support
  usb: gadget: fusb300_udc: add ep capabilities support
  usb: gadget: goku_udc: add ep capabilities support
  usb: gadget: gr_udc: add ep capabilities support
  usb: gadget: lpc32xx_udc: add ep capabilities support
  usb: gadget: m66592-udc: add ep capabilities support
  usb: gadget: mv_u3d_core: add ep capabilities support
  usb: gadget: mv_udc_core: add ep capabilities support
  usb: gadget: net2272: add ep capabilities support
  usb: gadget: net2280: add ep capabilities support
  usb: gadget: omap_udc: add ep capabilities support
  usb: gadget: pch_ud: add ep capabilities support
  usb: gadget: pxa25x_udc: add ep capabilities support
  usb: gadget: pxa27x_udc: add ep capabilities support
  usb: gadget: r8a66597-udc: add ep capabilities support
  usb: gadget: s3c-hsudc: add ep capabilities support
  usb: gadget: s3c2410_udc: add ep capabilities support
  usb: gadget: udc-xilinx: add ep capabilities support
  usb: isp1760: udc: add ep capabilities support
  usb: musb: gadget: add ep capabilities support
  usb: renesas: gadget: add ep capabilities support
  usb: gadget: atmel_usba_udc: add ep capabilities support
  usb: gadget: epautoconf: add endpoint capabilities flags verification

 drivers/staging/emxx_udc/emxx_udc.c     | 60 ++++++++++++------------
 drivers/usb/chipidea/udc.c              | 14 ++++++
 drivers/usb/dwc2/gadget.c               | 13 ++++++
 drivers/usb/dwc3/gadget.c               | 13 ++++++
 drivers/usb/gadget/epautoconf.c         | 83 +++++++++++----------------------
 drivers/usb/gadget/udc/amd5536udc.c     | 57 ++++++++++++++++++----
 drivers/usb/gadget/udc/at91_udc.c       | 33 +++++++++----
 drivers/usb/gadget/udc/atmel_usba_udc.c | 11 +++++
 drivers/usb/gadget/udc/bcm63xx_udc.c    | 25 ++++++++--
 drivers/usb/gadget/udc/bdc/bdc_ep.c     |  9 ++++
 drivers/usb/gadget/udc/dummy_hcd.c      | 65 ++++++++++++++++++++------
 drivers/usb/gadget/udc/fotg210-udc.c    | 11 +++++
 drivers/usb/gadget/udc/fsl_qe_udc.c     | 11 +++++
 drivers/usb/gadget/udc/fsl_udc_core.c   | 13 ++++++
 drivers/usb/gadget/udc/fusb300_udc.c    | 11 +++++
 drivers/usb/gadget/udc/goku_udc.c       |  8 ++++
 drivers/usb/gadget/udc/gr_udc.c         | 11 +++++
 drivers/usb/gadget/udc/lpc32xx_udc.c    | 32 +++++++++++++
 drivers/usb/gadget/udc/m66592-udc.c     | 11 +++++
 drivers/usb/gadget/udc/mv_u3d_core.c    |  9 ++++
 drivers/usb/gadget/udc/mv_udc_core.c    |  9 ++++
 drivers/usb/gadget/udc/net2272.c        | 11 +++++
 drivers/usb/gadget/udc/net2280.c        | 50 +++++++++++++++-----
 drivers/usb/gadget/udc/omap_udc.c       | 22 +++++++++
 drivers/usb/gadget/udc/pch_udc.c        | 14 +++++-
 drivers/usb/gadget/udc/pxa25x_udc.c     | 32 +++++++++++++
 drivers/usb/gadget/udc/pxa27x_udc.h     | 33 +++++++------
 drivers/usb/gadget/udc/r8a66597-udc.c   | 10 ++++
 drivers/usb/gadget/udc/s3c-hsudc.c      | 15 ++++++
 drivers/usb/gadget/udc/s3c2410_udc.c    | 10 ++++
 drivers/usb/gadget/udc/udc-xilinx.c     |  9 ++++
 drivers/usb/isp1760/isp1760-udc.c       | 11 +++++
 drivers/usb/musb/musb_gadget.c          | 12 +++++
 drivers/usb/renesas_usbhs/mod_gadget.c  |  6 +++
 include/linux/usb/gadget.h              | 42 +++++++++++++++++
 35 files changed, 633 insertions(+), 153 deletions(-)

-- 
1.9.1
