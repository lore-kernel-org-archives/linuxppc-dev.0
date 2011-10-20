Return-Path: <pratyush.anand@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 97938B70BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 20:55:59 +1100 (EST)
Received: by yws29 with SMTP id 29so2791878yws.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 02:55:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1318630147-14358-1-git-send-email-tmarri@apm.com>
References: <1318630147-14358-1-git-send-email-tmarri@apm.com>
Date: Thu, 20 Oct 2011 15:25:54 +0530
Message-ID: <CAHM4w1nJ4fLdd217x86jFiXeB7djXKTh6UoCJyN0L_Uet=PWxA@mail.gmail.com>
Subject: Re: [PATCH v15 07/10] USB/ppc4xx: Add Synopsys DWC OTG PCD function
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
> The PCD is responsible for translating requests from the gadget driver
> to appropriate actions on the DWC OTG controller.
>

[...]

> +static int dwc_otg_pcd_ep_disable(struct usb_ep *_ep)
> +{
> +       struct pcd_ep *ep;
> +       struct core_if *core_if;
> +       unsigned long flags;
> +
> +       ep = container_of(_ep, struct pcd_ep, ep);
> +       if (!_ep || !ep->desc)
> +               return -EINVAL;
> +
> +       core_if = ep->pcd->otg_dev->core_if;
> +
> +       spin_lock_irqsave(&ep->pcd->lock, flags);
> +
> +       request_nuke(ep);
> +       dwc_otg_ep_deactivate(core_if, &ep->dwc_ep);
> +
> +       ep->desc = NULL;
> +       ep->stopped = 1;
> +       if (ep->dwc_ep.is_in) {
> +               release_perio_tx_fifo(core_if, ep->dwc_ep.tx_fifo_num);
> +               release_tx_fifo(core_if, ep->dwc_ep.tx_fifo_num);

Is only releasing fifo sufficient?
Will the above procedure insures that EP is disable?
I think not.
To insure that EP is disabled , you need to fllow steps as defines in specs.

Also, Fifo must be flushed completely.

Just a question: Which test have you run to test the driver?

I had tested your v13 with testusb and zero gadget and found that all the IN
test were failing because of this limitation.


> +       }
> +

[...]

> +/**
> + * Set the EP STALL.
> + */
> +void dwc_otg_ep_set_stall(struct core_if *core_if, struct dwc_ep *ep)
> +{
> +       u32 depctl = 0;
> +       ulong depctl_addr;
> +
> +       if (ep->is_in) {
> +               depctl_addr =
> +                   (core_if->dev_if->in_ep_regs[ep->num]) + DWC_DIEPCTL;
> +               depctl = dwc_reg_read(depctl_addr, 0);
> +
> +               /* set the disable and stall bits */
> +               if (DWC_DEPCTL_EPENA_RD(depctl))
> +                       depctl = DWC_DEPCTL_EPDIS_RW(depctl, 1);
> +               depctl = DWC_DEPCTL_STALL_HNDSHK_RW(depctl, 1);
> +               dwc_reg_write(depctl_addr, 0, depctl);

After stall bit set, you must disable EP.
Also you must clear TX fifo completetly for respective EP.


> +       } else {
> +               depctl_addr =
> +                   (core_if->dev_if->out_ep_regs[ep->num] + DWC_DOEPCTL);
> +               depctl = dwc_reg_read(depctl_addr, 0);
> +
> +               /* set the stall bit */
> +               depctl = DWC_DEPCTL_STALL_HNDSHK_RW(depctl, 1);
> +               dwc_reg_write(depctl_addr, 0, depctl);
> +       }
> +}

Regards
Pratyush
