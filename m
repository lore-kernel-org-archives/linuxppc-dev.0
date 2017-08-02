Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMdRT6j6kzDrLS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 13:08:05 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id t86so4588801pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 20:08:05 -0700 (PDT)
Date: Wed, 2 Aug 2017 13:07:30 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v1 1/3] arch/powerpc/set_memory: Implement set_memory_xx
 routines
Message-ID: <20170802130730.5ccc0b6c@firefly.ozlabs.ibm.com>
In-Reply-To: <c0303243-e20a-a2ee-7d5c-7660c10daedc@c-s.fr>
References: <20170801112535.20765-1-bsingharora@gmail.com>
 <20170801112535.20765-2-bsingharora@gmail.com>
 <c0303243-e20a-a2ee-7d5c-7660c10daedc@c-s.fr>
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

On Tue, 1 Aug 2017 21:08:49 +0200
christophe leroy <christophe.leroy@c-s.fr> wrote:

> Le 01/08/2017 =C3=A0 13:25, Balbir Singh a =C3=A9crit :
> > Add support for set_memory_xx routines. With the STRICT_KERNEL_RWX
> > feature support we got support for changing the page permissions
> > for pte ranges. This patch adds support for both radix and hash
> > so that we can change their permissions via set/clear masks.
> >
> > A new helper is required for hash (hash__change_memory_range()
> > is changed to hash__change_boot_memory_range() as it deals with
> > bolted PTE's).
> >
> > hash__change_memory_range() works with vmalloc'ed PAGE_SIZE requests
> > for permission changes. hash__change_memory_range() does not invoke
> > updatepp, instead it changes the software PTE and invalidates the PTE.
> >
> > For radix, radix__change_memory_range() is setup to do the right
> > thing for vmalloc'd addresses. It takes a new parameter to decide
> > what attributes to set.
> >
> > Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/hash.h  |  6 +++
> >  arch/powerpc/include/asm/book3s/64/radix.h |  6 +++
> >  arch/powerpc/include/asm/set_memory.h      | 34 +++++++++++++++
> >  arch/powerpc/mm/pgtable-hash64.c           | 51 ++++++++++++++++++++--
> >  arch/powerpc/mm/pgtable-radix.c            | 26 ++++++------
> >  arch/powerpc/mm/pgtable_64.c               | 68 ++++++++++++++++++++++=
++++++++
> >  6 files changed, 175 insertions(+), 16 deletions(-)
> >  create mode 100644 arch/powerpc/include/asm/set_memory.h
> > =20
>=20
> [...]
>=20
> > diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> > index 0736e94..3ee4c7d 100644
> > --- a/arch/powerpc/mm/pgtable_64.c
> > +++ b/arch/powerpc/mm/pgtable_64.c
> > @@ -514,3 +514,71 @@ void mark_initmem_nx(void)
> >  		hash__mark_initmem_nx();
> >  }
> >  #endif
> > +
> > +#ifdef CONFIG_ARCH_HAS_SET_MEMORY
> > +/*
> > + * Some of these bits are taken from arm64/mm/page_attr.c
> > + */
> > +static int change_memory_common(unsigned long addr, int numpages,
> > +				unsigned long set, unsigned long clear)
> > +{
> > +	unsigned long start =3D addr;
> > +	unsigned long size =3D PAGE_SIZE*numpages;
> > +	unsigned long end =3D start + size;
> > +	struct vm_struct *area;
> > +
> > +	if (!PAGE_ALIGNED(addr)) {
> > +		start &=3D PAGE_MASK;
> > +		end =3D start + size;
> > +		WARN_ON_ONCE(1);
> > +	} =20
>=20
> Why not just set start =3D addr & PAGE_MASK, then just do=20
> WARN_ON_ONCE(start !=3D addr), instead of that if ()

The code has been taken from arch/arm64/mm/page_attr.c. I did
not change any bits, but we could make changes.

>=20
> > +
> > +	/*
> > +	 * So check whether the [addr, addr + size) interval is entirely
> > +	 * covered by precisely one VM area that has the VM_ALLOC flag set.
> > +	 */
> > +	area =3D find_vm_area((void *)addr);
> > +	if (!area ||
> > +	    end > (unsigned long)area->addr + area->size ||
> > +	    !(area->flags & VM_ALLOC))
> > +		return -EINVAL;
> > +
> > +	if (!numpages)
> > +		return 0; =20
>=20
> Shouldn't that be tested earlier ?
>=20

Same as above

> > +
> > +	if (radix_enabled())
> > +		return radix__change_memory_range(start, start + size,
> > +							set, clear);
> > +	else
> > +		return hash__change_memory_range(start, start + size,
> > +							set, clear);
> > +} =20
>=20
> The following functions should go in a place common to PPC32 and PPC64,=20
> otherwise they will have to be duplicated when implementing for PPC32.
> Maybe the above function should also go in a common place, only the last=
=20
> part should remain in a PPC64 dedicated part. It could be called=20
> change_memory_range(), something like
>=20
> int change_memory_range(unsigned long start, unsigned long end,
> 			unsigned long set, unsigned long clear)
> {
> 	if (radix_enabled())
> 		return radix__change_memory_range(start, end,
> 						  set, clear);
> 	return hash__change_memory_range(start, end, set, clear);
> }
>=20
> Then change_memory_range() could also be implemented for PPC32 later.

I was hoping that when we implement support for PPC32, we
could refactor the code then and move it to arch/powerpc/mm/page_attr.c
if required. What do you think?

>=20
> > +
> > +int set_memory_ro(unsigned long addr, int numpages)
> > +{
> > +	return change_memory_common(addr, numpages,
> > +					0, _PAGE_WRITE);
> > +}
> > +EXPORT_SYMBOL(set_memory_ro); =20
>=20
> Take care that _PAGE_WRITE has value 0 when _PAGE_RO instead of _PAGE_RW=
=20
> is defined (eg for the 8xx).
>=20
> It would be better to use accessors like pte_wrprotect() and pte_mkwrite()
>

Sure we can definitely refactor this for PPC32, pte_wrprotect()
and pte_mkwrite() would require us to make the changes when we've
walked down to the pte and then invoke different functions based
on the flag, I kind of like the addr and permission abstraction<`2`><`2`>

> > +
> > +int set_memory_rw(unsigned long addr, int numpages)
> > +{
> > +	return change_memory_common(addr, numpages,
> > +					_PAGE_WRITE, 0);
> > +}
> > +EXPORT_SYMBOL(set_memory_rw);
> > +
> > +int set_memory_nx(unsigned long addr, int numpages)
> > +{
> > +	return change_memory_common(addr, numpages,
> > +					0, _PAGE_EXEC);
> > +}
> > +EXPORT_SYMBOL(set_memory_nx);
> > +
> > +int set_memory_x(unsigned long addr, int numpages)
> > +{
> > +	return change_memory_common(addr, numpages,
> > +					_PAGE_EXEC, 0);
> > +}
> > +EXPORT_SYMBOL(set_memory_x);
> > +#endif
> > =20
>=20
Thanks for the review
Balbir
