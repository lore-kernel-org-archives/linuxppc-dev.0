Return-Path: <pratyush.anand@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A5E861007D2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2011 14:48:56 +1100 (EST)
Received: by gyg8 with SMTP id 8so3685719gyg.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 20:48:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1318630114-14064-1-git-send-email-tmarri@apm.com>
References: <1318630114-14064-1-git-send-email-tmarri@apm.com>
Date: Fri, 21 Oct 2011 09:18:53 +0530
Message-ID: <CAHM4w1k+-KgpkW4QzRkq5wDZK0+VdVhD_QLkJy24HB0s+pE8fg@mail.gmail.com>
Subject: Re: [PATCH v15 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
From: Pratyush Anand <pratyush.anand@gmail.com>
To: tmarri@apm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tirumala,

I have reviwed all the patches.
Thanks for taking my most of the diffs over your v13.
There are few thing, which are really very important like,
AHB disable check, EP Disable/Stall (have commented about them in
respective patches). I am doubtful, that how does all of usbcv test cases p=
asses
without those modifications.
So, please have a look on those comments.
You may  add my signed-off.

Regards
Pratyush


On Sat, Oct 15, 2011 at 3:38 AM,  <tmarri@apm.com> wrote:
> From: Tirumala Marri <tmarri@apm.com>
>
> v15:
> =A01. Fixed some checkpatch errors.
> =A02. Added spin lock check during read-modify-write of interrupt registe=
rs
> =A0 =A0out side intr handlers.
> =A03. Removed Kconfig var which is not used and not defined.
>
> v14:
> =A01. Modifying dwc_reg_read/write functions to accepts offset as arg.
> =A02. Adding spin_lock to common interrupt function.
> =A03. Adding start/stop, vbus_power functions to gadget_opst struct.
> =A04. Removed some unnecessary comments and prints.
> =A05. op_state_str() replace with common function.
> =A06. Removed some unnecessary checks from apmppc.c file.
>
> Tirumala Marri (10):
> =A0USB/ppc4xx: Add Synopsys DesignWare HS USB OTG Register definitions
> =A0USB/ppc4xx: Add Synopsys DesignWare HS USB OTG driver framework
> =A0USB/ppc4xx: Add Synopsys DWC OTG Core Interface Layer (CIL)
> =A0USB/ppc4xx: Add Synopsys DWC OTG HCD function
> =A0USB/ppc4xx: Add Synopsys DWC OTG HCD interrupt function
> =A0USB/ppc4xx: Add Synopsys DWC OTG HCD queue function
> =A0USB/ppc4xx: Add Synopsys DWC OTG PCD function
> =A0USB ppc4xx: Add Synopsys DWC OTG PCD interrupt function
> =A0USB ppc4xx: Add Synopsys DWC OTG driver kernel configuration and
> =A0 =A0Makefile
> =A0USB/ppc4xx:Synopsys DWC OTG driver enable gadget support
>
> =A0drivers/usb/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A0drivers/usb/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/usb/dwc/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 84 ++
> =A0drivers/usb/dwc/Makefile =A0 =A0 =A0 =A0 =A0| =A0 19 +
> =A0drivers/usb/dwc/apmppc.c =A0 =A0 =A0 =A0 =A0| =A0355 ++++++
> =A0drivers/usb/dwc/cil.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0890 +++++++++++++
> =A0drivers/usb/dwc/cil.h =A0 =A0 =A0 =A0 =A0 =A0 | 1174 +++++++++++++++++=
+
> =A0drivers/usb/dwc/cil_intr.c =A0 =A0 =A0 =A0| =A0616 +++++++++
> =A0drivers/usb/dwc/driver.h =A0 =A0 =A0 =A0 =A0| =A0 76 ++
> =A0drivers/usb/dwc/hcd.c =A0 =A0 =A0 =A0 =A0 =A0 | 2471 +++++++++++++++++=
++++++++++++++++++++
> =A0drivers/usb/dwc/hcd.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0416 +++++++
> =A0drivers/usb/dwc/hcd_intr.c =A0 =A0 =A0 =A0| 1477 +++++++++++++++++++++=
+
> =A0drivers/usb/dwc/hcd_queue.c =A0 =A0 =A0 | =A0696 +++++++++++
> =A0drivers/usb/dwc/param.c =A0 =A0 =A0 =A0 =A0 | =A0180 +++
> =A0drivers/usb/dwc/pcd.c =A0 =A0 =A0 =A0 =A0 =A0 | 1791 +++++++++++++++++=
++++++++++
> =A0drivers/usb/dwc/pcd.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0139 +++
> =A0drivers/usb/dwc/pcd_intr.c =A0 =A0 =A0 =A0| 2312 +++++++++++++++++++++=
+++++++++++++
> =A0drivers/usb/dwc/regs.h =A0 =A0 =A0 =A0 =A0 =A0| 1326 +++++++++++++++++=
+++
> =A0drivers/usb/gadget/Kconfig =A0 =A0 =A0 =A0| =A0 10 +
> =A0drivers/usb/gadget/gadget_chips.h | =A0 =A03 +
> =A020 files changed, 14038 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/usb/dwc/Kconfig
> =A0create mode 100644 drivers/usb/dwc/Makefile
> =A0create mode 100644 drivers/usb/dwc/apmppc.c
> =A0create mode 100644 drivers/usb/dwc/cil.c
> =A0create mode 100644 drivers/usb/dwc/cil.h
> =A0create mode 100644 drivers/usb/dwc/cil_intr.c
> =A0create mode 100644 drivers/usb/dwc/driver.h
> =A0create mode 100644 drivers/usb/dwc/hcd.c
> =A0create mode 100644 drivers/usb/dwc/hcd.h
> =A0create mode 100644 drivers/usb/dwc/hcd_intr.c
> =A0create mode 100644 drivers/usb/dwc/hcd_queue.c
> =A0create mode 100644 drivers/usb/dwc/param.c
> =A0create mode 100644 drivers/usb/dwc/pcd.c
> =A0create mode 100644 drivers/usb/dwc/pcd.h
> =A0create mode 100644 drivers/usb/dwc/pcd_intr.c
> =A0create mode 100644 drivers/usb/dwc/regs.h
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
