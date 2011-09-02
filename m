Return-Path: <pratyush.anand@gmail.com>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2916B6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Sep 2011 21:17:32 +1000 (EST)
Received: by gwj17 with SMTP id 17so1583805gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 02 Sep 2011 04:17:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110831071929.GA9353@linutronix.de>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<73a8a4be221e3bc0404da22473913e9a846ee0df.1314704557.git.pratyush.anand@st.com>
	<20110831071929.GA9353@linutronix.de>
Date: Fri, 2 Sep 2011 16:47:28 +0530
Message-ID: <CAHM4w1nwyCxJYyPxJn=yXmcD+cAMY4txorrgfKHdp-FGDZ7BKg@mail.gmail.com>
Subject: Re: [PATCH 03/14] dwc/otg: Add driver framework
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, tmarri@apm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com,
	linux-usb@vger.kernel.org, vipin.kumar@st.com,
	shiraz.hashim@st.com, Amit.VIRDI@st.com, rajeev-dlh.kumar@st.com,
	mmiesfeld@apm.com, deepak.sikri@st.com,
	linuxppc-dev@lists.ozlabs.org, fchen@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 31, 2011 at 12:49 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Pratyush Anand | 2011-08-30 17:27:50 [+0530]:
>
>>diff --git a/drivers/usb/dwc/apmppc.c b/drivers/usb/dwc/apmppc.c
>>new file mode 100644
>>index 0000000..80ea274
>>--- /dev/null
>>+++ b/drivers/usb/dwc/apmppc.c
>>@@ -0,0 +1,436 @@
>>+/*
>>+ * DesignWare HS OTG controller driver
>>+ * Copyright (C) 2006 Synopsys, Inc.
>>+ * Portions Copyright (C) 2010 Applied Micro Circuits Corporation.
>>+ *
>>+ * This program is free software: you can redistribute it and/or
>>+ * modify it under the terms of the GNU General Public License
>>+ * version 2 as published by the Free Software Foundation.
>>+ *
>>+ * This program is distributed in the hope that it will be useful
>>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>+ * GNU General Public License version 2 for more details.
>>+ *
>>+ * You should have received a copy of the GNU General Public License
>>+ * along with this program; if not, see http://www.gnu.org/licenses
>>+ * or write to the Free Software Foundation, Inc., 51 Franklin Street,
>>+ * Suite 500, Boston, MA 02110-1335 USA.
>>+ *
>>+ * Based on Synopsys driver version 2.60a
>>+ * Modified by Mark Miesfeld <mmiesfeld@apm.com>
>>+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
>>+ *
>>+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "=
AS IS"
>>+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO T=
HE
>>+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
>>+ * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY DI=
RECT,
>>+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
>>+ * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SER=
VICES;
>>+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
>>+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR =
TORT
>>+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF
>>+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>+ *
>>+ */
> In every file...
>
>>+/*
>>+ * The dwc_otg module provides the initialization and cleanup entry
>>+ * points for the dwcotg driver. This module will be dynamically install=
ed
>>+ * after Linux is booted using the insmod command. When the module is
>>+ * installed, the dwc_otg_driver_init function is called. When the modul=
e is
>>+ * removed (using rmmod), the dwc_otg_driver_cleanup function is called.
>>+ *
>>+ * This module also defines a data structure for the dwc_otg driver, whi=
ch is
>>+ * used in conjunction with the standard device structure. These
>>+ * structures allow the OTG driver to comply with the standard Linux dri=
ver
>>+ * model in which devices and drivers are registered with a bus driver. =
This
>>+ * has the benefit that Linux can expose attributes of the driver and de=
vice
>>+ * in its special sysfs file system. Users can then read or write files =
in
>>+ * this file system to perform diagnostics on the driver components or t=
he
>>+ * device.
>>+ */
>>+
>>+#include <linux/platform_device.h>
>>+
>>+#include "driver.h"
>>+
>>+#define DWC_DRIVER_VERSION =A0 =A0 =A0 =A0 =A0 =A0"1.05"
> do you intend to increment this version number?
>

I do not see any other reference of this define.
@Tirumala, Can we remove it?

