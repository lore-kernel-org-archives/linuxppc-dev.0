Return-Path: <fchen@apm.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9DAFAB6F1A
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 09:16:49 +1000 (EST)
From: Fushen Chen <fchen@apm.com>
To: linux-usb@vger.kernel.org
Subject: [PATCH 2/9 v1.01] Add Synopsys DesignWare HS USB OTG Controller
	driver.
Date: Mon, 12 Jul 2010 16:16:37 -0700
Message-Id: <12789766051659-git-send-email-fchen@apm.com>
In-Reply-To: <12789766042434-git-send-email-fchen@apm.com>
References: <12789766042434-git-send-email-fchen@apm.com>
Cc: linuxppc-dev@ozlabs.org, chuck@theptrgroup.com, gregkh@suse.de,
	Mark Miesfeld <mmiesfeld@apm.com>, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Core Interface Layer provides basic services for accessing and
managing the DWC OTG hardware. These services are used by both the
Host Controller and the Peripheral Controller driver.

Signed-off-by: Fushen Chen <fchen@apm.com>
Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
---
 drivers/usb/otg/dwc_otg_cil.c |  758 ++++++++++++++++++++++++++
 drivers/usb/otg/dwc_otg_cil.h | 1205 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1963 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/otg/dwc_otg_cil.c
 create mode 100644 drivers/usb/otg/dwc_otg_cil.h

