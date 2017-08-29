Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhhTg1zWHzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 07:24:07 +1000 (AEST)
Message-ID: <1504041817.2358.32.camel@kernel.crashing.org>
Subject: Re: [PATCH V3 6/6] crypto/nx: Add P9 NX support for 842 compression
 engine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Streetman <ddstreet@ieee.org>, Haren Myneni <haren@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Herbert Xu
 <herbert@gondor.apana.org.au>, Linux Crypto Mailing List
 <linux-crypto@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, mikey@neuling.org, suka@us.ibm.com, Ram
 Pai <linuxram@us.ibm.com>, npiggin@gmail.com, Haren Myneni
 <hbabu@us.ibm.com>
Date: Wed, 30 Aug 2017 07:23:37 +1000
In-Reply-To: <CALZtONBGVQy2iwkb8WpVd-_QG7bLFTvUbnuub6CCXP55YpQiSQ@mail.gmail.com>
References: <1500699702.23205.8.camel@hbabu-laptop>
 <CALZtONBGVQy2iwkb8WpVd-_QG7bLFTvUbnuub6CCXP55YpQiSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-29 at 09:58 -0400, Dan Streetman wrote:
> > +
> > +       ret = -EINVAL;
> > +       if (coproc && coproc->vas.rxwin) {
> > +               wmem->txwin = nx842_alloc_txwin(coproc);
> 
> this is wrong.  the workmem is scratch memory that's valid only for
> the duration of a single operation.
> 
> do you actually need a txwin per crypto transform?  or do you need a
> txwin per coprocessor?  or txwin per processor?  either per-coproc or
> per-cpu should be created at driver init and held separately
> (globally) instead of a per-transform txwin.  I really don't see why
> you would need a txwin per transform, because the coproc should not
> care how many different transforms there are.

We should only need a single window for the whole kernel really, plus
one per user process who wants direct access but that's not relevant
here.

Cheers,
Ben.
