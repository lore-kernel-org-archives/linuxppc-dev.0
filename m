Return-Path: <R65777@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 795C02C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 13:12:00 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 6/6 v2] kvm: powerpc: use caching attributes as per
 linux pte
Date: Sat, 3 Aug 2013 03:11:45 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D070F8FE9@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375355558-19187-7-git-send-email-Bharat.Bhushan@freescale.com>
 <20130802233452.GA27636@home.buserror.net>
In-Reply-To: <20130802233452.GA27636@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Saturday, August 03, 2013 5:05 AM
> To: Bhushan Bharat-R65777
> Cc: benh@kernel.crashing.org; agraf@suse.de; kvm-ppc@vger.kernel.org;
> kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Bhushan Bharat-R65777
> Subject: Re: [PATCH 6/6 v2] kvm: powerpc: use caching attributes as per l=
inux
> pte
>=20
> On Thu, Aug 01, 2013 at 04:42:38PM +0530, Bharat Bhushan wrote:
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c index
> > 17722d8..ebcccc2 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -697,7 +697,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run,
> > struct kvm_vcpu *vcpu)  #endif
> >
> >  	kvmppc_fix_ee_before_entry();
> > -
> > +	vcpu->arch.pgdir =3D current->mm->pgd;
> >  	ret =3D __kvmppc_vcpu_run(kvm_run, vcpu);
>=20
> kvmppc_fix_ee_before_entry() is supposed to be the last thing that happen=
s
> before __kvmppc_vcpu_run().
>=20
> > @@ -332,6 +324,8 @@ static inline int kvmppc_e500_shadow_map(struct
> kvmppc_vcpu_e500 *vcpu_e500,
> >  	unsigned long hva;
> >  	int pfnmap =3D 0;
> >  	int tsize =3D BOOK3E_PAGESZ_4K;
> > +	pte_t pte;
> > +	int wimg =3D 0;
> >
> >  	/*
> >  	 * Translate guest physical to true physical, acquiring @@ -437,6
> > +431,8 @@ static inline int kvmppc_e500_shadow_map(struct
> > kvmppc_vcpu_e500 *vcpu_e500,
> >
> >  	if (likely(!pfnmap)) {
> >  		unsigned long tsize_pages =3D 1 << (tsize + 10 - PAGE_SHIFT);
> > +		pgd_t *pgdir;
> > +
> >  		pfn =3D gfn_to_pfn_memslot(slot, gfn);
> >  		if (is_error_noslot_pfn(pfn)) {
> >  			printk(KERN_ERR "Couldn't get real page for gfn %lx!\n", @@
> -447,9
> > +443,18 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_=
e500
> *vcpu_e500,
> >  		/* Align guest and physical address to page map boundaries */
> >  		pfn &=3D ~(tsize_pages - 1);
> >  		gvaddr &=3D ~((tsize_pages << PAGE_SHIFT) - 1);
> > +		pgdir =3D vcpu_e500->vcpu.arch.pgdir;
> > +		pte =3D lookup_linux_pte(pgdir, hva, 1, &tsize_pages);
> > +		if (pte_present(pte)) {
> > +			wimg =3D (pte >> PTE_WIMGE_SHIFT) & MAS2_WIMGE_MASK;
> > +		} else {
> > +			printk(KERN_ERR "pte not present: gfn %lx, pfn %lx\n",
> > +					(long)gfn, pfn);
> > +			return -EINVAL;
> > +		}
> >  	}
>=20
> How does wimg get set in the pfnmap case?

Pfnmap is not kernel managed pages, right? So should we set I+G there ?

>=20
> Could you explain why we need to set dirty/referenced on the PTE, when we=
 didn't
> need to do that before? All we're getting from the PTE is wimg.
> We have MMU notifiers to take care of the page being unmapped, and we've =
already
> marked the page itself as dirty if the TLB entry is writeable.

I pulled this code from book3s.

Ben, can you describe why we need this on book3s ?

Thanks
-Bharat
>=20
> -Scott
