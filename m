Return-Path: <sarah.a.sharp@linux.intel.com>
Date: Mon, 28 Mar 2011 15:20:23 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v2 3/5] xhci: Add rmb() between reading event validity
	& event data access.
Message-ID: <20110328222023.GD8065@xanatos>
References: <4D8C47CD.3020108@ozlabs.org>
	<61164.94.211.195.167.1301094709.squirrel@gate.crashing.org>
	<4D901429.5010807@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D901429.5010807@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch looks fine, thanks!

Sarah Sharp

On Mon, Mar 28, 2011 at 03:52:57PM +1100, Matt Evans wrote:
> On weakly-ordered systems, the reading of an event's content must occur
> after reading the event's validity.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
> Segher, thanks for the comment; explanation added.
> 
>  drivers/usb/host/xhci-ring.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 45f3b77..d6aa880 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -2152,6 +2152,11 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
>  	}
>  	xhci_dbg(xhci, "%s - OS owns TRB\n", __func__);
>  
> +	/*
> +	 * Barrier between reading the TRB_CYCLE (valid) flag above and any
> +	 * speculative reads of the event's flags/data below.
> +	 */
> +	rmb();
>  	/* FIXME: Handle more event types. */
>  	switch ((le32_to_cpu(event->event_cmd.flags) & TRB_TYPE_BITMASK)) {
>  	case TRB_TYPE(TRB_COMPLETION):
> -- 
> 1.7.0.4
> 