>>+#define DWC_DRIVER_DESC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "HS =
OTG USB Controller driver"
>>+static const char dwc_driver_name[] =3D "dwc_otg";
>>+
>>+/**
>>+ * This function is the top level interrupt handler for the Common
>>+ * (Device and host modes) interrupts.
>>+ */
>>+static irqreturn_t dwc_otg_common_irq(int _irq, void *dev)
>>+{
>>+ =A0 =A0 =A0struct dwc_otg_device *dwc_dev =3D dev;
>>+ =A0 =A0 =A0int retval;
>>+
>>+ =A0 =A0 =A0retval =3D dwc_otg_handle_common_intr(dwc_dev->core_if);
>>+ =A0 =A0 =A0return IRQ_RETVAL(retval);
>>+}
>>+
>>+/**
>>+ * This function is the interrupt handler for the OverCurrent condition
>>+ * from the external charge pump (if enabled)
>>+ */
>>+static irqreturn_t dwc_otg_externalchgpump_irq(int _irq, void *dev)
>>+{
>>+ =A0 =A0 =A0struct dwc_otg_device *dwc_dev =3D dev;
>>+
>>+ =A0 =A0 =A0if (dwc_otg_is_host_mode(dwc_dev->core_if)) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0struct dwc_hcd *dwc_hcd;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 hprt0 =3D 0;
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_hcd =3D dwc_dev->hcd;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock(&dwc_hcd->lock);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_hcd->flags.b.port_over_current_change =
=3D 1;
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0hprt0 =3D DWC_HPRT0_PRT_PWR_RW(hprt0, 0);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_write32(dwc_dev->core_if->host_if->hprt0=
, hprt0);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&dwc_hcd->lock);
>>+ =A0 =A0 =A0} else {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Device mode - This int is n/a for device =
mode */
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(dev, "DeviceMode: OTG OverCurrent De=
tected\n");
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0return IRQ_HANDLED;
>>+}
>>+
>>+/**
>>+ * This function is called when a device is unregistered with the
>>+ * dwc_otg_driver. This happens, for example, when the rmmod command is
>>+ * executed. The device may or may not be electrically present. If it is
>>+ * present, the driver stops device processing. Any resources used on be=
half
>>+ * of this device are freed.
>>+ */
>>+static int __devexit dwc_otg_driver_remove(struct platform_device *ofdev=
)
>>+{
>>+ =A0 =A0 =A0struct device *dev =3D &ofdev->dev;
>>+ =A0 =A0 =A0struct dwc_otg_device *dwc_dev =3D dev_get_drvdata(dev);
>>+
>>+ =A0 =A0 =A0/* Memory allocation for dwc_otg_device may have failed. */
>>+ =A0 =A0 =A0if (!dwc_dev)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>>+
>>+ =A0 =A0 =A0/* Free the IRQ */
>>+ =A0 =A0 =A0if (dwc_dev->common_irq_installed)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(dwc_dev->irq, dwc_dev);
>>+
>>+ =A0 =A0 =A0if (!dwc_has_feature(dwc_dev->core_if, DWC_DEVICE_ONLY)) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dwc_dev->hcd) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dwc_dev->hcd->cp_irq_ins=
talled)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(dwc=
_dev->hcd->cp_irq, dwc_dev);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_hcd_remove(dev);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0if (!dwc_has_feature(dwc_dev->core_if, DWC_HOST_ONLY)) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dwc_dev->pcd)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_pcd_remove(dev);
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0if (dwc_dev->core_if)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_cil_remove(dwc_dev->core_if);
>>+
>>+ =A0 =A0 =A0/* Return the memory. */
>>+ =A0 =A0 =A0if (dwc_dev->base)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(dwc_dev->base);
>>+
>>+ =A0 =A0 =A0if (dwc_dev->phys_addr)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0release_mem_region(dwc_dev->phys_addr, dwc_d=
ev->base_len);
>>+
>>+ =A0 =A0 =A0if (dwc_dev->core_if->xceiv) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0otg_put_transceiver(dwc_dev->core_if->xceiv)=
;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_dev->core_if->xceiv =3D NULL;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_nop_xceiv_unregister();
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0kfree(dwc_dev);
>>+
>>+ =A0 =A0 =A0/* Clear the drvdata pointer. */
>>+ =A0 =A0 =A0dev_set_drvdata(dev, NULL);
>>+ =A0 =A0 =A0return 0;
>>+}
>>+
>>+/**
>>+ * This function is called when an device is bound to a
>>+ * dwc_otg_driver. It creates the driver components required to
>>+ * control the device (CIL, HCD, and PCD) and it initializes the
>>+ * device. The driver components are stored in a dwc_otg_device
>>+ * structure. A reference to the dwc_otg_device is saved in the
>>+ * device. This allows the driver to access the dwc_otg_device
>>+ * structure on subsequent calls to driver methods for this device.
>>+ */
>
> This is almost kernel doc. Mind doing a proper kernel doc?

will take care.

>
>>+static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
>>+{
>>+ =A0 =A0 =A0int retval;
>>+ =A0 =A0 =A0struct dwc_otg_device *dwc_dev;
>>+ =A0 =A0 =A0struct device *dev =3D &ofdev->dev;
>>+ =A0 =A0 =A0struct resource *res;
>>+ =A0 =A0 =A0struct dwc_otg_plat_data *pdata;
>>+ =A0 =A0 =A0ulong gusbcfg_addr;
>>+ =A0 =A0 =A0u32 usbcfg =3D 0;
>>+
>>+ =A0 =A0 =A0dev_dbg(dev, "dwc_otg_driver_probe(%p)\n", dev);
>
> __func__, but do you really care?
>

will correct.

>>+ =A0 =A0 =A0dwc_dev =3D kzalloc(sizeof(*dwc_dev), GFP_KERNEL);
>>+ =A0 =A0 =A0if (!dwc_dev) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "kmalloc of dwc_otg_device fail=
ed\n");
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D -ENOMEM;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_dwc_dev;
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0/* Retrieve the memory and IRQ resources. */
> Most people can read C
>

:( : will take care.

>>+ =A0 =A0 =A0dwc_dev->irq =3D platform_get_irq(ofdev, 0);
>>+ =A0 =A0 =A0if (dwc_dev->irq =3D=3D NO_IRQ) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "no device irq\n");
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D -ENODEV;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_of_irq;
>>+ =A0 =A0 =A0}
>>+ =A0 =A0 =A0dev_dbg(dev, "OTG - device irq: %d\n", dwc_dev->irq);
>>+
>>+ =A0 =A0 =A0res =3D platform_get_resource(ofdev, IORESOURCE_MEM, 0);
>>+ =A0 =A0 =A0if (!res) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "%s: Can't get USB-OTG register=
 address\n",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D -ENOMEM;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_of_irq;
