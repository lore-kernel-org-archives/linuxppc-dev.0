Return-Path: <r.baldyga@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD6481A0BBF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 19:40:07 +1000 (AEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRH024GP1IR4L70@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 14 Jul 2015 18:40:03 +0900 (KST)
From: Robert Baldyga <r.baldyga@samsung.com>
To: gregkh@linuxfoundation.org, balbi@ti.com
Cc: Peter.Chen@freescale.com, johnyoun@synopsys.com, dahlmann.thomas@arcor.de,
 nicolas.ferre@atmel.com, cernekee@gmail.com, leoli@freescale.com,
 daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
 michal.simek@xilinx.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-geode@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 andrzej.p@samsung.com, m.szyprowski@samsung.com,
 Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 00/48] usb: gadget: rework ep matching and claiming
 mechanism
Date: Tue, 14 Jul 2015 11:38:48 +0200
Message-id: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
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
epautoconf. From v2 there are 11 additional patches adding 'ep_match'
to usb_gadget_ops and removing chip-specific quirk handling from generic
code of autoconfig.

I'm not sure if this patch set isn't too long, as it has 48 patches,
but I decided to send it as single series to avoid problems with patch
applying order.

The aim of whole patchset is to rework epautoconf code to get rid of
things like name-based endpoint matching and UDC name-based quirks in
generic code. These needed to do some modifications in framework like
adding 'endpoint capabilities flags' feature or adding 'match_ep'.

Following paragraphs contain brief description of what modifications are
done by particular parts of this patch set:

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

Patch (38) removes chip-specific quirk from ep_matches() function.

Patches (39-40) remove code modifying endpoint and descriptor structures
from ep_matches() function and cleans it up to make it simpler and more
readable.

Patches (41-42) add 'match_ep' callback to usb_gadget_ops and make use
of it in epautoconf. This callback allows UDC drivers to supply
non-standard endpoint matching algorithms.

Patches (43-44) add usb_gadget_ep_match_desc() function which makes the
same thing as ep_matches(), but is located in udc-core where it's
available for UDC drivers, which can use it as helper function in
'match_ep' callback to avoid writing lots of repetitive code. Patch (44)
replaces all calls of ep_matches() with usb_gadget_ep_match_desc() and
removes the ep_matches() as a dead code.

Patches (45-47) move chip-specific enpoint matching algorithms from
generic code of usb_ep_autoconfig_ss() function to UDC controller drivers
using 'match_ep' callback.

Patch (48) makes final cleanup after whole operation.

[1] https://lkml.org/lkml/2014/6/16/94
[2] http://www.spinics.net/lists/linux-usb/msg99662.html

Best regards,
Robert Baldyga

Changelog:

v2:
- remove PXA quirk from ep_matches() function without behaviour change
  using ep capabilities flags
- separate ep and desc configuration code from ep_match() function
- add 'ep_match' to usb_gadget_ops and move chip-specific endpoint
  matching algorithms from generic code to UDC controller drivers

v1: https://lkml.org/lkml/2015/7/8/436

Robert Baldyga (48):
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
  usb: gadget: epautoconf: remove pxa quirk from ep_matches()
  usb: gadget: epautoconf: remove ep and desc configuration from
    ep_matches()
  usb: gadget: epautoconf: rework ep_matches() function
  usb: gadget: add 'ep_match' callback to usb_gadget_ops
  usb: gadget: epautoconf: use 'ep_match' gadget callback
  usb: gadget: udc: add usb_gadget_ep_match_desc() function
  usb: gadget: epautoconf: remove ep_matches() function
  usb: gadget: net2280: add net2280_match_ep() function
  usb: gadget: goku_udc: add goku_match_ep() function
  usb: musb: gadget: add musb_match_ep() function
  usb: gadget: epautoconf: cleanup dead code

 drivers/staging/emxx_udc/emxx_udc.c     |  60 ++++---
 drivers/usb/chipidea/udc.c              |  14 ++
 drivers/usb/dwc2/gadget.c               |  13 ++
 drivers/usb/dwc3/gadget.c               |  13 ++
 drivers/usb/gadget/epautoconf.c         | 282 +++++---------------------------
 drivers/usb/gadget/udc/amd5536udc.c     |  57 +++++--
 drivers/usb/gadget/udc/at91_udc.c       |  33 +++-
 drivers/usb/gadget/udc/atmel_usba_udc.c |  11 ++
 drivers/usb/gadget/udc/bcm63xx_udc.c    |  25 ++-
 drivers/usb/gadget/udc/bdc/bdc_ep.c     |   9 +
 drivers/usb/gadget/udc/dummy_hcd.c      |  65 ++++++--
 drivers/usb/gadget/udc/fotg210-udc.c    |  11 ++
 drivers/usb/gadget/udc/fsl_qe_udc.c     |  11 ++
 drivers/usb/gadget/udc/fsl_udc_core.c   |  13 ++
 drivers/usb/gadget/udc/fusb300_udc.c    |  11 ++
 drivers/usb/gadget/udc/goku_udc.c       |  33 ++++
 drivers/usb/gadget/udc/gr_udc.c         |  11 ++
 drivers/usb/gadget/udc/lpc32xx_udc.c    |  32 ++++
 drivers/usb/gadget/udc/m66592-udc.c     |  11 ++
 drivers/usb/gadget/udc/mv_u3d_core.c    |   9 +
 drivers/usb/gadget/udc/mv_udc_core.c    |   9 +
 drivers/usb/gadget/udc/net2272.c        |  11 ++
 drivers/usb/gadget/udc/net2280.c        |  94 +++++++++--
 drivers/usb/gadget/udc/omap_udc.c       |  22 +++
 drivers/usb/gadget/udc/pch_udc.c        |  14 +-
 drivers/usb/gadget/udc/pxa25x_udc.c     |  29 ++++
 drivers/usb/gadget/udc/pxa27x_udc.h     |  33 ++--
 drivers/usb/gadget/udc/r8a66597-udc.c   |  10 ++
 drivers/usb/gadget/udc/s3c-hsudc.c      |  15 ++
 drivers/usb/gadget/udc/s3c2410_udc.c    |  10 ++
 drivers/usb/gadget/udc/udc-core.c       |  69 ++++++++
 drivers/usb/gadget/udc/udc-xilinx.c     |   9 +
 drivers/usb/isp1760/isp1760-udc.c       |  11 ++
 drivers/usb/musb/musb_gadget.c          |  56 +++++++
 drivers/usb/renesas_usbhs/mod_gadget.c  |   6 +
 include/linux/usb/gadget.h              |  53 ++++++
 36 files changed, 838 insertions(+), 337 deletions(-)

-- 
1.9.1
