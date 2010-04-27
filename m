Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 97AE3B7DE6
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 03:07:37 +1000 (EST)
Received: by pvg6 with SMTP id 6so1635998pvg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 10:07:36 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1272384698-4359-4-git-send-email-agust@denx.de>
References: <1272384698-4359-1-git-send-email-agust@denx.de>
	<1272384698-4359-4-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Apr 2010 11:07:16 -0600
Message-ID: <h2gfa686aa41004271007xb45b5321xef2f2f18da23a886@mail.gmail.com>
Subject: Re: [PATCH 3/4] USB: add USB OTG support for MPC5121 SoC
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	Bruce Schmid <duck@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anatolij,

I haven't looked deeply, but I've written a couple of minor comments below.

g.

On Tue, Apr 27, 2010 at 10:11 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Adds Freescale USB OTG driver and extends Freescale
> USB SoC Device Controller driver and FSL EHCI driver
> to support OTG operation on MPC5121.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Bruce Schmid <duck@freescale.com>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> =A0arch/powerpc/include/asm/fsl_usb_io.h | =A0106 +++
> =A0drivers/usb/gadget/fsl_udc_core.c =A0 =A0 | =A0357 ++++++++--
> =A0drivers/usb/gadget/fsl_usb2_udc.h =A0 =A0 | =A0 14 +
> =A0drivers/usb/host/ehci-fsl.c =A0 =A0 =A0 =A0 =A0 | =A0261 +++++++-
> =A0drivers/usb/host/ehci-fsl.h =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A0drivers/usb/host/ehci-hub.c =A0 =A0 =A0 =A0 =A0 | =A0 39 ++
> =A0drivers/usb/host/ehci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +
> =A0drivers/usb/otg/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 +
> =A0drivers/usb/otg/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0drivers/usb/otg/fsl_otg.c =A0 =A0 =A0 =A0 =A0 =A0 | 1199 +++++++++++++=
++++++++++++++++++++
> =A0drivers/usb/otg/fsl_otg.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0418 +++++++++++=
+
> =A0drivers/usb/otg/otg.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 17 +
> =A0drivers/usb/otg/otg_fsm.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0368 ++++++++++
> =A0drivers/usb/otg/otg_fsm.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0154 +++++
> =A0include/linux/fsl_devices.h =A0 =A0 =A0 =A0 =A0 | =A0 15 +
> =A015 files changed, 2867 insertions(+), 99 deletions(-)
> =A0create mode 100644 arch/powerpc/include/asm/fsl_usb_io.h
> =A0create mode 100644 drivers/usb/otg/fsl_otg.c
> =A0create mode 100644 drivers/usb/otg/fsl_otg.h
> =A0create mode 100644 drivers/usb/otg/otg_fsm.c
> =A0create mode 100644 drivers/usb/otg/otg_fsm.h
>
> diff --git a/arch/powerpc/include/asm/fsl_usb_io.h b/arch/powerpc/include=
/asm/fsl_usb_io.h
> new file mode 100644
> index 0000000..20c42ef
> --- /dev/null
> +++ b/arch/powerpc/include/asm/fsl_usb_io.h
> @@ -0,0 +1,106 @@
> +/* Copyright (c) 2008 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute =A0it and/or modi=
fy it
> + * under =A0the terms of =A0the GNU General =A0Public License as publish=
ed by the
> + * Free Software Foundation; =A0either version 2 of the =A0License, or (=
at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the =A0GNU General Public License =
along
> + * with this program; if not, write =A0to the Free Software Foundation, =
Inc.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +#ifndef _FSL_USB_IO_H
> +#define _FSL_USB_IO_H
> +
> +/*
> + * On some SoCs, the USB controller registers can be big or little endia=
n,
> + * depending on the version of the chip. =A0For these SoCs, the kernel
> + * should be configured with CONFIG_USB_FSL_BIG_ENDIAN_MMIO enabled.
> + *
> + * Platform code for SoCs that have BE USB registers should set
> + * pdata->big_endian_mmio flag.
> + *
> + * In order to be able to run the same kernel binary on 2 different
> + * versions of an SoC, the BE/LE decision must be made at run time.
> + * _fsl_readl and fsl_writel are pointers to the BE or LE readl()
> + * and writel() functions, and fsl_readl() and fsl_writel() call through
> + * those pointers.
> + *
> + * For SoCs with the usual LE USB registers, don't enable
> + * CONFIG_USB_FSL_BIG_ENDIAN_MMIO, and then fsl_readl() and fsl_writel()
> + * are just macro wrappers for in_le32() and out_le32().
> + *
> + * In either (LE or mixed) case, the function fsl_set_usb_accessors()
> + * should be called at probe time, to either set up the readl/writel
> + * function pointers (mixed case), or do nothing (LE case).
> + *
> + * The host USB drivers already have a mechanism to handle BE/LE
> + * registers. =A0The functionality here is intended to be used by the
> + * gadget and OTG transceiver drivers.
> + *
> + * This file also contains controller-to-cpu accessors for the
> + * USB descriptors, since their endianess is also SoC dependant.
> + * The kernel option CONFIG_USB_FSL_BIG_ENDIAN_DESC configures
> + * which way to go.
> + */
> +
> +#ifdef CONFIG_USB_FSL_BIG_ENDIAN_MMIO
> +static u32 __maybe_unused _fsl_readl_be(const unsigned __iomem *p)
> +{
> + =A0 =A0 =A0 return in_be32(p);
> +}
> +static u32 __maybe_unused _fsl_readl_le(const unsigned __iomem *p)
> +{
> + =A0 =A0 =A0 return in_le32(p);
> +}
> +
> +static void __maybe_unused _fsl_writel_be(u32 v, unsigned __iomem *p)
> +{
> + =A0 =A0 =A0 out_be32(p, v);
> +}
> +static void __maybe_unused _fsl_writel_le(u32 v, unsigned __iomem *p)
> +{
> + =A0 =A0 =A0 out_le32(p, v);
> +}
> +
> +static u32 (*_fsl_readl)(const unsigned __iomem *p);
> +static void (*_fsl_writel)(u32 v, unsigned __iomem *p);

