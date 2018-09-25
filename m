Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42K8C70y8jzDrhS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 15:05:07 +1000 (AEST)
Subject: Re: [PATCH v2 2/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
 linux/setbits.h
To: Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr,
 Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie,
 alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org,
 carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org,
 joabreu@synopsys.com, khilman@baylibre.com, maxime.ripard@bootlin.com,
 michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org,
 narmstrong@baylibre.com, nicolas.palix@imag.fr, oss@buserror.net,
 paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org,
 vitb@kernel.crashing.org, wens@csie.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-3-git-send-email-clabbe@baylibre.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <4a63152f-9eca-f7d9-8fe6-59caaab33666@c-s.fr>
Date: Tue, 25 Sep 2018 07:05:00 +0200
MIME-Version: 1.0
In-Reply-To: <1537815856-31728-3-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 24/09/2018 à 21:04, Corentin Labbe a écrit :
> This patch adds setbits32/clrbits32/clrsetbits32 and
> setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.

Fix the patch subject and description.

> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>   include/linux/setbits.h | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 88 insertions(+)
>   create mode 100644 include/linux/setbits.h
> 
> diff --git a/include/linux/setbits.h b/include/linux/setbits.h
> new file mode 100644
> index 000000000000..6e7e257134ae
> --- /dev/null
> +++ b/include/linux/setbits.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_SETBITS_H
> +#define __LINUX_SETBITS_H
> +
> +#include <linux/io.h>
> +
> +#define __setbits(readfunction, writefunction, addr, set) \
> +	writefunction((readfunction(addr) | (set)), addr)

You don't need so long names for parameters in a 2 lines macro (See 
Linux Kernel Codying style §4 Naming).

A single line macro would be feasible with only 3 chars names:

#define __setbits(rfn, wfn, addr, set) wfn((rfn(addr) | (set)), addr)

> +#define __clrbits(readfunction, writefunction, addr, mask) \
> +	writefunction((readfunction(addr) & ~(mask)), addr)
> +#define __clrsetbits(readfunction, writefunction, addr, mask, set) \
> +	writefunction(((readfunction(addr) & ~(mask)) | (set)), addr)
> +#define __setclrbits(readfunction, writefunction, addr, mask, set) \
> +	writefunction(((readfunction(addr) | (set)) & ~(mask)), addr)
> +
> +#ifndef setbits_le32
> +#define setbits_le32(addr, set) __setbits(readl, writel, addr, set)
> +#endif
> +#ifndef setbits_le32_relaxed
> +#define setbits_le32_relaxed(addr, set) __setbits(readl_relaxed, writel_relaxed, \
> +					       addr, set)
> +#endif
> +
> +#ifndef clrbits_le32
> +#define clrbits_le32(addr, mask) __clrbits(readl, writel, addr, mask)
> +#endif
> +#ifndef clrbits_le32_relaxed
> +#define clrbits_le32_relaxed(addr, mask) __clrbits(readl_relaxed, writel_relaxed, \
> +						addr, mask)
> +#endif
> +
> +#ifndef clrsetbits_le32
> +#define clrsetbits_le32(addr, mask, set) __clrsetbits(readl, writel, addr, mask, set)
> +#endif
> +#ifndef clrsetbits_le32_relaxed
> +#define clrsetbits_le32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
> +							   writel_relaxed, \
> +							   addr, mask, set)
> +#endif
> +
> +#ifndef setclrbits_le32
> +#define setclrbits_le32(addr, mask, set) __setclrbits(readl, writel, addr, mask, set)
> +#endif
> +#ifndef setclrbits_le32_relaxed
> +#define setclrbits_le32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
> +							   writel_relaxed, \
> +							   addr, mask, set)
> +#endif
> +
> +/* We cannot use CONFIG_64BIT as some x86 drivers use non-atomicwriteq() */
> +#if defined(writeq) && defined(readq)

Take care. At least Alpha Arch defines it as a static inline without
redefining it as a #define. (see arch/alpha/kernel/io.c)

Christophe

> +#ifndef setbits_le64
> +#define setbits_le64(addr, set) __setbits(readq, writeq, addr, set)
> +#endif
> +#ifndef setbits_le64_relaxed
> +#define setbits_le64_relaxed(addr, set) __setbits(readq_relaxed, writeq_relaxed, \
> +					       addr, set)
> +#endif
> +
> +#ifndef clrbits_le64
> +#define clrbits_le64(addr, mask) __clrbits(readq, writeq, addr, mask)
> +#endif
> +#ifndef clrbits_le64_relaxed
> +#define clrbits_le64_relaxed(addr, mask) __clrbits(readq_relaxed, writeq_relaxed, \
> +						addr, mask)
> +#endif
> +
> +#ifndef clrsetbits_le64
> +#define clrsetbits_le64(addr, mask, set) __clrsetbits(readq, writeq, addr, mask, set)
> +#endif
> +#ifndef clrsetbits_le64_relaxed
> +#define clrsetbits_le64_relaxed(addr, mask, set) __clrsetbits(readq_relaxed, \
> +							   writeq_relaxed, \
> +							   addr, mask, set)
> +#endif
> +
> +#ifndef setclrbits_le64
> +#define setclrbits_le64(addr, mask, set) __setclrbits(readq, writeq, addr, mask, set)
> +#endif
> +#ifndef setclrbits_le64_relaxed
> +#define setclrbits_le64_relaxed(addr, mask, set) __setclrbits(readq_relaxed, \
> +							   writeq_relaxed, \
> +							   addr, mask, set)
> +#endif
> +
> +#endif /* writeq/readq */
> +
> +#endif /* __LINUX_SETBITS_H */
> 
