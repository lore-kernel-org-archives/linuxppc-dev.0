Return-Path: <pratyush.anand@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9EEAB1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2011 14:40:16 +1100 (EST)
Received: by gyg8 with SMTP id 8so3681428gyg.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 20:40:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1318630125-14200-1-git-send-email-tmarri@apm.com>
References: <1318630125-14200-1-git-send-email-tmarri@apm.com>
Date: Fri, 21 Oct 2011 09:10:13 +0530
Message-ID: <CAHM4w1nxqVXq1qdnjR_mazKAtRBO2oKB-O0sD5+CR8FJ4TfqSw@mail.gmail.com>
Subject: Re: [PATCH v15 02/10] USB/ppc4xx: Add Synopsys DesignWare HS USB OTG
 driver framework
From: Pratyush Anand <pratyush.anand@gmail.com>
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

On Sat, Oct 15, 2011 at 3:38 AM,  <tmarri@apm.com> wrote:
> From: Tirumala Marri <tmarri@apm.com>
>
> Platform probing is in apmppc.c.

Most if this file is common for other platform too.
So, why not extract common part and put them here.
All the platform specific whether PPC or ARM or else
should move to arch directory.

> Driver parameter and parameter checking are in param.c.
>
> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> ---
>  drivers/usb/dwc/apmppc.c |  355 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc/driver.h |   76 ++++++++++
>  drivers/usb/dwc/param.c  |  180 +++++++++++++++++++++++
>  3 files changed, 611 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/dwc/apmppc.c
>  create mode 100644 drivers/usb/dwc/driver.h
> +

[...]