>>+ =A0 =A0 =A0}
>>+ =A0 =A0 =A0dev_dbg(dev, "OTG - ioresource_mem start0x%llx: end:0x%llx\n=
",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)res->start, (unsigned lo=
ng long)res->end);
>>+
>>+ =A0 =A0 =A0dwc_dev->phys_addr =3D res->start;
>>+ =A0 =A0 =A0dwc_dev->base_len =3D res->end - res->start + 1;
>>+ =A0 =A0 =A0if (!request_mem_region(dwc_dev->phys_addr,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_dev->bas=
e_len, dwc_driver_name)) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "request_mem_region failed\n");
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D -EBUSY;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_of_irq;
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0/* Map the DWC_otg Core memory into virtual address space. *=
/
>>+ =A0 =A0 =A0dwc_dev->base =3D ioremap(dwc_dev->phys_addr, dwc_dev->base_=
len);
>>+ =A0 =A0 =A0if (!dwc_dev->base) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "ioremap() failed\n");
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D -ENOMEM;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_ioremap;
>>+ =A0 =A0 =A0}
>>+ =A0 =A0 =A0dev_dbg(dev, "mapped base=3D0x%08x\n", (__force u32)dwc_dev-=
>base);
>>+
>>+ =A0 =A0 =A0pdata =3D dev_get_platdata(dev);
>>+ =A0 =A0 =A0if (pdata) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdata->phy_init)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->phy_init();
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdata->param_init)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->param_init(&dwc_otg_m=
odule_params);
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0/*
>>+ =A0 =A0 =A0 * Initialize driver data to point to the global DWC_otg
>>+ =A0 =A0 =A0 * Device structure.
>>+ =A0 =A0 =A0 */
>>+ =A0 =A0 =A0dev_set_drvdata(dev, dwc_dev);
>>+
>>+ =A0 =A0 =A0dwc_dev->core_if =3D
>>+ =A0 =A0 =A0 =A0 =A0dwc_otg_cil_init(dwc_dev->base, &dwc_otg_module_para=
ms);
>>+ =A0 =A0 =A0if (!dwc_dev->core_if) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "CIL initialization failed!\n")=
;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D -ENOMEM;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_cil_init;
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0/*
>>+ =A0 =A0 =A0 * Validate parameter values after dwc_otg_cil_init.
>>+ =A0 =A0 =A0 */
> Single line would do it.
>

ok.

