Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [150.101.137.145])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xbwXg1ZCgzDqY9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 13:10:11 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, clombard@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/3] cxl: Mark context requiring global TLBIs
Date: Tue, 22 Aug 2017 13:09:44 +1000
Message-ID: <2098488.gckpkjsb17@new-mexico>
In-Reply-To: <CAKTCnz=f-Z4vg-1V2bsx-JGHPmnPdu_DGDNoSjsB17id=F57gQ@mail.gmail.com>
References: <20170802202930.5616-1-fbarrat@linux.vnet.ibm.com>
 <20170802202930.5616-3-fbarrat@linux.vnet.ibm.com>
 <CAKTCnz=f-Z4vg-1V2bsx-JGHPmnPdu_DGDNoSjsB17id=F57gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 3 Aug 2017 05:22:31 PM Balbir Singh wrote:
> On Thu, Aug 3, 2017 at 6:29 AM, Frederic Barrat
> <fbarrat@linux.vnet.ibm.com> wrote:
> > The PSL and XSL need to see all TLBIs pertinent to the memory contexts
> > used on the adapter. For the hash memory model, it is done by making
> > all TLBIs global as soon as the cxl driver is in use. For radix, we
> > need something similar, but we can refine and only convert to global
> > the invalidations for contexts actually used by the device.
> >
> > So mark the contexts being attached to the cxl adapter as requiring
> > global TLBIs.
> >
> 
> Looking at these bits, I'm wondering the previous code should check
> for CONFIG_CXL in mm_is_invalidation_local? That would pretty much cover
> BOOK3S_64

That won't work as we also need this for other nest MMU users which might
not have CONFIG_CXL set - for example the NPU the will use
mm_context_set_global_tlbi() for processes on the GPU.

Regards,

Alistair

> > Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> > ---
> >  drivers/misc/cxl/api.c    | 12 ++++++++++--
> >  drivers/misc/cxl/cxllib.c |  7 +++++++
> >  drivers/misc/cxl/file.c   | 12 ++++++++++--
> >  3 files changed, 27 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> > index 1a138c83f877..d3f3fdede755 100644
> > --- a/drivers/misc/cxl/api.c
> > +++ b/drivers/misc/cxl/api.c
> > @@ -332,8 +332,17 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
> >                 cxl_context_mm_count_get(ctx);
> >
> >                 /* decrement the use count */
> > -               if (ctx->mm)
> > +               if (ctx->mm) {
> >                         mmput(ctx->mm);
> > +#ifdef CONFIG_PPC_BOOK3S_64
> > +                       mm_context_set_global_tlbi(&ctx->mm->context);
> 
> Do we have CXL for non PPC_BOOK3S_64?
> 
> > +                       /*
> > +                        * Barrier guarantees that the device will
> > +                        * receive all TLBIs from that point on
> > +                        */
> > +                       wmb();
> 
> smp_wmb();
> 
> > +#endif
> > +               }
> >         }
> 
> The other comments are the same as this (in the snip'd code)
> 
> Balbir
