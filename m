Return-Path: <David.Daney@caviumnetworks.com>
Received: from mail3.caviumnetworks.com (mail3.caviumnetworks.com
	[12.108.191.235]) by ozlabs.org (Postfix) with ESMTP id C55261007D4
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:11:11 +1000 (EST)
Message-ID: <4C48DE1C.4040008@caviumnetworks.com>
Date: Thu, 22 Jul 2010 17:11:08 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Fushen Chen <fchen@apm.com>
Subject: Re: [PATCH 1/9 v1.02] Add Synopsys DesignWare HS USB OTG Controller
	driver.
References: <12798369431775-git-send-email-fchen@apm.com>
In-Reply-To: <12798369431775-git-send-email-fchen@apm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2010 03:15 PM, Fushen Chen wrote:
> The DWC OTG driver module provides the initialization and cleanup
> entry points for the DWC OTG USB driver.
>
> Signed-off-by: Fushen Chen<fchen@apm.com>
> Signed-off-by: Mark Miesfeld<mmiesfeld@apm.com>
> ---
>   drivers/Makefile                     |    1 +
>   drivers/usb/Kconfig                  |    2 +
>   drivers/usb/dwc_otg/Kconfig          |   96 +++
>   drivers/usb/dwc_otg/Makefile         |   13 +
>   drivers/usb/dwc_otg/dwc_otg_driver.c | 1246 ++++++++++++++++++++++++++++++++++
>   drivers/usb/dwc_otg/dwc_otg_driver.h |   97 +++
>   drivers/usb/gadget/Kconfig           |   21 +
>   drivers/usb/gadget/gadget_chips.h    |    7 +
>   8 files changed, 1483 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/usb/dwc_otg/Kconfig
>   create mode 100644 drivers/usb/dwc_otg/Makefile
>   create mode 100644 drivers/usb/dwc_otg/dwc_otg_driver.c
>   create mode 100644 drivers/usb/dwc_otg/dwc_otg_driver.h
>
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 20dcced..f3fc7c7 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_UWB)		+= uwb/
>   obj-$(CONFIG_USB_OTG_UTILS)	+= usb/otg/
>   obj-$(CONFIG_USB)		+= usb/
>   obj-$(CONFIG_USB_MUSB_HDRC)	+= usb/musb/
> +obj-$(CONFIG_USB_DWC_OTG)	+= usb/dwc_otg/
>   obj-$(CONFIG_PCI)		+= usb/
>   obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
>   obj-$(CONFIG_SERIO)		+= input/serio/
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 6a58cb1..f48920b 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -113,6 +113,8 @@ source "drivers/usb/host/Kconfig"
>
>   source "drivers/usb/musb/Kconfig"
>
> +source "drivers/usb/dwc_otg/Kconfig"
> +
>   source "drivers/usb/class/Kconfig"
>
>   source "drivers/usb/storage/Kconfig"
> diff --git a/drivers/usb/dwc_otg/Kconfig b/drivers/usb/dwc_otg/Kconfig
> new file mode 100644
> index 0000000..27ae0d5
> --- /dev/null
> +++ b/drivers/usb/dwc_otg/Kconfig
> @@ -0,0 +1,96 @@
> +#
> +# USB Dual Role (OTG-ready) Controller Drivers
> +# for silicon based on Synopsys DesignWare IP
> +#
[...]
> diff --git a/drivers/usb/dwc_otg/Makefile b/drivers/usb/dwc_otg/Makefile
> new file mode 100644
> index 0000000..337ff81
> --- /dev/null
> +++ b/drivers/usb/dwc_otg/Makefile
> @@ -0,0 +1,13 @@
> +#
> +# OTG infrastructure and transceiver drivers
> +#
> +obj-$(CONFIG_USB_DWC_OTG)	+= dwc_otg.o
> +
> +dwc_otg-objs := dwc_otg_driver.o dwc_otg_cil.o dwc_otg_cil_intr.o
> +ifneq ($(CONFIG_DWC_DEVICE_ONLY),y)
> +dwc_otg-objs += dwc_otg_hcd.o dwc_otg_hcd_intr.o \
> +		dwc_otg_hcd_queue.o
> +endif
> +ifneq ($(CONFIG_DWC_HOST_ONLY),y)
> +dwc_otg-objs += dwc_otg_pcd.o dwc_otg_pcd_intr.o
> +endif
> diff --git a/drivers/usb/dwc_otg/dwc_otg_driver.c b/drivers/usb/dwc_otg/dwc_otg_driver.c
> new file mode 100644
> index 0000000..3aae30e

Look at all those files you reference in your Makefile.  Most of them 
don't exist.  This will cause the kernel to be unbuildable and break the 
ability to use git bisect.

One way to remedy this situation would be to make your Kconfig changes 
the last patch in the series.

Also the subject line for all nine patches seems to be identical, yet 
the patches are distinct.  Perhaps you could find better subject lines.

The very last patch contains exactly one file (dwc_otg_regs.h), but this 
file is required by most of the preceding patches.  This indicates that 
the ordering of the patches and the way that the files were distributed 
among the patches could improve.  Could you just fold most of the file 
addition patches into a single patch?

Or if that is untenable, put the core files in one patch, and then maybe 
hcd and pcd seperatly.

This patch contains many lines that are indented with spaces instead of 
tabs.  How did it manage to pass checkpatch.pl formatted like that?

And finally I would like to suggest taking all the glue-logic functions 
in dwc_otg_driver.c and putting them in a separate file (perhaps 
something like dwc_otg_amppc.c or something like that).  It could be 
that initially you just rename dwc_otg_driver.c to dwc_otg_amppc.c. 
That would make it easy for me to then add my dwc_otg_octeon.c and use 
the driver with OCTEON (in arch/mips/cavium-octeon).

See: http://marc.info/?l=linux-mips&m=125502126531841&w=2


Thanks,
David Daney
