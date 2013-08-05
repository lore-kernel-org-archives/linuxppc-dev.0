Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2410F2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 05:19:17 +1000 (EST)
Message-ID: <1375730341.13074.38.camel@snotra.buserror.net>
Subject: Re: [PATCH 5/6 v2] kvm: powerpc: booke: Add linux pte lookup like
 booke3s
From: Scott Wood <scottwood@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Date: Mon, 5 Aug 2013 14:19:01 -0500
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D070FAD49@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375355558-19187-6-git-send-email-Bharat.Bhushan@freescale.com>
 <1375484319.26902.4.camel@snotra.buserror.net>
 <1375485408.15999.67.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D070F8FCC@039-SN2MPN1-012.039d.mgd.msft.net>
 <1375503847.15999.80.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D070FAD49@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-05 at 09:27 -0500, Bhushan Bharat-R65777 wrote:
> 
> > -----Original Message-----
> > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> > Sent: Saturday, August 03, 2013 9:54 AM
> > To: Bhushan Bharat-R65777
> > Cc: Wood Scott-B07421; agraf@suse.de; kvm-ppc@vger.kernel.org;
> > kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 5/6 v2] kvm: powerpc: booke: Add linux pte lookup like
> > booke3s
> > 
> > On Sat, 2013-08-03 at 02:58 +0000, Bhushan Bharat-R65777 wrote:
> > > One of the problem I saw was that if I put this code in
> > > asm/pgtable-32.h and asm/pgtable-64.h then pte_persent() and other
> > > friend function (on which this code depends) are defined in pgtable.h.
> > > And pgtable.h includes asm/pgtable-32.h and asm/pgtable-64.h before it
> > > defines pte_present() and friends functions.
> > >
> > > Ok I move wove this in asm/pgtable*.h, initially I fought with myself
> > > to take this code in pgtable* but finally end up doing here (got
> > > biased by book3s :)).
> > 
> > Is there a reason why these routines can not be completely generic in pgtable.h
> > ?
> 
> How about the generic function:
> 
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> index d257d98..21daf28 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -221,6 +221,27 @@ static inline unsigned long pte_update(struct mm_struct *mm,
>         return old;
>  }
> 
> +static inline unsigned long pte_read(pte_t *p)
> +{
> +#ifdef PTE_ATOMIC_UPDATES
> +       pte_t pte;
> +       pte_t tmp;
> +       __asm__ __volatile__ (
> +       "1:     ldarx   %0,0,%3\n"
> +       "       andi.   %1,%0,%4\n"
> +       "       bne-    1b\n"
> +       "       ori     %1,%0,%4\n"
> +       "       stdcx.  %1,0,%3\n"
> +       "       bne-    1b"
> +       : "=&r" (pte), "=&r" (tmp), "=m" (*p)
> +       : "r" (p), "i" (_PAGE_BUSY)
> +       : "cc");
> +
> +       return pte;
> +#else  
> +       return pte_val(*p);
> +#endif
> +#endif
> +}
>  static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
>                                               unsigned long addr, pte_t *ptep)

Please leave a blank line between functions.

>  {
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index 690c8c2..dad712c 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -254,6 +254,45 @@ static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
>  }
>  #endif /* !CONFIG_HUGETLB_PAGE */
> 
> +static inline pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
> +                                    int writing, unsigned long *pte_sizep)

The name implies that it just reads the PTE.  Setting accessed/dirty
shouldn't be an undocumented side-effect.  Why can't the caller do that
(or a different function that the caller calls afterward if desired)?  

Though even then you have the undocumented side effect of locking the
PTE on certain targets.

> +{
> +       pte_t *ptep;
> +       pte_t pte;
> +       unsigned long ps = *pte_sizep;
> +       unsigned int shift;
> +
> +       ptep = find_linux_pte_or_hugepte(pgdir, hva, &shift);
> +       if (!ptep)
> +               return __pte(0);
> +       if (shift)
> +               *pte_sizep = 1ul << shift;
> +       else
> +               *pte_sizep = PAGE_SIZE;
> +
> +       if (ps > *pte_sizep)
> +               return __pte(0);
> +
> +       if (!pte_present(*ptep))
> +               return __pte(0);
> +
> +#ifdef CONFIG_PPC64
> +       /* Lock PTE (set _PAGE_BUSY) and read */
> +       pte = pte_read(ptep);
> +#else
> +       pte = pte_val(*ptep);
> +#endif

What about 32-bit platforms that need atomic PTEs?

-Scott
