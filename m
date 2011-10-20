Return-Path: <pratyush.anand@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0AD2BB70C0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 21:12:50 +1100 (EST)
Received: by yxi13 with SMTP id 13so2619802yxi.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 03:12:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1318630151-14394-1-git-send-email-tmarri@apm.com>
References: <1318630151-14394-1-git-send-email-tmarri@apm.com>
Date: Thu, 20 Oct 2011 15:42:46 +0530
Message-ID: <CAHM4w1naqQQGS7303-e3uK=rSfYDNCgz0G_ODrOeJP4AHR6beg@mail.gmail.com>
Subject: Re: [PATCH v15 08/10] USB ppc4xx: Add Synopsys DWC OTG PCD interrupt
 function
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

On Sat, Oct 15, 2011 at 3:39 AM,  <tmarri@apm.com> wrote:
> From: Tirumala Marri <tmarri@apm.com>
>

[...]

> +static int write_empty_tx_fifo(struct dwc_pcd *pcd, u32 epnum)
> +{
> +       struct core_if *core_if = GET_CORE_IF(pcd);
> +       ulong regs;
> +       u32 txstatus = 0;
> +       struct pcd_ep *ep;
> +       u32 len;
> +       int dwords;
> +       u32 diepint = 0;
> +
> +       ep = get_in_ep(pcd, epnum);
> +       regs = core_if->dev_if->in_ep_regs[epnum];
> +       txstatus = dwc_reg_read(regs, DWC_DTXFSTS);
> +
> +       /*
> +        * While there is space in the queue, space in the FIFO and data to
> +        * tranfer, write packets to the Tx FIFO
> +        */
> +       len = ep->dwc_ep.xfer_len - ep->dwc_ep.xfer_count;
> +       dwords = count_dwords(ep, len);
> +       while (DWC_DTXFSTS_TXFSSPC_AVAI_RD(txstatus) > dwords

If you use a >= here, it will be more efficient.
Other wise even if you have 512 bytes spece remaining in TXFIFO, you will not be
able to send a 512 byte packet.

> +              && ep->dwc_ep.xfer_count < ep->dwc_ep.xfer_len
> +              && ep->dwc_ep.xfer_len != 0) {
> +               dwc_otg_ep_write_packet(core_if, &ep->dwc_ep, 0);
> +               len = ep->dwc_ep.xfer_len - ep->dwc_ep.xfer_count;
> +               dwords = count_dwords(ep, len);
> +               txstatus = dwc_reg_read(regs, DWC_DTXFSTS);
> +       }
> +       /* Clear emptyintr */
> +       diepint = DWC_DIEPINT_TXFIFO_EMPTY_RW(diepint, 1);
> +       dwc_reg_write(in_ep_int_reg(pcd, epnum), 0, diepint);
> +       return 1;
> +}

[...]

> +/**
> + * Clear the EP halt (STALL) and if pending requests start the
> + * transfer.
> + */
> +static void pcd_clear_halt(struct dwc_pcd *pcd, struct pcd_ep *ep)
> +{
> +       struct core_if *core_if = GET_CORE_IF(pcd);
> +
> +       if (!ep->dwc_ep.stall_clear_flag)
> +               dwc_otg_ep_clear_stall(core_if, &ep->dwc_ep);
> +
> +       /* Reactive the EP */
> +       dwc_otg_ep_activate(core_if, &ep->dwc_ep);
> +
> +       if (ep->stopped) {
> +               ep->stopped = 0;
> +               /* If there is a request in the EP queue start it */
> +
> +               /*
> +                * dwc_start_next_request(), outside of interpt contxt at some
> +                * time after the current time, after a clear-halt setup packet.
> +                * Still need to implement ep mismatch in the future if a gadget
> +                * ever uses more than one endpoint at once
> +                */
> +               if (core_if->dma_enable) {
> +                       ep->queue_sof = 1;
> +                       tasklet_schedule(pcd->start_xfer_tasklet);
> +               } else {
> +                       /*
> +                        * Added-sr: 2007-07-26
> +                        *
> +                        * To re-enable this endpoint it's important to
> +                        * set this next_ep number. Otherwise the endpoint
> +                        * will not get active again after stalling.
> +                        */
> +                       if (dwc_has_feature(core_if, DWC_LIMITED_XFER))
> +                               dwc_start_next_request(ep);

Should next request be not started for all the cases?

> +               }
> +       }
> +
> +       /* Start Control Status Phase */
> +       do_setup_in_status_phase(pcd);
> +}
> +

Regards
Pratyush
