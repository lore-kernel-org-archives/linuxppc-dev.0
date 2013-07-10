Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6A7D42C02FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 07:44:14 +1000 (EST)
Date: Wed, 10 Jul 2013 16:42:57 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/hibernate: add restore mmu context after
 resume
To: Wang Dongsheng-B40534 <B40534@freescale.com>
References: <1370774260-31072-1-git-send-email-dongsheng.wang@freescale.com>
 <1370774260-31072-2-git-send-email-dongsheng.wang@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259FBECEC@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259FBECEC@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Wed Jul 10 05:11:54 2013)
Message-ID: <1373492577.8183.235@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "anton@enomsg.org" <anton@enomsg.org>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2013 05:11:54 AM, Wang Dongsheng-B40534 wrote:
> Hi scott & ben,
>=20
> About this patch do you have any suggestions?
>=20
> Thanks
>=20
> - dongsheng
>=20
> > -----Original Message-----
> > From: Wang Dongsheng-B40534
> > Sent: Sunday, June 09, 2013 6:38 PM
> > To: benh@kernel.crashing.org
> > Cc: johannes@sipsolutions.net; anton@enomsg.org; Wood Scott-B07421;
> > galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org; Wang =20
> Dongsheng-
> > B40534
> > Subject: [PATCH 2/2] powerpc/hibernate: add restore mmu context =20
> after
> > resume
> >
> > add restore_mmu_context to replace switch_mmu_context in
> > restore_processor_state, because the switch_mmu_context will do
> > a whole pile of stuff that are probably completely unnecessary.
> >
> > There just need to restore the existing process context, and
> > invalidate TLB for boot core.
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > ---
> >  arch/powerpc/include/asm/tlbflush.h |  2 ++
> >  arch/powerpc/kernel/swsusp.c        |  4 +---
> >  arch/powerpc/mm/tlb_nohash.c        | 12 ++++++++++++
> >  3 files changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/tlbflush.h
> > b/arch/powerpc/include/asm/tlbflush.h
> > index 61a5927..c401fe3 100644
> > --- a/arch/powerpc/include/asm/tlbflush.h
> > +++ b/arch/powerpc/include/asm/tlbflush.h
> > @@ -44,6 +44,8 @@ extern void local_flush_tlb_page(struct =20
> vm_area_struct
> > *vma, unsigned long vmadd
> >  extern void __local_flush_tlb_page(struct mm_struct *mm, unsigned =20
> long
> > vmaddr,
> >  				   int tsize, int ind);
> >
> > +extern void restore_mmu_context(void);
> > +
> >  #ifdef CONFIG_SMP
> >  extern void flush_tlb_mm(struct mm_struct *mm);
> >  extern void flush_tlb_page(struct vm_area_struct *vma, unsigned =20
> long
> > vmaddr);
> > diff --git a/arch/powerpc/kernel/swsusp.c =20
> b/arch/powerpc/kernel/swsusp.c
> > index eae33e1..0b104d7 100644
> > --- a/arch/powerpc/kernel/swsusp.c
> > +++ b/arch/powerpc/kernel/swsusp.c
> > @@ -32,7 +32,5 @@ void save_processor_state(void)
> >
> >  void restore_processor_state(void)
> >  {
> > -#ifdef CONFIG_PPC32
> > -	switch_mmu_context(current->active_mm, current->active_mm);
> > -#endif
> > +	restore_mmu_context();
> >  }
> > diff --git a/arch/powerpc/mm/tlb_nohash.c =20
> b/arch/powerpc/mm/tlb_nohash.c
> > index df32a83..a5a0708 100644
> > --- a/arch/powerpc/mm/tlb_nohash.c
> > +++ b/arch/powerpc/mm/tlb_nohash.c
> > @@ -39,10 +39,12 @@
> >  #include <linux/of_fdt.h>
> >  #include <linux/hugetlb.h>
> >
> > +#include <asm/current.h>
> >  #include <asm/tlbflush.h>
> >  #include <asm/tlb.h>
> >  #include <asm/code-patching.h>
> >  #include <asm/hugetlb.h>
> > +#include <asm/mmu_context.h>
> >
> >  #include "mmu_decl.h"
> >
> > @@ -193,6 +195,16 @@ void local_flush_tlb_page(struct =20
> vm_area_struct *vma,
> > unsigned long vmaddr)
> >  }
> >  EXPORT_SYMBOL(local_flush_tlb_page);
> >
> > +void restore_mmu_context(void)
> > +{
> > +	struct mm_struct *mm =3D current->active_mm;
> > +
> > +	set_context(mm->context.id, mm->pgd);
> > +
> > +	_tlbil_all();
> > +}
> > +EXPORT_SYMBOL(restore_mmu_context);

What about targets that don't use tlb_nohash.c?

-Scott=
