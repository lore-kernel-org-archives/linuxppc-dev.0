Return-Path: <akpm@linux-foundation.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CC44FB711E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 15:04:35 +1000 (EST)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4499ADDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 15:04:34 +1000 (EST)
Date: Mon, 22 Jun 2009 22:04:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Richard =?ISO-8859-1?Q?R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>
Subject: Re: [RESEND][PATCH] SPI: xilinx_spi: Added platform driver and
	support for DS570
Message-Id: <20090622220419.a60dbe71.akpm@linux-foundation.org>
In-Reply-To: <4A366622.2050606@mocean-labs.com>
References: <4A366622.2050606@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: dbrownell@users.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	Andrei Konovalov <akonovalov@ru.mvista.com>, John,
	Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This appears to be a ppc thing, so let's cc that list.  Let's also cc
the driver's author and other contributors.  Please cc these people on
future versions of the patch also.

On Mon, 15 Jun 2009 17:17:54 +0200 Richard R__jfors <richard.rojfors.ext@mocean-labs.com> wrote:

> This patch splits xilinx_spi into three parts, an OF and a platform
> driver and generic part.
> 
> The generic part now also works on X86 and also supports the Xilinx
> SPI IP DS570
> 
>
> ...
>
> +#ifndef CONFIG_PPC
> +#define in_8(addr) ioread8(addr)
> +#define in_be16(addr) ioread16(addr)
> +#define in_be32(addr) ioread32(addr)
> +
> +#define out_8(addr, b) iowrite8(b, addr)
> +#define out_be16(addr, w) iowrite16(w, addr)
> +#define out_be32(addr, l) iowrite32(l, addr)
> +#endif

Why do we need these?

> +#define XSPI_WRITE8(xspi, offs, val) \
> +	do { \
> +		if (xspi->model == XILINX_SPI_MODEL_DS464) \
> +			out_8(xspi->regs + offs, (val) & 0xff); \
> +		else \
> +			XSPI_WRITE32(xspi, offs, val); \
> +	} while (0)
> +
> +#define XSPI_WRITE16(xspi, offs, val) \
> +	do { \
> +		if (xspi->model == XILINX_SPI_MODEL_DS464) \
> +			out_be16(xspi->regs + offs, (val) & 0xffff); \
> +		else \
> +			XSPI_WRITE32(xspi, offs, val); \
> +	} while (0)
> +
> +#define XSPI_WRITE32(xspi, offs, val) \
> +	out_be32(xspi->regs + offs, val)
> +
> +#define XSPI_READ8(xspi, offs) \
> +	(xspi->model == XILINX_SPI_MODEL_DS464) ? \
> +		in_8(xspi->regs + offs) : XSPI_READ32(xspi, offs)
> +
> +#define XSPI_READ16(xspi, offs) \
> +	(xspi->model == XILINX_SPI_MODEL_DS464) ? \
> +	in_be16(xspi->regs + offs) : XSPI_READ32(xspi, offs)
> +
> +#define XSPI_READ32(xspi, offs) \
> +	in_be32(xspi->regs + offs)

I'm seeing no reason why these had to be implemented as macros. 
They're ugly, add considerable code bloat and, because they evaluate
their args multiple times they will fail if passed as expression with
side-effects.

I suggest that they be reimplemented as lower-case, uninlined C functions.
