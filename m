Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <1112826162.9568.175.camel@gaston>
References: <1112826162.9568.175.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <7f8b1a7904bb3fd53304ee2ea4b6a501@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 6 Apr 2005 17:27:22 -0500
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


On Apr 6, 2005, at 5:22 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2005-04-06 at 11:44 -0500, Kumar Gala wrote:
>
> > Ben, I agree with you about having the flags in a single word so we=20=

> can
> > lock them properly.=A0 In the short term it appears that the issue =
I'm
> > running into is explicit with ptep_get_and_clear():
> >
> > static inline pte_t ptep_get_and_clear(struct mm_struct *mm, =
unsigned
>  > long addr,
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pte_t *ptep)
>  > {
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0 return __pte(pte_update(ptep, =
~_PAGE_HASHPTE, 0));
>  > }
>  >
> > It appears that we should be returning the pte that was passed in,
>  > before its modified?=A0 (seems a little silly to me, why bother, =
the
> > caller could do this -- i've posted to lkml on the issue?).
>
> No, we should return the "old" PTE.
>
> >=A0=A0 Anyways,
> > since pte_update only returns the lower 32-bits the wrong thing
> > happens.=A0 The following seems to be a better implementation of
> > ptep_get_and_clear() for ppc32 which resolves my issue:
>  >
> > static inline pte_t ptep_get_and_clear(struct mm_struct *mm, =
unsigned
>  > long addr,
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pte_t *ptep)
>  > {
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0 pte_t tmp =3D *ptep;
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0 pte_update(ptep, ~_PAGE_HASHPTE, 0);
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0 return tmp;
>  > }
>
> Hrm... I would still do it differently. I would read the "rpn only"=20
> part
>  non atomically and load/clear the other half atomically. Withotu =
that,
>  you may miss a bit set between the load and the update (for example,
>  _PAGE_HASHPTE may have been put in in between).

Ben,

I'll let you catch up with the rest of the thread, I realized most of=20
what you have here and created a new implementation of pte_update that=20=

should be doing what you are asking for.

- kumar
