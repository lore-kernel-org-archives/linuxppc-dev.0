Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn5ys33tSzDqPv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 20:45:57 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id a70so17957847pge.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 03:45:57 -0700 (PDT)
Date: Tue, 13 Jun 2017 20:45:38 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Shreyas B . Prabhu"
 <shreyas@linux.vnet.ibm.com>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 08/14] powerpc/64s: idle avoid SRR usage in idle
 sleep/wake paths
Message-ID: <20170613204538.779ebc40@roar.ozlabs.ibm.com>
In-Reply-To: <20170613102553.GJ10921@in.ibm.com>
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-9-npiggin@gmail.com>
 <20170613102553.GJ10921@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Jun 2017 15:55:53 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hi Nick,
> 
> On Mon, Jun 12, 2017 at 09:58:29AM +1000, Nicholas Piggin wrote:
> > Idle code now always runs at the 0xc... effective address whether
> > in real or virtual mode. This means rfid can be ditched, along
> > with a lot of SRR manipulations.
> > 
> > In the wakeup path, carry SRR1 around in r12. Use mtmsrd to change
> > MSR states as required.
> > 
> > This also balances the return prediction for the idle call, by
> > doing blr rather than rfid to return to the idle caller.
> > 
> > On POWER9, 2-process context switch on different cores, with snooze
> > disabled, increases performance by 2%.
> > ---
> >  arch/powerpc/kernel/exceptions-64s.S    |  1 +
> >  arch/powerpc/kernel/idle_book3s.S       | 57 +++++++++++++++------------------
> >  arch/powerpc/kvm/book3s_hv_rmhandlers.S |  8 ++++-
> >  3 files changed, 33 insertions(+), 33 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index fec7c933d095..c3d0aef089a7 100644
> > --- a/arch/powerpc/kernel/idle_book3s.S
> > +++ b/arch/powerpc/kernel/idle_book3s.S
> > @@ -148,12 +147,8 @@ pnv_powersave_common:
> >  	 * the MMU context to the guest.
> >  	 */
> >  	LOAD_REG_IMMEDIATE(r7, MSR_IDLE)
> > -	li	r6, MSR_RI
> > -	andc	r6, r9, r6
> > -	mtmsrd	r6, 1		/* clear RI before setting SRR0/1 */
> > -	mtspr	SPRN_SRR0, r4
> > -	mtspr	SPRN_SRR1, r7
> > -	rfid
> > +	mtmsrd	r7,0
> > +	bctr  
> 
> So at this point we need to transition from virtual to real mode as
> the comment in pnv_enter_arch207_idle_mode expects us to. Which is
> being performed by mtmsrd here. Then we jump to the function via
> bctr. So, in this patch we are using two instructions to modify the
> MSR and the PC, while earlier the rfid would update these atomically.
> 
> Does forgoing atomicity have any risk? I am asking this because
> historically we have modified IR/DR bits in the MSR via rfid
> mechanism.

I believe it's not a problem. Actually the ISA has a note about using
it in this way, p.1181 of ISA v3.0B, the programming note suggests
using mtmsrd rather than rfid to enable IR.

I've tested on POWER8 and 9 and not had any problems with it. Interesting
question though.

One thing I wonder about is that ERAT installs real mode entries, so
using mtmsrd to transition from real to virtual mode will require 2
I-ERAT entries for these nearby instruction addresses. Then if you did
a branch to a distant address, that would require another I-ERAT. On
the other hand if you do an rfid to switch MSR and branch to distant
address at the same time, it should only require 2 I-ERAT entries. So
you may see better microbenchmark performance of the first case, but
the latter may end up being slower on real work.

I've decided that probably the kernel is compact enough that we aren't
likely to cause more ERAT footprint by doing this. It would be
interesting to do a proper analysis of this, but I haven't got around
to it yet.

Thanks,
Nick
