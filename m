Return-Path: <sarah.a.sharp@linux.intel.com>
Date: Mon, 28 Mar 2011 15:23:36 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH 4/5] xhci: Add an assertion to check for virt_dev=0 bug.
Message-ID: <20110328222336.GE8065@xanatos>
References: <4D8C47D2.9010501@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D8C47D2.9010501@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 25, 2011 at 06:44:18PM +1100, Matt Evans wrote:
> During a "plug-unplug" stress test on an NEC xHCI card, a null pointer
> dereference was observed.  xhci_address_device() dereferenced a null
> virt_dev (possibly an erroneous udev->slot_id?); this patch adds a WARN_ON &
> message to aid debug if it can be recreated.

Hmm, that's interesting.  I haven't seen any null pointer dereferences
during my tests, but perhaps I'm not being ADDH enough about randomly
unplugging devices. :)  Let me know if you trigger this again.

Sarah Sharp

> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/usb/host/xhci.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 88e6298..7d43456 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -2542,6 +2542,17 @@ int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
>  
>  	virt_dev = xhci->devs[udev->slot_id];
>  
> +	if (WARN_ON(!virt_dev)) {
> +		/*
> +		 * In plug/unplug torture test with an NEC controller,
> +		 * a zero-dereference was observed once due to virt_dev = 0.
> +		 * Print useful debug rather than crash if it is observed again!
> +		 */
> +		xhci_warn(xhci, "Virt dev invalid for slot_id 0x%x!\n",
> +			udev->slot_id);
> +		return -EINVAL;
> +	}
> +
>  	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
>  	/*
>  	 * If this is the first Set Address since device plug-in or
> -- 
> 1.7.0.4
> 
