Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41m60g4hFqzDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 08:45:23 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id d5-v6so1660564pll.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Aug 2018 15:45:22 -0700 (PDT)
Date: Thu, 9 Aug 2018 08:45:10 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>, Mahesh Jagannath Salgaonkar
 <mahesh@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/64s: move machine check SLB flushing to
 mm/slb.c
Message-ID: <20180809084510.351c4870@roar.ozlabs.ibm.com>
In-Reply-To: <20180808222252.5be0feac@kitsune.suse.cz>
References: <20180803041350.25493-1-npiggin@gmail.com>
 <20180808222252.5be0feac@kitsune.suse.cz>
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

On Wed, 8 Aug 2018 22:22:52 +0200
Michal Such=C3=A1nek <msuchanek@suse.de> wrote:

> On Fri,  3 Aug 2018 14:13:49 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
> > The machine check code that flushes and restores bolted segments in
> > real mode belongs in mm/slb.c. This will be used by pseries machine
> > check and idle code.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  3 ++
> >  arch/powerpc/kernel/mce_power.c               | 21 ++--------
> >  arch/powerpc/mm/slb.c                         | 38
> > +++++++++++++++++++ 3 files changed, 44 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> > b/arch/powerpc/include/asm/book3s/64/mmu-hash.h index
> > 2f74bdc805e0..d4e398185b3a 100644 ---
> > a/arch/powerpc/include/asm/book3s/64/mmu-hash.h +++
> > b/arch/powerpc/include/asm/book3s/64/mmu-hash.h @@ -497,6 +497,9 @@
> > extern void hpte_init_native(void);=20
> >  extern void slb_initialize(void);
> >  extern void slb_flush_and_rebolt(void);
> > +extern void slb_flush_all_realmode(void);
> > +extern void __slb_restore_bolted_realmode(void);
> > +extern void slb_restore_bolted_realmode(void);
> > =20
> >  extern void slb_vmalloc_update(void);
> >  extern void slb_set_size(u16 size);
> > diff --git a/arch/powerpc/kernel/mce_power.c
> > b/arch/powerpc/kernel/mce_power.c index d6756af6ec78..50f7b9817246
> > 100644 --- a/arch/powerpc/kernel/mce_power.c
> > +++ b/arch/powerpc/kernel/mce_power.c
> > @@ -62,11 +62,8 @@ static unsigned long addr_to_pfn(struct pt_regs
> > *regs, unsigned long addr) #ifdef CONFIG_PPC_BOOK3S_64
> >  static void flush_and_reload_slb(void)
> >  {
> > -	struct slb_shadow *slb;
> > -	unsigned long i, n;
> > -
> >  	/* Invalidate all SLBs */
> > -	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
> > +	slb_flush_all_realmode();
> > =20
> >  #ifdef CONFIG_KVM_BOOK3S_HANDLER
> >  	/*
> > @@ -76,22 +73,10 @@ static void flush_and_reload_slb(void)
> >  	if (get_paca()->kvm_hstate.in_guest)
> >  		return;
> >  #endif
> > -
> > -	/* For host kernel, reload the SLBs from shadow SLB buffer.
> > */
> > -	slb =3D get_slb_shadow();
> > -	if (!slb)
> > +	if (early_radix_enabled())
> >  		return; =20
>=20
> And we lose the check that the shadow slb exists. Is !slb equivalent to
> early_radix_enabled()=20

Yeah pretty close to.

>=20
> > =20
> > -	n =3D min_t(u32, be32_to_cpu(slb->persistent), SLB_MIN_SIZE);
> > -
> > -	/* Load up the SLB entries from shadow SLB */
> > -	for (i =3D 0; i < n; i++) {
> > -		unsigned long rb =3D
> > be64_to_cpu(slb->save_area[i].esid);
> > -		unsigned long rs =3D
> > be64_to_cpu(slb->save_area[i].vsid); -
> > -		rb =3D (rb & ~0xFFFul) | i;
> > -		asm volatile("slbmte %0,%1" : : "r" (rs), "r" (rb));
> > -	}
> > +	slb_restore_bolted_realmode();
> >  }
> >  #endif
> > =20
> > diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> > index cb796724a6fc..136db8652577 100644
> > --- a/arch/powerpc/mm/slb.c
> > +++ b/arch/powerpc/mm/slb.c
> > @@ -90,6 +90,44 @@ static inline void create_shadowed_slbe(unsigned
> > long ea, int ssize, : "memory" );
> >  }
> > =20
> > +/*
> > + * Insert bolted entries into SLB (which may not be empty).
> > + */
> > +void __slb_restore_bolted_realmode(void)
> > +{
> > +	struct slb_shadow *p =3D get_slb_shadow();
> > +	enum slb_index index; =20
>=20
> or can we get here at some point when shadow slb is not populated?

We shouldn't because we won't turn the MMU on so we shouldn't get SLB
MCEs... But I don't think that's guaranteed anywhere, so yeah wouldn't
hurt to add that check back in.

I'll send out another revision.

Thanks,
Nick
