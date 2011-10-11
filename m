Return-Path: <kassey1216@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 869C4B6F75
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 19:57:19 +1100 (EST)
Received: by gyg4 with SMTP id 4so7286066gyg.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 01:57:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1317954632-11768-1-git-send-email-tmarri@apm.com>
References: <1317954632-11768-1-git-send-email-tmarri@apm.com>
Date: Tue, 11 Oct 2011 16:57:07 +0800
Message-ID: <CAKwPUowTCS2jO1QdFMCFg86Mb_d_yo2NvnWQ=Lh6N1tdgZE1rA@mail.gmail.com>
Subject: Re: [PATCH v14 02/10] USB/ppc4xx: Add Synopsys DesignWare HS USB OTG
 driver framework
From: Kassey Lee <kassey1216@gmail.com>
To: tmarri@apm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Miesfeld <mmiesfeld@apm.com>, greg@kroah.com,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi, Tirumala:

     I did  find any private info for ppc in
     drivers/usb/dwc/apmppc.c

     do you want make it generic driver ? if yes, it could be a
generic name too.

     thanks !

2011/10/7  <tmarri@apm.com>:
> From: Tirumala Marri <tmarri@apm.com>
>
> Platform probing is in apmppc.c.
> Driver parameter and parameter checking are in param.c.
>
> Signed-off-by: Tirumala R Marri<tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> ---
> =A0drivers/usb/dwc/apmppc.c | =A0353 ++++++++++++++++++++++++++++++++++++=
++++++++++
> =A0drivers/usb/dwc/driver.h | =A0 76 ++++++++++
> =A0drivers/usb/dwc/param.c =A0| =A0180 +++++++++++++++++++++++
> =A03 files changed, 609 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/usb/dwc/apmppc.c
> =A0create mode 100644 drivers/usb/dwc/driver.h
> =A0create mode 100644 drivers/usb/dwc/param.c
>
> diff --git a/drivers/usb/dwc/apmppc.c b/drivers/usb/dwc/apmppc.c
> new file mode 100644
> index 0000000..5053c6a
> --- /dev/null
> +++ b/drivers/usb/dwc/apmppc.c
> @@ -0,0 +1,353 @@
> +/*
> + * DesignWare HS OTG controller driver
> + * Copyright (C) 2006 Synopsys, Inc.
> + * Portions Copyright (C) 2010 Applied Micro Circuits Corporation.
> + *
> + * This program is free software: you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License version 2 for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see http://www.gnu.org/licenses
> + * or write to the Free Software Foundation, Inc., 51 Franklin Street,
> + * Suite 500, Boston, MA 02110-1335 USA.
> + *
> + * Based on Synopsys driver version 2.60a
> + * Modified by Mark Miesfeld <mmiesfeld@apm.com>
> + * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "=
AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO T=
HE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY DI=
RECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SER=
VICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR =
TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + */
> +
> +/*
> + * The dwc_otg module provides the initialization and cleanup entry
> + * points for the dwcotg driver. This module will be dynamically install=
ed
> + * after Linux is booted using the insmod command. When the module is
> + * installed, the dwc_otg_driver_init function is called. When the modul=
e is
> + * removed (using rmmod), the dwc_otg_driver_cleanup function is called.
> + *
> + * This module also defines a data structure for the dwc_otg driver, whi=
ch is
> + * used in conjunction with the standard device structure. These
> + * structures allow the OTG driver to comply with the standard Linux dri=
ver
> + * model in which devices and drivers are registered with a bus driver. =
This
> + * has the benefit that Linux can expose attributes of the driver and de=
vice
> + * in its special sysfs file system. Users can then read or write files =
in
> + * this file system to perform diagnostics on the driver components or t=
he
> + * device.
> + */
> +
> +#include <linux/of_platform.h>
> +
> +#include "driver.h"
> +
> +#define DWC_DRIVER_VERSION =A0 =A0 =A0 =A0 =A0 =A0 "1.05"
> +#define DWC_DRIVER_DESC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"=
HS OTG USB Controller driver"
> +static const char dwc_driver_name[] =3D "dwc_otg";
> +
> +static irqreturn_t dwc_otg_common_irq(int _irq, void *dev)
> +{
> + =A0 =A0 =A0 struct dwc_otg_device *dwc_dev =3D dev;
> + =A0 =A0 =A0 int retval;
> + =A0 =A0 =A0 struct dwc_hcd *dwc_hcd;
> +
> + =A0 =A0 =A0 dwc_hcd =3D dwc_dev->hcd;
> + =A0 =A0 =A0 spin_lock(&dwc_hcd->lock);
> + =A0 =A0 =A0 retval =3D dwc_otg_handle_common_intr(dwc_dev->core_if);
> + =A0 =A0 =A0 spin_unlock(&dwc_hcd->lock);
> + =A0 =A0 =A0 return IRQ_RETVAL(retval);
> +}
> +
> +static irqreturn_t dwc_otg_externalchgpump_irq(int _irq, void *dev)
> +{
> + =A0 =A0 =A0 struct dwc_otg_device *dwc_dev =3D dev;
> +
> + =A0 =A0 =A0 if (dwc_otg_is_host_mode(dwc_dev->core_if)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dwc_hcd *dwc_hcd;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 hprt0 =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_hcd =3D dwc_dev->hcd;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&dwc_hcd->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_hcd->flags.b.port_over_current_change =
=3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hprt0 =3D DWC_HPRT0_PRT_PWR_RW(hprt0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_reg_write(dwc_dev->core_if->host_if->hp=
rt0, 0, hprt0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&dwc_hcd->lock);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Device mode - This int is n/a for device=
 mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "DeviceMode: OTG OverCurrent D=
etected\n");
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int __devexit dwc_otg_driver_remove(struct platform_device *ofdev=
)
> +{
> + =A0 =A0 =A0 struct device *dev =3D &ofdev->dev;
> + =A0 =A0 =A0 struct dwc_otg_device *dwc_dev =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 /* Memory allocation for dwc_otg_device may have failed. */
> + =A0 =A0 =A0 if (!dwc_dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 /* Free the IRQ */
> + =A0 =A0 =A0 free_irq(dwc_dev->irq, dwc_dev);
> + =A0 =A0 =A0 /* Free external charge pump irq */
> + =A0 =A0 =A0 free_irq(dwc_dev->hcd->cp_irq, dwc_dev);
> +
> + =A0 =A0 =A0 if (dwc_dev->hcd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_remove(dev);
> +
> + =A0 =A0 =A0 if (dwc_dev->pcd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_pcd_remove(dev);
> +
> + =A0 =A0 =A0 if (dwc_dev->core_if)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_cil_remove(dwc_dev->core_if);
> +
> + =A0 =A0 =A0 /* Return the memory. */
> + =A0 =A0 =A0 if (dwc_dev->base)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(dwc_dev->base);
> +
> + =A0 =A0 =A0 if (dwc_dev->phys_addr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(dwc_dev->phys_addr, dwc_=
dev->base_len);
> +
> + =A0 =A0 =A0 otg_put_transceiver(dwc_dev->core_if->xceiv);
> + =A0 =A0 =A0 dwc_dev->core_if->xceiv =3D NULL;
> +
> + =A0 =A0 =A0 kfree(dwc_dev);
> +
> + =A0 =A0 =A0 /* Clear the drvdata pointer. */
> + =A0 =A0 =A0 dev_set_drvdata(dev, NULL);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
> +{
> + =A0 =A0 =A0 int retval;
> + =A0 =A0 =A0 struct dwc_otg_device *dwc_dev;
> + =A0 =A0 =A0 struct device *dev =3D &ofdev->dev;
> + =A0 =A0 =A0 struct resource res;
> + =A0 =A0 =A0 ulong gusbcfg_addr;
> + =A0 =A0 =A0 u32 usbcfg =3D 0;
> +
> + =A0 =A0 =A0 dwc_dev =3D kzalloc(sizeof(*dwc_dev), GFP_KERNEL);
> + =A0 =A0 =A0 if (!dwc_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "kmalloc of dwc_otg_device fai=
led\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_dwc_dev;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Retrieve the memory and IRQ resources. */
> + =A0 =A0 =A0 dwc_dev->irq =3D irq_of_parse_and_map(ofdev->dev.of_node, 0=
);
> + =A0 =A0 =A0 if (dwc_dev->irq =3D=3D NO_IRQ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no device irq\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_of_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (of_address_to_resource(ofdev->dev.of_node, 0, &res)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s: Can't get USB-OTG registe=
r address\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_of_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dwc_dev->phys_addr =3D res.start;
> + =A0 =A0 =A0 dwc_dev->base_len =3D res.end - res.start + 1;
> + =A0 =A0 =A0 if (!request_mem_region(dwc_dev->phys_addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_dev->ba=
se_len, dwc_driver_name)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "request_mem_region failed\n")=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_of_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Map the DWC_otg Core memory into virtual address space. =
*/
> + =A0 =A0 =A0 dwc_dev->base =3D ioremap(dwc_dev->phys_addr, dwc_dev->base=
_len);
> + =A0 =A0 =A0 if (!dwc_dev->base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "ioremap() failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_ioremap;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 dev_dbg(dev, "mapped base=3D0x%08x\n", (__force u32)dwc_dev=
->base);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Initialize driver data to point to the global DWC_otg
> + =A0 =A0 =A0 =A0* Device structure.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 dev_set_drvdata(dev, dwc_dev);
> +
> + =A0 =A0 =A0 dwc_dev->core_if =3D
> + =A0 =A0 =A0 =A0 =A0 dwc_otg_cil_init(dwc_dev->base, &dwc_otg_module_par=
ams);
> + =A0 =A0 =A0 if (!dwc_dev->core_if) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "CIL initialization failed!\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_cil_init;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Validate parameter values after dwc_otg_cil_init.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (check_parameters(dwc_dev->core_if)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_check_param;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 usb_nop_xceiv_register();
> + =A0 =A0 =A0 dwc_dev->core_if->xceiv =3D otg_get_transceiver();
> + =A0 =A0 =A0 if (!dwc_dev->core_if->xceiv) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_xceiv;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 dwc_set_feature(dwc_dev->core_if);
> +
> + =A0 =A0 =A0 /* Initialize the DWC_otg core. */
> + =A0 =A0 =A0 dwc_otg_core_init(dwc_dev->core_if);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Disable the global interrupt until all the interrupt
> + =A0 =A0 =A0 =A0* handlers are installed.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 dwc_otg_disable_global_interrupts(dwc_dev->core_if);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Install the interrupt handler for the common interrupt=
s before
> + =A0 =A0 =A0 =A0* enabling common interrupts in core_init below.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 retval =3D request_irq(dwc_dev->irq, dwc_otg_common_irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF_SHARED, "dw=
c_otg", dwc_dev);
> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "request of irq%d failed retva=
l: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_dev->irq, retval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_req_irq;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_dev->common_irq_installed =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!dwc_has_feature(dwc_dev->core_if, DWC_HOST_ONLY)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Initialize the PCD */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D dwc_otg_pcd_init(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "dwc_otg_pcd_i=
nit failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_dev->pcd =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_req_irq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 gusbcfg_addr =3D (ulong) (dwc_dev->core_if->core_global_reg=
s)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 + DWC_GUSBCFG;
> + =A0 =A0 =A0 if (!dwc_has_feature(dwc_dev->core_if, DWC_DEVICE_ONLY)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Initialize the HCD and force_host_mode *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbcfg =3D dwc_reg_read(gusbcfg_addr, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbcfg |=3D DWC_USBCFG_FRC_HST_MODE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_reg_write(gusbcfg_addr, 0, usbcfg);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D dwc_otg_hcd_init(dev, dwc_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "dwc_otg_hcd_i=
nit failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_dev->hcd =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_hcd;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure chargepump interrupt */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_dev->hcd->cp_irq =3D irq_of_parse_and_m=
ap(ofdev->dev.of_node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dwc_dev->hcd->cp_irq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D request_irq(dwc_=
dev->hcd->cp_irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0dwc_otg_externalchgpump_irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0IRQF_SHARED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0"dwc_otg_ext_chg_pump", dwc_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "request of irq failed retval: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 retval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D =
-EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_h=
cd;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev=
, "%s: ExtChgPump Detection "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "IRQ registered\n", dwc_driver_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Enable the global interrupt after all the interrupt
> + =A0 =A0 =A0 =A0* handlers are installed.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 dwc_otg_enable_global_interrupts(dwc_dev->core_if);
> +
> + =A0 =A0 =A0 usbcfg =3D dwc_reg_read(gusbcfg_addr, 0);
> + =A0 =A0 =A0 usbcfg &=3D ~DWC_USBCFG_FRC_HST_MODE;
> + =A0 =A0 =A0 dwc_reg_write(gusbcfg_addr, 0, usbcfg);
> +
> + =A0 =A0 =A0 return 0;
> +fail_hcd:
> + =A0 =A0 =A0 free_irq(dwc_dev->irq, dwc_dev);
> + =A0 =A0 =A0 if (!dwc_has_feature(dwc_dev->core_if, DWC_HOST_ONLY)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dwc_dev->pcd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_pcd_remove(dev);
> + =A0 =A0 =A0 }
> +fail_req_irq:
> + =A0 =A0 =A0 otg_put_transceiver(dwc_dev->core_if->xceiv);
> +fail_xceiv:
> + =A0 =A0 =A0 usb_nop_xceiv_unregister();
> +fail_check_param:
> + =A0 =A0 =A0 dwc_otg_cil_remove(dwc_dev->core_if);
> +fail_cil_init:
> + =A0 =A0 =A0 dev_set_drvdata(dev, NULL);
> + =A0 =A0 =A0 iounmap(dwc_dev->base);
> +fail_ioremap:
> + =A0 =A0 =A0 release_mem_region(dwc_dev->phys_addr, dwc_dev->base_len);
> +fail_of_irq:
> + =A0 =A0 =A0 kfree(dwc_dev);
> +fail_dwc_dev:
> + =A0 =A0 =A0 return retval;
> +}
> +
> +static const struct of_device_id dwc_otg_match[] =3D {
> + =A0 =A0 =A0 {.compatible =3D "amcc,dwc-otg",},
> + =A0 =A0 =A0 {}
> +};
> +
> +MODULE_DEVICE_TABLE(of, dwc_otg_match);
> +
> +static struct platform_driver dwc_otg_driver =3D {
> + =A0 =A0 =A0 .probe =3D dwc_otg_driver_probe,
> + =A0 =A0 =A0 .remove =3D __devexit_p(dwc_otg_driver_remove),
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "dwc_otg",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D dwc_otg_match,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init dwc_otg_driver_init(void)
> +{
> +
> + =A0 =A0 =A0 return platform_driver_register(&dwc_otg_driver);
> +}
> +
> +module_init(dwc_otg_driver_init);
> +
> +static void __exit dwc_otg_driver_cleanup(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&dwc_otg_driver);
> +}
> +
> +module_exit(dwc_otg_driver_cleanup);
> +
> +MODULE_DESCRIPTION(DWC_DRIVER_DESC);
> +MODULE_AUTHOR("Mark Miesfeld <mmiesfeld@apm.com");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/usb/dwc/driver.h b/drivers/usb/dwc/driver.h
> new file mode 100644
> index 0000000..a86532b
> --- /dev/null
> +++ b/drivers/usb/dwc/driver.h
> @@ -0,0 +1,76 @@
> +/*
> + * DesignWare HS OTG controller driver
> + * Copyright (C) 2006 Synopsys, Inc.
> + * Portions Copyright (C) 2010 Applied Micro Circuits Corporation.
> + *
> + * This program is free software: you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License version 2 for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see http://www.gnu.org/licenses
> + * or write to the Free Software Foundation, Inc., 51 Franklin Street,
> + * Suite 500, Boston, MA 02110-1335 USA.
> + *
> + * Based on Synopsys driver version 2.60a
> + * Modified by Mark Miesfeld <mmiesfeld@apm.com>
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "=
AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO T=
HE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY DI=
RECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SER=
VICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR =
TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + */
> +
> +#if !defined(__DWC_OTG_DRIVER_H__)
> +#define __DWC_OTG_DRIVER_H__
> +
> +/*
> + * This file contains the interface to the Linux driver.
> + */
> +#include "cil.h"
> +
> +/*
> + * This structure is a wrapper that encapsulates the driver components u=
sed to
> + * manage a single DWC_otg controller.
> + */
> +struct dwc_otg_device {
> + =A0 =A0 =A0 /* Base address returned from ioremap() */
> + =A0 =A0 =A0 __iomem void *base;
> +
> + =A0 =A0 =A0 /* Pointer to the core interface structure. */
> + =A0 =A0 =A0 struct core_if *core_if;
> +
> + =A0 =A0 =A0 /* Pointer to the PCD structure. */
> + =A0 =A0 =A0 struct dwc_pcd *pcd;
> +
> + =A0 =A0 =A0 /* Pointer to the HCD structure. */
> + =A0 =A0 =A0 struct dwc_hcd *hcd;
> +
> + =A0 =A0 =A0 /* Flag to indicate whether the common IRQ handler is insta=
lled. */
> + =A0 =A0 =A0 u8 common_irq_installed;
> +
> + =A0 =A0 =A0 /* Interrupt request number. */
> + =A0 =A0 =A0 unsigned int irq;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Physical address of Control and Status registers, used=
 by
> + =A0 =A0 =A0 =A0* release_mem_region().
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 resource_size_t phys_addr;
> +
> + =A0 =A0 =A0 /* Length of memory region, used by release_mem_region(). *=
/
> + =A0 =A0 =A0 unsigned long base_len;
> +};
> +#endif
> diff --git a/drivers/usb/dwc/param.c b/drivers/usb/dwc/param.c
> new file mode 100644
> index 0000000..afae800
> --- /dev/null
> +++ b/drivers/usb/dwc/param.c
> @@ -0,0 +1,180 @@
> +/*
> + * DesignWare HS OTG controller driver
> + * Copyright (C) 2006 Synopsys, Inc.
> + * Portions Copyright (C) 2010 Applied Micro Circuits Corporation.
> + *
> + * This program is free software: you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License version 2 for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see http://www.gnu.org/licenses
> + * or write to the Free Software Foundation, Inc., 51 Franklin Street,
> + * Suite 500, Boston, MA 02110-1335 USA.
> + *
> + * Based on Synopsys driver version 2.60a
> + * Modified by Mark Miesfeld <mmiesfeld@apm.com>
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "=
AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO T=
HE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY DI=
RECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SER=
VICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR =
TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + */
> +
> +/*
> + * This file provides dwc_otg driver parameter and parameter checking.
> + */
> +
> +#include "cil.h"
> +
> +/*
> + * Encapsulate the module parameter settings
> + */
> +struct core_params dwc_otg_module_params =3D {
> + =A0 =A0 =A0 .otg_cap =3D -1,
> + =A0 =A0 =A0 .dma_enable =3D -1,
> + =A0 =A0 =A0 .dma_burst_size =3D -1,
> + =A0 =A0 =A0 .speed =3D -1,
> + =A0 =A0 =A0 .host_support_fs_ls_low_power =3D -1,
> + =A0 =A0 =A0 .host_ls_low_power_phy_clk =3D -1,
> + =A0 =A0 =A0 .enable_dynamic_fifo =3D -1,
> + =A0 =A0 =A0 .dev_rx_fifo_size =3D -1,
> + =A0 =A0 =A0 .dev_nperio_tx_fifo_size =3D -1,
> + =A0 =A0 =A0 .dev_perio_tx_fifo_size =3D {-1, -1, -1, -1, -1, -1, -1, -1=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 -1, -1, -1, -1, -1, -1, -1}, =A0 =A0/* 15 *=
/
> + =A0 =A0 =A0 .host_rx_fifo_size =3D -1,
> + =A0 =A0 =A0 .host_nperio_tx_fifo_size =3D -1,
> + =A0 =A0 =A0 .host_perio_tx_fifo_size =3D -1,
> + =A0 =A0 =A0 .max_transfer_size =3D -1,
> + =A0 =A0 =A0 .max_packet_count =3D -1,
> + =A0 =A0 =A0 .host_channels =3D -1,
> + =A0 =A0 =A0 .dev_endpoints =3D -1,
> + =A0 =A0 =A0 .phy_type =3D -1,
> + =A0 =A0 =A0 .phy_utmi_width =3D -1,
> + =A0 =A0 =A0 .phy_ulpi_ddr =3D -1,
> + =A0 =A0 =A0 .phy_ulpi_ext_vbus =3D -1,
> + =A0 =A0 =A0 .i2c_enable =3D -1,
> + =A0 =A0 =A0 .ulpi_fs_ls =3D -1,
> + =A0 =A0 =A0 .ts_dline =3D -1,
> + =A0 =A0 =A0 .en_multiple_tx_fifo =3D -1,
> + =A0 =A0 =A0 .dev_tx_fifo_size =3D {-1, -1, -1, -1, -1, -1, -1, -1, -1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 -1, -1, -1, -1, -1, -1}, =A0 =A0 =A0 =A0/* =
15 */
> + =A0 =A0 =A0 .thr_ctl =3D -1,
> + =A0 =A0 =A0 .tx_thr_length =3D -1,
> + =A0 =A0 =A0 .rx_thr_length =3D -1,
> +};
> +
> +/**
> + * Checks that parameter settings for the periodic Tx FIFO sizes are cor=
rect
> + * according to the hardware configuration. Sets the size to the hardwar=
e
> + * configuration if an incorrect size is detected.
> + */
> +static int set_valid_perio_tx_fifo_sizes(struct core_if *core_if)
> +{
> + =A0 =A0 =A0 ulong regs =3D (u32) core_if->core_global_regs;
> + =A0 =A0 =A0 u32 *param_size =3D &dwc_otg_module_params.dev_perio_tx_fif=
o_size[0];
> + =A0 =A0 =A0 u32 i, size;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < MAX_PERIO_FIFOS; i++, param_size++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D dwc_reg_read(regs, DWC_DPTX_FSIZ_D=
IPTXF(i));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *param_size =3D size;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * Checks that parameter settings for the Tx FIFO sizes are correct acco=
rding to
> + * the hardware configuration. =A0Sets the size to the hardware configur=
ation if
> + * an incorrect size is detected.
> + */
> +static int set_valid_tx_fifo_sizes(struct core_if *core_if)
> +{
> + =A0 =A0 =A0 ulong regs =3D (u32) core_if->core_global_regs;
> + =A0 =A0 =A0 u32 *param_size =3D &dwc_otg_module_params.dev_tx_fifo_size=
[0];
> + =A0 =A0 =A0 u32 i, size;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < MAX_TX_FIFOS; i++, param_size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D dwc_reg_read(regs, =A0DWC_DPTX_FSI=
Z_DIPTXF(i));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *param_size =3D size;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * This function is called during module intialization to verify that
> + * the module parameters are in a valid state.
> + */
> +int __devinit check_parameters(struct core_if *core_if)
> +{
> + =A0 =A0 =A0 /* Default values */
> + =A0 =A0 =A0 dwc_otg_module_params.otg_cap =3D dwc_param_otg_cap_default=
;
> + =A0 =A0 =A0 dwc_otg_module_params.dma_enable =3D dwc_param_dma_enable_d=
efault;
> + =A0 =A0 =A0 dwc_otg_module_params.speed =3D dwc_param_speed_default;
> + =A0 =A0 =A0 dwc_otg_module_params.host_support_fs_ls_low_power =3D
> + =A0 =A0 =A0 =A0 =A0 dwc_param_host_support_fs_ls_low_power_default;
> + =A0 =A0 =A0 dwc_otg_module_params.host_ls_low_power_phy_clk =3D
> + =A0 =A0 =A0 =A0 =A0 dwc_param_host_ls_low_power_phy_clk_default;
> + =A0 =A0 =A0 dwc_otg_module_params.phy_type =3D dwc_param_phy_type_defau=
lt;
> + =A0 =A0 =A0 dwc_otg_module_params.phy_ulpi_ddr =3D dwc_param_phy_ulpi_d=
dr_default;
> + =A0 =A0 =A0 dwc_otg_module_params.phy_ulpi_ext_vbus =3D
> + =A0 =A0 =A0 =A0 =A0 dwc_param_phy_ulpi_ext_vbus_default;
> + =A0 =A0 =A0 dwc_otg_module_params.i2c_enable =3D dwc_param_i2c_enable_d=
efault;
> + =A0 =A0 =A0 dwc_otg_module_params.ulpi_fs_ls =3D dwc_param_ulpi_fs_ls_d=
efault;
> + =A0 =A0 =A0 dwc_otg_module_params.ts_dline =3D dwc_param_ts_dline_defau=
lt;
> +
> + =A0 =A0 =A0 dwc_otg_module_params.dma_burst_size =3D dwc_param_dma_burs=
t_size_default;
> + =A0 =A0 =A0 dwc_otg_module_params.phy_utmi_width =3D dwc_param_phy_utmi=
_width_default;
> + =A0 =A0 =A0 dwc_otg_module_params.thr_ctl =3D dwc_param_thr_ctl_default=
;
> + =A0 =A0 =A0 dwc_otg_module_params.tx_thr_length =3D dwc_param_tx_thr_le=
ngth_default;
> + =A0 =A0 =A0 dwc_otg_module_params.rx_thr_length =3D dwc_param_rx_thr_le=
ngth_default;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Hardware configurations of the OTG core.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 dwc_otg_module_params.enable_dynamic_fifo =3D
> + =A0 =A0 =A0 =A0 =A0 DWC_HWCFG2_DYN_FIFO_RD(core_if->hwcfg2);
> + =A0 =A0 =A0 dwc_otg_module_params.dev_rx_fifo_size =3D
> + =A0 =A0 =A0 =A0 =A0 dwc_reg_read(core_if->core_global_regs, DWC_GRXFSIZ=
);
> + =A0 =A0 =A0 dwc_otg_module_params.dev_nperio_tx_fifo_size =3D
> + =A0 =A0 =A0 =A0 =A0 dwc_reg_read(core_if->core_global_regs, DWC_GNPTXFS=
IZ) >> 16;
> +
> + =A0 =A0 =A0 dwc_otg_module_params.host_rx_fifo_size =3D
> + =A0 =A0 =A0 =A0 =A0 dwc_reg_read(core_if->core_global_regs, DWC_GRXFSIZ=
);
> + =A0 =A0 =A0 dwc_otg_module_params.host_nperio_tx_fifo_size =3D
> + =A0 =A0 =A0 =A0 =A0 dwc_reg_read(core_if->core_global_regs, DWC_GNPTXFS=
IZ) >> 16;
> + =A0 =A0 =A0 dwc_otg_module_params.host_perio_tx_fifo_size =3D
> + =A0 =A0 =A0 =A0 =A0 dwc_reg_read(core_if->core_global_regs, DWC_HPTXFSI=
Z) >> 16;
> + =A0 =A0 =A0 dwc_otg_module_params.max_transfer_size =3D
> + =A0 =A0 =A0 =A0 =A0 (1 << (DWC_HWCFG3_XFERSIZE_CTR_WIDTH_RD(core_if->hw=
cfg3) + 11))
> + =A0 =A0 =A0 =A0 =A0 - 1;
> + =A0 =A0 =A0 dwc_otg_module_params.max_packet_count =3D
> + =A0 =A0 =A0 =A0 =A0 (1 << (DWC_HWCFG3_PKTSIZE_CTR_WIDTH_RD(core_if->hwc=
fg3) + 4))
> + =A0 =A0 =A0 =A0 =A0 - 1;
> +
> + =A0 =A0 =A0 dwc_otg_module_params.host_channels =3D
> + =A0 =A0 =A0 =A0 =A0 DWC_HWCFG2_NO_HST_CHAN_RD(core_if->hwcfg2) + 1;
> + =A0 =A0 =A0 dwc_otg_module_params.dev_endpoints =3D
> + =A0 =A0 =A0 =A0 =A0 DWC_HWCFG2_NO_DEV_EP_RD(core_if->hwcfg2);
> + =A0 =A0 =A0 dwc_otg_module_params.en_multiple_tx_fifo =3D
> + =A0 =A0 =A0 =A0 =A0 (DWC_HWCFG4_DED_FIFO_ENA_RD(core_if->hwcfg4) =3D=3D=
 0)
> + =A0 =A0 =A0 =A0 =A0 ? 0 : 1, 0;
> + =A0 =A0 =A0 set_valid_perio_tx_fifo_sizes(core_if);
> + =A0 =A0 =A0 set_valid_tx_fifo_sizes(core_if);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +module_param_named(dma_enable, dwc_otg_module_params.dma_enable, bool, 0=
444);
> +MODULE_PARM_DESC(dma_enable, "DMA Mode 0=3DSlave 1=3DDMA enabled");
> --
> 1.6.1.rc3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Best regards
Kassey

Intel Mobile Communication =A0Xi'an, China PRC
