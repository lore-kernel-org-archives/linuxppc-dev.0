Date: Fri, 07 Jun 2002 19:54:42 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] USB on PPC440GP (cache incoherent)
To: Roland Dreier <roland@topspin.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	linux-usb-devel@lists.sourceforge.net
Message-id: <3D0171F2.4080602@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <52hekebq2a.fsf@topspin.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Roland Dreier wrote:
> I had to make some changes to the USB driver to get this working as
> there are still some places where structures on the stack are being
> used for DMA.

Good to have that -- there have periodically been passes made through
drivers to fix such problems, evidently at least 2.4 didn't catch all
of them.  Corresponding changes should get into 2.5 kernels too.


> Note that this might not work perfectly on all cache-incoherent
> processors, since kmalloc could potentially allocate a chunk of memory
> that is smaller than the processor's cache line size.  However it is
> safe on the 440GP since the 440GP's cache line size is 32 bytes.

Could you elaborate?  Documentation/DMA-mapping.txt says that kmalloc
returns data suitable for DMA, you are saying otherwise.  The DMA
mapping calls are supposed to handle cache flushing as needed.  If
they don't, a lot of code will be breaking ...


>  struct usb_hub {
>  	struct usb_device *dev;
>
>  	struct urb *urb;		/* Interrupt polling pipe */
>
> -	char buffer[(USB_MAXCHILDREN + 1 + 7) / 8]; /* add 1 bit for hub status change */
> -					/* and add 7 bits to round up to byte boundary */
> +        char *buffer;
>  	int error;
>  	int nerrors;

This hub.h change (and its follow-ons) should not be necessary since the
struct usb_hub is already allocated using kmalloc() in hub_probe(), and
so it's DMA-ready.  (Modulo the spec issue noted above for DMA-mapping.txt
of course!)

- Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
