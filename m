Return-Path: <david-b@pacbell.net>
Received: from smtp119.sbc.mail.sp1.yahoo.com (smtp119.sbc.mail.sp1.yahoo.com
	[69.147.64.92]) by ozlabs.org (Postfix) with SMTP id 43F62DDDF3
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 13:46:56 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/4] USB: Protect hcd.h from multiple inclusions
Date: Tue, 23 Sep 2008 20:35:18 -0700
References: <20080924000255.GA28054@oksana.dev.rtsoft.ru>
	<20080924000340.GC29733@oksana.dev.rtsoft.ru>
In-Reply-To: <20080924000340.GC29733@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809232035.19684.david-b@pacbell.net>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 23 September 2008, Anton Vorontsov wrote:
> This will let us use this header in other header files.
> Will be needed for the FHCI USB Host driver.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

This seems innocuous.  I'm content with Greg merging it into
his tree for 2.6.28-rc0 merge ...

Acked-by: David Brownell <dbrownell@users.sourceforge.net>


> ---
>  drivers/usb/core/hcd.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
> index e710ce0..66b64d7 100644
> --- a/drivers/usb/core/hcd.h
> +++ b/drivers/usb/core/hcd.h
> @@ -16,6 +16,8 @@
>   * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
> +#ifndef __USB_CORE_HCD_H
> +#define __USB_CORE_HCD_H
>  
>  #ifdef __KERNEL__
>  
> @@ -483,3 +485,5 @@ static inline void usbmon_urb_complete(struct usb_bus *bus, struct urb *urb,
>  extern struct rw_semaphore ehci_cf_port_reset_rwsem;
>  
>  #endif /* __KERNEL__ */
> +
> +#endif /* __USB_CORE_HCD_H */
> -- 
> 1.5.6.3
> 
> 
