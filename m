Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 0B065DDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 04:54:21 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so715001wag
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Aug 2007 11:54:20 -0700 (PDT)
Message-ID: <fa686aa40708091154t55ca4df7q7be2acf5662e6076@mail.gmail.com>
Date: Thu, 9 Aug 2007 12:54:19 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
In-Reply-To: <200708070124.04748.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
	<200708070124.04748.arnd@arndb.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/6/07, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 07 August 2007, Wolfgang Reissnegger wrote:
> >
> > Make support for Xilinx boards more generic, making it easier
> > to add new boards. Add initial support for xupv2p and ml410 boards.
>
> I really think we shouldn't add stuff to arch/ppc at this point,
> it has been deprecated for over two years now.

Naahh, this is pretty benign stuff.  I say let it go in.  :-)

These changes are low risk and they don't hurt anything.  If Virtex
support worked in arch/powerpc then I'd agree, but for now it allows
us to keep the virtex device driver support somewhat current.

>
> > --- a/arch/ppc/platforms/4xx/virtex.h
> > +++ b/arch/ppc/platforms/4xx/virtex.h
> > @@ -31,5 +31,14 @@ extern const char* virtex_machine_name;
> > #define PPC4xx_ONB_IO_VADDR0u
> > #define PPC4xx_ONB_IO_SIZE0u
> >
> > +
> > +#if defined(CONFIG_XILINX_VIRTEX_II_PRO)
> > +#define XILINX_ARCH "Virtex-II Pro"
> > +#elif defined(CONFIG_XILINX_VIRTEX_4_FX)
> > +#define XILINX_ARCH "Virtex-4 FX"
> > +#else
> > +#error "No Xilinx Architecture recognized."
> > +#endif
> > +
> > #endif/* __ASM_VIRTEX_H__ */
> > #endif/* __KERNEL__ */
>
> When you move over to arch/powerpc, you can't do it this way, because
> that prevents you from building a multiplatform kernel.
>
> Every macro and global function that gets defined must be able to coexist
> with others that are enabled by nonexclusive configuration options.
>
> > +#if defined(CONFIG_XILINX_ML300)
> > +const char *virtex_machine_name = "Xilinx ML300";
> > +#elif defined(CONFIG_XILINX_XUPV2P)
> > +const char *virtex_machine_name = "Xilinx XUPV2P";
> > +#elif defined(CONFIG_XILINX_ML40x)
> > +const char *virtex_machine_name = "Xilinx ML40x";
> > +#elif defined(CONFIG_XILINX_ML41x)
> > +const char *virtex_machine_name = "Xilinx ML41x";
> > +#else
> > +const char *virtex_machine_name = "Unknown Xilinx with PowerPC";
> > +#endif
>
> same here.
>
> > +
> > +
> > +#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
> > +static volatile unsigned *powerdown_base =
> > + (volatile unsigned *) XPAR_POWER_0_POWERDOWN_BASEADDR;
>
> volatile is a bug. This needs to be __iomem, and the address probably
> needs to come from of_iomap() or a similar function.

Ugh; this is an old bug that they just copied.  I'll submit a fix for
the original code.

>
> > +static void
> > +xilinx_power_off(void)
> > +{
> > +local_irq_disable();
> > +out_be32(powerdown_base, XPAR_POWER_0_POWERDOWN_VALUE);
> > +while (1) ;
> > +}
> > +#endif
>
> You should run 'sparse' on your code before submitting patches. That
> would have caught this bug in the out_be32() instruction that expects
> an __iomem pointer.
>
> > +
> > +void __init
> > +xilinx_generic_ppc_map_io(void)
> > +{
> > +ppc4xx_map_io();
> > +
> > +#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
> > +powerdown_base = ioremap((unsigned long) powerdown_base,
> > + XPAR_POWER_0_POWERDOWN_HIGHADDR -
> > + XPAR_POWER_0_POWERDOWN_BASEADDR + 1);
> > +#endif
> > +}
>
> It's a rather unconventional way of working with the addresses.
> You should never use a single variable for pointers going to
> two different address spaces (physical and kernel virtual in this
> case).

Double ewh; this is also a cloned bug.

>
> > +void __init
> > +xilinx_generic_ppc_setup_arch(void)
> > +{
> > +virtex_early_serial_map();
>
> Use legacy_serial/of_serial to do this, with proper device tree entries.
>
> > +
> > +int virtex_device_fixup(struct platform_device *dev)
> > +{
> > + int i;
> > +#ifdef XPAR_ONEWIRE_0_BASEADDR
> > + /* Use the Silicon Serial ID attached on the onewire bus to */
> > + /* generate sensible MAC addresses. */
> > + unsigned char *pOnewire = ioremap(XPAR_ONEWIRE_0_BASEADDR, 6);
> > + struct xemac_platform_data *pdata = dev->dev.platform_data;
> > + if (strcmp(dev->name, "xilinx_emac") == 0) {
>
> This is heavily whitespace damaged, use tabs for indentation instead
> of spaces.
>
> > diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters.h b/arch/ppc/platforms/4xx/xparameters/xparameters.h
> > index 01aa043..34d9844 100644
> > --- a/arch/ppc/platforms/4xx/xparameters/xparameters.h
> > +++ b/arch/ppc/platforms/4xx/xparameters/xparameters.h
> > @@ -15,8 +15,12 @@
> >
> > #if defined(CONFIG_XILINX_ML300)
> > #include "xparameters_ml300.h"
> > +#elif defined(CONFIG_XILINX_XUPV2P)
> > + #include "xparameters_xupv2p.h"
> > #elif defined(CONFIG_XILINX_ML403)
> > #include "xparameters_ml403.h"
> > +#elif defined(CONFIG_XILINX_ML41x)
> > + #include "xparameters_ml41x.h"
> > #else
> > /* Add other board xparameter includes here before the #else */
> > #error No xparameters_*.h file included
>
> see comment above.

This whole xparams stuff is a special case; but it is going away for
arch/powerpc.  xparameters.h is generated by the xilinx EDK tool and
it is painful to work with in the Linux context.  For arch/powerpc,
I've got a tool that generates a device tree from the FPGA hardware
design.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