>>+ =A0 =A0 =A0if (check_parameters(dwc_dev->core_if)) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D -EINVAL;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_check_param;
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0usb_nop_xceiv_register();
>>+ =A0 =A0 =A0dwc_dev->core_if->xceiv =3D otg_get_transceiver();
>>+ =A0 =A0 =A0if (!dwc_dev->core_if->xceiv) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D -ENODEV;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_xceiv;
>>+ =A0 =A0 =A0}
>>+ =A0 =A0 =A0dwc_set_feature(dwc_dev->core_if);
>>+
>>+ =A0 =A0 =A0/* Initialize the DWC_otg core. */
>>+ =A0 =A0 =A0dwc_otg_core_init(dwc_dev->core_if);
>>+
>>+ =A0 =A0 =A0/*
>>+ =A0 =A0 =A0 * Disable the global interrupt until all the interrupt
>>+ =A0 =A0 =A0 * handlers are installed.
>>+ =A0 =A0 =A0 */
>>+ =A0 =A0 =A0dwc_otg_disable_global_interrupts(dwc_dev->core_if);
>>+
>>+ =A0 =A0 =A0/*
>>+ =A0 =A0 =A0 * Install the interrupt handler for the common interrupts b=
efore
>>+ =A0 =A0 =A0 * enabling common interrupts in core_init below.
>>+ =A0 =A0 =A0 */
>>+ =A0 =A0 =A0retval =3D request_irq(dwc_dev->irq, dwc_otg_common_irq,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_SHARED, "dwc_o=
tg", dwc_dev);
>>+ =A0 =A0 =A0if (retval) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "request of irq%d failed retval=
: %d\n",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_dev->irq, retval);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D -EBUSY;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_req_irq;
>>+ =A0 =A0 =A0} else {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_dev->common_irq_installed =3D 1;
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0gusbcfg_addr =3D (ulong) (dwc_dev->core_if->core_global_regs=
)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0+ DWC_GUSBCFG;
>
> This looks wrong. If this is a virtual pointer (i.e. from ioremap()) it
> should have the type "__iomem void *" and never be casted to something
> else.
>

will remove typecasting.

>>+ =A0 =A0 =A0if (dwc_has_feature(dwc_dev->core_if, DWC_DEVICE_ONLY)) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0usbcfg =3D dwc_read32(gusbcfg_addr);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0usbcfg &=3D ~DWC_USBCFG_FRC_HST_MODE;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0usbcfg |=3D DWC_USBCFG_FRC_DEV_MODE;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_write32(gusbcfg_addr, usbcfg);
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0if (!dwc_has_feature(dwc_dev->core_if, DWC_HOST_ONLY)) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Initialize the PCD */
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D dwc_otg_pcd_init(dev);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (retval) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "dwc_otg_pcd_in=
it failed\n");
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_dev->pcd =3D NULL;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_req_irq;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0if (dwc_has_feature(dwc_dev->core_if, DWC_HOST_ONLY)) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Initialize the HCD and force_host_mode */
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0usbcfg =3D dwc_read32(gusbcfg_addr);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0usbcfg |=3D DWC_USBCFG_FRC_HST_MODE;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0usbcfg &=3D ~DWC_USBCFG_FRC_DEV_MODE;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_write32(gusbcfg_addr, usbcfg);
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0if (!dwc_has_feature(dwc_dev->core_if, DWC_DEVICE_ONLY)) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0/* update transiver state */
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_dev->core_if->xceiv->state =3D OTG_STATE=
_A_HOST;
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D dwc_otg_hcd_init(dev, dwc_dev);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (retval) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "dwc_otg_hcd_in=
it failed\n");
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_dev->hcd =3D NULL;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_hcd;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0/* configure chargepump interrupt */
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_dev->hcd->cp_irq =3D platform_get_irq(of=
dev, 1);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dwc_dev->hcd->cp_irq !=3D -ENXIO) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D request_irq(dwc_d=
ev->hcd->cp_irq,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 dwc_otg_externalchgpump_irq,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 IRQF_SHARED,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 "dwc_otg_ext_chg_pump", dwc_dev);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (retval) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"request of irq failed retval: %d\n",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0retval);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D -=
EBUSY;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_hc=
d;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(dev,=
 "%s: ExtChgPump Detection "
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"IRQ registered\n", dwc_driver_name);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_dev->hcd=
->cp_irq_installed =3D 1;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>+ =A0 =A0 =A0}
>>+ =A0 =A0 =A0/*
>>+ =A0 =A0 =A0 * Enable the global interrupt after all the interrupt
>>+ =A0 =A0 =A0 * handlers are installed.
>>+ =A0 =A0 =A0 */
>>+ =A0 =A0 =A0dwc_otg_enable_global_interrupts(dwc_dev->core_if);
>>+ =A0 =A0 =A0return 0;
>>+fail_hcd:
>>+ =A0 =A0 =A0free_irq(dwc_dev->irq, dwc_dev);
>>+ =A0 =A0 =A0if (!dwc_has_feature(dwc_dev->core_if, DWC_HOST_ONLY)) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dwc_dev->pcd)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_pcd_remove(dev);
>>+ =A0 =A0 =A0}
>>+fail_req_irq:
>>+ =A0 =A0 =A0otg_put_transceiver(dwc_dev->core_if->xceiv);
>>+fail_xceiv:
>>+ =A0 =A0 =A0usb_nop_xceiv_unregister();
>>+fail_check_param:
>>+ =A0 =A0 =A0dwc_otg_cil_remove(dwc_dev->core_if);
>>+fail_cil_init:
>>+ =A0 =A0 =A0dev_set_drvdata(dev, NULL);
>>+ =A0 =A0 =A0iounmap(dwc_dev->base);
>>+fail_ioremap:
>>+ =A0 =A0 =A0release_mem_region(dwc_dev->phys_addr, dwc_dev->base_len);
>>+fail_of_irq:
>>+ =A0 =A0 =A0kfree(dwc_dev);
>>+fail_dwc_dev:
>>+ =A0 =A0 =A0return retval;
>>+}
>>+
>>+/*
>>+ * This structure defines the methods to be called by a bus driver
>>+ * during the lifecycle of a device on that bus. Both drivers and
>>+ * devices are registered with a bus driver. The bus driver matches
>>+ * devices to drivers based on information in the device and driver
>>+ * structures.
>>+ *
>>+ * The probe function is called when the bus driver matches a device
>>+ * to this driver. The remove function is called when a device is
>>+ * unregistered with the bus driver.
>>+ */
>>+
>>+#if defined(CONFIG_OF)
>>+static const struct of_device_id dwc_otg_match[] =3D {
>>+ =A0 =A0 =A0{.compatible =3D "amcc,dwc-otg",},
>
> Do you explain this binding somewhere? I.e. additional properties and
> so? If so ignore this, I will find it :)
>

I think Tirumala can explain it.
My platform (SPEAr) works with dwc_otg.

