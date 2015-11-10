Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AAD7D1A0225
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 15:57:49 +1100 (AEDT)
Message-ID: <1447131469.13889.27.camel@ellerman.id.au>
Subject: Re: [PATCH v2] of: Check for overlap in reserved memory regions
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh+dt@kernel.org>
Cc: Mitchel Humpherys <mitchelh@codeaurora.org>, Frank Rowand
 <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 10 Nov 2015 15:57:49 +1100
In-Reply-To: <CAL_JsqLAxTF6DgwHNN94iQyds-rmchKS4Tx+8U7sSbAvGHMg9Q@mail.gmail.com>
References: <1442367036-15205-1-git-send-email-mitchelh@codeaurora.org>
 <1447129784.13889.25.camel@ellerman.id.au>
 <CAL_JsqLAxTF6DgwHNN94iQyds-rmchKS4Tx+8U7sSbAvGHMg9Q@mail.gmail.com>
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

On Mon, 2015-11-09 at 22:41 -0600, Rob Herring wrote:
> On Mon, Nov 9, 2015 at 10:29 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Tue, 2015-09-15 at 18:30 -0700, Mitchel Humpherys wrote:
> > > Any overlap in the reserved memory regions (those specified in the
> > > reserved-memory DT node) is a bug.  These bugs might go undetected as
> > > long as the contested region isn't used simultaneously by multiple
> > > software agents, which makes such bugs hard to debug.  Fix this by
> > > printing a scary warning during boot if overlap is detected.
> > > 
> > > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> > > index 726ebe792813..62f467b8ccae 100644
> > > --- a/drivers/of/of_reserved_mem.c
> > > +++ b/drivers/of/of_reserved_mem.c
> > > @@ -197,12 +198,52 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
> > >       return -ENOENT;
> > >  }
> > > 
> > > +static int __init __rmem_cmp(const void *a, const void *b)
> > > +{
> > > +     const struct reserved_mem *ra = a, *rb = b;
> > > +
> > > +     return ra->base - rb->base;
> > > +}
> > > +
> > > +static void __init __rmem_check_for_overlap(void)
> > > +{
> > > +     int i;
> > > +
> > > +     if (reserved_mem_count < 2)
> > > +             return;
> > > +
> > > +     sort(reserved_mem, reserved_mem_count, sizeof(reserved_mem[0]),
> > > +          __rmem_cmp, NULL);
> > > +     for (i = 0; i < reserved_mem_count - 1; i++) {
> > > +             struct reserved_mem *this, *next;
> > > +
> > > +             this = &reserved_mem[i];
> > > +             next = &reserved_mem[i + 1];
> > > +             if (!(this->base && next->base))
> > > +                     continue;
> > > +             if (this->base + this->size > next->base) {
> > > +                     phys_addr_t this_end, next_end;
> > > +
> > > +                     this_end = this->base + this->size;
> > > +                     next_end = next->base + next->size;
> > > +                     WARN(1,
> > > +                          "Reserved memory: OVERLAP DETECTED!\n%s (%pa--%pa) overlaps with %s (%pa--%pa)\n",
> > > +                          this->name, &this->base, &this_end,
> > > +                          next->name, &next->base, &next_end);
> > 
> > This is blowing up on some powerpc machines.
> > 
> > It's too early in boot to call WARN() on these systems.
> 
> I didn't realize WARN could not be used early. Good to know.

Yeah, it's a bit horrible.

It used to be even worse, we'd take a recursive trap and you'd get nothing
useful at all. Ben fixed that, which makes BUG work but not WARN, because WARN
requires you to take the trap _and return_. We should be able to fix it in the
medium term, but not immediately.

> > Can we turn it into a pr_err() for now?
> 
> Sounds fine.

> > I'll send a patch?
> 
> Great.

Thanks. I'll just test the final version and then send.

cheers
