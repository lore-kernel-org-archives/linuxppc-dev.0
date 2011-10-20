Return-Path: <pratyush.anand@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B84B5B70C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 19:42:59 +1100 (EST)
Received: by gyg8 with SMTP id 8so2725189gyg.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 01:42:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1318630119-14165-1-git-send-email-tmarri@apm.com>
References: <1318630119-14165-1-git-send-email-tmarri@apm.com>
Date: Thu, 20 Oct 2011 14:12:55 +0530
Message-ID: <CAHM4w1mPvvXM6fwQSuFT6=PdgwSnqdRkqNoCL5EzOpfNHR1fUA@mail.gmail.com>
Subject: Re: [PATCH v15 01/10] USB/ppc4xx: Add Synopsys DesignWare HS USB OTG
 Register definitions
From: Pratyush Anand <pratyush.anand@gmail.com>
To: tmarri@apm.com
Content-Type: text/plain; charset=ISO-8859-1
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

On Sat, Oct 15, 2011 at 3:38 AM,  <tmarri@apm.com> wrote:
> From: Tirumala Marri <tmarri@apm.com>
>
[...]

> +/*
> + * These Macros represents the bit fields in the FIFO Size Registers (HPTXFSIZ,
> + * GNPTXFSIZ, DPTXFSIZn). Read the register into the u32 element then
> + * read out the bits using the bit elements.
> + */
> +#define DWC_RX_FIFO_DEPTH_RD(reg)      (((reg) & ((u32)0xffff << 16)) >> 16)
> +#define DWC_RX_FIFO_DEPTH_WR(reg, x)   \
> +       (((reg) & (~((u32)0xffff << 16))) | ((x) << 16))
> +#define DWC_RX_FIFO_START_ADDR_RD(reg)         ((reg) & 0xffff)
> +#define DWC_RX_FIFO_START_ADDR_WR(reg, x)      \
> +       (((reg) & (~((u32)0xffff))) | (x))
> +

These are GNPTX  and DPTX registers.
So name should be DWC_TX_FIFO_DEPTH_RD rather than DWC_RX_FIFO_DEPTH_RD.
Same for other defines.


> +/*
> + * These Macros represents the bit fields in the Non-Periodic Tx FIFO/Queue
> +

[...]

> +#define MAX_PERIO_FIFOS                        15      /* Max periodic FIFOs */
> +#define MAX_TX_FIFOS                   15      /* Max non-periodic FIFOs */
> +
> +/* Maximum number of Endpoints/HostChannels */
> +#define MAX_EPS_CHANNELS 12    /* This come from device tree or defconfig */

There could be some platform even with 16 channels (as specs permits it.)
So, please make it 16.
