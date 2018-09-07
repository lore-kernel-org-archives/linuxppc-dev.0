Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426TNC6FByzF370
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 06:20:59 +1000 (AEST)
Message-ID: <8bfa1740800ca494028350addd7c874a8b4804bb.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr,
 Julia.Lawall@lip6.fr, agust@denx.de, alexandre.torgue@st.com,
 alistair@popple.id.au, benh@kernel.crashing.org, carlo@caione.org,
 davem@davemloft.net, galak@kernel.crashing.org, joabreu@synopsys.com,
 khilman@baylibre.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net,
 mpe@ellerman.id.au, mporter@kernel.crashing.org, nicolas.palix@imag.fr,
 paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org,
 vitb@kernel.crashing.org,  wens@csie.org
Cc: cocci@systeme.lip6.fr, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-sunxi@googlegroups.com
Date: Fri, 07 Sep 2018 15:00:40 -0500
In-Reply-To: <1536349307-20714-3-git-send-email-clabbe@baylibre.com>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
 <1536349307-20714-3-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 2/5] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
 linux/setbits.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-09-07 at 19:41 +0000, Corentin Labbe wrote:
> This patch adds setbits32/clrbits32/clrsetbits32 and
> setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  include/linux/setbits.h | 55
> +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 include/linux/setbits.h
> 
> diff --git a/include/linux/setbits.h b/include/linux/setbits.h
> new file mode 100644
> index 000000000000..3e1e273551bb
> --- /dev/null
> +++ b/include/linux/setbits.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_SETBITS_H
> +#define __LINUX_SETBITS_H
> +
> +#include <linux/io.h>
> +
> +#define __setbits(readfunction, writefunction, addr, set) \
> +	writefunction((readfunction(addr) | (set)), addr)
> +#define __clrbits(readfunction, writefunction, addr, mask) \
> +	writefunction((readfunction(addr) & ~(mask)), addr)
> +#define __clrsetbits(readfunction, writefunction, addr, mask, set) \
> +	writefunction(((readfunction(addr) & ~(mask)) | (set)), addr)
> +#define __setclrbits(readfunction, writefunction, addr, mask, set) \
> +	writefunction(((readfunction(addr) | (seti)) & ~(mask)), addr)
> +
> +#define setbits32(addr, set) __setbits(readl, writel, addr, set)
> +#define setbits32_relaxed(addr, set) __setbits(readl_relaxed,
> writel_relaxed, \
> +					       addr, set)
> +
> +#define clrbits32(addr, mask) __clrbits(readl, writel, addr, mask)
> +#define clrbits32_relaxed(addr, mask) __clrbits(readl_relaxed,
> writel_relaxed, \
> +						addr, mask)

So now setbits32/clrbits32 is implicitly little-endian?  Introducing new
implicit-endian accessors is probably a bad thing in general, but doing it
with a name that until this patchset was implicitly big-endian (at least on
powerpc) seems worse.  Why not setbits32_le()?


> +
> +#define clrsetbits32(addr, mask, set) __clrsetbits(readl, writel, addr,
> mask, set)
> +#define clrsetbits32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
> +							   writel_relaxed,
> \
> +							   addr, mask, set)
> +
> +#define setclrbits32(addr, mask, set) __setclrbits(readl, writel, addr,
> mask, set)
> +#define setclrbits32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
> +							   writel_relaxed,
> \
> +							   addr, mask, set)

What's the use case for setclrbits?  I don't see it used anywhere in this
patchset (not even in the coccinelle patterns), it doesn't seem like it would
be a common pattern, and it could easily get confused with clrsetbits.

-Scott
