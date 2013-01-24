Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 829002C0152
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:12 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 00/32] usb: refactor gadget->dev registration
Date: Thu, 24 Jan 2013 17:45:38 +0200
Message-ID: <1359042370-4358-1-git-send-email-balbi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kgene.kim@samsung.com, eric.y.miao@gmail.com,
 kuninori.morimoto.gx@renesas.com, alexander.shishkin@linux.intel.com,
 gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com,
 nicolas.ferre@atmel.com, linux-geode@lists.infradead.org,
 haojian.zhuang@gmail.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@ti.com>,
 ben-linux@fluff.org, dahlmann.thomas@arcor.de, linux@arm.linux.org.uk,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi folks,

Please comment on this series as I need help testing it
on all UDC controllers so we can send it for v3.10 merge
window.

NOTE: I will queue this series for v3.10 merge window, so
make sure to test and comment.

cheers

Felipe Balbi (32):
  usb: gadget: udc-core: allow udc class register gadget device
  usb: dwc3: gadget: let udc-core manage gadget->dev
  usb: musb: gadget: let udc-core manage gadget-dev
  usb: gadget: omap_udc: let udc-core manage gadget->dev
  usb: gadget: amd5536udc: let udc-core manage gadget->dev
  usb: gadget: at91_udc: let udc-core manage gadget->dev
  usb: gadget: atmel_usba_udc: let udc-core manage gadget->dev
  usb: gadget: bcm63xx_udc: let udc-core manage gadget->dev
  usb: gadget: dummy_hcd: let udc-core manage gadget->dev
  usb: gadget: fsl_qe_udc: let udc-core manage gadget->dev
  usb: gadget: fsl_udc_core: let udc-core manage gadget->dev
  usb: gadget: fusb300_udc: let udc-core manage gadget->dev
  usb: gadget: goku_udc: let udc-core manage gadget->dev
  usb: gadget: imx_udc: let udc-core manage gadget->dev
  usb: gadget: lpc32xx_udc: let udc-core manage gadget->dev
  usb: gadget: m66592-udc: let udc-core manage gadget->dev
  usb: gadget: mv_u3d_core: let udc-core manage gadget->dev
  usb: gadget: mv_u3d_core: fix a compile warning
  usb: gadget: mv_udc_core: let udc-core manage gadget->dev
  usb: gadget: net2272: let udc-core manage gadget->dev
  usb: gadget: net2280: let udc-core manage gadget->dev
  usb: gadget: pch_udc: let udc-core manage gadget->dev
  usb: gadget: r8a66597-udc: let udc-core manage gadget->dev
  usb: gadget: s3c-hsotg: let udc-core manage gadget->dev
  usb: gadget: s3c-hsudc: let udc-core manage gadget->dev
  usb: gadget: s3c2410_udc: let udc-core manage gadget->dev
  usb: renesas_usbhs: gadget: let udc-core manage gadget->dev
  usb: gadget: pxa25x_udc: let udc-core manage gadget->dev
  usb: gadget: pxa27x_udc: let udc-core manage gadget->dev
  usb: chipidea: register debugging syfs on our device
  usb: chipidea: let udc-core manage gadget->dev
  usb: gadget: drop now unnecessary flag

 drivers/usb/chipidea/udc.c             | 18 ++++--------------
 drivers/usb/dwc3/gadget.c              | 16 +---------------
 drivers/usb/gadget/amd5536udc.c        |  8 --------
 drivers/usb/gadget/at91_udc.c          | 12 +-----------
 drivers/usb/gadget/atmel_usba_udc.c    | 12 ------------
 drivers/usb/gadget/bcm63xx_udc.c       |  6 ------
 drivers/usb/gadget/dummy_hcd.c         |  9 ---------
 drivers/usb/gadget/fsl_qe_udc.c        | 14 +-------------
 drivers/usb/gadget/fsl_udc_core.c      |  8 +-------
 drivers/usb/gadget/fusb300_udc.c       | 13 -------------
 drivers/usb/gadget/goku_udc.c          |  9 ---------
 drivers/usb/gadget/goku_udc.h          |  3 +--
 drivers/usb/gadget/imx_udc.c           | 12 ------------
 drivers/usb/gadget/lpc32xx_udc.c       | 10 ----------
 drivers/usb/gadget/m66592-udc.c        | 12 ------------
 drivers/usb/gadget/mv_u3d_core.c       | 11 +----------
 drivers/usb/gadget/mv_udc_core.c       | 11 +----------
 drivers/usb/gadget/net2272.c           |  9 +--------
 drivers/usb/gadget/net2280.c           |  4 ----
 drivers/usb/gadget/omap_udc.c          | 11 +++--------
 drivers/usb/gadget/pch_udc.c           |  9 ---------
 drivers/usb/gadget/pxa25x_udc.c        |  9 ---------
 drivers/usb/gadget/pxa27x_udc.c        |  8 --------
 drivers/usb/gadget/r8a66597-udc.c      | 11 +----------
 drivers/usb/gadget/s3c-hsotg.c         | 13 -------------
 drivers/usb/gadget/s3c-hsudc.c         | 10 ----------
 drivers/usb/gadget/s3c2410_udc.c       |  9 ---------
 drivers/usb/gadget/udc-core.c          | 20 ++++++++++++++++----
 drivers/usb/musb/musb_gadget.c         |  9 ---------
 drivers/usb/renesas_usbhs/mod_gadget.c | 10 +---------
 30 files changed, 33 insertions(+), 283 deletions(-)

-- 
1.8.1.rc1.5.g7e0651a
