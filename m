Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94FF9B70A3
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jan 2011 08:31:24 +1100 (EST)
In-Reply-To: <20110113144400.28892935@udp111988uds.am.freescale.net>
References: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>	<20110111060926.GE16301@1wt.eu>
	<OFEC114402.5A694921-ONC1257815.002CC8F2-C1257815.002D1C7D@LocalDomain>	<OF18595787.9140CED3-ONC1257815.003BD10E-C1257815.003C1BD5@transmode.se>
	<20110113144400.28892935@udp111988uds.am.freescale.net>
Subject: Re: [PATCH 00/13] powerpc: Backport 8xx TLB to 2.4
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF17821FE2.8701ABFC-ONC1257817.0075D6D2-C1257817.007638FB@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 13 Jan 2011 22:31:18 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Willy Tarreau <w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 2011/01/13 21:44:00:
> > BTW, it occurred to me that the following 8xx quirk is best
> > done in 8xx code:
> >
> > From c1985a3b8b16d96ddce5ef90d5a15e70fb8a2aec Mon Sep 17 00:00:00 2001
> > From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > Date: Tue, 11 Jan 2011 11:24:22 +0100
> > Subject: [PATCH] 8xx: Move invalidation of non present TLBs
> >
> > 8xx does not invalidate ~PRESENT TLBs, move the workaround
> > in mm/fault.c here to keep 8xx quirks localized.
> >
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > ---
> >  arch/ppc/kernel/head_8xx.S |   12 ++++++++++--
> >  arch/ppc/mm/fault.c        |    7 -------
> >  2 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
> > index 75acaa0..24b206c 100644
> > --- a/arch/ppc/kernel/head_8xx.S
> > +++ b/arch/ppc/kernel/head_8xx.S
> > @@ -221,7 +221,11 @@ DataAccess:
> >     mr   r5,r20
> >     mfspr   r4,DAR
> >     stw   r4,_DAR(r21)
> > -   li   r20,0x00f0
> > +   /* invalidate ~PRESENT TLBs, 8xx MMU don't do this */
> > +   andis.   r20,r5,0x4000
> > +   beq+   1f
> > +   tlbie   r4
> > +1:   li   r20,0x00f
> >     mtspr   DAR,r20   /* Tag DAR */
> >     addi   r3,r1,STACK_FRAME_OVERHEAD
> >     li   r20,MSR_KERNEL
> > @@ -238,7 +242,11 @@ InstructionAccess:
> >     addi   r3,r1,STACK_FRAME_OVERHEAD
> >     mr   r4,r22
> >     mr   r5,r23
> > -   li   r20,MSR_KERNEL
> > +   /* invalidate ~PRESENT TLBs, 8xx MMU don't do this */
> > +   andis.   r20,r5,0x4000
> > +   beq+   1f
> > +   tlbie   r4
> > +1:   li   r20,MSR_KERNEL
> >     rlwimi   r20,r23,0,16,16      /* copy EE bit from saved MSR */
> >     FINISH_EXCEPTION(do_page_fault)
> >
> > diff --git a/arch/ppc/mm/fault.c b/arch/ppc/mm/fault.c
> > index 874005a..8819fb1 100644
> > --- a/arch/ppc/mm/fault.c
> > +++ b/arch/ppc/mm/fault.c
> > @@ -116,13 +116,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
> >     else
> >        is_write = error_code & 0x02000000;
> >  #endif /* CONFIG_4xx || CONFIG_BOOKE */
> > -#if defined(CONFIG_8xx)
> > -   /* 8xx does no invalidate TLBs that are ~PRESENT,
> > -    * do it here.
> > -    */
> > -   if (error_code & 0x40000000)
> > -      _tlbie(address);
> > -#endif
> >  #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
> >     if (debugger_fault_handler && regs->trap == 0x300) {
> >        debugger_fault_handler(regs);
> > --
> > 1.7.3.4
> >
> > Scott, what do you think of this? Is it safe to call tlbie in this context?
>
> I'd guess so (I assume the concern is MMU translation being off?), but I
> don't have any particular knowledge about this.  I'd be checking the
> same manual that you have. :-)

I noticed 2.6 uses tlbie in CPU15 errata workaround so it is fine
and it is better to invalidate as soon as possible to free up a TLB slot.
Runs on my old 2.4 too.

 Jocke