>>+ =A0 =A0 =A0{}
>>+};
>>+MODULE_DEVICE_TABLE(of, dwc_otg_match);
>>+#endif
>>+
>>+static struct platform_driver dwc_otg_driver =3D {
>>+ =A0 =A0 =A0.probe =3D dwc_otg_driver_probe,
>>+ =A0 =A0 =A0.remove =3D __devexit_p(dwc_otg_driver_remove),
>>+ =A0 =A0 =A0.driver =3D {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "dwc_otg",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>>+#if defined(CONFIG_OF)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D dwc_otg_match,
>>+#endif
>
> ifdef CONFIG_OF is not required at all.

ok.

>
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>>+};
>>+
>>+/**
>>+ * This function is called when the dwc_otg_driver is installed with the
>>+ * insmod command. It registers the dwc_otg_driver structure with the
>>+ * appropriate bus driver. This will cause the dwc_otg_driver_probe func=
tion
>>+ * to be called. In addition, the bus driver will automatically expose
>>+ * attributes defined for the device and driver in the special sysfs fil=
e
>>+ * system.
>>+ */
>>+static int __init dwc_otg_driver_init(void)
>>+{
>>+
>>+ =A0 =A0 =A0pr_info("%s: version %s\n", dwc_driver_name, DWC_DRIVER_VERS=
ION);
>>+ =A0 =A0 =A0return platform_driver_register(&dwc_otg_driver);
>>+}
>>+
>>+module_init(dwc_otg_driver_init);
>>+
>>+/**
>>+ * This function is called when the driver is removed from the kernel
>>+ * with the rmmod command. The driver unregisters itself with its bus
>>+ * driver.
>>+ *
>>+ */
>>+static void __exit dwc_otg_driver_cleanup(void)
>>+{
>>+ =A0 =A0 =A0platform_driver_unregister(&dwc_otg_driver);
>>+}
>>+
>>+module_exit(dwc_otg_driver_cleanup);
>>+
>>+MODULE_DESCRIPTION(DWC_DRIVER_DESC);
>>+MODULE_AUTHOR("Mark Miesfeld <mmiesfeld@apm.com");
>>+MODULE_LICENSE("GPL");
>>diff --git a/drivers/usb/dwc/driver.h b/drivers/usb/dwc/driver.h
>>new file mode 100644
>>index 0000000..a86532b
>>--- /dev/null
>>+++ b/drivers/usb/dwc/driver.h
>>@@ -0,0 +1,76 @@
>>+/*
>>+ * DesignWare HS OTG controller driver
>>+ * Copyright (C) 2006 Synopsys, Inc.
>>+ * Portions Copyright (C) 2010 Applied Micro Circuits Corporation.
>>+ *
>>+ * This program is free software: you can redistribute it and/or
>>+ * modify it under the terms of the GNU General Public License
>>+ * version 2 as published by the Free Software Foundation.
>>+ *
>>+ * This program is distributed in the hope that it will be useful
>>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>+ * GNU General Public License version 2 for more details.
>>+ *
>>+ * You should have received a copy of the GNU General Public License
>>+ * along with this program; if not, see http://www.gnu.org/licenses
>>+ * or write to the Free Software Foundation, Inc., 51 Franklin Street,
>>+ * Suite 500, Boston, MA 02110-1335 USA.
>>+ *
>>+ * Based on Synopsys driver version 2.60a
>>+ * Modified by Mark Miesfeld <mmiesfeld@apm.com>
>>+ *
>>+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "=
AS IS"
>>+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO T=
HE
>>+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
>>+ * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY DI=
RECT,
>>+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
>>+ * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SER=
VICES;
>>+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
>>+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR =
TORT
>>+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF
>>+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>+ *
>>+ */
>>+
>>+#if !defined(__DWC_OTG_DRIVER_H__)
>>+#define __DWC_OTG_DRIVER_H__
>>+
>>+/*
>>+ * This file contains the interface to the Linux driver.
>>+ */
>>+#include "cil.h"
>
> Oh, onion layers? Will check, never mind.
>
>>+/*
>>+ * This structure is a wrapper that encapsulates the driver components u=
sed to
>>+ * manage a single DWC_otg controller.
>>+ */
>>+struct dwc_otg_device {
>>+ =A0 =A0 =A0/* Base address returned from ioremap() */
>>+ =A0 =A0 =A0__iomem void *base;
>>+
>>+ =A0 =A0 =A0/* Pointer to the core interface structure. */
>>+ =A0 =A0 =A0struct core_if *core_if;
>>+
>>+ =A0 =A0 =A0/* Pointer to the PCD structure. */
>>+ =A0 =A0 =A0struct dwc_pcd *pcd;
>>+
>>+ =A0 =A0 =A0/* Pointer to the HCD structure. */
>>+ =A0 =A0 =A0struct dwc_hcd *hcd;
>>+
>>+ =A0 =A0 =A0/* Flag to indicate whether the common IRQ handler is instal=
led. */
>>+ =A0 =A0 =A0u8 common_irq_installed;
>
> please correct if I'm wring but it seems the only reason when this is
> not set is in an error case. In this case the driver is not loaded. So
> why do we have this here?

yes, you are coorect.
Must not be used.

>
>>+
>>+ =A0 =A0 =A0/* Interrupt request number. */
>>+ =A0 =A0 =A0unsigned int irq;
>>+
>>+ =A0 =A0 =A0/*
>>+ =A0 =A0 =A0 * Physical address of Control and Status registers, used by
>>+ =A0 =A0 =A0 * release_mem_region().
>>+ =A0 =A0 =A0 */
>>+ =A0 =A0 =A0resource_size_t phys_addr;
>
> If this is a physical address it should phys_addr_t.
>

yes this is a physical address..will correct.

>>+
>>+ =A0 =A0 =A0/* Length of memory region, used by release_mem_region(). */
>>+ =A0 =A0 =A0unsigned long base_len;
> this should be resource_size_t. But why are you collecting all this
> informations? You need it just for probe and remove right? Wouldn't it
> be easier to grab it again from platoform_device?

will review all these and correct.

>
>>+};
>>+#endif
>>diff --git a/drivers/usb/dwc/param.c b/drivers/usb/dwc/param.c
>>new file mode 100644
>>index 0000000..b9fcfa3
>>--- /dev/null
>>+++ b/drivers/usb/dwc/param.c
>>@@ -0,0 +1,219 @@
>>+/*
>>+ * DesignWare HS OTG controller driver
>>+ * Copyright (C) 2006 Synopsys, Inc.
>>+ * Portions Copyright (C) 2010 Applied Micro Circuits Corporation.
>>+ *
>>+ * This program is free software: you can redistribute it and/or
>>+ * modify it under the terms of the GNU General Public License
>>+ * version 2 as published by the Free Software Foundation.
>>+ *
>>+ * This program is distributed in the hope that it will be useful
>>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>+ * GNU General Public License version 2 for more details.
>>+ *
>>+ * You should have received a copy of the GNU General Public License
>>+ * along with this program; if not, see http://www.gnu.org/licenses
>>+ * or write to the Free Software Foundation, Inc., 51 Franklin Street,
>>+ * Suite 500, Boston, MA 02110-1335 USA.
>>+ *
>>+ * Based on Synopsys driver version 2.60a
>>+ * Modified by Mark Miesfeld <mmiesfeld@apm.com>
>>+ *
>>+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "=
AS IS"
>>+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO T=
HE
>>+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
>>+ * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY DI=
RECT,
>>+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
>>+ * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SER=
VICES;
>>+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
>>+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR =
TORT
>>+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF
>>+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>+ *
>>+ */
>>+
>>+/*
>>+ * This file provides dwc_otg driver parameter and parameter checking.
>>+ */
>>+
>>+#include "cil.h"
>>+
>>+/*
>>+ * Encapsulate the module parameter settings
>>+ */
>>+struct core_params dwc_otg_module_params =3D {
>>+ =A0 =A0 =A0.otg_cap =3D dwc_param_otg_cap_default,
>>+ =A0 =A0 =A0.dma_enable =3D dwc_param_dma_enable_default,
>>+ =A0 =A0 =A0.dma_burst_size =3D dwc_param_dma_burst_size_default,
>>+ =A0 =A0 =A0.speed =3D dwc_param_speed_default,
>>+ =A0 =A0 =A0.host_support_fs_ls_low_power
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D dwc_param_host_support_fs_ls_low_power_d=
efault,
>>+ =A0 =A0 =A0.host_ls_low_power_phy_clk
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D dwc_param_host_ls_low_power_phy_clk_defa=
ult,
>>+ =A0 =A0 =A0.enable_dynamic_fifo =3D -1,
>>+ =A0 =A0 =A0.dev_rx_fifo_size =3D -1,
>>+ =A0 =A0 =A0.dev_nperio_tx_fifo_size =3D -1,
>>+ =A0 =A0 =A0.dev_perio_tx_fifo_size =3D {-1, -1, -1, -1, -1, -1, -1, -1,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0-1, -1, -1, -1, -1, -1, -1}, =A0 =A0/* 15 */
>>+ =A0 =A0 =A0.host_rx_fifo_size =3D -1,
>>+ =A0 =A0 =A0.host_nperio_tx_fifo_size =3D -1,
>>+ =A0 =A0 =A0.host_perio_tx_fifo_size =3D -1,
>>+ =A0 =A0 =A0.max_transfer_size =3D -1,
>>+ =A0 =A0 =A0.max_packet_count =3D -1,
>>+ =A0 =A0 =A0.host_channels =3D -1,
>>+ =A0 =A0 =A0.dev_endpoints =3D -1,
>>+ =A0 =A0 =A0.phy_type =3D dwc_param_phy_type_default,
>>+ =A0 =A0 =A0.phy_utmi_width =3D dwc_param_phy_utmi_width_default,
>>+ =A0 =A0 =A0.phy_ulpi_ddr =3D dwc_param_phy_ulpi_ddr_default,
>>+ =A0 =A0 =A0.phy_ulpi_ext_vbus =3D dwc_param_phy_ulpi_ext_vbus_default,
>>+ =A0 =A0 =A0.i2c_enable =3D dwc_param_i2c_enable_default,
>>+ =A0 =A0 =A0.ulpi_fs_ls =3D dwc_param_ulpi_fs_ls_default,
>>+ =A0 =A0 =A0.ts_dline =3D dwc_param_ts_dline_default,
>>+ =A0 =A0 =A0.en_multiple_tx_fifo =3D -1,
>>+ =A0 =A0 =A0.dev_tx_fifo_size =3D {-1, -1, -1, -1, -1, -1, -1, -1, -1,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0-1, -1, -1, -1, -1, -1}, =A0 =A0 =A0 =A0/* 1=
5 */
>>+ =A0 =A0 =A0.fifo_number =3D MAX_TX_FIFOS,
>>+ =A0 =A0 =A0.thr_ctl =3D dwc_param_thr_ctl_default,
>>+ =A0 =A0 =A0.tx_thr_length =3D dwc_param_tx_thr_length_default,
>>+ =A0 =A0 =A0.rx_thr_length =3D dwc_param_rx_thr_length_default,
>>+};
>>+
>>+/**
>>+ * Checks that parameter settings for the periodic Tx FIFO sizes are cor=
rect
>>+ * according to the hardware configuration. Sets the size to the hardwar=
e
>>+ * configuration if an incorrect size is detected.
>>+ */
>>+static int set_valid_perio_tx_fifo_sizes(struct core_if *core_if)
>>+{
>>+ =A0 =A0 =A0ulong regs =3D (u32) core_if->core_global_regs;
>>+ =A0 =A0 =A0u32 *param_size =3D &dwc_otg_module_params.dev_perio_tx_fifo=
_size[0];
>>+ =A0 =A0 =A0u32 i, size;
>>+
>>+ =A0 =A0 =A0for (i =3D 0; i < dwc_otg_module_params.fifo_number; i++) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (param_size[i] =3D=3D -1) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size =3D dwc_read32(regs + D=
WC_DPTX_FSIZ_DIPTXF(i));
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0param_size[i] =3D DWC_TX_FIF=
O_DEPTH_RD(size);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>+ =A0 =A0 =A0}
>>+ =A0 =A0 =A0return 0;
>>+}
>>+
>>+/**
>>+ * Checks that parameter settings for the Tx FIFO sizes are correct acco=
rding to
>>+ * the hardware configuration. =A0Sets the size to the hardware configur=
ation if
>>+ * an incorrect size is detected.
>>+ */
>>+static int set_valid_tx_fifo_sizes(struct core_if *core_if)
>>+{
>>+ =A0 =A0 =A0ulong regs =3D (u32) core_if->core_global_regs;
>>+ =A0 =A0 =A0u32 *param_size =3D &dwc_otg_module_params.dev_tx_fifo_size[=
0];
>>+ =A0 =A0 =A0u32 i, size;
>>+
>>+ =A0 =A0 =A0for (i =3D 0; i < dwc_otg_module_params.fifo_number; i++) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (param_size[i] =3D=3D -1) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size =3D dwc_read32(regs + D=
WC_DPTX_FSIZ_DIPTXF(i));
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0param_size[i] =3D DWC_TX_FIF=
O_DEPTH_RD(size);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>+ =A0 =A0 =A0}
>>+ =A0 =A0 =A0return 0;
>>+}
>>+
>>+/**
>>+ * This function is called during module intialization to verify that
>>+ * the module parameters are in a valid state.
>>+ */
>>+int __devinit check_parameters(struct core_if *core_if)
>>+{
>>+ =A0 =A0 =A0int size;
>>+
>>+ =A0 =A0 =A0/* Hardware read only configurations of the OTG core. */
>>+ =A0 =A0 =A0dwc_otg_module_params.enable_dynamic_fifo =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0DWC_HWCFG2_DYN_FIFO_RD(core_if->hwcfg2);
>>+ =A0 =A0 =A0dwc_otg_module_params.max_transfer_size =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << (DWC_HWCFG3_XFERSIZE_CTR_WIDTH_RD(core=
_if->hwcfg3) + 11))
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0- 1;
>>+ =A0 =A0 =A0dwc_otg_module_params.max_packet_count =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << (DWC_HWCFG3_PKTSIZE_CTR_WIDTH_RD(core_=
if->hwcfg3) + 4))
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0- 1;
>>+ =A0 =A0 =A0dwc_otg_module_params.host_channels =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0DWC_HWCFG2_NO_HST_CHAN_RD(core_if->hwcfg2) +=
 1;