> +static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
> +{
> +       int retval;
> +       struct dwc_otg_device *dwc_dev;
> +       struct device *dev = &ofdev->dev;
> +       struct resource res;
> +       ulong gusbcfg_addr;
> +       u32 usbcfg = 0;
> +
> +       dwc_dev = kzalloc(sizeof(*dwc_dev), GFP_KERNEL);
> +       if (!dwc_dev) {
> +               dev_err(dev, "kmalloc of dwc_otg_device failed\n");
> +               retval = -ENOMEM;
> +               goto fail_dwc_dev;
> +       }
> +
> +       /* Retrieve the memory and IRQ resources. */
> +       dwc_dev->irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
> +       if (dwc_dev->irq == NO_IRQ) {
> +               dev_err(dev, "no device irq\n");
> +               retval = -ENODEV;
> +               goto fail_of_irq;
> +       }
> +
> +       if (of_address_to_resource(ofdev->dev.of_node, 0, &res)) {
> +               dev_err(dev, "%s: Can't get USB-OTG register address\n",
> +                       __func__);
> +               retval = -ENOMEM;
> +               goto fail_of_irq;
> +       }
> +
> +       dwc_dev->phys_addr = res.start;
> +       dwc_dev->base_len = res.end - res.start + 1;
> +       if (!request_mem_region(dwc_dev->phys_addr,
> +                               dwc_dev->base_len, dwc_driver_name)) {
> +               dev_err(dev, "request_mem_region failed\n");
> +               retval = -EBUSY;
> +               goto fail_of_irq;
> +       }
> +
> +       /* Map the DWC_otg Core memory into virtual address space. */
> +       dwc_dev->base = ioremap(dwc_dev->phys_addr, dwc_dev->base_len);
> +       if (!dwc_dev->base) {
> +               dev_err(dev, "ioremap() failed\n");
> +               retval = -ENOMEM;
> +               goto fail_ioremap;
> +       }
> +       dev_dbg(dev, "mapped base=0x%08x\n", (__force u32)dwc_dev->base);
> +
> +       /*
> +        * Initialize driver data to point to the global DWC_otg
> +        * Device structure.
> +        */
> +       dev_set_drvdata(dev, dwc_dev);
> +
> +       dwc_dev->core_if =
> +           dwc_otg_cil_init(dwc_dev->base, &dwc_otg_module_params);
> +       if (!dwc_dev->core_if) {
> +               dev_err(dev, "CIL initialization failed!\n");
> +               retval = -ENOMEM;
> +               goto fail_cil_init;
> +       }
> +
> +       /*
> +        * Validate parameter values after dwc_otg_cil_init.
> +        */
> +       if (check_parameters(dwc_dev->core_if)) {
> +               retval = -EINVAL;
> +               goto fail_check_param;
> +       }
> +
> +       usb_nop_xceiv_register();
> +       dwc_dev->core_if->xceiv = otg_get_transceiver();
> +       if (!dwc_dev->core_if->xceiv) {
> +               retval = -ENODEV;
> +               goto fail_xceiv;
> +       }
> +       dwc_set_feature(dwc_dev->core_if);
> +
> +       /* Initialize the DWC_otg core. */
> +       dwc_otg_core_init(dwc_dev->core_if);
> +
> +       /*
> +        * Disable the global interrupt until all the interrupt
> +        * handlers are installed.
> +        */
> +       spin_lock(&dwc_dev->hcd->lock);
> +       dwc_otg_disable_global_interrupts(dwc_dev->core_if);
> +       spin_unlock(&dwc_dev->hcd->lock);
> +
> +       /*
> +        * Install the interrupt handler for the common interrupts before
> +        * enabling common interrupts in core_init below.
> +        */
> +       retval = request_irq(dwc_dev->irq, dwc_otg_common_irq,
> +                            IRQF_SHARED, "dwc_otg", dwc_dev);
> +       if (retval) {
> +               dev_err(dev, "request of irq%d failed retval: %d\n",
> +                       dwc_dev->irq, retval);
> +               retval = -EBUSY;
> +               goto fail_req_irq;
> +       } else {
> +               dwc_dev->common_irq_installed = 1;
> +       }
> +
> +       if (!dwc_has_feature(dwc_dev->core_if, DWC_HOST_ONLY)) {
> +               /* Initialize the PCD */
> +               retval = dwc_otg_pcd_init(dev);
> +               if (retval) {
> +                       dev_err(dev, "dwc_otg_pcd_init failed\n");
> +                       dwc_dev->pcd = NULL;
> +                       goto fail_req_irq;
> +               }
> +       }
> +
> +       gusbcfg_addr = (ulong) (dwc_dev->core_if->core_global_regs)
> +               + DWC_GUSBCFG;
> +       if (!dwc_has_feature(dwc_dev->core_if, DWC_DEVICE_ONLY)) {
> +               /* Initialize the HCD and force_host_mode */
> +               usbcfg = dwc_reg_read(gusbcfg_addr, 0);
> +               usbcfg |= DWC_USBCFG_FRC_HST_MODE;
> +               dwc_reg_write(gusbcfg_addr, 0, usbcfg);

What, if default mode supported by controller is device?
This code will set both host and device mode, even for host only.
So, along with setting forced host mode you should reset forced device
mode bit.

Same for the device only case.


> +
> +               retval = dwc_otg_hcd_init(dev, dwc_dev);
> +               if (retval) {
> +                       dev_err(dev, "dwc_otg_hcd_init failed\n");
> +                       dwc_dev->hcd = NULL;
> +                       goto fail_hcd;
> +               }
> +               /* configure chargepump interrupt */
> +               dwc_dev->hcd->cp_irq = irq_of_parse_and_map(ofdev->dev.of_node,
> +                                                           3);

Is the above function return 0 on error , I think , it retrun NO_IRQ
which is -1. So even then , the below code will try to register irq.


> +               if (dwc_dev->hcd->cp_irq) {
> +                       retval = request_irq(dwc_dev->hcd->cp_irq,
> +                                            dwc_otg_externalchgpump_irq,
> +                                            IRQF_SHARED,
> +                                            "dwc_otg_ext_chg_pump", dwc_dev);
> +                       if (retval) {
> +                               dev_err(dev,
> +                                       "request of irq failed retval: %d\n",
> +                                       retval);
> +                               retval = -EBUSY;
> +                               goto fail_hcd;
> +                       } else {
> +                               dev_dbg(dev, "%s: ExtChgPump Detection "
> +                                       "IRQ registered\n", dwc_driver_name);
> +                       }
> +               }
> +       }
> +       /*
> +        * Enable the global interrupt after all the interrupt
> +        * handlers are installed.
> +        */
> +       dwc_otg_enable_global_interrupts(dwc_dev->core_if);
> +
> +       usbcfg = dwc_reg_read(gusbcfg_addr, 0);
> +       usbcfg &= ~DWC_USBCFG_FRC_HST_MODE;
> +       dwc_reg_write(gusbcfg_addr, 0, usbcfg);

Why are you disbling forced host mode here. How will the system work, if
you have selected DWC_HOST_ONLY.

> +
> +       return 0;
> +fail_hcd:
> +       free_irq(dwc_dev->irq, dwc_dev);
> +       if (!dwc_has_feature(dwc_dev->core_if, DWC_HOST_ONLY)) {
> +               if (dwc_dev->pcd)
> +                       dwc_otg_pcd_remove(dev);
> +       }
> +fail_req_irq:
> +       otg_put_transceiver(dwc_dev->core_if->xceiv);
> +fail_xceiv:
> +       usb_nop_xceiv_unregister();
> +fail_check_param:
> +       dwc_otg_cil_remove(dwc_dev->core_if);
> +fail_cil_init:
> +       dev_set_drvdata(dev, NULL);
> +       iounmap(dwc_dev->base);
> +fail_ioremap:
> +       release_mem_region(dwc_dev->phys_addr, dwc_dev->base_len);
> +fail_of_irq:
> +       kfree(dwc_dev);
> +fail_dwc_dev:
> +       return retval;
> +}
> +
> +static const struct of_device_id dwc_otg_match[] = {
> +       {.compatible = "amcc,dwc-otg",},
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(of, dwc_otg_match);
> +
> +static struct platform_driver dwc_otg_driver = {
> +       .probe = dwc_otg_driver_probe,
> +       .remove = __devexit_p(dwc_otg_driver_remove),
> +       .driver = {
> +               .name = "dwc_otg",
> +               .owner = THIS_MODULE,
> +               .of_match_table = dwc_otg_match,
> +       },
> +};
> +
> +static int __init dwc_otg_driver_init(void)
> +{
> +
> +       return platform_driver_register(&dwc_otg_driver);
> +}
> +
> +module_init(dwc_otg_driver_init);
> +
> +static void __exit dwc_otg_driver_cleanup(void)
> +{
> +       platform_driver_unregister(&dwc_otg_driver);
> +}
> +
> +module_exit(dwc_otg_driver_cleanup);
> +
> +MODULE_DESCRIPTION(DWC_DRIVER_DESC);
> +MODULE_AUTHOR("Mark Miesfeld <mmiesfeld@apm.com");
> +MODULE_LICENSE("GPL");


Which part do you say that, its PPC specific.
I see everything generic.
Will work for ARM too.


[...]


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
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY DIRECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
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
> +struct core_params dwc_otg_module_params = {
> +       .otg_cap = -1,
> +       .dma_enable = -1,
> +       .dma_burst_size = -1,
> +       .speed = -1,
> +       .host_support_fs_ls_low_power = -1,
> +       .host_ls_low_power_phy_clk = -1,
> +       .enable_dynamic_fifo = -1,
> +       .dev_rx_fifo_size = -1,
> +       .dev_nperio_tx_fifo_size = -1,
> +       .dev_perio_tx_fifo_size = {-1, -1, -1, -1, -1, -1, -1, -1,
> +               -1, -1, -1, -1, -1, -1, -1},    /* 15 */
> +       .host_rx_fifo_size = -1,
> +       .host_nperio_tx_fifo_size = -1,
> +       .host_perio_tx_fifo_size = -1,
> +       .max_transfer_size = -1,
> +       .max_packet_count = -1,
> +       .host_channels = -1,
> +       .dev_endpoints = -1,
> +       .phy_type = -1,
> +       .phy_utmi_width = -1,
> +       .phy_ulpi_ddr = -1,
> +       .phy_ulpi_ext_vbus = -1,
> +       .i2c_enable = -1,
> +       .ulpi_fs_ls = -1,
> +       .ts_dline = -1,
> +       .en_multiple_tx_fifo = -1,
> +       .dev_tx_fifo_size = {-1, -1, -1, -1, -1, -1, -1, -1, -1,
> +               -1, -1, -1, -1, -1, -1},        /* 15 */
> +       .thr_ctl = -1,
> +       .tx_thr_length = -1,
> +       .rx_thr_length = -1,
> +};
> +
> +/**
> + * Checks that parameter settings for the periodic Tx FIFO sizes are correct
> + * according to the hardware configuration. Sets the size to the hardware
> + * configuration if an incorrect size is detected.
> + */
> +static int set_valid_perio_tx_fifo_sizes(struct core_if *core_if)
> +{
> +       ulong regs = (u32) core_if->core_global_regs;
> +       u32 *param_size = &dwc_otg_module_params.dev_perio_tx_fifo_size[0];
> +       u32 i, size;
> +
> +       for (i = 0; i < MAX_PERIO_FIFOS; i++, param_size++) {

So, if you take my suggestion to define fifo number also as user parameter
then, the loop will run only for fifo_number times.

> +               size = dwc_reg_read(regs, DWC_DPTX_FSIZ_DIPTXF(i));
> +               *param_size = size;
> +       }
> +       return 0;
> +}
> +
> +/**
> + * Checks that parameter settings for the Tx FIFO sizes are correct according to
> + * the hardware configuration.  Sets the size to the hardware configuration if
> + * an incorrect size is detected.
> + */
> +static int set_valid_tx_fifo_sizes(struct core_if *core_if)
> +{
> +       ulong regs = (u32) core_if->core_global_regs;
> +       u32 *param_size = &dwc_otg_module_params.dev_tx_fifo_size[0];
> +       u32 i, size;
> +
> +       for (i = 0; i < MAX_TX_FIFOS; i++, param_size) {

Its really starnge, how does this code work without incrementing param_size?

> +               size = dwc_reg_read(regs,  DWC_DPTX_FSIZ_DIPTXF(i));
> +               *param_size = size;
> +       }
> +       return 0;
> +}
> +
> +/**
> + * This function is called during module intialization to verify that
> + * the module parameters are in a valid state.
> + */
> +int __devinit check_parameters(struct core_if *core_if)
> +{
> +       /* Default values */
> +       dwc_otg_module_params.otg_cap = dwc_param_otg_cap_default;
> +       dwc_otg_module_params.dma_enable = dwc_param_dma_enable_default;
> +       dwc_otg_module_params.speed = dwc_param_speed_default;
> +       dwc_otg_module_params.host_support_fs_ls_low_power =
> +           dwc_param_host_support_fs_ls_low_power_default;
> +       dwc_otg_module_params.host_ls_low_power_phy_clk =
> +           dwc_param_host_ls_low_power_phy_clk_default;
> +       dwc_otg_module_params.phy_type = dwc_param_phy_type_default;
> +       dwc_otg_module_params.phy_ulpi_ddr = dwc_param_phy_ulpi_ddr_default;
> +       dwc_otg_module_params.phy_ulpi_ext_vbus =
> +           dwc_param_phy_ulpi_ext_vbus_default;
> +       dwc_otg_module_params.i2c_enable = dwc_param_i2c_enable_default;
> +       dwc_otg_module_params.ulpi_fs_ls = dwc_param_ulpi_fs_ls_default;
> +       dwc_otg_module_params.ts_dline = dwc_param_ts_dline_default;
> +
> +       dwc_otg_module_params.dma_burst_size = dwc_param_dma_burst_size_default;
> +       dwc_otg_module_params.phy_utmi_width = dwc_param_phy_utmi_width_default;
> +       dwc_otg_module_params.thr_ctl = dwc_param_thr_ctl_default;
> +       dwc_otg_module_params.tx_thr_length = dwc_param_tx_thr_length_default;
> +       dwc_otg_module_params.rx_thr_length = dwc_param_rx_thr_length_default;

Since, you are assiging default values here, why not to do that when
you have defined the
structure. In stead of initilizing struct with -1, you can initilize
with these default values.
It will save lot of computation.

> +
> +       /*
> +        * Hardware configurations of the OTG core.
> +        */
> +       dwc_otg_module_params.enable_dynamic_fifo =
> +           DWC_HWCFG2_DYN_FIFO_RD(core_if->hwcfg2);

What if, someone has passed enable_dynamic_fifo as parameter?
Will this code not overwrite user/application defined parameter?
So, before overwrting any of the parameter, you must check whether they
have been passed by the user or not? If passed, then you must not overwrite it.
Otherwise, there is no meaning of keeping such huge list of parameter.

> +       dwc_otg_module_params.dev_rx_fifo_size =
> +           dwc_reg_read(core_if->core_global_regs, DWC_GRXFSIZ);
> +       dwc_otg_module_params.dev_nperio_tx_fifo_size =
> +           dwc_reg_read(core_if->core_global_regs, DWC_GNPTXFSIZ) >> 16;
> +
> +       dwc_otg_module_params.host_rx_fifo_size =
> +           dwc_reg_read(core_if->core_global_regs, DWC_GRXFSIZ);
> +       dwc_otg_module_params.host_nperio_tx_fifo_size =
> +           dwc_reg_read(core_if->core_global_regs, DWC_GNPTXFSIZ) >> 16;
> +       dwc_otg_module_params.host_perio_tx_fifo_size =
> +           dwc_reg_read(core_if->core_global_regs, DWC_HPTXFSIZ) >> 16;
> +       dwc_otg_module_params.max_transfer_size =
> +           (1 << (DWC_HWCFG3_XFERSIZE_CTR_WIDTH_RD(core_if->hwcfg3) + 11))
> +           - 1;
> +       dwc_otg_module_params.max_packet_count =
> +           (1 << (DWC_HWCFG3_PKTSIZE_CTR_WIDTH_RD(core_if->hwcfg3) + 4))
> +           - 1;
> +
> +       dwc_otg_module_params.host_channels =
> +           DWC_HWCFG2_NO_HST_CHAN_RD(core_if->hwcfg2) + 1;
> +       dwc_otg_module_params.dev_endpoints =
> +           DWC_HWCFG2_NO_DEV_EP_RD(core_if->hwcfg2);
> +       dwc_otg_module_params.en_multiple_tx_fifo =
> +           (DWC_HWCFG4_DED_FIFO_ENA_RD(core_if->hwcfg4) == 0)
> +           ? 0 : 1, 0;
> +       set_valid_perio_tx_fifo_sizes(core_if);
> +       set_valid_tx_fifo_sizes(core_if);
> +
> +       return 0;
> +}
> +
> +module_param_named(dma_enable, dwc_otg_module_params.dma_enable, bool, 0444);
> +MODULE_PARM_DESC(dma_enable, "DMA Mode 0=Slave 1=DMA enabled");
> --
> 1.6.1.rc3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Regards
Pratyush
