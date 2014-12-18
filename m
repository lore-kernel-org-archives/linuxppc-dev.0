Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0109.outbound.protection.outlook.com [157.56.111.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 07BD21A0B58
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 22:23:23 +1100 (AEDT)
Message-ID: <1418901787.5581.131.camel@freescale.com>
Subject: Re: [v2 PATCH 1/2] powerpc32: adds handling of _PAGE_RO
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Thu, 18 Dec 2014 05:23:07 -0600
In-Reply-To: <54927E1E.1030407@c-s.fr>
References: <20141217091431.D3F761A5E0D@localhost.localdomain>
 <1418868868.5581.121.camel@freescale.com> <54927E1E.1030407@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-12-18 at 08:11 +0100, leroy christophe wrote:
> Le 18/12/2014 03:14, Scott Wood a écrit :
> > On Wed, 2014-12-17 at 10:14 +0100, Christophe Leroy wrote:
> >> Some powerpc like the 8xx don't have a RW bit in PTE bits but a RO (Read Only) bit.
> >> This patch implements the handling of a _PAGE_RO flag to be used in place of _PAGE_RW
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>
> >> ---
> >> v2 is a complete rework compared to v1
> >>
> >>   arch/powerpc/include/asm/pgtable-ppc32.h | 11 ++++++-----
> >>   arch/powerpc/include/asm/pgtable.h       | 10 +++++++---
> >>   arch/powerpc/include/asm/pte-common.h    | 27 ++++++++++++++++++---------
> >>   arch/powerpc/mm/gup.c                    |  2 ++
> >>   arch/powerpc/mm/mem.c                    |  2 +-
> >>   arch/powerpc/mm/pgtable_32.c             | 24 ++++++++++++++++++++----
> >>   6 files changed, 54 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
> >> index 543bb8e..64ed9e1 100644
> >> --- a/arch/powerpc/include/asm/pgtable-ppc32.h
> >> +++ b/arch/powerpc/include/asm/pgtable-ppc32.h
> >> @@ -125,7 +125,7 @@ extern int icache_44x_need_flush;
> >>   #ifndef __ASSEMBLY__
> >>   
> >>   #define pte_clear(mm, addr, ptep) \
> >> -	do { pte_update(ptep, ~_PAGE_HASHPTE, 0); } while (0)
> >> +	do { pte_update(ptep, ~_PAGE_HASHPTE, _PAGE_RO); } while (0)
> > Is this really necessary?  It's already clearing the valid bit.
> >
> > Likewise in several other places that set or check for _PAGE_RO on pages
> > for which no access is permitted.
> >
> >> @@ -287,8 +287,9 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
> >>   static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
> >>   {
> >>   	unsigned long bits = pte_val(entry) &
> >> -		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
> >> -	pte_update(ptep, 0, bits);
> >> +		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_RO |
> >> +		 _PAGE_EXEC);
> >> +	pte_update(ptep, _PAGE_RO, bits);
> >>   }
> > You're unconditionally clearing _PAGE_RO, and apparently relying on the
> > undocumented behavior of pte_update() to clear "clr" before setting
> > "set".
> >
> > Instead I'd write this as:
> >
> > 	unsigned long set = pte_val(entry) &
> > 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
> > 	unsigned long clr = pte_val(entry) & _PAGE_RO;
> Don't you mean ?
> 
> 	unsigned long clr = ~pte_val(entry) & _PAGE_RO;
> 
> Because, we want to clear _PAGE_RO when _PAGE_RO is not set in entry.

Yes, sorry.

-Scott
