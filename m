Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xybss409KzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 22:44:48 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id e69so2444772pfg.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 05:44:48 -0700 (PDT)
Date: Thu, 21 Sep 2017 22:44:33 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: Handle MCE on POWER9 with only DSISR bit 33
 set
Message-ID: <20170921224433.085a3539@roar.ozlabs.ibm.com>
In-Reply-To: <1505987840.15768.18.camel@neuling.org>
References: <20170921020434.21018-1-mikey@neuling.org>
 <20170921181801.5a260281@roar.ozlabs.ibm.com>
 <1505987840.15768.18.camel@neuling.org>
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

On Thu, 21 Sep 2017 19:57:20 +1000
Michael Neuling <mikey@neuling.org> wrote:

> On Thu, 2017-09-21 at 18:18 +1000, Nicholas Piggin wrote:
> > On Thu, 21 Sep 2017 12:04:34 +1000
> > Michael Neuling <mikey@neuling.org> wrote:
> >   
> > > On POWER9 DD2.1 and below, it's possible to get Machine Check
> > > Exception (MCE) where only DSISR bit 33 is set. This will result in
> > > the linux MCE handler seeing an unknown event, which triggers linux to
> > > crash.
> > > 
> > > We change this by detecting unknown events in the MCE handler and
> > > marking them as handled so that we no longer crash. We do this only on
> > > chip revisions known to have this problem.
> > > 
> > > MCE that occurs like this is spurious, so we don't need to do anything
> > > in terms of servicing it. If there is something that needs to be
> > > serviced, the CPU will raise the MCE again with the correct DSISR so
> > > that it can be serviced properly.
> > > 
> > > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > > ---
> > > v2 update commit message based on Balbir's comments
> > > ---
> > >  arch/powerpc/kernel/mce_power.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/kernel/mce_power.c
> > > b/arch/powerpc/kernel/mce_power.c
> > > index b76ca198e0..72ec667136 100644
> > > --- a/arch/powerpc/kernel/mce_power.c
> > > +++ b/arch/powerpc/kernel/mce_power.c
> > > @@ -595,6 +595,7 @@ static long mce_handle_error(struct pt_regs *regs,
> > >  	uint64_t addr;
> > >  	uint64_t srr1 = regs->msr;
> > >  	long handled;
> > > +	unsigned long pvr;
> > >  
> > >  	if (SRR1_MC_LOADSTORE(srr1))
> > >  		handled = mce_handle_derror(regs, dtable, &mce_err, &addr);
> > > @@ -604,6 +605,20 @@ static long mce_handle_error(struct pt_regs *regs,
> > >  	if (!handled && mce_err.error_type == MCE_ERROR_TYPE_UE)
> > >  		handled = mce_handle_ue_error(regs);
> > >  
> > > +	/*
> > > +	 * On POWER9 DD2.1 and below, it's possible to get machine
> > > +	 * check where only DSISR bit 33 is set. This will result in
> > > +	 * the MCE handler seeing an unknown event and us crashing.
> > > +	 * Change this to mark as handled on these revisions.
> > > +	 */
> > > +	pvr = mfspr(SPRN_PVR);
> > > +	if (((PVR_VER(pvr) == PVR_POWER9) &&
> > > +	     (PVR_CFG(pvr) == 2) &&
> > > +	     (PVR_MIN(pvr) <= 1)) || cpu_has_feature(CPU_FTR_POWER9_DD1))
> > > +		/* DD2.1 and below */
> > > +		if (mce_err.error_type == MCE_ERROR_TYPE_UNKNOWN)
> > > +		    handled = 1;  
> > 
> > I might be missing something, but can you just do
> > 
> >   if (regs->dsisr == 0x40000000)
> >       return 1;
> > 
> > In __machine_check_early_realmode_p9() ?  
> 
> You're right, thanks.

If you leave the PVR and DD1 checks in there, it would be a good
reminder for me to convert into a quirk if I can get this version
specific quirks stuff going

https://marc.info/?l=linuxppc-embedded&m=150597337720114&w=2

Thanks,
Nick
