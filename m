Return-Path: <lasaine@lvk.cs.msu.su>
Received: from mail.lvk.cs.msu.su (gate.lvk.cs.msu.su [158.250.17.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lvk.cs.msu.su", Issuer "CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C75A3B710E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 03:24:38 +1100 (EST)
Date: Wed, 26 Jan 2011 19:17:34 +0300
From: Alexander Gordeev <lasaine@lvk.cs.msu.su>
To: tmarri@apm.com
Subject: Re: [PATCH V8 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core
	Interface Layer
Message-ID: <20110126191734.5dff9641@desktopvm.lvknet>
In-Reply-To: <1295477852-14735-1-git-send-email-tmarri@apm.com>
References: <1295477852-14735-1-git-send-email-tmarri@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/ImjHaptZjy8JuSgLC1be6th";
	protocol="application/pgp-signature"
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>, Mark Miesfeld <mmiesfeld@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/ImjHaptZjy8JuSgLC1be6th
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=D0=92 Wed, 19 Jan 2011 14:57:32 -0800
tmarri@apm.com =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> From: Tirumala Marri <tmarri@apm.com>
>=20
> Core Interface Layer Common provides common functions for both host
> controller and peripheral controller.  CIL manages the memory map
> for the core. It also handles basic tasks like reading/writing the
> registers and data FIFOs in the controller. CIL performs basic
> services that are not specific to either the host or device modes
> of operation. These services include management of the OTG Host
> Negotiation Protocol (HNP) and Session Request Protocol (SRP).
>=20
> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> ---
>  drivers/usb/dwc_otg/dwc_otg_cil.c      |  972 +++++++++++++++++++++++++
>  drivers/usb/dwc_otg/dwc_otg_cil.h      | 1220 ++++++++++++++++++++++++++=
++++++
>  drivers/usb/dwc_otg/dwc_otg_cil_intr.c |  616 ++++++++++++++++
>  3 files changed, 2808 insertions(+), 0 deletions(-)
>=20
[snip drivers/usb/dwc_otg/dwc_otg_cil.c]
> diff --git a/drivers/usb/dwc_otg/dwc_otg_cil.h b/drivers/usb/dwc_otg/dwc_=
otg_cil.h
> new file mode 100644
> index 0000000..d97a8db
> --- /dev/null
> +++ b/drivers/usb/dwc_otg/dwc_otg_cil.h
> @@ -0,0 +1,1220 @@
> +/*
> + * DesignWare HS OTG controller driver
> + * Copyright (C) 2006 Synopsys, Inc.
> + * Portions Copyright (C) 2010 Applied Micro Circuits Corporation.
> + *
> + * This program is free software: you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License version 2 for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see http://www.gnu.org/licenses
> + * or write to the Free Software Foundation, Inc., 51 Franklin Street,
> + * Suite 500, Boston, MA 02110-1335 USA.
> + *
> + * Based on Synopsys driver version 2.60a
> + * Modified by Mark Miesfeld <mmiesfeld@apm.com>
> + * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "=
AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO T=
HE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY DI=
RECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SER=
VICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR =
TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + */
> +
> +#if !defined(__DWC_CIL_H__)
> +#define __DWC_CIL_H__
> +#include <linux/io.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/interrupt.h>
> +#include <linux/dmapool.h>
> +#include <linux/spinlock.h>
> +#include <linux/usb/otg.h>
> +
> +#include "dwc_otg_regs.h"
> +
> +#ifdef CONFIG_DWC_DEBUG
> +#define DEBUG
> +#endif
> +
> +/**
> + * Reads the content of a register.
> + */
> +static inline u32 dwc_read32(u32 reg)
> +{
> +#ifdef CONFIG_DWC_OTG_REG_LE
> +	return in_le32((unsigned __iomem *)reg);
> +#else
> +	return in_be32((unsigned __iomem *)reg);
> +#endif
> +};
> +static inline u32 dwc_read_reg32(u32 *reg)
> +{
> +#ifdef CONFIG_DWC_OTG_REG_LE
> +	return in_le32(reg);
> +#else
> +	return in_be32(reg);
> +#endif
> +};
> +

dwc_read_reg32 is used nowhere throughout the code. One of dwc_read32
and dwc_read_reg32 should be removed IMO. There was once only
dwc_read_reg32. In version 5 of your patchset I believe. Why did you
add another function? AFAIK it is not correct to store pointers in u32
because they need 8 bytes on 64-bit archs. So it was ok with the old
dwc_read_reg32.

> +/**
> + * Writes a register with a 32 bit value.
> + */
> +static inline void dwc_write32(u32 reg, const u32 value)
> +{
> +#ifdef CONFIG_DWC_OTG_REG_LE
> +	out_le32((unsigned __iomem *)reg, value);
> +#else
> +	out_be32((unsigned __iomem *)reg, value);
> +#endif
> +};
> +static inline void dwc_write_reg32(u32 *reg, const u32 value)
> +{
> +#ifdef CONFIG_DWC_OTG_REG_LE
> +	out_le32(reg, value);
> +#else
> +	out_be32(reg, value);
> +#endif
> +};
> +

Same thing here. dwc_write_reg32 is never used. And it should be used
instead of dwc_write32 probably.

> +/**
> + * This function modifies bit values in a register.  Using the
> + * algorithm: (reg_contents & ~clear_mask) | set_mask.
> + */
> +static inline
> +	void dwc_modify_reg32(u32 *_reg, const u32 _clear_mask,
> +			  const u32 _set_mask)
> +{
> +#ifdef CONFIG_DWC_OTG_REG_LE
> +	out_le32(_reg, (in_le32(_reg) & ~_clear_mask) | _set_mask);
> +#else
> +	out_be32(_reg, (in_be32(_reg) & ~_clear_mask) | _set_mask);
> +#endif
> +};
> +static inline
> +	void dwc_modify32(u32 reg, const u32 _clear_mask, const u32 _set_mask)
> +{
> +#ifdef CONFIG_DWC_OTG_REG_LE
> +	out_le32((unsigned __iomem *)reg,
> +			(in_le32((unsigned __iomem *)reg) & ~_clear_mask) |
> +			_set_mask);
> +#else
> +	out_be32((unsigned __iomem *)reg,
> +			(in_be32(((unsigned __iomem *))reg) & ~_clear_mask) |
> +			_set_mask);
> +#endif
> +};
> +

Same thing here. dwc_write_reg32 is never used.

> +static inline void dwc_write_datafifo32(u32 *reg, const u32 _value)
> +{
> +#ifdef CONFIG_DWC_OTG_FIFO_LE
> +	out_le32((unsigned __iomem *)reg, _value);
> +#else
> +	out_be32((unsigned __iomem *)reg, _value);
> +#endif
> +};
> +static inline void dwc_write_fifo32(u32 reg, const u32 _value)
> +{
> +#ifdef CONFIG_DWC_OTG_FIFO_LE
> +	out_le32((unsigned __iomem *)reg, _value);
> +#else
> +	out_be32((unsigned __iomem *)reg, _value);
> +#endif
> +};
> +

And here. dwc_write_fifo32 is never used.

> +static inline u32 dwc_read_datafifo32(u32 *_reg)
> +{
> +#ifdef CONFIG_DWC_OTG_FIFO_LE
> +	return in_le32((unsigned __iomem *)_reg);
> +#else
> +	return in_be32((unsigned __iomem *)_reg);
> +#endif
> +};
> +static inline u32 dwc_read_fifo32(u32 _reg)
> +{
> +#ifdef CONFIG_DWC_OTG_FIFO_LE
> +	return in_le32((unsigned __iomem *) _reg);
> +#else
> +	return in_be32((unsigned __iomem *) _reg);
> +#endif
> +};
> +

And here. dwc_read_fifo32 is never used.

Also in_le32/out_le32/in_be32/out_be32 are architecture-specific AFAIK.
I'd suggest using readl/writel for LE ops and
__be32_to_cpu(__raw_readl(addr))/__raw_writel(__cpu_to_be32(b),addr)
for BE ops.

--=20
  Alexander

--Sig_/ImjHaptZjy8JuSgLC1be6th
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJNQEkeAAoJEElrwznyooJbVm0H/3LqfQ+fy0Yw3UGBOcpmBXZo
lJzLrmxU0e+zTVOm7JQbTK4wZ/S0rqTODZTm2sJN1O6JgV6ULbyf6oUoMcM7Gxpw
QX2XFhCEw/oJyBCVAgHSqe0qvm5nv97vHZYrXDwX8bVCFUq+d1N0ZC096v8oRoYU
i6631cXu8HwSwXeoApL5I/hwrZaBMnRJ5Ox4pBr1liGD0bh5Gw9KF5op+ZvKnOb8
Bo3vbLrFCsDf//h1SsBSU3oPf5B4vpRuLtBEkxwytZeuJja9JRnVIlQE/10FChzV
sKAUD/KxbklMLN3g6g4MAijIbKq4L5JQxBkhaRMMdSmpVcuyT1+Arp+R59Sn73g=
=jzWj
-----END PGP SIGNATURE-----

--Sig_/ImjHaptZjy8JuSgLC1be6th--
