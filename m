Return-Path: <olof@lixom.net>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
 [209.85.216.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9B7441007D1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2011 04:48:04 +1100 (EST)
Received: by qyk31 with SMTP id 31so4313884qyk.17
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2011 10:48:01 -0700 (PDT)
Date: Fri, 21 Oct 2011 10:48:13 -0700
From: Olof Johansson <olof@lixom.net>
To: tmarri@apm.com
Subject: Re: [PATCH v15 04/10] USB/ppc4xx: Add Synopsys DWC OTG HCD function
Message-ID: <20111021174813.GD27652@quad.lixom.net>
References: <1318630133-14264-1-git-send-email-tmarri@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318630133-14264-1-git-send-email-tmarri@apm.com>
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

Some more hit-and-run comments.

On Fri, Oct 14, 2011 at 03:08:53PM -0700, tmarri@apm.com wrote:
> +static int dwc_otg_hcd_disconnect_cb(void *_p)
> +{
> +	u32 intr;
> +	struct dwc_hcd *hcd = hcd_to_dwc_otg_hcd(_p);
> +	struct core_if *core_if = hcd->core_if;
> +
> +	/* Set status flags for the hub driver. */
> +	hcd->flags.b.port_connect_status_change = 1;
> +	hcd->flags.b.port_connect_status = 0;
> +
> +	/*
> +	 * Shutdown any transfers in process by clearing the Tx FIFO Empty
> +	 * interrupt mask and status bits and disabling subsequent host
> +	 * channel interrupts.
> +	 */
> +	intr = 0;
> +	intr |= DWC_INTMSK_NP_TXFIFO_EMPT;
> +	intr |= DWC_INTMSK_P_TXFIFO_EMPTY;
> +	intr |= DWC_INTMSK_HST_CHAN;
> +	spin_lock(&hcd->lock);
> +	dwc_reg_modify(gintmsk_reg(hcd), 0, intr, 0);
> +	dwc_reg_modify(gintsts_reg(hcd), 0, intr, 0);
> +	spin_unlock(&hcd->lock);
> +
> +	del_timers(hcd);
> +
> +	/*
> +	 * Turn off the vbus power only if the core has transitioned to device
> +	 * mode. If still in host mode, need to keep power on to detect a
> +	 * reconnection.
> +	 */
> +	if (dwc_otg_is_device_mode(core_if)) {
> +		if (core_if->xceiv->state != OTG_STATE_A_SUSPEND) {
> +			u32 hprt0 = 0;
> +
> +			pr_info("Disconnect: PortPower off\n");
> +			hprt0 = DWC_HPRT0_PRT_PWR_RW(hprt0, 0);
> +			dwc_reg_write(core_if->host_if->hprt0, 0, hprt0);
> +		}
> +		dwc_otg_disable_host_interrupts(core_if);
> +	}
> +
> +	/* Respond with an error status to all URBs in the schedule. */
> +	kill_all_urbs(hcd);
> +	if (dwc_otg_is_host_mode(core_if)) {
> +		/* Clean up any host channels that were in use. */
> +		int num_channels;
> +		u32 i;
> +		struct dwc_hc *channel;
> +		ulong regs;
> +		u32 hcchar;

If you need these many local variables here, and this much indentation, then
please refactor to a helper function. That will get rid of the crazy
linewrapping below too.

> +
> +		num_channels = core_if->core_params->host_channels;
> +		if (!core_if->dma_enable) {
> +			/* Flush out any channel requests in slave mode. */
> +			for (i = 0; i < num_channels; i++) {
> +				channel = hcd->hc_ptr_array[i];
> +				if (list_empty(&channel->hc_list_entry)) {
> +					regs =
> +					    core_if->host_if->hc_regs[i];
> +					hcchar = dwc_reg_read(regs, DWC_HCCHAR);
> +
> +					if (DWC_HCCHAR_ENA_RD(hcchar)) {
> +						hcchar =
> +						    DWC_HCCHAR_ENA_RW(hcchar,
> +								      0);
> +						hcchar =
> +						    DWC_HCCHAR_DIS_RW(hcchar,
> +								      1);
> +						hcchar =
> +						    DWC_HCCHAR_EPDIR_RW(hcchar,
> +									0);
> +						dwc_reg_write(regs, DWC_HCCHAR,
> +							    hcchar);
> +					}
> +				}
> +			}
> +		}
> +
> +		for (i = 0; i < num_channels; i++) {
> +			channel = hcd->hc_ptr_array[i];
> +			if (list_empty(&channel->hc_list_entry)) {
> +				regs = core_if->host_if->hc_regs[i];
> +				hcchar = dwc_reg_read(regs, DWC_HCCHAR);
> +
> +				if (DWC_HCCHAR_ENA_RD(hcchar)) {
> +					/* Halt the channel. */
> +					hcchar = DWC_HCCHAR_DIS_RW(hcchar, 1);
> +					dwc_reg_write(regs, DWC_HCCHAR, hcchar);
> +				}
> +				dwc_otg_hc_cleanup(core_if, channel);
> +				list_add_tail(&channel->hc_list_entry,
> +					      &hcd->free_hc_list);
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * A disconnect will end the session so the B-Device is no
> +	 * longer a B-host.
> +	 */
> +	((struct usb_hcd *)_p)->self.is_b_host = 0;
> +	return 1;
> +}
> +

-Olof
