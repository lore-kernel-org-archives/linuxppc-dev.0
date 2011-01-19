Return-Path: <stern+4d39b18a@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id BE9B2B70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Jan 2011 03:30:10 +1100 (EST)
Date: Wed, 19 Jan 2011 11:23:27 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: tmarri@apm.com
Subject: Re: [PATCH V7 07/10] USB/ppc4xx: Add Synopsys DWC OTG PCD function
In-Reply-To: <1295402749-2193-1-git-send-email-tmarri@apm.com>
Message-ID: <Pine.LNX.4.44L0.1101191122180.3655-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Tue, 18 Jan 2011 tmarri@apm.com wrote:

> From: Tirumala Marri <tmarri@apm.com>
> 
> The PCD is responsible for translating requests from the gadget driver
> to appropriate actions on the DWC OTG controller.
> 
> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> ---
>  drivers/usb/dwc_otg/dwc_otg_pcd.c | 1752 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc_otg/dwc_otg_pcd.h |  139 +++
>  2 files changed, 1891 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/dwc_otg/dwc_otg_pcd.c b/drivers/usb/dwc_otg/dwc_otg_pcd.c
> new file mode 100644
> index 0000000..857dcee
> --- /dev/null
> +++ b/drivers/usb/dwc_otg/dwc_otg_pcd.c

...

> +static struct usb_ep_ops dwc_otg_pcd_ep_ops = {
> +	.enable = dwc_otg_pcd_ep_enable,
> +	.disable = dwc_otg_pcd_ep_disable,
> +	.alloc_request = dwc_otg_pcd_alloc_request,
> +	.free_request = dwc_otg_pcd_free_request,
> +	.queue = dwc_otg_pcd_ep_queue,
> +	.dequeue = dwc_otg_pcd_ep_dequeue,
> +	.set_halt = dwc_otg_pcd_ep_set_halt,
> +	.fifo_status = NULL,
> +	.fifo_flush = NULL,
> +};

This is missing a .set_wedge method.

Alan Stern
