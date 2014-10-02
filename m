Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A93781A190A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 17:39:24 +1000 (EST)
Message-ID: <1412235563.6143.33.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 09/17] powerpc/mm: Add new hash_page_mm()
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 02 Oct 2014 17:39:23 +1000
In-Reply-To: <20141002034855.8E3D514017E@ozlabs.org>
References: <20141002034855.8E3D514017E@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, "Aneesh
 Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 anton@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-02 at 13:48 +1000, Michael Ellerman wrote:
> On Tue, 2014-30-09 at 10:34:58 UTC, Michael Neuling wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >=20
> > This adds a new function hash_page_mm() based on the existing hash_page=
().
> > This version allows any struct mm to be passed in, rather than assuming
> > current.  This is useful for servicing co-processor faults which are no=
t in the
> > context of the current running process.
>=20
> I'm not a big fan. hash_page() is already a train wreck, and this doesn't=
 make
> it any better.

I can document it to make the situation a bit better.  It's certainly
not clear which one to use here and under what circumstances.  It's
basically ask benh territory. =20

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
>=20
> This is a bit fishy.
>=20
> If that mm is currently running on another cpu you just failed to update =
it's
> paca. But I think the call to check_paca_psize() in hash_page() will save=
 you
> on that cpu.
>=20
> In fact we might be able to remove that synchronisation from
> demote_segment_4k() and always leave it up to check_paca_psize()?

Aneesh asked the same thing for v1 and we convinced ourselves it was ok.
I said this at the time...

I had a chat to benh offline about this and he thinks it's fine.  A
running process in the same mm context will either have hit this mapping
or not.  If it's hit it, the page will be invalidated and it'll come in
via hash_page and have it's segment demoted also (and paca updated).  If
it hasn't hit, again it'll come into hash_page() and get demoted also.

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
>=20
> What about the VMALLOC case where we do:
> 		mm =3D &init_mm;
> 	=09
> Is that what you want? It seems odd that you pass an mm to the routine, b=
ut
> then potentially it ends up using a different mm after all depending on t=
he
> address.

Good point.  We have hash_page() still.  I can make that check in there
and decide which mm to use and pass that to hash_page_mm().   Then we
always use mm in hash_page_mm().  hash_page() will then look like this:=20

int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
{
	struct mm_struct *mm =3D current->mm;

	if (REGION_ID(ea) =3D=3D VMALLOC_REGION_ID)
		mm =3D &init_mm;

	return hash_page_mm(mm, ea, access, trap);
}

Mikey
