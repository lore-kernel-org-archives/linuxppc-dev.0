Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20971DDF55
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Mar 2009 09:00:54 +1100 (EST)
Subject: Re: [PATCH] powerpc/usb: Fix 440EPx USBH_3 & USBH_5 EHCI errata
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: - Reyneke <reynekejunk@hotmail.com>
In-Reply-To: <BAY101-W12966ECAF38C4FD6F26513BEA50@phx.gbl>
References: <BAY101-W12966ECAF38C4FD6F26513BEA50@phx.gbl>
Content-Type: text/plain
Date: Sun, 08 Mar 2009 09:00:45 +1100
Message-Id: <1236463245.7260.170.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	Alan Stern <stern@rowland.harvard.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-03-06 at 11:30 +0000, - Reyneke wrote:
> Patch applies to 440EPx devices in USB EHCI host mode (USB 2.0).
> 
> >From the 440EPx errata:
> 
> USBH_3: Host hangs after underrun or overrun occurs
> USBH_5: EHCI0_INSNREGxx registers are reset by a Soft or Light Host Controller Reset
> 
> Workround for USBH_3 is to enable Break Memory Transfer (BMT) in INSNREG3. But the controller is reset after this fix is applied, and thus the current workround is lost. The following short patch ensures INSNREG3 is correctly set after reset.

> Signed-off-by: Jan Reyneke 

Please provide a valid email address here.

> ---
>  ehci-hcd.c    |    7 +++++++
>  ehci-ppc-of.c |   30 +++++++++++++++++++-----------
>  ehci.h        |    5 +++++
>  3 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff -uprN a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> --- a/drivers/usb/host/ehci.h    2009-03-04 01:05:22.000000000 +0000
> +++ b/drivers/usb/host/ehci.h    2009-03-06 10:52:53.000000000 +0000
> @@ -137,6 +137,11 @@ struct ehci_hcd {            /* one per controlle
>  
>      u8            sbrn;        /* packed release number */
>  
> +#if defined(CONFIG_440EPX)
> +    #define     PPC440EPX_EHCI0_INSREG_BMT    (0x1 << 0)
> +    __iomem u32 *insn_regs;        /* INSNREGx device memory/io */
> +#endif

I don't think you need the above based on what you do later on...
(see comments below)

>      /* irq statistics */
>  #ifdef EHCI_STATS
>      struct ehci_stats    stats;
> diff -uprN a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> --- a/drivers/usb/host/ehci-hcd.c    2009-03-04 01:05:22.000000000 +0000
> +++ b/drivers/usb/host/ehci-hcd.c    2009-03-06 10:54:36.000000000 +0000
> @@ -217,6 +217,13 @@ static int ehci_reset (struct ehci_hcd *
>      if (ehci_is_TDI(ehci))
>          tdi_reset (ehci);
>  
> +#if defined(CONFIG_440EPX)
> +    /* USBH_5: INSN values are lost on reset -> redo USBH_3.
> +       See also ppc44x_enable_bmt.*/
> +    if (ehci->insn_regs)
> +        out_be32(ehci->insn_regs + 3, PPC440EPX_EHCI0_INSREG_BMT);
> +#endif

A few issues here. First, it would be preferable to have this in the
ehci-ppc-of.c file. If you can't stick that in such a place that it will
be called after ehci_reset, then maybe you can add a reset "hook" so
that ehci-ppc-of.c gets to wrap the real ehci_reset().

Also, while the ifdef CONFIG_440EPX is good to prevent building the code
on machines that don't need it, it's also not enough. We allow building
kernels that support multiple boards and SoC's within the same major CPU
family and thus you -also- need runtime detection. Either using a quirk
(I think the USB drivers have quirk flags) or just always doing the
of_device_is_compatible() thingy which is yet another reason for finding
a way to move that up into ehci-ppc-of.c

That would also avoid some duplication...

>  /*
> - * 440EPx Errata USBH_3
> - * Fix: Enable Break Memory Transfer (BMT) in INSNREG3
> - */
> -#define PPC440EPX_EHCI0_INSREG_BMT    (0x1 << 0)
> + * 440EPx Errata USBH_3 & USBH_5
> + * Fix: Enable Break Memory Transfer (BMT) in INSNREG3. Also cache
> + * the registers so we can redo the USBH_3 fix on future resets */
>  static int __devinit
> -ppc44x_enable_bmt(struct device_node *dn)
> +ppc44x_enable_bmt(struct device_node *dn, struct ehci_hcd* ehci)
>  {
> -    __iomem u32 *insreg_virt;
>  
> -    insreg_virt = of_iomap(dn, 1);
> -    if (!insreg_virt)
> +#if defined(CONFIG_440EPX)
> +
> +    ehci->insn_regs = of_iomap(dn, 1);
> +    if (!ehci->insn_regs)
>          return  -EINVAL;
>  
> -    out_be32(insreg_virt + 3, PPC440EPX_EHCI0_INSREG_BMT);
> +    out_be32(ehci->insn_regs + 3, PPC440EPX_EHCI0_INSREG_BMT);
>  
> -    iounmap(insreg_virt);
> +#endif
>      return 0;
> +
>  }

So if you manage to move the quirk here, you can thus re-use the
existing code, or is the reset always called in a context where you
can't iomap ? (ie with a spinlock held).

In any case, I don't like adding a specific field to the generic ehci
structure like that. If that's what it takes, add a void
*platform_private to it, and use -that- to stick a host specific data
structure, but for something not performance sensitive such as a reset,
if you can get away with always mapping/unmapping, it's probably better.
 
Cheers,
Ben.
