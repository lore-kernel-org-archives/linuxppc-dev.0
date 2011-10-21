Return-Path: <olof@lixom.net>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A5B13B702E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2011 04:27:20 +1100 (EST)
Received: by yxk30 with SMTP id 30so434922yxk.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2011 10:27:17 -0700 (PDT)
Date: Fri, 21 Oct 2011 10:27:02 -0700
From: Olof Johansson <olof@lixom.net>
To: tmarri@apm.com
Subject: Re: [PATCH v15 01/10] USB/ppc4xx: Add Synopsys DesignWare HS USB OTG
 Register definitions
Message-ID: <20111021172702.GA27652@quad.lixom.net>
References: <1318630119-14165-1-git-send-email-tmarri@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318630119-14165-1-git-send-email-tmarri@apm.com>
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

On Fri, Oct 14, 2011 at 03:08:39PM -0700, tmarri@apm.com wrote:
> diff --git a/drivers/usb/dwc/regs.h b/drivers/usb/dwc/regs.h
> new file mode 100644
> index 0000000..d3694f3
> --- /dev/null
> +++ b/drivers/usb/dwc/regs.h

> +#define DWC_GCTL_BSESSION_VALID_RW(reg, x)	\
> +	(((reg) & (~((u32)0x01 << 19))) | ((x) << 19))
> +#define DWC_GCTL_CSESSION_VALID_RW(reg, x)	\
> +	(((reg) & (~((u32)0x01 << 18))) | ((x) << 18))
> +#define DWC_GCTL_DEBOUNCE_RW(reg, x)		\
> +	(((reg) & (~((u32)0x01 << 17))) | ((x) << 17))
> +#define DWC_GCTL_CONN_ID_STATUS_RW(reg, x)	\
> +	(((reg) & (~((u32)0x01 << 16))) | ((x) << 16))
> +#define DWC_GCTL_DEV_HNP_ENA_RW	(reg, x)	\
> +	(((reg) & (~((u32)0x01 << 11))) | ((x) << 11))
> +#define DWC_GCTL_HOST_HNP_ENA_RW(reg, x)	\
> +	(((reg) & (~((u32)0x01 << 10))) | ((x) << 10))
> +#define DWC_GCTL_HNP_REQ_RW(reg, x)		\
> +	(((reg) & (~((u32)0x01 << 9))) | ((x) << 9))
> +#define DWC_GCTL_HOST_NEG_SUCCES_RW(reg, x)	\
> +	(((reg) & (~((u32)0x01 << 8))) | ((x) << 8))
> +#define DWC_GCTL_SES_REQ_RW(reg, x)		\
> +	(((reg) & (~((u32)0x01 << 1))) | ((x) << 1))
> +#define DWC_GCTL_SES_REQ_SUCCESS_RW(reg, x)	\
> +	(((reg) & (~((u32)0x01 << 0))) | ((x) << 0))

Ouch! These could be done much more readable.

> +/*
> + * These Macros represents the bit fields in the FIFO Size Registers (HPTXFSIZ,
> + * GNPTXFSIZ, DPTXFSIZn). Read the register into the u32 element then
> + * read out the bits using the bit elements.
> + */
> +#define DWC_RX_FIFO_DEPTH_RD(reg)	(((reg) & ((u32)0xffff << 16)) >> 16)

What the...   What's wrong with ((reg >> 16) & 0xffff) here and everywhere
else?


-Olof
