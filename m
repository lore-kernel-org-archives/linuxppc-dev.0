Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rQ7J1CKlzF0gL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 18:05:48 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id t12-v6so12538926plo.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 01:05:47 -0700 (PDT)
Date: Wed, 23 May 2018 18:05:37 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8] powerpc/mm: Only read faulting instruction when
 necessary in do_page_fault()
Message-ID: <20180523180537.37d54cb7@roar.ozlabs.ibm.com>
In-Reply-To: <cda4bbef-f4a9-142d-3fa4-86c2693ed35f@c-s.fr>
References: <61ef5847cedae91eb5415f40fb4276585950cb43.1527058032.git.christophe.leroy@c-s.fr>
 <20180523171710.00792240@roar.ozlabs.ibm.com>
 <cda4bbef-f4a9-142d-3fa4-86c2693ed35f@c-s.fr>
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

On Wed, 23 May 2018 09:31:33 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 23/05/2018 =C3=A0 09:17, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Wed, 23 May 2018 09:01:19 +0200 (CEST)
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >  =20

> >> @@ -264,8 +266,30 @@ static bool bad_stack_expansion(struct pt_regs *r=
egs, unsigned long address,
> >>   		 * between the last mapped region and the stack will
> >>   		 * expand the stack rather than segfaulting.
> >>   		 */
> >> -		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
> >> -			return true;
> >> +		if (address + 2048 >=3D uregs->gpr[1])
> >> +			return false;
> >> +		if (is_retry)
> >> +			return false;
> >> +
> >> +		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
> >> +		    access_ok(VERIFY_READ, nip, sizeof(inst))) {
> >> +			int res;
> >> +
> >> +			pagefault_disable();
> >> +			res =3D __get_user_inatomic(inst, nip);
> >> +			pagefault_enable();
> >> +			if (res) {
> >> +				up_read(&mm->mmap_sem);
> >> +				res =3D __get_user(inst, nip);
> >> +				if (!res && store_updates_sp(inst))
> >> +					return -1;
> >> +				return true;
> >> +			}
> >> +			if (store_updates_sp(inst))
> >> +				return false;
> >> +		}
> >> +		up_read(&mm->mmap_sem); =20
> >=20
> > Starting to look pretty good... I think probably I prefer the mmap_sem
> > drop going into the caller so we don't don't drop in the child function=
. =20
>=20
> Yes I can do that. I though it was ok as the drop is already done in=20
> children functions like bad_area(), bad_access(), ...

That's true, all exit functions though. I think it may end up being a
bit nicer with the up_read in the caller, but see what you think.

> > I thought the retry logic was a little bit complex too, what do you
> > think of using fault_in_pages_readable and just doing a full retry to
> > avoid some of this complexity? =20
>=20
> Yes lets try that way, allthough fault_in_pages_readable() is nothing=20
> else than a get_user().
> Should we take any precaution to avoid retrying forever or is it just=20
> not worth it ?

generic_perform_write() the core of the data copying for write(2)
syscall does this retry, so I think it's okay... Although I think I
wrote that so maybe that's a circular justification.

I think if we end up thrashing on this type of loop for a long time,
the system will already be basically dead.


> >>   	/* The stack is being expanded, check if it's valid */
> >> -	if (unlikely(bad_stack_expansion(regs, address, vma, store_update_sp=
)))
> >> -		return bad_area(regs, address);
> >> +	is_bad =3D bad_stack_expansion(regs, address, vma, flags, is_retry);
> >> +	if (unlikely(is_bad =3D=3D -1)) {
> >> +		is_retry =3D true;
> >> +		goto retry;
> >> +	}
> >> +	if (unlikely(is_bad))
> >> +		return bad_area_nosemaphore(regs, address); =20
> >=20
> > Suggest making the return so that you can do a single unlikely test for
> > the retry or bad case, and then distinguish the retry in there. Code
> > generation should be better. =20
>=20
> Ok. I'll try and come with v9 during this morning.

Thanks,
Nick
