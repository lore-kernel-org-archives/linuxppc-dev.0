Return-Path: <tmarri@amcc.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D9201B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 11:16:11 +1100 (EST)
From: tmarri@apm.com
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V6 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver 
Date: Wed,  8 Dec 2010 16:16:04 -0800
Message-Id: <1291853764-20438-1-git-send-email-tmarri@apm.com>
Cc: tmarri@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tirumala Marri <tmarri@apm.com>

v6:
 1. Replaced register definitions and bit fields with macros.
 2. Replace printks with dev_dbg or dev_err functions.
 3. Cleanup some assignments.
 4. Remove chip specific selections in Kconfig file.

v5:
 1. "PATCH V5" has a new license header from Synopsys and APM

Tirumala Marri (10):
  USB/ppc4xx: Add Synopsys DWC OTG Register definitions
  USB/ppc4xx: Add Synopsys DWC OTG driver framework
  USB/ppc4xx: Add Synopsys DWC OTG Core Interface Layer (CIL)
  USB/ppc4xx: Add Synopsys DWC OTG HCD function
  USB/ppc4xx: Add Synopsys DWC OTG HCD interrupt function
  USB/ppc4xx: Add Synopsys DWC OTG HCD queue function
  USB/ppc4xx: Add Synopsys DWC OTG PCD function
  USB ppc4xx: Add Synopsys DWC OTG PCD interrupt function
  USB/ppc4xx:Synopsys DWC OTG driver enable gadget support
  USB ppc4xx: Add Synopsys DWC OTG driver kernel configuration and
    Makefile

 drivers/Makefile                        |    2 +
 drivers/usb/Kconfig                     |    3 +-
 drivers/usb/dwc_otg/Kconfig             |   96 ++
 drivers/usb/dwc_otg/Makefile            |   19 +
 drivers/usb/dwc_otg/dwc_otg_apmppc.c    |  413 ++++++
 drivers/usb/dwc_otg/dwc_otg_cil.c       |  944 ++++++++++++
 drivers/usb/dwc_otg/dwc_otg_cil.h       | 1215 ++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_cil_intr.c  |  617 ++++++++
 drivers/usb/dwc_otg/dwc_otg_driver.h    |   78 +
 drivers/usb/dwc_otg/dwc_otg_hcd.c       | 2408 +++++++++++++++++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_hcd.h       |  416 ++++++
 drivers/usb/dwc_otg/dwc_otg_hcd_intr.c  | 1470 +++++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_hcd_queue.c |  697 +++++++++
 drivers/usb/dwc_otg/dwc_otg_param.c     |  182 +++
 drivers/usb/dwc_otg/dwc_otg_pcd.c       | 1736 ++++++++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_pcd.h       |  138 ++
 drivers/usb/dwc_otg/dwc_otg_pcd_intr.c  | 2278 +++++++++++++++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_regs.h      | 1313 +++++++++++++++++
 drivers/usb/gadget/Kconfig              |   22 +
 drivers/usb/gadget/gadget_chips.h       |    8 +
 20 files changed, 14054 insertions(+), 1 deletions(-)
 create mode 100644 drivers/usb/dwc_otg/Kconfig
 create mode 100644 drivers/usb/dwc_otg/Makefile
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_apmppc.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_cil.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_cil.h
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_cil_intr.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_driver.h
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_hcd.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_hcd.h
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_hcd_intr.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_hcd_queue.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_param.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_pcd.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_pcd.h
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_pcd_intr.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_regs.h
