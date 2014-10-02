Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 078F31A181E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 17:10:05 +1000 (EST)
Message-ID: <1412233804.6143.24.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 09/17] powerpc/mm: Add new hash_page_mm()
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 02 Oct 2014 17:10:04 +1000
In-Reply-To: <8761g4nn12.fsf@linux.vnet.ibm.com>
References: <1412073306-13812-1-git-send-email-mikey@neuling.org>
 <1412073306-13812-10-git-send-email-mikey@neuling.org>
 <8761g4nn12.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, anton@samba.org,
 imunsie@au1.ibm.com, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-01 at 15:13 +0530, Aneesh Kumar K.V wrote:
> Michael Neuling <mikey@neuling.org> writes:
>=20
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >
> > This adds a new function hash_page_mm() based on the existing hash_page=
().
> > This version allows any struct mm to be passed in, rather than assuming
> > current.  This is useful for servicing co-processor faults which are no=
t in the
> > context of the current running process.
> >
> > We need to be careful here as the current hash_page() assumes current i=
n a few
> > places.
>=20
> It would be nice to document the rules here. So when we try to add a hash
> page entry, and if that result in demotion of the segment are we suppose =
to
> flush slbs ?=20

Yeah, we found it sucky to understand.  The current documentation is
"buy benh a beer and ask him" which doesn't scale very well unless
you're benh and you like beer.

> Also why would one want to hash anything other
> than current->mm ? How will this get called ?=20

We are calling this on behalf of a co-processor (eg cxl).  The mm this
is currently associated with may not be running on a cpu. =20

> May be they are explained in later patches. But can we also explain it
> here.=20

Ok, I'll add something (mpe had the same question).

Mikey
>=20
> >
> > Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> >  arch/powerpc/include/asm/mmu-hash64.h |  1 +
> >  arch/powerpc/mm/hash_utils_64.c       | 22 ++++++++++++++--------
> >  2 files changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/inclu=
de/asm/mmu-hash64.h
> > index 6d0b7a2..f84e5a5 100644
> > --- a/arch/powerpc/include/asm/mmu-hash64.h
> > +++ b/arch/powerpc/include/asm/mmu-hash64.h
> > @@ -322,6 +322,7 @@ extern int __hash_page_64K(unsigned long ea, unsign=
ed long access,
> >  			   unsigned int local, int ssize);
> >  struct mm_struct;
> >  unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int =
trap);
> > +extern int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsign=
ed long access, unsigned long trap);
> >  extern int hash_page(unsigned long ea, unsigned long access, unsigned =
long trap);
> >  int __hash_page_huge(unsigned long ea, unsigned long access, unsigned =
long vsid,
> >  		     pte_t *ptep, unsigned long trap, int local, int ssize,
> > diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_uti=
ls_64.c
> > index bbdb054..0a5c8c0 100644
> > --- a/arch/powerpc/mm/hash_utils_64.c
> > +++ b/arch/powerpc/mm/hash_utils_64.c
> > @@ -904,7 +904,7 @@ void demote_segment_4k(struct mm_struct *mm, unsign=
ed long addr)
> >  		return;
> >  	slice_set_range_psize(mm, addr, 1, MMU_PAGE_4K);
> >  	copro_flush_all_slbs(mm);
> > -	if (get_paca_psize(addr) !=3D MMU_PAGE_4K) {
> > +	if ((get_paca_psize(addr) !=3D MMU_PAGE_4K) && (current->mm =3D=3D mm=
)) {
> >  		get_paca()->context =3D mm->context;
> >  		slb_flush_and_rebolt();
> >  	}
> > @@ -989,26 +989,24 @@ static void check_paca_psize(unsigned long ea, st=
ruct mm_struct *mm,
> >   * -1 - critical hash insertion error
> >   * -2 - access not permitted by subpage protection mechanism
> >   */
> > -int hash_page(unsigned long ea, unsigned long access, unsigned long tr=
ap)
> > +int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsigned long=
 access, unsigned long trap)
> >  {
> >  	enum ctx_state prev_state =3D exception_enter();
> >  	pgd_t *pgdir;
> >  	unsigned long vsid;
> > -	struct mm_struct *mm;
> >  	pte_t *ptep;
> >  	unsigned hugeshift;
> >  	const struct cpumask *tmp;
> >  	int rc, user_region =3D 0, local =3D 0;
> >  	int psize, ssize;
> > =20
> > -	DBG_LOW("hash_page(ea=3D%016lx, access=3D%lx, trap=3D%lx\n",
> > -		ea, access, trap);
> > +	DBG_LOW("%s(ea=3D%016lx, access=3D%lx, trap=3D%lx\n",
> > +		__func__, ea, access, trap);
> > =20
> >  	/* Get region & vsid */
> >   	switch (REGION_ID(ea)) {
> >  	case USER_REGION_ID:
> >  		user_region =3D 1;
> > -		mm =3D current->mm;
> >  		if (! mm) {
> >  			DBG_LOW(" user region with no mm !\n");
> >  			rc =3D 1;
> > @@ -1104,7 +1102,8 @@ int hash_page(unsigned long ea, unsigned long acc=
ess, unsigned long trap)
> >  			WARN_ON(1);
> >  		}
> >  #endif
> > -		check_paca_psize(ea, mm, psize, user_region);
> > +		if (current->mm =3D=3D mm)
> > +			check_paca_psize(ea, mm, psize, user_region);
> > =20
> >  		goto bail;
> >  	}
> > @@ -1145,7 +1144,8 @@ int hash_page(unsigned long ea, unsigned long acc=
ess, unsigned long trap)
> >  		}
> >  	}
> > =20
> > -	check_paca_psize(ea, mm, psize, user_region);
> > +	if (current->mm =3D=3D mm)
> > +		check_paca_psize(ea, mm, psize, user_region);
> >  #endif /* CONFIG_PPC_64K_PAGES */
> > =20
> >  #ifdef CONFIG_PPC_HAS_HASH_64K
> > @@ -1180,6 +1180,12 @@ bail:
> >  	exception_exit(prev_state);
> >  	return rc;
> >  }
> > +EXPORT_SYMBOL_GPL(hash_page_mm);
> > +
> > +int hash_page(unsigned long ea, unsigned long access, unsigned long tr=
ap)
> > +{
> > +	return hash_page_mm(current->mm, ea, access, trap);
> > +}
> >  EXPORT_SYMBOL_GPL(hash_page);
> > =20
> >  void hash_preload(struct mm_struct *mm, unsigned long ea,
> > --=20
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>=20
