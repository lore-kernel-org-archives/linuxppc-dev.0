Return-Path: <keshava_mgowda@ti.com>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4FEB4B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 21:58:54 +1100 (EST)
Received: by bwz14 with SMTP id 14so89548bwz.30
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 03:58:50 -0700 (PDT)
From: Keshava Munegowda <keshava_mgowda@ti.com>
References: <1301336856-1802-1-git-send-email-tmarri@apm.com>
MIME-Version: 1.0
In-Reply-To: <1301336856-1802-1-git-send-email-tmarri@apm.com>
Date: Tue, 29 Mar 2011 16:28:43 +0530
Message-ID: <3a04648a22d8cb5be414fe90b2bd0d84@mail.gmail.com>
Subject: RE: [PATCH v10 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
To: tmarri@apm.com, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linux-usb-owner@vger.kernel.org
[mailto:linux-usb-owner@vger.kernel.org] On Behalf Of
> tmarri@apm.com
> Sent: Monday, March 28, 2011 11:58 PM
> To: linux-usb@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Cc: greg@kroah.com; tmarri@apm.com
> Subject: [PATCH v10 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
>
> From: Tirumala Marri <tmarri@apm.com>
>
> v10:
>  1. Change address argument type from u32 to ulong to
>     make it arch independent.
>  2. Cleaning un-necasary changes from Kconfig.
>
> v9:
>  1. Move the source under usb/otg/dwc.
>  2. Rename the source files with out dwc_otg prefix.
>  3. Remove unused read/write modify functions.
>  4. Including changes related to register base print.
>
> Tirumala Marri (10):
>   USB/ppc4xx: Add Synopsys DWC OTG Register definitions
>   USB/ppc4xx: Add Synopsys DWC OTG driver framework
>   USB/ppc4xx: Add Synopsys DWC OTG Core Interface Layer (CIL)
>   USB/ppc4xx: Add Synopsys DWC OTG HCD function
>   USB/ppc4xx: Add Synopsys DWC OTG HCD interrupt function
>   USB/ppc4xx: Add Synopsys DWC OTG HCD queue function
>   USB/ppc4xx: Add Synopsys DWC OTG PCD function
>   USB ppc4xx: Add Synopsys DWC OTG PCD interrupt function
>   USB/ppc4xx:Synopsys DWC OTG driver enable gadget support
>   USB ppc4xx: Add Synopsys DWC OTG driver kernel configuration and
>     Makefile
>
>  drivers/Makefile                  |    1 +
>  drivers/usb/Kconfig               |    2 +
>  drivers/usb/gadget/Kconfig        |   22 +
>  drivers/usb/gadget/gadget_chips.h |    9 +
>  drivers/usb/otg/dwc/Kconfig       |   88 ++
>  drivers/usb/otg/dwc/Makefile      |   19 +
>  drivers/usb/otg/dwc/apmppc.c      |  414 +++++++
>  drivers/usb/otg/dwc/cil.c         |  972 +++++++++++++++
>  drivers/usb/otg/dwc/cil.h         | 1177 ++++++++++++++++++
>  drivers/usb/otg/dwc/cil_intr.c    |  616 +++++++++
>  drivers/usb/otg/dwc/driver.h      |   76 ++
>  drivers/usb/otg/dwc/hcd.c         | 2465
+++++++++++++++++++++++++++++++++++++
>  drivers/usb/otg/dwc/hcd.h         |  416 +++++++
>  drivers/usb/otg/dwc/hcd_intr.c    | 1477 ++++++++++++++++++++++
>  drivers/usb/otg/dwc/hcd_queue.c   |  696 +++++++++++
>  drivers/usb/otg/dwc/param.c       |  180 +++
>  drivers/usb/otg/dwc/pcd.c         | 1766 ++++++++++++++++++++++++++
>  drivers/usb/otg/dwc/pcd.h         |  139 +++
>  drivers/usb/otg/dwc/pcd_intr.c    | 2311
++++++++++++++++++++++++++++++++++
>  drivers/usb/otg/dwc/regs.h        | 1326 ++++++++++++++++++++
>  20 files changed, 14172 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/otg/dwc/Kconfig
>  create mode 100644 drivers/usb/otg/dwc/Makefile
>  create mode 100644 drivers/usb/otg/dwc/apmppc.c
>  create mode 100644 drivers/usb/otg/dwc/cil.c
>  create mode 100644 drivers/usb/otg/dwc/cil.h
>  create mode 100644 drivers/usb/otg/dwc/cil_intr.c
>  create mode 100644 drivers/usb/otg/dwc/driver.h
>  create mode 100644 drivers/usb/otg/dwc/hcd.c
>  create mode 100644 drivers/usb/otg/dwc/hcd.h
>  create mode 100644 drivers/usb/otg/dwc/hcd_intr.c
>  create mode 100644 drivers/usb/otg/dwc/hcd_queue.c
>  create mode 100644 drivers/usb/otg/dwc/param.c
>  create mode 100644 drivers/usb/otg/dwc/pcd.c
>  create mode 100644 drivers/usb/otg/dwc/pcd.h
>  create mode 100644 drivers/usb/otg/dwc/pcd_intr.c
>  create mode 100644 drivers/usb/otg/dwc/regs.h
>
> --

Just a cosmetic review comment: you need to Tabify the declarations of in
the functions, at least when you are declaring variable of different data
types


> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