>>+ =A0 =A0 =A0dwc_otg_module_params.dev_endpoints =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0DWC_HWCFG2_NO_DEV_EP_RD(core_if->hwcfg2);
>>+ =A0 =A0 =A0dwc_otg_module_params.en_multiple_tx_fifo =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0(DWC_HWCFG4_DED_FIFO_ENA_RD(core_if->hwcfg4)=
 =3D=3D 0)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0? 0 : 1, 0;
>>+
>>+ =A0 =A0 =A0/*
>>+ =A0 =A0 =A0 * Hardware read/write configurations of the OTG core.
>>+ =A0 =A0 =A0 * If not defined by platform then read it from HW itself
>>+ =A0 =A0 =A0 */
>>+ =A0 =A0 =A0if (dwc_otg_module_params.dev_rx_fifo_size =3D=3D -1)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_module_params.dev_rx_fifo_size =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_read32(core_if->core_global_regs + DWC_G=
RXFSIZ);
>>+
>>+ =A0 =A0 =A0if (dwc_otg_module_params.dev_nperio_tx_fifo_size =3D=3D -1)=
 {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0size =3D dwc_read32(core_if->core_global_reg=
s + DWC_GNPTXFSIZ);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_module_params.dev_nperio_tx_fifo_siz=
e =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0DWC_TX_FIFO_DEPTH_RD(size);
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0if (dwc_otg_module_params.en_multiple_tx_fifo)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0set_valid_tx_fifo_sizes(core_if);
>>+ =A0 =A0 =A0else
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0set_valid_perio_tx_fifo_sizes(core_if);
>>+
>>+ =A0 =A0 =A0if (dwc_otg_module_params.host_rx_fifo_size =3D=3D -1)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_module_params.host_rx_fifo_size =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_read32(core_if->core_global_regs + DWC_G=
RXFSIZ);
>>+ =A0 =A0 =A0if (dwc_otg_module_params.host_nperio_tx_fifo_size =3D=3D -1=
) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0size
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D dwc_read32(core_if->core_global_regs + D=
WC_GNPTXFSIZ) >> 16;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_module_params.host_nperio_tx_fifo_si=
ze =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0DWC_TX_FIFO_DEPTH_RD(size);
>>+ =A0 =A0 =A0}
>>+ =A0 =A0 =A0if (dwc_otg_module_params.host_perio_tx_fifo_size =3D=3D -1)=
 {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0size =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_read32(core_if->core_global_regs + DWC_H=
PTXFSIZ) >> 16;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_module_params.host_perio_tx_fifo_siz=
e =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0DWC_TX_FIFO_DEPTH_RD(size);
>>+ =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0/*
>>+ =A0 =A0 =A0 * Hardware read/write configurations of the OTG core.
>>+ =A0 =A0 =A0 * If not defined by platform then read it from HW itself
>>+ =A0 =A0 =A0 * If defined by platform then write the same value in HW re=
gs
>>+ =A0 =A0 =A0 */
>>+ =A0 =A0 =A0if (dwc_otg_module_params.dev_rx_fifo_size =3D=3D -1)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_module_params.dev_rx_fifo_size =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_read32(core_if->core_global_regs + DWC_G=
RXFSIZ);
>>+ =A0 =A0 =A0else
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_write32(core_if->core_global_regs + DWC_=
GRXFSIZ,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_module_params.dev_rx_fifo_size);
>>+
>>+ =A0 =A0 =A0if (dwc_otg_module_params.dev_nperio_tx_fifo_size =3D=3D -1)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_module_params.dev_nperio_tx_fifo_siz=
e =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_read32(core_if->core_global_regs + DWC_G=
NPTXFSIZ) >> 16;
>>+ =A0 =A0 =A0else
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_write32(core_if->core_global_regs + DWC_=
GNPTXFSIZ,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(dwc_otg_module_params.dev_r=
x_fifo_size |
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(dwc_otg_module_params.dev_n=
perio_tx_fifo_size << 16)));
>>+
>>+ =A0 =A0 =A0set_valid_perio_tx_fifo_sizes(core_if);
>>+ =A0 =A0 =A0set_valid_tx_fifo_sizes(core_if);
>>+
>>+ =A0 =A0 =A0if (dwc_otg_module_params.host_rx_fifo_size =3D=3D -1)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_module_params.host_rx_fifo_size =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_read32(core_if->core_global_regs + DWC_G=
RXFSIZ);
>>+ =A0 =A0 =A0if (dwc_otg_module_params.host_nperio_tx_fifo_size =3D=3D -1=
)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_module_params.host_nperio_tx_fifo_si=
ze =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_read32(core_if->core_global_regs + DWC_G=
NPTXFSIZ) >> 16;
>>+ =A0 =A0 =A0if (dwc_otg_module_params.host_perio_tx_fifo_size =3D=3D -1)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_otg_module_params.host_perio_tx_fifo_siz=
e =3D
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_read32(core_if->core_global_regs + DWC_H=
PTXFSIZ) >> 16;
>
> oh boy, oh boy. This is a huge number of module parameters. Do you
> actually expect someone setting all of them on modprobe? And if udev is
> faster you rmmod and modpobe again, right? The clever ones would enter
> it somewhere in modprobe.conf or so. Anyway. Since you have
> already device tree bindings and I assume you are using them, why not
> move all this parameters into the device and remove _all_ module
> parameters?

In my case, I am passing necessary parameters from platform_data.
I do not use module param.

@Tirumala: please reply.

>
>>+ =A0 =A0 =A0return 0;
>>+}
>>+
>>+module_param_named(dma_enable, dwc_otg_module_params.dma_enable, bool, 0=
444);
>>+MODULE_PARM_DESC(dma_enable, "DMA Mode 0=3DSlave 1=3DDMA enabled");
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
