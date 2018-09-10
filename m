Return-Path: <clabbe@baylibre.com>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428HCQ1CrTzF382
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 04:49:36 +1000 (AEST)
Received: by mail-wr1-x441.google.com with SMTP id 20-v6so23026774wrb.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 11:49:36 -0700 (PDT)
Date: Mon, 10 Sep 2018 20:49:29 +0200
From: LABBE Corentin <clabbe@baylibre.com>
To: Scott Wood <oss@buserror.net>
Cc: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
 alexandre.torgue@st.com, alistair@popple.id.au,
 benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
 galak@kernel.crashing.org, joabreu@synopsys.com,
 khilman@baylibre.com, maxime.ripard@bootlin.com,
 michal.lkml@markovi.net, mpe@ellerman.id.au,
 mporter@kernel.crashing.org, nicolas.palix@imag.fr,
 paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org,
 vitb@kernel.crashing.org, wens@csie.org, cocci@systeme.lip6.fr,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/5] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
 linux/setbits.h
Message-ID: <20180910184929.GA7819@Red>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
 <1536349307-20714-3-git-send-email-clabbe@baylibre.com>
 <8bfa1740800ca494028350addd7c874a8b4804bb.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8bfa1740800ca494028350addd7c874a8b4804bb.camel@buserror.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2018 at 03:00:40PM -0500, Scott Wood wrote:
> On Fri, 2018-09-07 at 19:41 +0000, Corentin Labbe wrote:
> > This patch adds setbits32/clrbits32/clrsetbits32 and
> > setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  include/linux/setbits.h | 55
> > +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644 include/linux/setbits.h
> > 
> > diff --git a/include/linux/setbits.h b/include/linux/setbits.h
> > new file mode 100644
> > index 000000000000..3e1e273551bb
> > --- /dev/null
> > +++ b/include/linux/setbits.h
> > @@ -0,0 +1,55 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __LINUX_SETBITS_H
> > +#define __LINUX_SETBITS_H
> > +
> > +#include <linux/io.h>
> > +
> > +#define __setbits(readfunction, writefunction, addr, set) \
> > +	writefunction((readfunction(addr) | (set)), addr)
> > +#define __clrbits(readfunction, writefunction, addr, mask) \
> > +	writefunction((readfunction(addr) & ~(mask)), addr)
> > +#define __clrsetbits(readfunction, writefunction, addr, mask, set) \
> > +	writefunction(((readfunction(addr) & ~(mask)) | (set)), addr)
> > +#define __setclrbits(readfunction, writefunction, addr, mask, set) \
> > +	writefunction(((readfunction(addr) | (seti)) & ~(mask)), addr)
> > +
> > +#define setbits32(addr, set) __setbits(readl, writel, addr, set)
> > +#define setbits32_relaxed(addr, set) __setbits(readl_relaxed,
> > writel_relaxed, \
> > +					       addr, set)
> > +
> > +#define clrbits32(addr, mask) __clrbits(readl, writel, addr, mask)
> > +#define clrbits32_relaxed(addr, mask) __clrbits(readl_relaxed,
> > writel_relaxed, \
> > +						addr, mask)
> 
> So now setbits32/clrbits32 is implicitly little-endian?  Introducing new
> implicit-endian accessors is probably a bad thing in general, but doing it
> with a name that until this patchset was implicitly big-endian (at least on
> powerpc) seems worse.  Why not setbits32_le()?
> 

I believed that writel/readl was endian agnostic, but It seems that I was wrong.
So I will use _le32.

> 
> > +
> > +#define clrsetbits32(addr, mask, set) __clrsetbits(readl, writel, addr,
> > mask, set)
> > +#define clrsetbits32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
> > +							   writel_relaxed,
> > \
> > +							   addr, mask, set)
> > +
> > +#define setclrbits32(addr, mask, set) __setclrbits(readl, writel, addr,
> > mask, set)
> > +#define setclrbits32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
> > +							   writel_relaxed,
> > \
> > +							   addr, mask, set)
> 
> What's the use case for setclrbits?  I don't see it used anywhere in this
> patchset (not even in the coccinelle patterns), it doesn't seem like it would
> be a common pattern, and it could easily get confused with clrsetbits.
> 

It is absent from the coccinelle script due to copy/paste error.
And absent from patchset since it is only two possible example that I can test.

If you run the next fixed coccinelle script, you will find some setclrbits.
Since I fear that mask and set could have some common bits sometimes, I prefer to keep separate clrsetbits and setclrbits.

Regards
