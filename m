Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 733442C0351
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 07:55:00 +1000 (EST)
Date: Fri, 12 Jul 2013 16:54:50 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/hibernate: add restore mmu context after
 resume
To: Wang Dongsheng-B40534 <B40534@freescale.com>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259FC2B51@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Thu Jul 11 23:04:23 2013)
Message-ID: <1373666090.8183.290@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "anton@enomsg.org" <anton@enomsg.org>,
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

On 07/11/2013 11:04:23 PM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, July 11, 2013 5:43 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wang Dongsheng-B40534; benh@kernel.crashing.org; Wood =20
> Scott-B07421;
> > johannes@sipsolutions.net; anton@enomsg.org; =20
> galak@kernel.crashing.org;
> > linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 2/2] powerpc/hibernate: add restore mmu context =20
> after
> > resume
> >
> > On 07/10/2013 05:11:54 AM, Wang Dongsheng-B40534 wrote:
> > > > +void restore_mmu_context(void)
> > > > +{
> > > > +	struct mm_struct *mm =3D current->active_mm;
> > > > +
> > > > +	set_context(mm->context.id, mm->pgd);
> > > > +
> > > > +	_tlbil_all();
> > > > +}
> > > > +EXPORT_SYMBOL(restore_mmu_context);
> >
> > What about targets that don't use tlb_nohash.c?
> >
> Yes, you are right, if we used PPC_STD_MMU, compilation error will =20
> occur.
> And _tlbil_all should be remove, because all of the tlb already =20
> invalidated in swsusp_*.S .
> So we should invalid tlb in swsusp_asm64.S & swsusp_booke.S on =20
> freescale platform.
>=20
> How about add restore_mmu_context(struct mm_struct* mm) into =20
> "arch/powerpc/include/asm/mmu_context.h"
>=20
> Path: arch/powerpc/include/asm/mmu_context.h
> static void restore_mmu_context(struct mm_struct *mm)
> {
>        set_context(mm->context.id, mm->pgd);
> }

set_context() doesn't exist for hash MMUs.

Whatever you do, please try actually building it on various targets, =20
including both 32 and 64 bits, and both hash and non-hash.  And make =20
sure that whatever effect PPC32 was depending on switch_mmu_context for =20
is preserved, including on non-booke.

-Scott=
