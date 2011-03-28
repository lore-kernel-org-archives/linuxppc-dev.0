Return-Path: <sarah.a.sharp@linux.intel.com>
Date: Mon, 28 Mar 2011 15:34:24 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v2 5/5] xhci: Remove recursive call to xhci_handle_event
Message-ID: <20110328223424.GF8065@xanatos>
References: <4D8C47D8.4020901@ozlabs.org> <4D8C8F2B.9090808@ru.mvista.com>
	<4D90142C.4050206@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D90142C.4050206@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Sergei Shtylyov <sshtylyov@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 28, 2011 at 03:53:00PM +1100, Matt Evans wrote:
> Make the caller loop while there are events to handle, instead.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
> 1 byte smaller after Sergei's suggestion.
> 
>  drivers/usb/host/xhci-ring.c |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index d6aa880..9c51d69 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -2131,7 +2131,7 @@ cleanup:
>   * This function handles all OS-owned events on the event ring.  It may drop
>   * xhci->lock between event processing (e.g. to pass up port status changes).
>   */
> -static void xhci_handle_event(struct xhci_hcd *xhci)
> +static int xhci_handle_event(struct xhci_hcd *xhci)

Can you add documentation here about what this function returns?

Also, there's the issue of error handling.  It's kind of a future
functionality, rather than a needed bug fix, but this code reminded me
of the issue.

If we get a critical error, like when the xHCI host controller is dead
(the XHCI_STATE_DYING case), then the interrupt handler really shouldn't
call xhci_handle_event again.  There's no point in processing the event
ring further if something is seriously wrong with the host controller,
as it can be writing absolute garbage to the ring at that point.  This
isn't what's been done in the past (we just blindly process), so we
might find more bugs in software/hardware implementations.

What I'd like to do is take out the read of the status register out of
the interrupt handler (which is killing performance), and make it only
check the status register when xhci_handle_event() returns a negative
error status.  If the status register shows the host controller has a
critical error, the driver should call usb_hcd_died().

Sarah Sharp

>  {
>  	union xhci_trb *event;
>  	int update_ptrs = 1;
> @@ -2140,7 +2140,7 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
>  	xhci_dbg(xhci, "In %s\n", __func__);
>  	if (!xhci->event_ring || !xhci->event_ring->dequeue) {
>  		xhci->error_bitmask |= 1 << 1;
> -		return;
> +		return 0;
>  	}
>  
>  	event = xhci->event_ring->dequeue;
> @@ -2148,7 +2148,7 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
>  	if ((le32_to_cpu(event->event_cmd.flags) & TRB_CYCLE) !=
>  	    xhci->event_ring->cycle_state) {
>  		xhci->error_bitmask |= 1 << 2;
> -		return;
> +		return 0;
>  	}
>  	xhci_dbg(xhci, "%s - OS owns TRB\n", __func__);
>  
> @@ -2192,15 +2192,17 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
>  	if (xhci->xhc_state & XHCI_STATE_DYING) {
>  		xhci_dbg(xhci, "xHCI host dying, returning from "
>  				"event handler.\n");
> -		return;
> +		return 0;
>  	}
>  
>  	if (update_ptrs)
>  		/* Update SW event ring dequeue pointer */
>  		inc_deq(xhci, xhci->event_ring, true);
>  
> -	/* Are there more items on the event ring? */
> -	xhci_handle_event(xhci);
> +	/* Are there more items on the event ring?  Caller will call us again to
> +	 * check.
> +	 */
> +	return 1;
>  }
>  
>  /*
> @@ -2282,7 +2284,7 @@ hw_died:
>  	/* FIXME this should be a delayed service routine
>  	 * that clears the EHB.
>  	 */
> -	xhci_handle_event(xhci);
> +	while (xhci_handle_event(xhci)) {}
>  
>  	temp_64 = xhci_read_64(xhci, &xhci->ir_set->erst_dequeue);
>  	/* If necessary, update the HW's version of the event ring deq ptr. */
> -- 
> 1.7.0.4
> 
