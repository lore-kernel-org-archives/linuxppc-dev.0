Return-Path: <npiggin@gmail.com>
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zR2j1f3KzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 19:11:24 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id ba4-v6so3887883plb.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 02:11:24 -0700 (PDT)
Date: Mon, 27 Aug 2018 19:11:16 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <pmac@au1.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/64s/radix: Explicitly flush ERAT with local
 LPID invalidation
Message-ID: <20180827191116.4c013e8a@roar.ozlabs.ibm.com>
In-Reply-To: <9fd2cb24976fc3b4534d7ab6186032ac4e27c9d5.camel@kernel.crashing.org>
References: <20180827030302.17541-1-npiggin@gmail.com>
 <20180827030302.17541-3-npiggin@gmail.com>
 <9fd2cb24976fc3b4534d7ab6186032ac4e27c9d5.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 27 Aug 2018 18:16:05 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2018-08-27 at 13:03 +1000, Nicholas Piggin wrote:
> > Local radix TLB flush operations that operate on congruence classes
> > have explicit ERAT flushes for POWER9. The process scoped LPID flush
> > did not have a flush, so add it. =20
>=20
> Paul, is that an actual bug ? I think the ERAT is flushed on LPID
> changes...

We also have a PPC_INVALIDATE_ERAT in tlbiel_lpid. I'd like to add some
comments for these things because I'm not entirely clear on them myself.

The P9 UM says, "Additionally, mtpidr and mtlpidr instructions perform
an implicit slbia with IH =3D x=E2=80=983=E2=80=99."

Although slbia IH=3D3 does not appear to invalidate LPID!=3D0 && PID=3D=3D0
entries (guest OS mappigs).

The UM also says that tlbiels will clear the involved ERATs, but this
might not match hardware?

Thanks,
Nick

>=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/mm/tlb-radix.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> > index fef3e1eb3a19..4e798f33c530 100644
> > --- a/arch/powerpc/mm/tlb-radix.c
> > +++ b/arch/powerpc/mm/tlb-radix.c
> > @@ -366,6 +366,7 @@ static inline void _tlbiel_lpid_guest(unsigned long=
 lpid, unsigned long ric)
> >  		__tlbiel_lpid_guest(lpid, set, RIC_FLUSH_TLB);
> > =20
> >  	asm volatile("ptesync": : :"memory");
> > +	asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
> >  }
> > =20
> >   =20
>=20
