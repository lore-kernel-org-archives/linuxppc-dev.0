Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <1112770418.9567.137.camel@gaston>
References: <1112770418.9567.137.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <c689550a30a3129f8576f78eaa6f7af4@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 6 Apr 2005 11:44:13 -0500
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: pte_update and 64-bit PTEs on PPC32?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 6, 2005, at 1:53 AM, Benjamin Herrenschmidt wrote:

> On Wed, 2005-04-06 at 01:51 -0500, Kumar Gala wrote:
>  > Paul,
>  >
> > I've tracked down a bug I've been having to the fact that pte_update
> > assumes a pte is a unsigned long.=A0 I need to look into what the =
exact
>  > implications this has.=A0 I was wondering what the thoughts were =
with
> > respect to how this is suppose to work properly on 440 with its=20
> 64-bit
> > pte?=A0 I'm looking at a 64-bit pte for some Freescale book-e parts =
as=20
> we
> > move to 36-bit physical address support.
>  >
> > The problem I found was ptep_get_and_clear() would return back only =
a
> > 32-bit value and thus we loose any information in the upper=20
> 32-bits.=A0 I
> > found the call in sys_mprotect ... -> change_pte_range ->
> > ptep_get_and_clear()
> >
> > Will provide some update on this tomorrow.
>
> It's quite important for the flags to all be together in a single 32
>  bits entity so that atomic operations can be done on them. The RPN
>  should be able to extend beyond the initial 32 bits provided we are
>  careful about the way we manipulate the PTEs. When setting a PTE, we
>  should always first set the "other" part, then the PTE present bit=20
> last
> or a CPU would possibly get a stale PTE. The problem with that scheme=20=

> is
> that I can see possible races on dual page faults trying to fill in =
the
>  same PTE if we drop the page table lock (christoph lameter stuff) but=20=

> it
>  should work for us now.

Ben, I agree with you about having the flags in a single word so we can=20=

lock them properly.  In the short term it appears that the issue I'm=20
running into is explicit with ptep_get_and_clear():

static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned=20
long addr,
                                        pte_t *ptep)
{
         return __pte(pte_update(ptep, ~_PAGE_HASHPTE, 0));
}

It appears that we should be returning the pte that was passed in,=20
before its modified?  (seems a little silly to me, why bother, the=20
caller could do this -- i've posted to lkml on the issue?).  Anyways,=20
since pte_update only returns the lower 32-bits the wrong thing=20
happens.  The following seems to be a better implementation of=20
ptep_get_and_clear() for ppc32 which resolves my issue:

static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned=20
long addr,
                                        pte_t *ptep)
{
         pte_t tmp =3D *ptep;
         pte_update(ptep, ~_PAGE_HASHPTE, 0);
         return tmp;
}

If we are ok with this I'll send a patch upstream for it.  I'd like to=20=

still discuss how to make this all proper long term.  Currently,=20
ptep_get_and_clear was the only user of pte_update that used the return=20=

value for anything but flags.  One change would be for it to return=20
just the flags portion of the pte it was given.  Another would be for=20
us to implement a proper 64-bit pte version of pte_update.

- kumar
