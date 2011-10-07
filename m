Return-Path: <tmarri@amcc.com>
Received: from denmail01.apm.com (denmail01-v4020.amcc.com [192.195.68.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4B4F0B70BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2011 13:38:49 +1100 (EST)
From: tmarri@apm.com
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v14 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
Date: Thu,  6 Oct 2011 19:30:21 -0700
Message-Id: <1317954621-11702-1-git-send-email-tmarri@apm.com>
Cc: tmarri@apm.com, greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tirumala Marri <tmarri@apm.com>

v14:
 1. Modifying dwc_reg_read/write functions to accepts offset as arg.
 2. Adding spin_lock to common interrupt function.
 3. Adding start/stop, vbus_power functions to gadget_opst struct.
 4. Removed some unnecessary comments and prints.
 5. op_state_str() replace with common function.
 6. Removed some unnecessary checks from apmppc.c file.

v13:
 1. Remove redundant CONFIG VARIABLE from drivers/usb/dwc/Kconfig.

Tirumala Marri (10):
  USB/ppc4xx: Add Synopsys DesignWare HS USB OTG Register definitions
  USB/ppc4xx: Add Synopsys DesignWare HS USB OTG driver framework
  USB/ppc4xx: Add Synopsys DWC OTG Core Interface Layer (CIL)
  USB/ppc4xx: Add Synopsys DWC OTG HCD function
  USB/ppc4xx: Add Synopsys DWC OTG HCD interrupt function
  USB/ppc4xx: Add Synopsys DWC OTG HCD queue function
  USB/ppc4xx: Add Synopsys DWC OTG PCD function
  USB ppc4xx: Add Synopsys DWC OTG PCD interrupt function
  Add Synopsys DWC OTG driver kernel configuration and Makefile
  USB/ppc4xx:Synopsys DWC OTG driver enable gadget support

 drivers/usb/Kconfig               |    2 +
 drivers/usb/Makefile              |    1 +
 drivers/usb/dwc/Kconfig           |   84 ++
 drivers/usb/dwc/Makefile          |   19 +
 drivers/usb/dwc/apmppc.c          |  353 ++++++
 drivers/usb/dwc/cil.c             |  889 +++++++++++++
 drivers/usb/dwc/cil.h             | 1174 ++++++++++++++++++
 drivers/usb/dwc/cil_intr.c        |  616 +++++++++
 drivers/usb/dwc/driver.h          |   76 ++
 drivers/usb/dwc/hcd.c             | 2465 +++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc/hcd.h             |  416 +++++++
 drivers/usb/dwc/hcd_intr.c        | 1477 ++++++++++++++++++++++
 drivers/usb/dwc/hcd_queue.c       |  696 +++++++++++
 drivers/usb/dwc/param.c           |  180 +++
 drivers/usb/dwc/pcd.c             | 1791 +++++++++++++++++++++++++++
 drivers/usb/dwc/pcd.h             |  139 +++
 drivers/usb/dwc/pcd_intr.c        | 2311 ++++++++++++++++++++++++++++++++++
 drivers/usb/dwc/regs.h            | 1326 ++++++++++++++++++++
 drivers/usb/gadget/Kconfig        |   11 +
 drivers/usb/gadget/gadget_chips.h |    3 +
 20 files changed, 14029 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/dwc/Kconfig
 create mode 100644 drivers/usb/dwc/Makefile
 create mode 100644 drivers/usb/dwc/apmppc.c
 create mode 100644 drivers/usb/dwc/cil.c
 create mode 100644 drivers/usb/dwc/cil.h
 create mode 100644 drivers/usb/dwc/cil_intr.c
 create mode 100644 drivers/usb/dwc/driver.h
 create mode 100644 drivers/usb/dwc/hcd.c
 create mode 100644 drivers/usb/dwc/hcd.h
 create mode 100644 drivers/usb/dwc/hcd_intr.c
 create mode 100644 drivers/usb/dwc/hcd_queue.c
 create mode 100644 drivers/usb/dwc/param.c
 create mode 100644 drivers/usb/dwc/pcd.c
 create mode 100644 drivers/usb/dwc/pcd.h
 create mode 100644 drivers/usb/dwc/pcd_intr.c
 create mode 100644 drivers/usb/dwc/regs.h
