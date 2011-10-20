Return-Path: <pratyush.anand@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AD04DB6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 20:12:06 +1100 (EST)
Received: by ggnk1 with SMTP id k1so2756348ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 02:12:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1317954637-11802-1-git-send-email-tmarri@apm.com>
References: <1317954637-11802-1-git-send-email-tmarri@apm.com>
Date: Thu, 20 Oct 2011 14:42:02 +0530
Message-ID: <CAHM4w1=OiZA4S4TBE_Hgx3yBptcWdtLu2iQiy17wb2=NaSjwZw@mail.gmail.com>
Subject: Re: [PATCH v14 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core Interface
 Layer (CIL)
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

On Fri, Oct 7, 2011 at 8:00 AM,  <tmarri@apm.com> wrote:
> From: Tirumala Marri <tmarri@apm.com>
>

[...]

> + * Do core a soft reset of the core.  Be careful with this because it
> + * resets all the internal state machines of the core.
> + */
> +static void dwc_otg_core_reset(struct core_if *core_if)
> +{
> +       ulong global_regs = core_if->core_global_regs;
> +       u32 greset = 0;
> +       int count = 0;
> +
> +       /* Wait for AHB master IDLE state. */
> +       do {
> +               udelay(10);
> +               greset = dwc_reg_read(global_regs, DWC_GRSTCTL);
> +               if (++count > 100000) {
> +                       pr_warning("%s() HANG! AHB Idle GRSTCTL=%0x\n",
> +                                  __func__, greset);
> +                       return;
> +               }
> +       } while (greset & DWC_RSTCTL_AHB_IDLE);

As per sepcs:
Bit 31:  AHB Master Idle (AHBIdle): Indicates that the AHB Master State
Machine is in the IDLE condition.
So when this bit is 1 , AHB would be idle. So, what do you want here?
If AHB is idle, control wil return from above loop rather going ahead to execute
this function.

> +
> +       /* Core Soft Reset */
> +       count = 0;
> +       greset |= DWC_RSTCTL_SFT_RST;

[...]

> +       /* Rx FIFO */
> +       dwc_reg_write(regs, DWC_GRXFSIZ, params->dev_rx_fifo_size);
> +
> +       /* Set Periodic and Non-periodic Tx FIFO Mask bits to all 0 */
> +       core_if->p_tx_msk = 0;
> +       core_if->tx_msk = 0;
> +
> +       if (core_if->en_multiple_tx_fifo == 0) {
> +               /* Non-periodic Tx FIFO */
> +               nptxsize = DWC_RX_FIFO_DEPTH_WR(nptxsize,
> +                                               params->
> +                                               dev_nperio_tx_fifo_size);

So, if you will follow the commnet of patch 01 then , here two you will have to
rename as TX_FIFO.
Also, at all other occurances.

> +               nptxsize =
> +                   DWC_RX_FIFO_START_ADDR_WR(nptxsize,
> +                                             params->dev_rx_fifo_size);
> +               dwc_reg_write(regs, DWC_GNPTXFSIZ, nptxsize);
> +
> +               ptxsize = DWC_RX_FIFO_START_ADDR_WR(ptxsize,
> +                                                   (DWC_RX_FIFO_START_ADDR_RD
> +                                                    (nptxsize) +
> +                                                    DWC_RX_FIFO_DEPTH_RD
> +                                                    (nptxsize)));
> +               for (i = 0;
> +                    i < DWC_HWCFG4_NUM_DEV_PERIO_IN_EP_RD(core_if->hwcfg4);
> +                    i++) {


Reading hwcfg4 will give you maximum nuber of fifos provided by hardware.
But, a particular application (platform) may not need all those fifo. Since, you
have a vriable fifo_num in your param list, so why not use that?

> +                       ptxsize =
> +                           DWC_RX_FIFO_DEPTH_WR(ptxsize,
> +                                                params->
> +                                                dev_perio_tx_fifo_size[i]);
> +                       dwc_reg_write(regs, DWC_DPTX_FSIZ_DIPTXF(i), ptxsize);
> +                       ptxsize = DWC_RX_FIFO_START_ADDR_WR(ptxsize,
> +                                                  (DWC_RX_FIFO_START_ADDR_RD
> +                                                   (ptxsize) +
> +                                                   DWC_RX_FIFO_DEPTH_RD
> +                                                   (ptxsize)));
> +               }
> +       } else {
> +               nptxsize = DWC_RX_FIFO_DEPTH_WR(nptxsize,
> +                                               params->
> +                                               dev_nperio_tx_fifo_size);
> +               nptxsize =
> +                   DWC_RX_FIFO_START_ADDR_WR(nptxsize,
> +                                             params->dev_rx_fifo_size);
> +               dwc_reg_write(regs, DWC_GNPTXFSIZ, nptxsize);
> +
> +               txsize = DWC_RX_FIFO_START_ADDR_WR(txsize,
> +                                                  (DWC_RX_FIFO_START_ADDR_RD
> +                                                   (nptxsize) +
> +                                                   DWC_RX_FIFO_DEPTH_RD
> +                                                   (nptxsize)));
> +               for (i = 1;
> +                    i < DWC_HWCFG4_NUM_DEV_PERIO_IN_EP_RD(core_if->hwcfg4);
> +                    i++) {

Same as above

> +                       txsize =
> +                           DWC_RX_FIFO_DEPTH_WR(txsize,
> +                                                params->dev_tx_fifo_size[i]);
> +                       dwc_reg_write(regs, DWC_DPTX_FSIZ_DIPTXF(i - 1), txsize);
> +                       txsize = DWC_RX_FIFO_START_ADDR_WR(txsize,
> +                                                  (DWC_RX_FIFO_START_ADDR_RD
> +                                                   (txsize) +
> +                                                   DWC_RX_FIFO_DEPTH_RD
> +                                                   (txsize)));
> +               }
> +       }
> +}
> +

Regards
Pratyush
