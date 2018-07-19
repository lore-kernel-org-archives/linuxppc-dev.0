Return-Path: <stern+5b5b8f2e@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by lists.ozlabs.org (Postfix) with SMTP id 41Wc9j6C3czDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 00:39:52 +1000 (AEST)
Date: Thu, 19 Jul 2018 10:33:10 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Geoff Levand <geoff@infradead.org>
cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Michael Ellerman <mpe@ellerman.id.au>,  <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/ps3: Set driver coherent_dma_mask
In-Reply-To: <068ebcfa-7cd0-bd06-42e7-577a4624f0b0@infradead.org>
Message-ID: <Pine.LNX.4.44L0.1807191029570.1491-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 18 Jul 2018, Geoff Levand wrote:

> Set the coherent_dma_mask for the PS3 ehci, ohci, and snd devices.
> 
> Silences WARN_ON_ONCE messages emitted by the dma_alloc_attrs() routine.
> 
> Reported-by: Fredrik Noring <noring@nocrew.org>
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> Hi Michael,
> 
> This just silences some warnings.  Can you take it through the powerpc
> tree?
> 
> -Geoff
> 
> 
>  drivers/usb/host/ehci-ps3.c | 6 ++++--
>  drivers/usb/host/ohci-ps3.c | 6 ++++--
>  sound/ppc/snd_ps3.c         | 5 +++++
>  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
> index 8c733492d8fe..454d8c624a3f 100644
> --- a/drivers/usb/host/ehci-ps3.c
> +++ b/drivers/usb/host/ehci-ps3.c
> @@ -86,7 +86,7 @@ static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
>  	int result;
>  	struct usb_hcd *hcd;
>  	unsigned int virq;
> -	static u64 dummy_mask = DMA_BIT_MASK(32);
> +	static u64 dummy_mask;
>  
>  	if (usb_disabled()) {
>  		result = -ENODEV;
> @@ -131,7 +131,9 @@ static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
>  		goto fail_irq;
>  	}
>  
> -	dev->core.dma_mask = &dummy_mask; /* FIXME: for improper usb code */
> +	dummy_mask = DMA_BIT_MASK(32);
> +	dev->core.dma_mask = &dummy_mask;
> +	dma_set_coherent_mask(&dev->core, dummy_mask);

What is the reason for changing a static initialization to a dynamic
one?  As far as I can see, the patch touches four lines of code but the
only real difference is addition of a single line (and removal of a 
comment).

> diff --git a/drivers/usb/host/ohci-ps3.c b/drivers/usb/host/ohci-ps3.c
> index 20a23d795adf..395f9d3bc849 100644
> --- a/drivers/usb/host/ohci-ps3.c
> +++ b/drivers/usb/host/ohci-ps3.c
> @@ -69,7 +69,7 @@ static int ps3_ohci_probe(struct ps3_system_bus_device *dev)
>  	int result;
>  	struct usb_hcd *hcd;
>  	unsigned int virq;
> -	static u64 dummy_mask = DMA_BIT_MASK(32);
> +	static u64 dummy_mask;
>  
>  	if (usb_disabled()) {
>  		result = -ENODEV;
> @@ -115,7 +115,9 @@ static int ps3_ohci_probe(struct ps3_system_bus_device *dev)
>  		goto fail_irq;
>  	}
>  
> -	dev->core.dma_mask = &dummy_mask; /* FIXME: for improper usb code */
> +	dummy_mask = DMA_BIT_MASK(32);
> +	dev->core.dma_mask = &dummy_mask;
> +	dma_set_coherent_mask(&dev->core, dummy_mask);

Same here.

Alan Stern
