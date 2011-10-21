Return-Path: <olof@lixom.net>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
 [209.85.210.43]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7A5951007D1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2011 04:43:38 +1100 (EST)
Received: by pzk33 with SMTP id 33so10300237pzk.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2011 10:43:36 -0700 (PDT)
Date: Fri, 21 Oct 2011 10:43:47 -0700
From: Olof Johansson <olof@lixom.net>
To: tmarri@apm.com
Subject: Re: [PATCH v15 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core
 Interface Layer (CIL)
Message-ID: <20111021174347.GC27652@quad.lixom.net>
References: <1318630129-14235-1-git-send-email-tmarri@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318630129-14235-1-git-send-email-tmarri@apm.com>
Cc: Mark Miesfeld <mmiesfeld@apm.com>, greg@kroah.com,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Some hit-and-run comments below.


-Olof

On Fri, Oct 14, 2011 at 03:08:49PM -0700, tmarri@apm.com wrote:
> diff --git a/drivers/usb/dwc/cil.h b/drivers/usb/dwc/cil.h
> new file mode 100644
> index 0000000..8c29678
> --- /dev/null
> +++ b/drivers/usb/dwc/cil.h
> @@ -0,0 +1,1174 @@
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
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY DIRECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
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
> +#include "regs.h"
> +
> +#ifdef CONFIG_DWC_DEBUG
> +#define DEBUG
> +#endif
> +
> +/**
> + * Reads the content of a register.
> + */
> +static inline u32 dwc_reg_read(ulong reg , u32 offset)
> +{
> +
> +#ifdef CONFIG_DWC_OTG_REG_LE
> +	return in_le32((unsigned __iomem *)(reg + offset));
> +#else
> +	return in_be32((unsigned __iomem *)(reg + offset));
> +#endif
> +}
> +
> +static inline void dwc_reg_write(ulong reg, u32 offset, const u32 value)
> +{
> +#ifdef CONFIG_DWC_OTG_REG_LE
> +	out_le32((unsigned __iomem *)(reg + offset), value);
> +#else
> +	out_be32((unsigned __iomem *)(reg + offset), value);
> +#endif
> +};

NACK. This is powerpc-specific code.

Also, your function has to take the register as a void __iomem *  type instead
of casting it here.

Finally, please try to abstract away the endian ness a bit further, instead of
duplicating each implementation here twice.

> +/*
> + * Debugging support vanishes in non-debug builds.
> + */
> +/* Display CIL Debug messages */
> +#define dwc_dbg_cil		(0x2)
> +
> +/* Display CIL Verbose debug messages */
> +#define dwc_dbg_cilv		(0x20)
> +
> +/* Display PCD (Device) debug messages */
> +#define dwc_dbg_pcd		(0x4)
> +
> +/* Display PCD (Device) Verbose debug  messages */
> +#define dwc_dbg_pcdv		(0x40)
> +
> +/* Display Host debug messages */
> +#define dwc_dbg_hcd		(0x8)
> +
> +/* Display Verbose Host debug messages */
> +#define dwc_dbg_hcdv		(0x80)
> +
> +/* Display enqueued URBs in host mode. */
> +#define dwc_dbg_hcd_urb		(0x800)
> +
> +/* Display "special purpose" debug messages */
> +#define dwc_dbg_sp		(0x400)
> +
> +/* Display all debug messages */
> +#define dwc_dbg_any		(0xFF)
> +
> +/* All debug messages off */
> +#define dwc_dbg_off		0
> +
> +/* Prefix string for DWC_DEBUG print macros. */
> +#define usb_dwc "dwc_otg: "

These don't seem to have to do with CIL, so should go in their own debug header
perhaps?

> +/*
> + * Added-sr: 2007-07-26

Irrellevant in the upstream context.

> +	/* Internal DWC HCD Flags */
> +	union dwc_otg_hcd_internal_flags {
> +		u32 d32;
> +		struct {
> +			unsigned port_connect_status_change:1;
> +			unsigned port_connect_status:1;
> +			unsigned port_reset_change:1;
> +			unsigned port_enable_change:1;
> +			unsigned port_suspend_change:1;
> +			unsigned port_over_current_change:1;
> +			unsigned reserved:27;
> +		} b;
> +	} flags;

Please don't use structs/unions for register definitions.

> +static int dwc_otg_handle_otg_intr(struct core_if *core_if)
> +{

This function looks a bit long and indentation is deep. Please refactor into helpers.


-Olof