diff --git a/drivers/usb/otg/dwc_otg_cil.c b/drivers/usb/otg/dwc_otg_cil.c
new file mode 100644
index 0000000..3430655
--- /dev/null
+++ b/drivers/usb/otg/dwc_otg_cil.c
@@ -0,0 +1,758 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by AMCC and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * The Core Interface Layer provides basic services for accessing and
+ * managing the DWC_otg hardware. These services are used by both the
+ * Host Controller Driver and the Peripheral Controller Driver.
+ *
+ * The CIL manages the memory map for the core so that the HCD and PCD
+ * don't have to do this separately. It also handles basic tasks like
+ * reading/writing the registers and data FIFOs in the controller.
+ * Some of the data access functions provide encapsulation of several
+ * operations required to perform a task, such as writing multiple
+ * registers to start a transfer. Finally, the CIL performs basic
+ * services that are not specific to either the host or device modes
+ * of operation. These services include management of the OTG Host
+ * Negotiation Protocol (HNP) and Session Request Protocol (SRP). A
+ * Diagnostic API is also provided to allow testing of the controller
+ * hardware.
+ *
+ * The Core Interface Layer has the following requirements:
+ * - Provides basic controller operations.
+ * - Minimal use of OS services.
+ * - The OS services used will be abstracted by using inline functions
+ *	 or macros.
+ */
+#include <linux/delay.h>
+#include <linux/slab.h>
+
+#include "dwc_otg_regs.h"
+#include "dwc_otg_cil.h"
+
+/**
+ * This function enables the controller's Global Interrupt in the AHB Config
+ * register.
+ */
+void dwc_otg_enable_global_interrupts(struct core_if *core_if)
+{
+	union gahbcfg_data ahbcfg = {.d32 = 0};
+	ahbcfg.b.glblintrmsk = 1;
+	dwc_modify_reg32(&core_if->core_global_regs->gahbcfg, 0, ahbcfg.d32);
+}
+
+/**
+ * Tests if the current hardware is using a full speed phy.
+ */
+static inline int full_speed_phy(struct core_if *core_if)
+{
+	if ((core_if->hwcfg2.b.hs_phy_type == 2 &&
+			core_if->hwcfg2.b.fs_phy_type == 1 &&
+			core_if->core_params->ulpi_fs_ls) ||
+			core_if->core_params->phy_type ==
+			DWC_PHY_TYPE_PARAM_FS)
+		return 1;
+	return 0;
+}
+
+/**
+ * Initializes the FSLSPClkSel field of the HCFG register depending on the PHY
+ * type.
+ */
+void init_fslspclksel(struct core_if *core_if)
+{
+	u32 val;
+	union hcfg_data hcfg;
+
+	if (full_speed_phy(core_if))
+		val = DWC_HCFG_48_MHZ;
+	else
+		/* High speed PHY running at full speed or high speed */
+		val = DWC_HCFG_30_60_MHZ;
+
+	hcfg.d32 = dwc_read_reg32(&core_if->host_if->host_global_regs->hcfg);
+	hcfg.b.fslspclksel = val;
+	dwc_write_reg32(&core_if->host_if->host_global_regs->hcfg, hcfg.d32);
+}
+
+/**
+ * Initializes the DevSpd field of the DCFG register depending on the PHY type
+ * and the enumeration speed of the device.
+ */
+static void init_devspd(struct core_if *core_if)
+{
+	u32 val;
+	union  dcfg_data dcfg;
+
+	if (full_speed_phy(core_if))
+		val = 0x3;
+	 else if (core_if->core_params->speed == DWC_SPEED_PARAM_FULL)
+		/* High speed PHY running at full speed */
+		val = 0x1;
+	else
+		/* High speed PHY running at high speed */
+		val = 0x0;
+
+	dcfg.d32 = dwc_read_reg32(&core_if->dev_if->dev_global_regs->dcfg);
+	dcfg.b.devspd = val;
+	dwc_write_reg32(&core_if->dev_if->dev_global_regs->dcfg, dcfg.d32);
+}
+
+/**
+ * This function calculates the number of IN EPS using GHWCFG1 and GHWCFG2
+ * registers values
+ */
+static u32 calc_num_in_eps(struct core_if *core_if)
+{
+	u32 num_in_eps = 0;
+	u32 num_eps = core_if->hwcfg2.b.num_dev_ep;
+	u32 hwcfg1 = core_if->hwcfg1.d32 >> 2;
+	u32 num_tx_fifos = core_if->hwcfg4.b.num_in_eps;
+	u32 i;
+
+	for (i = 0; i < num_eps; ++i) {
+		if (!(hwcfg1 & 0x1))
+			num_in_eps++;
+		hwcfg1 >>= 2;
+	}
+
+	if (core_if->hwcfg4.b.ded_fifo_en)
+		num_in_eps = num_in_eps > num_tx_fifos ?
+				num_tx_fifos : num_in_eps;
+
+	return num_in_eps;
+}
+
+/**
+ * This function calculates the number of OUT EPS using GHWCFG1 and GHWCFG2
+ * registers values
+ */
+static u32 calc_num_out_eps(struct core_if *core_if)
+{
+	u32 num_out_eps = 0;
+	u32 num_eps = core_if->hwcfg2.b.num_dev_ep;
+	u32 hwcfg1 = core_if->hwcfg1.d32 >> 2;
+	u32 i;
+
+	for (i = 0; i < num_eps; ++i) {
+		if (!(hwcfg1 & 0x2))
+			num_out_eps++;
+		hwcfg1 >>= 2;
+	}
+	return num_out_eps;
+}
+
+/**
+ * Do core a soft reset of the core.  Be careful with this because it
+ * resets all the internal state machines of the core.
+ */
+static void dwc_otg_core_reset(struct core_if *core_if)
+{
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	union grstctl_data greset = {.d32 = 0};
+	int count = 0;
+
+	/* Wait for AHB master IDLE state. */
+	do {
+		udelay(10);
+		greset.d32 = dwc_read_reg32(&global_regs->grstctl);
+		if (++count > 100000) {
+			printk(KERN_WARNING
+				"%s() HANG! AHB Idle GRSTCTL=%0x\n",
+				__func__, greset.d32);
+			return;
+		}
+	} while (!greset.b.ahbidle);
+
+	/* Core Soft Reset */
+	count = 0;
+	greset.b.csftrst = 1;
+	dwc_write_reg32(&global_regs->grstctl, greset.d32);
+
+	do {
+		greset.d32 = dwc_read_reg32(&global_regs->grstctl);
+		if (++count > 10000) {
+			printk(KERN_WARNING "%s() HANG! Soft Reset "
+				"GRSTCTL=%0x\n", __func__, greset.d32);
+			break;
+		}
+		udelay(1);
+	} while (greset.b.csftrst);
+
+	/* Wait for 3 PHY Clocks */
+	msleep(100);
+}
+
+/**
+ * This function initializes the commmon interrupts, used in both
+ * device and host modes.
+ */
+void dwc_otg_enable_common_interrupts(struct core_if *core_if)
+{
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	union gintmsk_data intr_mask = {.d32 = 0};
+
+	/* Clear any pending OTG Interrupts */
+	dwc_write_reg32(&global_regs->gotgint, 0xFFFFFFFF);
+
+	/* Clear any pending interrupts */
+	dwc_write_reg32(&global_regs->gintsts, 0xFFFFFFFF);
+
+	/* Enable the interrupts in the GINTMSK. */
+	intr_mask.b.modemismatch = 1;
+	intr_mask.b.otgintr = 1;
+	intr_mask.b.conidstschng = 1;
+	intr_mask.b.wkupintr = 1;
+	intr_mask.b.disconnect = 1;
+	intr_mask.b.usbsuspend = 1;
+	intr_mask.b.sessreqintr = 1;
+	if (!core_if->dma_enable)
+		intr_mask.b.rxstsqlvl = 1;
+	dwc_write_reg32(&global_regs->gintmsk, intr_mask.d32);
+}
+
+/**
+ * This function initializes the DWC_otg controller registers and prepares the
+ * core for device mode or host mode operation.
+ */
+void dwc_otg_core_init(struct core_if *core_if)
+{
+	u32 i;
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	struct device_if *dev_if = core_if->dev_if;
+	union gahbcfg_data ahbcfg = {.d32 = 0};
+	union gusbcfg_data usbcfg = {.d32 = 0};
+	union gi2cctl_data i2cctl = {.d32 = 0};
+
+	/* Common Initialization */
+	usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+
+	/* Program the ULPI External VBUS bit if needed */
+	usbcfg.b.ulpi_ext_vbus_drv = 1;
+
+	/* Set external TS Dline pulsing */
+	usbcfg.b.term_sel_dl_pulse = core_if->core_params->ts_dline == 1 ?
+						1 : 0;
+	dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+	/* Reset the Controller */
+	dwc_otg_core_reset(core_if);
+
+	/* Initialize parameters from Hardware configuration registers. */
+	dev_if->num_in_eps = calc_num_in_eps(core_if);
+	dev_if->num_out_eps = calc_num_out_eps(core_if);
+
+	for (i = 0; i < core_if->hwcfg4.b.num_dev_perio_in_ep; i++) {
+		dev_if->perio_tx_fifo_size[i] =
+			dwc_read_reg32(&global_regs->dptxfsiz_dieptxf[i]) >> 16;
+	}
+	for (i = 0; i < core_if->hwcfg4.b.num_in_eps; i++) {
+		dev_if->tx_fifo_size[i] =
+			dwc_read_reg32(&global_regs->dptxfsiz_dieptxf[i]) >> 16;
+	}
+
+	core_if->total_fifo_size = core_if->hwcfg3.b.dfifo_depth;
+	core_if->rx_fifo_size = dwc_read_reg32(&global_regs->grxfsiz);
+	core_if->nperio_tx_fifo_size =
+			dwc_read_reg32(&global_regs->gnptxfsiz) >> 16;
+	/*
+	 * This programming sequence needs to happen in FS mode before any
+	 * other programming occurs
+	 */
+	if (core_if->core_params->speed == DWC_SPEED_PARAM_FULL &&
+			core_if->core_params->phy_type ==
+			DWC_PHY_TYPE_PARAM_FS) {
+		/*
+		 * core_init() is now called on every switch so only call the
+		 * following for the first time through.
+		 */
+		if (!core_if->phy_init_done) {
+			core_if->phy_init_done = 1;
+			usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+			usbcfg.b.physel = 1;
+			dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+			/* Reset after a PHY select */
+			dwc_otg_core_reset(core_if);
+		}
+
+		/*
+		 * Program DCFG.DevSpd or HCFG.FSLSPclkSel to 48Mhz in FS.
+		 * Also do this on HNP Dev/Host mode switches (done in dev_init
+		 * and host_init).
+		 */
+		if (dwc_otg_is_host_mode(core_if))
+			init_fslspclksel(core_if);
+		else
+			init_devspd(core_if);
+
+		if (core_if->core_params->i2c_enable) {
+			/* Program GUSBCFG.OtgUtmifsSel to I2C */
+			usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+			usbcfg.b.otgutmifssel = 1;
+			dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+			/* Program GI2CCTL.I2CEn */
+			i2cctl.d32 = dwc_read_reg32(&global_regs->gi2cctl);
+			i2cctl.b.i2cdevaddr = 1;
+			i2cctl.b.i2cen = 0;
+			dwc_write_reg32(&global_regs->gi2cctl, i2cctl.d32);
+			i2cctl.b.i2cen = 1;
+			dwc_write_reg32(&global_regs->gi2cctl, i2cctl.d32);
+		}
+	} else if (!core_if->phy_init_done) {
+		/*
+		 * High speed PHY. These parameters are preserved during soft
+		 * reset so only program them the first time. Do a soft reset
+		 * immediately after setting phyif.
+		 */
+		core_if->phy_init_done = 1;
+		/* test-only: in AMCC 460EX code not used!!!???*/
+		usbcfg.b.ulpi_utmi_sel = core_if->core_params->phy_type;
+		if (usbcfg.b.ulpi_utmi_sel == 1) {
+			/* ULPI interface */
+			usbcfg.b.phyif = 0;
+			usbcfg.b.ddrsel = core_if->core_params->phy_ulpi_ddr;
+		} else {
+			/* UTMI+ interface */
+			if (core_if->core_params->phy_utmi_width == 16)
+				usbcfg.b.phyif = 1;
+			else
+				usbcfg.b.phyif = 0;
+		}
+		dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+		/* Reset after setting the PHY parameters */
+		dwc_otg_core_reset(core_if);
+	}
+
+	if (core_if->hwcfg2.b.hs_phy_type == 2 &&
+			core_if->hwcfg2.b.fs_phy_type == 1 &&
+			core_if->core_params->ulpi_fs_ls) {
+		usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+		usbcfg.b.ulpi_fsls = 1;
+		usbcfg.b.ulpi_clk_sus_m = 1;
+		dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+	} else {
+		usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+		usbcfg.b.ulpi_fsls = 0;
+		usbcfg.b.ulpi_clk_sus_m = 0;
+		dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+	}
+
+	/* Program the GAHBCFG Register. */
+	switch (core_if->hwcfg2.b.architecture) {
+	case DWC_SLAVE_ONLY_ARCH:
+		ahbcfg.b.nptxfemplvl_txfemplvl =
+			DWC_GAHBCFG_TXFEMPTYLVL_HALFEMPTY;
+		ahbcfg.b.ptxfemplvl = DWC_GAHBCFG_TXFEMPTYLVL_HALFEMPTY;
+		core_if->dma_enable = 0;
+		break;
+	case DWC_EXT_DMA_ARCH:
+		ahbcfg.b.hburstlen = core_if->core_params->dma_burst_size;
+		core_if->dma_enable = (core_if->core_params->dma_enable != 0);
+		break;
+	case DWC_INT_DMA_ARCH:
+		ahbcfg.b.hburstlen = DWC_GAHBCFG_INT_DMA_BURST_INCR;
+		core_if->dma_enable = (core_if->core_params->dma_enable != 0);
+		break;
+	}
+
+	ahbcfg.b.dmaenable = core_if->dma_enable;
+	dwc_write_reg32(&global_regs->gahbcfg, ahbcfg.d32);
+	core_if->en_multiple_tx_fifo = core_if->hwcfg4.b.ded_fifo_en;
+
+	/* Program the GUSBCFG register. */
+	usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+	switch (core_if->hwcfg2.b.op_mode) {
+	case DWC_MODE_HNP_SRP_CAPABLE:
+		usbcfg.b.hnpcap = (core_if->core_params->otg_cap ==
+			DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE);
+		usbcfg.b.srpcap = (core_if->core_params->otg_cap !=
+			DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE);
+		break;
+	case DWC_MODE_SRP_ONLY_CAPABLE:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = (core_if->core_params->otg_cap !=
+			DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE);
+		break;
+	case DWC_MODE_NO_HNP_SRP_CAPABLE:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = 0;
+		break;
+	case DWC_MODE_SRP_CAPABLE_DEVICE:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = (core_if->core_params->otg_cap !=
+			DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE);
+		break;
+	case DWC_MODE_NO_SRP_CAPABLE_DEVICE:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = 0;
+		break;
+	case DWC_MODE_SRP_CAPABLE_HOST:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = (core_if->core_params->otg_cap !=
+			DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE);
+		break;
+	case DWC_MODE_NO_SRP_CAPABLE_HOST:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = 0;
+		break;
+	}
+	dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+	/* Enable common interrupts */
+	dwc_otg_enable_common_interrupts(core_if);
+
+	/*
+	 * Do device or host intialization based on mode during PCD
+	 * and HCD initialization
+	 */
+	if (dwc_otg_is_host_mode(core_if)) {
+		core_if->op_state = A_HOST;
+	} else {
+		core_if->op_state = B_PERIPHERAL;
+		if (dwc_has_feature(core_if, DWC_DEVICE_ONLY))
+			dwc_otg_core_dev_init(core_if);
+	}
+}
+
+/**
+ * This function enables the Device mode interrupts.
+ *
+ * Note that the bits in the Device IN endpoint mask register are laid out
+ * exactly the same as the Device IN endpoint interrupt register.
+ */
+static void dwc_otg_enable_device_interrupts(struct core_if *core_if)
+{
+	union gintmsk_data intr_mask = {.d32 = 0};
+	union diepint_data msk = {.d32 = 0};
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+
+	/* Disable all interrupts. */
+	dwc_write_reg32(&global_regs->gintmsk, 0);
+
+	/* Clear any pending interrupts */
+	dwc_write_reg32(&global_regs->gintsts, 0xFFFFFFFF);
+
+	/* Enable the common interrupts */
+	dwc_otg_enable_common_interrupts(core_if);
+
+	/* Enable interrupts */
+	intr_mask.b.usbreset = 1;
+	intr_mask.b.enumdone = 1;
+	intr_mask.b.inepintr = 1;
+	intr_mask.b.outepintr = 1;
+	intr_mask.b.erlysuspend = 1;
+	if (!core_if->en_multiple_tx_fifo)
+		intr_mask.b.epmismatch = 1;
+
+	/* Periodic EP */
+	intr_mask.b.isooutdrop = 1;
+	intr_mask.b.eopframe = 1;
+	intr_mask.b.incomplisoin = 1;
+	intr_mask.b.incomplisoout = 1;
+
+	dwc_modify_reg32(&global_regs->gintmsk, intr_mask.d32, intr_mask.d32);
+
+	msk.b.txfifoundrn = 1;
+	dwc_modify_reg32(&core_if->dev_if->dev_global_regs->diepmsk,
+				msk.d32, msk.d32);
+}
+
+/**
+ *  Configures the device data fifo sizes when dynamic sizing is enabled.
+ */
+static void config_dev_dynamic_fifos(struct core_if *core_if)
+{
+	u32 i;
+	struct core_global_regs *regs = core_if->core_global_regs;
+	struct core_params *params = core_if->core_params;
+	union fifosize_data txsize;
+	union fifosize_data nptxsize;
+	union fifosize_data ptxsize;
+
+	 /* Rx FIFO */
+	dwc_write_reg32(&regs->grxfsiz, params->dev_rx_fifo_size);
+
+	/* Set Periodic and Non-periodic Tx FIFO Mask bits to all 0 */
+	core_if->p_tx_msk = 0;
+	core_if->tx_msk = 0;
+
+	if (core_if->en_multiple_tx_fifo == 0) {
+		/* Non-periodic Tx FIFO */
+		nptxsize.b.depth = params->dev_nperio_tx_fifo_size;
+		nptxsize.b.startaddr = params->dev_rx_fifo_size;
+		dwc_write_reg32(&regs->gnptxfsiz, nptxsize.d32);
+
+		/*
+		 * Periodic Tx FIFOs These FIFOs are numbered from 1 to
+		 * 15. Indexes of the FIFO size module parameters in the
+		 * dev_perio_tx_fifo_size array and the FIFO size
+		 * registers in the dptxfsiz array run from 0 to 14.
+		 */
+		ptxsize.b.startaddr = nptxsize.b.startaddr + nptxsize.b.depth;
+		for (i = 0; i < core_if->hwcfg4.b.num_dev_perio_in_ep; i++) {
+			ptxsize.b.depth = params->dev_perio_tx_fifo_size[i];
+			dwc_write_reg32(&regs->dptxfsiz_dieptxf[i],
+						ptxsize.d32);
+			ptxsize.b.startaddr += ptxsize.b.depth;
+		}
+	} else {
+		/*
+		 * Non-periodic Tx FIFOs These FIFOs are numbered from
+		 * 1 to 15. Indexes of the FIFO size module parameters
+		 * in the dev_tx_fifo_size array and the FIFO size
+		 * registers in the dptxfsiz_dieptxf array run from 0 to
+		 * 14.
+		 */
+		nptxsize.b.depth = params->dev_nperio_tx_fifo_size;
+		nptxsize.b.startaddr = params->dev_rx_fifo_size;
+		dwc_write_reg32(&regs->gnptxfsiz, nptxsize.d32);
+
+		txsize.b.startaddr = nptxsize.b.startaddr + nptxsize.b.depth;
+		for (i = 1; i < core_if->hwcfg4.b.num_dev_perio_in_ep; i++) {
+			txsize.b.depth = params->dev_tx_fifo_size[i];
+			dwc_write_reg32(&regs->dptxfsiz_dieptxf[i - 1],
+						txsize.d32);
+			txsize.b.startaddr += txsize.b.depth;
+		}
+	}
+}
+
+/**
+ * This function initializes the DWC_otg controller registers for
+ * device mode.
+ */
+void dwc_otg_core_dev_init(struct core_if *c_if)
+{
+	u32 i;
+	struct device_if *d_if = c_if->dev_if;
+	struct core_params *params = c_if->core_params;
+	union dcfg_data dcfg = {.d32 = 0};
+	union grstctl_data resetctl = {.d32 = 0};
+	union dthrctl_data dthrctl;
+
+	/* Restart the Phy Clock */
+	dwc_write_reg32(c_if->pcgcctl, 0);
+
+	/* Device configuration register */
+	init_devspd(c_if);
+	dcfg.d32 = dwc_read_reg32(&d_if->dev_global_regs->dcfg);
+	dcfg.b.perfrint = DWC_DCFG_FRAME_INTERVAL_80;
+	dwc_write_reg32(&d_if->dev_global_regs->dcfg, dcfg.d32);
+
+	/* If needed configure data FIFO sizes */
+	if (c_if->hwcfg2.b.dynamic_fifo && params->enable_dynamic_fifo)
+		config_dev_dynamic_fifos(c_if);
+
+	/* Flush the FIFOs */
+	dwc_otg_flush_tx_fifo(c_if, DWC_GRSTCTL_TXFNUM_ALL);
+	dwc_otg_flush_rx_fifo(c_if);
+
+	/* Flush the Learning Queue. */
+	resetctl.b.intknqflsh = 1;
+	dwc_write_reg32(&c_if->core_global_regs->grstctl, resetctl.d32);
+
+	/* Clear all pending Device Interrupts */
+	dwc_write_reg32(&d_if->dev_global_regs->diepmsk, 0);
+	dwc_write_reg32(&d_if->dev_global_regs->doepmsk, 0);
+	dwc_write_reg32(&d_if->dev_global_regs->daint, 0xFFFFFFFF);
+	dwc_write_reg32(&d_if->dev_global_regs->daintmsk, 0);
+
+	for (i = 0; i <= d_if->num_in_eps; i++) {
+		union depctl_data depctl;
+
+		depctl.d32 = dwc_read_reg32(&d_if->in_ep_regs[i]->diepctl);
+		if (depctl.b.epena) {
+			depctl.d32 = 0;
+			depctl.b.epdis = 1;
+			depctl.b.snak = 1;
+		} else {
+			depctl.d32 = 0;
+		}
+
+		dwc_write_reg32(&d_if->in_ep_regs[i]->diepctl, depctl.d32);
+		dwc_write_reg32(&d_if->in_ep_regs[i]->dieptsiz, 0);
+		dwc_write_reg32(&d_if->in_ep_regs[i]->diepdma, 0);
+		dwc_write_reg32(&d_if->in_ep_regs[i]->diepint, 0xFF);
+	}
+
+	for (i = 0; i <= d_if->num_out_eps; i++) {
+		union depctl_data depctl;
+		depctl.d32 = dwc_read_reg32(&d_if->out_ep_regs[i]->doepctl);
+		if (depctl.b.epena) {
+			depctl.d32 = 0;
+			depctl.b.epdis = 1;
+			depctl.b.snak = 1;
+		} else {
+			depctl.d32 = 0;
+		}
+		dwc_write_reg32(&d_if->out_ep_regs[i]->doepctl, depctl.d32);
+		dwc_write_reg32(&d_if->out_ep_regs[i]->doeptsiz, 0);
+		dwc_write_reg32(&d_if->out_ep_regs[i]->doepdma, 0);
+		dwc_write_reg32(&d_if->out_ep_regs[i]->doepint, 0xFF);
+	}
+
+	if (c_if->en_multiple_tx_fifo && c_if->dma_enable) {
+		d_if->non_iso_tx_thr_en = c_if->core_params->thr_ctl & 0x1;
+		d_if->iso_tx_thr_en = (c_if->core_params->thr_ctl >> 1) & 0x1;
+		d_if->rx_thr_en = (c_if->core_params->thr_ctl >> 2) & 0x1;
+		d_if->rx_thr_length = c_if->core_params->rx_thr_length;
+		d_if->tx_thr_length = c_if->core_params->tx_thr_length;
+
+		dthrctl.d32 = 0;
+		dthrctl.b.non_iso_thr_en = d_if->non_iso_tx_thr_en;
+		dthrctl.b.iso_thr_en = d_if->iso_tx_thr_en;
+		dthrctl.b.tx_thr_len = d_if->tx_thr_length;
+		dthrctl.b.rx_thr_en = d_if->rx_thr_en;
+		dthrctl.b.rx_thr_len = d_if->rx_thr_length;
+		dwc_write_reg32(&d_if->dev_global_regs->dtknqr3_dthrctl,
+					dthrctl.d32);
+
+	}
+
+	dwc_otg_enable_device_interrupts(c_if);
+}
+
+/**
+ * This function reads a packet from the Rx FIFO into the destination buffer.
+ * To read SETUP data use dwc_otg_read_setup_packet.
+ */
+void dwc_otg_read_packet(struct core_if *core_if, u8 *dest,
+				u16 _bytes)
+{
+	u32 i;
+	int word_count = (_bytes + 3) / 4;
+	u32 *fifo = core_if->data_fifo[0];
+	u32 *data_buff = (u32 *) dest;
+
+	/*
+	 * This requires reading data from the FIFO into a u32 temp buffer,
+	 * then moving it into the data buffer.
+	 */
+	for (i = 0; i < word_count; i++, data_buff++)
+		*data_buff = dwc_read_datafifo32(fifo);
+}
+
+/**
+ * Flush a Tx FIFO.
+ */
+void dwc_otg_flush_tx_fifo(struct core_if *core_if, const int num)
+{
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	union grstctl_data greset = {.d32 = 0 };
+	int count = 0;
+
+	greset.b.txfflsh = 1;
+	greset.b.txfnum = num;
+	dwc_write_reg32(&global_regs->grstctl, greset.d32);
+
+	do {
+		greset.d32 = dwc_read_reg32(&global_regs->grstctl);
+		if (++count > 10000) {
+			printk(KERN_WARNING "%s() HANG! GRSTCTL=%0x "
+				"GNPTXSTS=0x%08x\n", __func__, greset.d32,
+				dwc_read_reg32(&global_regs->gnptxsts));
+			break;
+		}
+		udelay(1);
+	} while (greset.b.txfflsh == 1);
+
+	/* Wait for 3 PHY Clocks */
+	udelay(1);
+}
+
+/**
+ * Flush Rx FIFO.
+ */
+void dwc_otg_flush_rx_fifo(struct core_if *core_if)
+{
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	union grstctl_data greset = {.d32 = 0 };
+	int count = 0;
+
+	greset.b.rxfflsh = 1;
+	dwc_write_reg32(&global_regs->grstctl, greset.d32);
+
+	do {
+		greset.d32 = dwc_read_reg32(&global_regs->grstctl);
+		if (++count > 10000) {
+			printk(KERN_WARNING "%s() HANG! GRSTCTL=%0x\n",
+				__func__, greset.d32);
+			break;
+		}
+		udelay(1);
+	} while (greset.b.rxfflsh);
+
+	/* Wait for 3 PHY Clocks */
+	udelay(1);
+}
+
+/**
+ * Register HCD callbacks.
+ * The callbacks are used to start and stop the HCD for interrupt processing.
+ */
+void __devinit dwc_otg_cil_register_hcd_callbacks(struct core_if *c_if,
+				struct cil_callbacks *cb, void *p)
+{
+	c_if->hcd_cb = cb;
+	cb->p = p;
+}
+
+/**
+ * Register PCD callbacks.
+ * The callbacks are used to start and stop the PCD for interrupt processing.
+ */
+void __devinit dwc_otg_cil_register_pcd_callbacks(struct core_if *c_if,
+				struct cil_callbacks *cb, void *p)
+{
+	c_if->pcd_cb = cb;
+	cb->p = p;
+}
diff --git a/drivers/usb/otg/dwc_otg_cil.h b/drivers/usb/otg/dwc_otg_cil.h
new file mode 100644
index 0000000..b3e45b9
--- /dev/null
+++ b/drivers/usb/otg/dwc_otg_cil.h
@@ -0,0 +1,1205 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by AMCC and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#if !defined(__DWC_CIL_H__)
+#define __DWC_CIL_H__
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/io.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+#include <linux/interrupt.h>
+#include <linux/dmapool.h>
+#include <linux/spinlock.h>
+
+#include "dwc_otg_regs.h"
+
+#ifdef CONFIG_DWC_SLAVE
+#define DWC_ARCH DWC_SLAVE_ONLY_ARCH
+#else
+#define DWC_ARCH DWC_INT_DMA_ARCH
+#endif
+
+#ifdef CONFIG_DWC_DEBUG
+#define DEBUG
+#endif
+
+/**
+ * Reads the content of a register.
+ */
+static inline u32 dwc_read_reg32(u32 *reg)
+{
+#ifdef CONFIG_DWC_OTG_REG_LE
+	return in_le32(reg);
+#else
+	return in_be32(reg);
+#endif
+};
+
+/**
+ * Writes a register with a 32 bit value.
+ */
+static inline void dwc_write_reg32(u32 *reg, const u32 value)
+{
+#ifdef CONFIG_DWC_OTG_REG_LE
+	out_le32(reg, value);
+#else
+	out_be32(reg, value);
+#endif
+};
+
+/**
+ * This function modifies bit values in a register.  Using the
+ * algorithm: (reg_contents & ~clear_mask) | set_mask.
+ */
+static inline
+void dwc_modify_reg32(u32 *_reg, const u32 _clear_mask,
+			const u32 _set_mask)
+{
+#ifdef CONFIG_DWC_OTG_REG_LE
+	out_le32(_reg, (in_le32(_reg) & ~_clear_mask) | _set_mask);
+#else
+	out_be32(_reg, (in_be32(_reg) & ~_clear_mask) | _set_mask);
+#endif
+};
+
+static inline void dwc_write_datafifo32(u32 *reg, const u32 _value)
+{
+#ifdef CONFIG_DWC_OTG_FIFO_LE
+	out_le32(reg, _value);
+#else
+	out_be32(reg, _value);
+#endif
+};
+
+static inline u32 dwc_read_datafifo32(u32 *_reg)
+{
+#ifdef CONFIG_DWC_OTG_FIFO_LE
+	return in_le32(_reg);
+#else
+	return in_be32(_reg);
+#endif
+};
+
+/*
+ * Debugging support vanishes in non-debug builds.
+ */
+/* Display CIL Debug messages */
+#define dwc_dbg_cil		(0x2)
+
+/* Display CIL Verbose debug messages */
+#define dwc_dbg_cilv		(0x20)
+
+/* Display PCD (Device) debug messages */
+#define dwc_dbg_pcd		(0x4)
+
+/* Display PCD (Device) Verbose debug  messages */
+#define dwc_dbg_pcdv		(0x40)
+
+/* Display Host debug messages */
+#define dwc_dbg_hcd		(0x8)
+
+/* Display Verbose Host debug messages */
+#define dwc_dbg_hcdv		(0x80)
+
+/* Display enqueued URBs in host mode. */
+#define dwc_dbg_hcd_urb		(0x800)
+
+/* Display "special purpose" debug messages */
+#define dwc_dbg_sp		(0x400)
+
+/* Display all debug messages */
+#define dwc_dbg_any		(0xFF)
+
+/* All debug messages off */
+#define dwc_dbg_off		0
+
+/* Prefix string for DWC_DEBUG print macros. */
+#define usb_dwc "dwc_otg: "
+
+/*
+ * This file contains the interface to the Core Interface Layer.
+ */
+
+/*
+ * Added-sr: 2007-07-26
+ *
+ * Since the 405EZ (Ultra) only support 2047 bytes as
+ * max transfer size, we have to split up bigger transfers
+ * into multiple transfers of 1024 bytes sized messages.
+ * I happens often, that transfers of 4096 bytes are
+ * required (zero-gadget, file_storage-gadget).
+ *
+ * MAX_XFER_LEN is set to 1024 right now, but could be 2047,
+ * since the xfer-size field in the 405EZ USB device controller
+ * implementation has 11 bits. Using 1024 seems to work for now.
+ */
+#define MAX_XFER_LEN	1024
+
+/*
+ * The dwc_ep structure represents the state of a single endpoint when acting in
+ * device mode. It contains the data items needed for an endpoint to be
+ * activated and transfer packets.
+ */
+struct dwc_ep {
+	/* EP number used for register address lookup */
+	u8	 num;
+	/* EP direction 0 = OUT */
+	unsigned is_in:1;
+	/* EP active. */
+	unsigned active:1;
+
+	/*
+	 * Periodic Tx FIFO # for IN EPs For INTR EP set to 0 to use
+	 * non-periodic Tx FIFO If dedicated Tx FIFOs are enabled for all
+	 * IN Eps - Tx FIFO # FOR IN EPs
+	 */
+	unsigned tx_fifo_num:4;
+	/* EP type: 0 - Control, 1 - ISOC,	 2 - BULK,	3 - INTR */
+	unsigned type:2;
+#define DWC_OTG_EP_TYPE_CONTROL		0
+#define DWC_OTG_EP_TYPE_ISOC		1
+#define DWC_OTG_EP_TYPE_BULK		2
+#define DWC_OTG_EP_TYPE_INTR		3
+
+	/* DATA start PID for INTR and BULK EP */
+	unsigned data_pid_start:1;
+	/* Frame (even/odd) for ISOC EP */
+	unsigned even_odd_frame:1;
+	/* Max Packet bytes */
+	unsigned maxpacket:11;
+
+	u32 dma_addr;
+
+	/*
+	 * Pointer to the beginning of the transfer buffer -- do not modify
+	 * during transfer.
+	 */
+	u8 *start_xfer_buff;
+	/* pointer to the transfer buffer */
+	u8 *xfer_buff;
+	/* Number of bytes to transfer */
+	unsigned xfer_len:19;
+	/* Number of bytes transferred. */
+	unsigned xfer_count:19;
+	/* Sent ZLP */
+	unsigned sent_zlp:1;
+	/* Total len for control transfer */
+	unsigned total_len:19;
+
+	/* stall clear flag */
+	unsigned stall_clear_flag:1;
+
+	/*
+	 * Added-sr: 2007-07-26
+	 *
+	 * Since the 405EZ (Ultra) only support 2047 bytes as
+	 * max transfer size, we have to split up bigger transfers
+	 * into multiple transfers of 1024 bytes sized messages.
+	 * I happens often, that transfers of 4096 bytes are
+	 * required (zero-gadget, file_storage-gadget).
+	 *
+	 * "bytes_pending" will hold the amount of bytes that are
+	 * still pending to be send in further messages to complete
+	 * the bigger transfer.
+	 */
+	u32 bytes_pending;
+};
+
+
+/*
+ * States of EP0.
+ */
+enum ep0_state {
+	EP0_DISCONNECT = 0,     /* no host */
+	EP0_IDLE = 1,
+	EP0_IN_DATA_PHASE = 2,
+	EP0_OUT_DATA_PHASE = 3,
+	EP0_STATUS = 4,
+	EP0_STALL = 5,
+};
+
+/* Fordward declaration.*/
+struct dwc_pcd;
+
+/*
+ * This structure describes an EP, there is an array of EPs in the PCD
+ * structure.
+ */
+struct pcd_ep {
+	/* USB EP data */
+	struct usb_ep ep;
+	/* USB EP Descriptor */
+	const struct usb_endpoint_descriptor *desc;
+
+	/* queue of dwc_otg_pcd_requests. */
+	struct list_head queue;
+	unsigned stopped:1;
+	unsigned disabling:1;
+	unsigned dma:1;
+	unsigned queue_sof:1;
+
+	/* DWC_otg ep data. */
+	struct dwc_ep dwc_ep;
+
+	/* Pointer to PCD */
+	struct dwc_pcd *pcd;
+};
+
+/*
+ * DWC_otg PCD Structure.
+ * This structure encapsulates the data for the dwc_otg PCD.
+ */
+struct dwc_pcd {
+	/* USB gadget */
+	struct usb_gadget gadget;
+	/* USB gadget driver pointer*/
+	struct usb_gadget_driver *driver;
+	/* The DWC otg device pointer. */
+	struct dwc_otg_device *otg_dev;
+
+	/* State of EP0 */
+	enum ep0_state ep0state;
+	/* EP0 Request is pending */
+	unsigned ep0_pending:1;
+	/* Indicates when SET CONFIGURATION Request is in process */
+	unsigned request_config:1;
+	/* The state of the Remote Wakeup Enable. */
+	unsigned remote_wakeup_enable:1;
+	/* The state of the B-Device HNP Enable. */
+	unsigned b_hnp_enable:1;
+	/* The state of A-Device HNP Support. */
+	unsigned a_hnp_support:1;
+	/* The state of the A-Device Alt HNP support. */
+	unsigned a_alt_hnp_support:1;
+	/* Count of pending Requests */
+	unsigned request_pending;
+
+	/*
+	 * SETUP packet for EP0.  This structure is allocated as a DMA buffer on
+	 * PCD initialization with enough space for up to 3 setup packets.
+	 */
+	union {
+		struct usb_ctrlrequest req;
+		u32 d32[2];
+	} *setup_pkt;
+
+	struct dma_pool *dwc_pool;
+	dma_addr_t setup_pkt_dma_handle;
+
+	/* 2-byte dma buffer used to return status from GET_STATUS */
+	u16 *status_buf;
+	dma_addr_t status_buf_dma_handle;
+
+	/* Array of EPs. */
+	struct pcd_ep ep0;
+	/* Array of IN EPs. */
+	struct pcd_ep in_ep[MAX_EPS_CHANNELS - 1];
+	/* Array of OUT EPs. */
+	struct pcd_ep out_ep[MAX_EPS_CHANNELS - 1];
+	spinlock_t lock;
+	/*
+	 *  Timer for SRP.  If it expires before SRP is successful clear the
+	 *  SRP.
+	 */
+	struct timer_list srp_timer;
+
+	/*
+	 * Tasklet to defer starting of TEST mode transmissions until Status
+	 * Phase has been completed.
+	 */
+	struct tasklet_struct test_mode_tasklet;
+
+	/*  Tasklet to delay starting of xfer in DMA mode */
+	struct tasklet_struct *start_xfer_tasklet;
+
+	/* The test mode to enter when the tasklet is executed. */
+	unsigned test_mode;
+};
+
+/*
+ * This structure holds the state of the HCD, including the non-periodic and
+ * periodic schedules.
+ */
+struct dwc_hcd {
+	spinlock_t lock;
+
+	/* DWC OTG Core Interface Layer */
+	struct core_if *core_if;
+
+	/* Internal DWC HCD Flags */
+	union dwc_otg_hcd_internal_flags {
+		u32 d32;
+		struct {
+			unsigned port_connect_status_change:1;
+			unsigned port_connect_status:1;
+			unsigned port_reset_change:1;
+			unsigned port_enable_change:1;
+			unsigned port_suspend_change:1;
+			unsigned port_over_current_change:1;
+			unsigned reserved:27;
+		} b;
+	} flags;
+
+	/*
+	 * Inactive items in the non-periodic schedule. This is a list of
+	 * Queue Heads. Transfers associated with these Queue Heads are not
+	 * currently assigned to a host channel.
+	 */
+	struct list_head non_periodic_sched_inactive;
+
+	/*
+	 * Deferred items in the non-periodic schedule. This is a list of
+	 * Queue Heads. Transfers associated with these Queue Heads are not
+	 * currently assigned to a host channel.
+	 * When we get an NAK, the QH goes here.
+	 */
+	struct list_head non_periodic_sched_deferred;
+
+	/*
+	 * Active items in the non-periodic schedule. This is a list of
+	 * Queue Heads. Transfers associated with these Queue Heads are
+	 * currently assigned to a host channel.
+	 */
+	struct list_head non_periodic_sched_active;
+
+	/*
+	 * Pointer to the next Queue Head to process in the active
+	 * non-periodic schedule.
+	 */
+	struct list_head *non_periodic_qh_ptr;
+
+	/*
+	 * Inactive items in the periodic schedule. This is a list of QHs for
+	 * periodic transfers that are _not_ scheduled for the next frame.
+	 * Each QH in the list has an interval counter that determines when it
+	 * needs to be scheduled for execution. This scheduling mechanism
+	 * allows only a simple calculation for periodic bandwidth used (i.e.
+	 * must assume that all periodic transfers may need to execute in the
+	 * same frame). However, it greatly simplifies scheduling and should
+	 * be sufficient for the vast majority of OTG hosts, which need to
+	 * connect to a small number of peripherals at one time.
+	 *
+	 * Items move from this list to periodic_sched_ready when the QH
+	 * interval counter is 0 at SOF.
+	 */
+	struct list_head periodic_sched_inactive;
+
+	/*
+	 * List of periodic QHs that are ready for execution in the next
+	 * frame, but have not yet been assigned to host channels.
+	 *
+	 * Items move from this list to periodic_sched_assigned as host
+	 * channels become available during the current frame.
+	 */
+	struct list_head periodic_sched_ready;
+
+	/*
+	 * List of periodic QHs to be executed in the next frame that are
+	 * assigned to host channels.
+	 *
+	 * Items move from this list to periodic_sched_queued as the
+	 * transactions for the QH are queued to the DWC_otg controller.
+	 */
+	struct list_head periodic_sched_assigned;
+
+	/*
+	 * List of periodic QHs that have been queued for execution.
+	 *
+	 * Items move from this list to either periodic_sched_inactive or
+	 * periodic_sched_ready when the channel associated with the transfer
+	 * is released. If the interval for the QH is 1, the item moves to
+	 * periodic_sched_ready because it must be rescheduled for the next
+	 * frame. Otherwise, the item moves to periodic_sched_inactive.
+	 */
+	struct list_head periodic_sched_queued;
+
+	/*
+	 * Total bandwidth claimed so far for periodic transfers. This value
+	 * is in microseconds per (micro)frame. The assumption is that all
+	 * periodic transfers may occur in the same (micro)frame.
+	 */
+	u16 periodic_usecs;
+
+	/*
+	 * Total bandwidth claimed so far for all periodic transfers
+	 * in a frame.
+	 * This will include a mixture of HS and FS transfers.
+	 * Units are microseconds per (micro)frame.
+	 * We have a budget per frame and have to schedule
+	 * transactions accordingly.
+	 * Watch out for the fact that things are actually scheduled for the
+	 * "next frame".
+	 */
+	u16 frame_usecs[8];
+
+	/*
+	 * Frame number read from the core at SOF. The value ranges from 0 to
+	 * DWC_HFNUM_MAX_FRNUM.
+	 */
+	u16 frame_number;
+
+	/*
+	 * Free host channels in the controller. This is a list of
+	 * struct dwc_hc items.
+	 */
+	struct list_head free_hc_list;
+
+	/*
+	 * Number of available host channels.
+	 */
+	u32 available_host_channels;
+
+	/*
+	 * Array of pointers to the host channel descriptors. Allows accessing
+	 * a host channel descriptor given the host channel number. This is
+	 * useful in interrupt handlers.
+	 */
+	struct dwc_hc *hc_ptr_array[MAX_EPS_CHANNELS];
+
+	/*
+	 * Buffer to use for any data received during the status phase of a
+	 * control transfer. Normally no data is transferred during the status
+	 * phase. This buffer is used as a bit bucket.
+	 */
+	u8 *status_buf;
+
+	/*
+	 * DMA address for status_buf.
+	 */
+	dma_addr_t status_buf_dma;
+#define DWC_OTG_HCD_STATUS_BUF_SIZE		64
+
+	/*
+	 * Structure to allow starting the HCD in a non-interrupt context
+	 * during an OTG role change.
+	 */
+	struct work_struct start_work;
+	struct usb_hcd *_p;
+
+	/*
+	 * Connection timer. An OTG host must display a message if the device
+	 * does not connect. Started when the VBus power is turned on via
+	 * sysfs attribute "buspower".
+	 */
+	struct timer_list conn_timer;
+
+	/* workqueue for port wakeup */
+	struct work_struct usb_port_reset;
+};
+
+/*
+ * Reasons for halting a host channel.
+ */
+enum dwc_halt_status {
+	DWC_OTG_HC_XFER_NO_HALT_STATUS,
+	DWC_OTG_HC_XFER_COMPLETE,
+	DWC_OTG_HC_XFER_URB_COMPLETE,
+	DWC_OTG_HC_XFER_ACK,
+	DWC_OTG_HC_XFER_NAK,
+	DWC_OTG_HC_XFER_NYET,
+	DWC_OTG_HC_XFER_STALL,
+	DWC_OTG_HC_XFER_XACT_ERR,
+	DWC_OTG_HC_XFER_FRAME_OVERRUN,
+	DWC_OTG_HC_XFER_BABBLE_ERR,
+	DWC_OTG_HC_XFER_DATA_TOGGLE_ERR,
+	DWC_OTG_HC_XFER_AHB_ERR,
+	DWC_OTG_HC_XFER_PERIODIC_INCOMPLETE,
+	DWC_OTG_HC_XFER_URB_DEQUEUE
+};
+
+/*
+ * Host channel descriptor. This structure represents the state of a single
+ * host channel when acting in host mode. It contains the data items needed to
+ * transfer packets to an endpoint via a host channel.
+ */
+struct dwc_hc {
+	/* Host channel number used for register address lookup */
+	u8 hc_num;
+
+	/* Device to access */
+	unsigned dev_addr:7;
+
+	/* EP to access */
+	unsigned ep_num:4;
+
+	/* EP direction. 0: OUT, 1: IN */
+	unsigned ep_is_in:1;
+
+	/*
+	 * EP speed.
+	 * One of the following values:
+	 *	- DWC_OTG_EP_SPEED_LOW
+	 *	- DWC_OTG_EP_SPEED_FULL
+	 *	- DWC_OTG_EP_SPEED_HIGH
+	 */
+	unsigned speed:2;
+#define DWC_OTG_EP_SPEED_LOW		0
+#define DWC_OTG_EP_SPEED_FULL		1
+#define DWC_OTG_EP_SPEED_HIGH		2
+
+	/*
+	 * Endpoint type.
+	 * One of the following values:
+	 *	- DWC_OTG_EP_TYPE_CONTROL: 0
+	 *	- DWC_OTG_EP_TYPE_ISOC: 1
+	 *	- DWC_OTG_EP_TYPE_BULK: 2
+	 *	- DWC_OTG_EP_TYPE_INTR: 3
+	 */
+	unsigned ep_type:2;
+
+	/* Max packet size in bytes */
+	unsigned max_packet:11;
+
+	/*
+	 * PID for initial transaction.
+	 * 0: DATA0,
+	 * 1: DATA2,
+	 * 2: DATA1,
+	 * 3: MDATA (non-Control EP),
+	 *	SETUP (Control EP)
+	 */
+	unsigned data_pid_start:2;
+#define DWC_OTG_HC_PID_DATA0		0
+#define DWC_OTG_HC_PID_DATA2		1
+#define DWC_OTG_HC_PID_DATA1		2
+#define DWC_OTG_HC_PID_MDATA		3
+#define DWC_OTG_HC_PID_SETUP		3
+
+	/* Number of periodic transactions per (micro)frame */
+	unsigned multi_count:2;
+
+	/* Pointer to the current transfer buffer position. */
+	u8 *xfer_buff;
+	/* Total number of bytes to transfer. */
+	u32 xfer_len;
+	/* Number of bytes transferred so far. */
+	u32 xfer_count;
+	/* Packet count at start of transfer.*/
+	u16 start_pkt_count;
+
+	/*
+	 * Flag to indicate whether the transfer has been started. Set to 1 if
+	 * it has been started, 0 otherwise.
+	 */
+	u8 xfer_started;
+
+	/*
+	 * Set to 1 to indicate that a PING request should be issued on this
+	 * channel. If 0, process normally.
+	 */
+	u8 do_ping;
+
+	/*
+	 * Set to 1 to indicate that the error count for this transaction is
+	 * non-zero. Set to 0 if the error count is 0.
+	 */
+	u8 error_state;
+
+	/*
+	 * Set to 1 to indicate that this channel should be halted the next
+	 * time a request is queued for the channel. This is necessary in
+	 * slave mode if no request queue space is available when an attempt
+	 * is made to halt the channel.
+	 */
+	u8 halt_on_queue;
+
+	/*
+	 * Set to 1 if the host channel has been halted, but the core is not
+	 * finished flushing queued requests. Otherwise 0.
+	 */
+	u8 halt_pending;
+
+	/* Reason for halting the host channel. */
+	enum dwc_halt_status	halt_status;
+
+	/*  Split settings for the host channel	*/
+	u8 do_split;		/* Enable split for the channel */
+	u8 complete_split;		/* Enable complete split */
+	u8 hub_addr;		/* Address of high speed hub */
+	u8 port_addr;		/* Port of the low/full speed device */
+
+	/*
+	 * Split transaction position. One of the following values:
+	 *	- DWC_HCSPLIT_XACTPOS_MID
+	 *	- DWC_HCSPLIT_XACTPOS_BEGIN
+	 *	- DWC_HCSPLIT_XACTPOS_END
+	 *	- DWC_HCSPLIT_XACTPOS_ALL */
+	u8 xact_pos;
+
+	/* Set when the host channel does a short read. */
+	u8 short_read;
+
+	/*
+	 * Number of requests issued for this channel since it was assigned to
+	 * the current transfer (not counting PINGs).
+	 */
+	u8 requests;
+
+	/* Queue Head for the transfer being processed by this channel.	*/
+	struct dwc_qh *qh;
+
+	/* Entry in list of host channels. */
+	struct list_head	hc_list_entry;
+};
+
+/*
+ * The following parameters may be specified when starting the module. These
+ * parameters define how the DWC_otg controller should be configured.  Parameter
+ * values are passed to the CIL initialization function dwc_otg_cil_init.
+ */
+struct core_params {
+	int opt;
+#define dwc_param_opt_default				1
+
+	/*
+	 * Specifies the OTG capabilities. The driver will automatically
+	 * detect the value for this parameter if none is specified.
+	 * 0 - HNP and SRP capable (default)
+	 * 1 - SRP Only capable
+	 * 2 - No HNP/SRP capable
+	 */
+	int otg_cap;
+#define DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE		0
+#define DWC_OTG_CAP_PARAM_SRP_ONLY_CAPABLE		1
+#define DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE		2
+
+#define dwc_param_otg_cap_default	DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE
+
+	/*
+	 * Specifies whether to use slave or DMA mode for accessing the data
+	 * FIFOs. The driver will automatically detect the value for this
+	 * parameter if none is specified.
+	 * 0 - Slave
+	 * 1 - DMA (default, if available)
+	 */
+	int dma_enable;
+#define dwc_param_dma_enable_default			1
+
+	/*
+	 * The DMA Burst size (applicable only for External DMA	Mode).
+	 * 1, 4, 8 16, 32, 64, 128, 256 (default 32)
+	 */
+	int dma_burst_size;		/* Translate this to GAHBCFG values */
+#define dwc_param_dma_burst_size_default		32
+
+	/*
+	 * Specifies the maximum speed of operation in host and device mode.
+	 * The actual speed depends on the speed of the attached device and
+	 * the value of phy_type. The actual speed depends on the speed of the
+	 * attached device.
+	 *	0 - High Speed (default)
+	 *	1 - Full Speed
+	 */
+	int speed;
+#define dwc_param_speed_default				0
+#define DWC_SPEED_PARAM_HIGH				0
+#define DWC_SPEED_PARAM_FULL				1
+
+	/*
+	 * Specifies whether low power mode is supported when attached to a Full
+	 * Speed or Low Speed device in host mode.
+	 *	0 - Don't support low power mode (default)
+	 *	1 - Support low power mode
+	 */
+	int host_support_fs_ls_low_power;
+#define dwc_param_host_support_fs_ls_low_power_default	0
+
+	/*
+	 * Specifies the PHY clock rate in low power mode when connected to a
+	 * Low Speed device in host mode. This parameter is applicable only if
+	 * HOST_SUPPORT_FS_LS_LOW_POWER is enabled. If PHY_TYPE is set to FS
+	 * then defaults to 6 MHZ otherwise 48 MHZ.
+	 *
+	 *	0 - 48 MHz
+	 *	1 - 6 MHz
+	 */
+	int host_ls_low_power_phy_clk;
+#define dwc_param_host_ls_low_power_phy_clk_default	0
+#define DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_48MHZ	0
+#define DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_6MHZ	1
+
+	/*
+	 * 0 - Use cC FIFO size parameters
+	 * 1 - Allow dynamic FIFO sizing (default)
+	 */
+	int enable_dynamic_fifo;
+#define dwc_param_enable_dynamic_fifo_default		1
+
+	/*
+	 * Total number of 4-byte words in the data FIFO memory. This
+	 * memory includes the Rx FIFO, non-periodic Tx FIFO, and periodic
+	 * Tx FIFOs.  32 to 32768 (default 8192)
+	 *
+	 * Note: The total FIFO memory depth in the FPGA configuration is 8192.
+	 */
+	int data_fifo_size;
+#define dwc_param_data_fifo_size_default		8192
+
+	/*
+	 * Number of 4-byte words in the Rx FIFO in device mode when dynamic
+	 * FIFO sizing is enabled.  16 to 32768 (default 1064)
+	 */
+	int dev_rx_fifo_size;
+#define dwc_param_dev_rx_fifo_size_default		1064
+
+	/*
+	 * Number of 4-byte words in the non-periodic Tx FIFO in device mode
+	 * when dynamic FIFO sizing is enabled.  16 to 32768 (default 1024)
+	 */
+	int dev_nperio_tx_fifo_size;
+#define dwc_param_dev_nperio_tx_fifo_size_default	1024
+
+	/*
+	 * Number of 4-byte words in each of the periodic Tx FIFOs in device
+	 * mode when dynamic FIFO sizing is enabled.  4 to 768 (default 256)
+	 */
+	u32 dev_perio_tx_fifo_size[MAX_PERIO_FIFOS];
+#define dwc_param_dev_perio_tx_fifo_size_default	256
+
+	/*
+	 * Number of 4-byte words in the Rx FIFO in host mode when dynamic
+	 * FIFO sizing is enabled.  16 to 32768 (default 1024)
+	 */
+	int host_rx_fifo_size;
+#define dwc_param_host_rx_fifo_size_default		1024
+
+	/*
+	 * Number of 4-byte words in the non-periodic Tx FIFO in host mode
+	 * when Dynamic FIFO sizing is enabled in the core.  16 to 32768
+	 * (default 1024)
+	 */
+	int host_nperio_tx_fifo_size;
+#define dwc_param_host_nperio_tx_fifo_size_default	1024
+
+	/*
+	   Number of 4-byte words in the host periodic Tx FIFO when dynamic
+	 * FIFO sizing is enabled.  16 to 32768 (default 1024)
+	 */
+	int host_perio_tx_fifo_size;
+#define dwc_param_host_perio_tx_fifo_size_default	1024
+
+	/*
+	 * The maximum transfer size supported in bytes. 2047 to 65,535
+	 * (default 65,535)
+	 */
+	int max_transfer_size;
+#define dwc_param_max_transfer_size_default		65535
+
+	/*
+	 * The maximum number of packets in a transfer. 15 to 511  (default 511)
+	 */
+	int max_packet_count;
+#define dwc_param_max_packet_count_default		511
+
+	/*
+	 * The number of host channel registers to use.
+	 * 1 to 16 (default 12)
+	 * Note: The FPGA configuration supports a maximum of 12 host channels.
+	 */
+	int host_channels;
+#define dwc_param_host_channels_default			12
+
+	/*
+	 * The number of endpoints in addition to EP0 available for device
+	 * mode operations.
+	 * 1 to 15 (default 6 IN and OUT)
+	 * Note: The FPGA configuration supports a maximum of 6 IN and OUT
+	 * endpoints in addition to EP0.
+	 */
+	int dev_endpoints;
+#define dwc_param_dev_endpoints_default			6
+
+	/*
+	 * Specifies the type of PHY interface to use. By default, the driver
+	 * will automatically detect the phy_type.
+	 *
+	 *	0 - Full Speed PHY
+	 *	1 - UTMI+ (default)
+	 *	2 - ULPI
+	 */
+	int phy_type;
+#define DWC_PHY_TYPE_PARAM_FS			0
+#define DWC_PHY_TYPE_PARAM_UTMI			1
+#define DWC_PHY_TYPE_PARAM_ULPI			2
+#define dwc_param_phy_type_default		DWC_PHY_TYPE_PARAM_UTMI
+
+	/*
+	 * Specifies the UTMI+ Data Width.  This parameter is applicable for a
+	 * PHY_TYPE of UTMI+ or ULPI. (For a ULPI PHY_TYPE, this parameter
+	 * indicates the data width between the MAC and the ULPI Wrapper.) Also,
+	 * this parameter is applicable only if the OTG_HSPHY_WIDTH cC parameter
+	 * was set to "8 and 16 bits", meaning that the core has been configured
+	 * to work at either data path width.
+	 *
+	 * 8 or 16 bits (default 16)
+	 */
+	int phy_utmi_width;
+#define dwc_param_phy_utmi_width_default	16
+
+	/*
+	 * Specifies whether the ULPI operates at double or single
+	 * data rate. This parameter is only applicable if PHY_TYPE is
+	 * ULPI.
+	 *
+	 *	0 - single data rate ULPI interface with 8 bit wide data
+	 *		bus (default)
+	 *	1 - double data rate ULPI interface with 4 bit wide data
+	 *		bus
+	 */
+	int phy_ulpi_ddr;
+#define dwc_param_phy_ulpi_ddr_default		0
+
+	/*
+	 * Specifies whether to use the internal or external supply to
+	 * drive the vbus with a ULPI phy.
+	 */
+	int phy_ulpi_ext_vbus;
+#define DWC_PHY_ULPI_INTERNAL_VBUS		0
+#define DWC_PHY_ULPI_EXTERNAL_VBUS		1
+#define dwc_param_phy_ulpi_ext_vbus_default	DWC_PHY_ULPI_INTERNAL_VBUS
+
+	/*
+	 * Specifies whether to use the I2Cinterface for full speed PHY. This
+	 * parameter is only applicable if PHY_TYPE is FS.
+	 *	0 - No (default)
+	 *	1 - Yes
+	 */
+	int i2c_enable;
+#define dwc_param_i2c_enable_default		0
+
+	int ulpi_fs_ls;
+#define dwc_param_ulpi_fs_ls_default		0
+
+	int ts_dline;
+#define dwc_param_ts_dline_default		0
+
+	/*
+	 * Specifies whether dedicated transmit FIFOs are enabled for non
+	 * periodic IN endpoints in device mode
+	 *	0 - No
+	 *	1 - Yes
+	 */
+	 int en_multiple_tx_fifo;
+#define dwc_param_en_multiple_tx_fifo_default	1
+
+	/*
+	 * Number of 4-byte words in each of the Tx FIFOs in device
+	 * mode when dynamic FIFO sizing is enabled. 4 to 768 (default 256)
+	 */
+	u32 dev_tx_fifo_size[MAX_TX_FIFOS];
+#define dwc_param_dev_tx_fifo_size_default	256
+
+	/*
+	 * Thresholding enable flag
+	 *	bit 0 - enable non-ISO Tx thresholding
+	 *	bit 1 - enable ISO Tx thresholding
+	 *	bit 2 - enable Rx thresholding
+	 */
+	u32 thr_ctl;
+#define dwc_param_thr_ctl_default		0
+
+	/* Thresholding length for Tx FIFOs in 32 bit DWORDs */
+	u32 tx_thr_length;
+#define dwc_param_tx_thr_length_default		64
+
+	/* Thresholding length for Rx FIFOs in 32 bit DWORDs */
+	u32 rx_thr_length;
+#define dwc_param_rx_thr_length_default		64
+
+};
+
+/*
+ * The core_if structure contains information needed to manage the
+ * DWC_otg controller acting in either host or device mode. It represents the
+ * programming view of the controller as a whole.
+ */
+struct core_if {
+	/* Parameters that define how the core should be configured.*/
+	struct core_params *core_params;
+
+	/* Core Global registers starting at offset 000h. */
+	struct core_global_regs *core_global_regs;
+
+	/* Device-specific information */
+	struct device_if *dev_if;
+	/* Host-specific information */
+	struct dwc_host_if *host_if;
+
+	/*
+	 * Set to 1 if the core PHY interface bits in USBCFG have been
+	 * initialized.
+	 */
+	u8 phy_init_done;
+
+	/*
+	 * SRP Success flag, set by srp success interrupt in FS I2C mode
+	 */
+	u8 srp_success;
+	u8 srp_timer_started;
+
+	/* Common configuration information */
+	/* Power and Clock Gating Control Register */
+	u32 *pcgcctl;
+#define DWC_OTG_PCGCCTL_OFFSET			0xE00
+
+	/* Push/pop addresses for endpoints or host channels.*/
+	u32 *data_fifo[MAX_EPS_CHANNELS];
+#define DWC_OTG_DATA_FIFO_OFFSET		0x1000
+#define DWC_OTG_DATA_FIFO_SIZE			0x1000
+
+	/* Total RAM for FIFOs (Bytes) */
+	u16 total_fifo_size;
+	/* Size of Rx FIFO (Bytes) */
+	u16 rx_fifo_size;
+	/* Size of Non-periodic Tx FIFO (Bytes) */
+	u16 nperio_tx_fifo_size;
+
+	/* 1 if DMA is enabled, 0 otherwise. */
+	u8 dma_enable;
+
+	/* 1 if dedicated Tx FIFOs are enabled, 0 otherwise. */
+	u8 en_multiple_tx_fifo;
+
+	/*
+	 *  Set to 1 if multiple packets of a high-bandwidth transfer is in
+	 * process of being queued
+	 */
+	u8 queuing_high_bandwidth;
+
+	/* Hardware Configuration -- stored here for convenience.*/
+	union hwcfg1_data hwcfg1;
+	union hwcfg2_data hwcfg2;
+	union hwcfg3_data hwcfg3;
+	union hwcfg4_data hwcfg4;
+
+	/*
+	 * The operational State, during transations (a_host>>a_peripherial and
+	 * b_device=>b_host) this may not match the core but allows the software
+	 * to determine transitions.
+	 */
+	u8 op_state;
+
+	/*
+	 * Set to 1 if the HCD needs to be restarted on a session request
+	 * interrupt. This is required if no connector ID status change has
+	 * occurred since the HCD was last disconnected.
+	 */
+	u8 restart_hcd_on_session_req;
+
+	/* HCD callbacks */
+	/* A-Device is a_host */
+#define A_HOST		(1)
+	/* A-Device is a_suspend */
+#define A_SUSPEND	(2)
+	/* A-Device is a_peripherial */
+#define A_PERIPHERAL	(3)
+	/* B-Device is operating as a Peripheral. */
+#define B_PERIPHERAL	(4)
+	/* B-Device is operating as a Host. */
+#define B_HOST		(5)
+
+	/* HCD callbacks */
+	struct cil_callbacks *hcd_cb;
+	/* PCD callbacks */
+	struct cil_callbacks *pcd_cb;
+
+	/* Device mode Periodic Tx FIFO Mask */
+	u32 p_tx_msk;
+	/* Device mode Periodic Tx FIFO Mask */
+	u32 tx_msk;
+
+	/* Features of various DWC implementation */
+	u32 features;
+
+	/* Added to support PLB DMA : phys-virt mapping */
+	resource_size_t phys_addr;
+
+	struct delayed_work usb_port_wakeup;
+	struct work_struct usb_port_otg;
+};
+
+/*
+ * The following functions support initialization of the CIL driver component
+ * and the DWC_otg controller.
+ */
+extern void dwc_otg_core_init(struct core_if *core_if);
+extern void init_fslspclksel(struct core_if *core_if);
+extern void dwc_otg_core_dev_init(struct core_if *core_if);
+extern void dwc_otg_enable_global_interrupts(struct core_if *core_if);
+extern void dwc_otg_enable_common_interrupts(struct core_if *core_if);
+
+/**
+ * This function Reads HPRT0 in preparation to modify.  It keeps the WC bits 0
+ * so that if they are read as 1, they won't clear when you write it back
+ */
+static inline u32 dwc_otg_read_hprt0(struct core_if *core_if)
+{
+	union hprt0_data hprt0;
+	hprt0.d32 = dwc_read_reg32(core_if->host_if->hprt0);
+	hprt0.b.prtena = 0;
+	hprt0.b.prtconndet = 0;
+	hprt0.b.prtenchng = 0;
+	hprt0.b.prtovrcurrchng = 0;
+	return hprt0.d32;
+}
+
+/*
+ * The following functions support managing the DWC_otg controller in either
+ * device or host mode.
+ */
+extern void dwc_otg_read_packet(struct core_if *core_if, u8 *dest,
+		u16 bytes);
+extern void dwc_otg_flush_tx_fifo(struct core_if *core_if, const int _num);
+extern void dwc_otg_flush_rx_fifo(struct core_if *core_if);
+
+#define NP_TXFIFO_EMPTY				-1
+#define MAX_NP_TXREQUEST_Q_SLOTS		8
+
+/**
+ * This function returns the Core Interrupt register.
+ */
+static inline u32 dwc_otg_read_core_intr(struct core_if *core_if)
+{
+	return dwc_read_reg32(&core_if->core_global_regs->gintsts) &
+		dwc_read_reg32(&core_if->core_global_regs->gintmsk);
+}
+
+/**
+ * This function returns the mode of the operation, host or device.
+ */
+static inline u32 dwc_otg_mode(struct core_if *core_if)
+{
+	return dwc_read_reg32(&core_if->core_global_regs->gintsts) & 0x1;
+}
+
+static inline u8 dwc_otg_is_device_mode(struct core_if *core_if)
+{
+	return dwc_otg_mode(core_if) != DWC_HOST_MODE;
+}
+static inline u8 dwc_otg_is_host_mode(struct core_if *core_if)
+{
+	return dwc_otg_mode(core_if) == DWC_HOST_MODE;
+}
+
+extern int dwc_otg_handle_common_intr(struct core_if *core_if);
+
+/*
+ * DWC_otg CIL callback structure.  This structure allows the HCD and PCD to
+ * register functions used for starting and stopping the PCD and HCD for role
+ * change on for a DRD.
+ */
+struct cil_callbacks {
+	/* Start function for role change */
+	int (*start) (void *_p);
+	/* Stop Function for role change */
+	int (*stop) (void *_p);
+	/* Disconnect Function for role change */
+	int (*disconnect) (void *_p);
+	/* Resume/Remote wakeup Function */
+	int (*resume_wakeup) (void *_p);
+	/* Suspend function */
+	int (*suspend) (void *_p);
+	/* Session Start (SRP) */
+	int (*session_start) (void *_p);
+	/* Pointer passed to start() and stop() */
+	void *p;
+};
+
+extern void dwc_otg_cil_register_pcd_callbacks(struct core_if *core_if,
+			struct cil_callbacks *cb, void *p);
+extern void dwc_otg_cil_register_hcd_callbacks(struct core_if *core_if,
+			struct cil_callbacks *cb, void *p);
+
+#define DWC_LIMITED_XFER		0x00000000
+#define DWC_DEVICE_ONLY			0x00000000
+#define DWC_HOST_ONLY			0x00000000
+
+#ifdef CONFIG_DWC_LIMITED_XFER_SIZE
+#undef DWC_LIMITED_XFER
+#define DWC_LIMITED_XFER		0x00000001
+#endif
+
+#ifdef CONFIG_DWC_DEVICE_ONLY
+#undef DWC_DEVICE_ONLY
+#define DWC_DEVICE_ONLY			0x00000002
+static inline void dwc_otg_hcd_remove(struct device *dev)
+{
+}
+static inline int dwc_otg_hcd_init(struct device *_dev,
+			struct dwc_otg_device *dwc_dev)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_DWC_HOST_ONLY
+#undef DWC_HOST_ONLY
+#define DWC_HOST_ONLY			0x00000004
+static inline void dwc_otg_pcd_remove(struct device *dev)
+{
+}
+static inline int dwc_otg_pcd_init(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+
+static inline void dwc_set_feature(struct core_if *core_if)
+{
+	core_if->features = DWC_LIMITED_XFER | DWC_DEVICE_ONLY | DWC_HOST_ONLY;
+}
+
+static inline int dwc_has_feature(struct core_if *core_if,
+		unsigned long feature)
+{
+	return core_if->features & feature;
+}
+#endif
-- 
1.7.1
