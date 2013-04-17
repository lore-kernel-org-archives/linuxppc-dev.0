Return-Path: <stern+517b9ca4@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by ozlabs.org (Postfix) with SMTP id 5A9692C010C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 01:10:31 +1000 (EST)
Date: Wed, 17 Apr 2013 11:03:49 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [PATCH] usb: remove redundant tdi_reset
In-Reply-To: <1366193026-20871-1-git-send-email-Shengzhou.Liu@freescale.com>
Message-ID: <Pine.LNX.4.44L0.1304171054140.1623-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 17 Apr 2013, Shengzhou Liu wrote:

> We remove the redundant tdi_reset in ehci_setup since there
> is already it in ehci_reset.
> It was observed that the duplicated tdi_reset was causing
> the PHY_CLK_VALID bit unstable.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
>  drivers/usb/host/ehci-hcd.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 416a6dc..83b5a17 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -670,9 +670,6 @@ int ehci_setup(struct usb_hcd *hcd)
>  	if (retval)
>  		return retval;
>  
> -	if (ehci_is_TDI(ehci))
> -		tdi_reset(ehci);
> -
>  	ehci_reset(ehci);
>  
>  	return 0;

Acked-by: Alan Stern <stern@rowland.harvard.edu>

This should be applied to stable kernels going back to 3.6.

In case you are wondering why that redudant call was added, I did it
because some of the PCI drivers (Intel and TDI) already had calls to
tdi_reset.  The commit removed those calls, so the new one was added 
in.