statics defined in a header file?  That doesn't look right.  These
dynamic accessors probably need to be defined in a .c file and linked
to the rest of the driver code.

It is also better practise to put ops like these into the drivers
private instance data structure, but I understand that there is a
large driver impact associated with making that change.

> +
> +#define fsl_readl(p) =A0 =A0 =A0 =A0 =A0 (*_fsl_readl)((p))
> +#define fsl_writel(v, p) =A0 =A0 =A0 (*_fsl_writel)((v), (p))
> +
> +static inline void fsl_set_usb_accessors(struct fsl_usb2_platform_data *=
pdata)
> +{
> + =A0 =A0 =A0 if (pdata->big_endian_mmio) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _fsl_readl =3D _fsl_readl_be;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _fsl_writel =3D _fsl_writel_be;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _fsl_readl =3D _fsl_readl_le;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _fsl_writel =3D _fsl_writel_le;
> + =A0 =A0 =A0 }
> +}
> +
> +#else /* CONFIG_USB_FSL_BIG_ENDIAN_MMIO */
> +
> +#define fsl_readl(addr) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in_le32((addr))
> +#define fsl_writel(val32, addr) out_le32((addr), (val32))
> +
> +static inline void fsl_set_usb_accessors(struct fsl_usb2_platform_data *=
pdata)
> +{
> +}
> +#endif /* CONFIG_USB_FSL_BIG_ENDIAN_MMIO */
> +
> +#ifdef CONFIG_USB_FSL_BIG_ENDIAN_DESC
> +#define cpu_to_hc32(x) (x)
> +#define hc32_to_cpu(x) (x)
> +#else
> +#define cpu_to_hc32(x) cpu_to_le32((x))
> +#define hc32_to_cpu(x) le32_to_cpu((x))
> +#endif
> +
> +#endif /* _FSL_USB_IO_H */
> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_u=
dc_core.c
> index fa3d142..b5361a8 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -45,6 +45,7 @@
> =A0#include <asm/system.h>
> =A0#include <asm/unaligned.h>
> =A0#include <asm/dma.h>
> +#include <asm/cacheflush.h>
>
> =A0#include "fsl_usb2_udc.h"
>
> @@ -76,10 +77,7 @@ fsl_ep0_desc =3D {
>
> =A0static void fsl_ep_fifo_flush(struct usb_ep *_ep);
>
> -#ifdef CONFIG_PPC32
> -#define fsl_readl(addr) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in_le32(addr)
> -#define fsl_writel(val32, addr) out_le32(addr, val32)
> -#else
> +#ifndef CONFIG_PPC32
> =A0#define fsl_readl(addr) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0readl(addr)
> =A0#define fsl_writel(val32, addr) writel(val32, addr)
> =A0#endif

I would think these !CONFIG_PPC32 defines should also move into the
header file just so everything is defined in the same place.

Cheers,
g.
