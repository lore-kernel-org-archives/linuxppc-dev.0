Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vp2vm46DHzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 19:31:16 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 81so21237322pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 01:31:16 -0700 (PDT)
Date: Wed, 22 Mar 2017 18:30:55 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Balbir
 Singh <bsingharora@gmail.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 4/4] powernv: Recover correct PACA on wakeup from a
 stop on P9 DD1
Message-ID: <20170322183055.1ce9f6ed@roar.ozlabs.ibm.com>
In-Reply-To: <20170322055846.GB8326@in.ibm.com>
References: <cover.1490024477.git.ego@linux.vnet.ibm.com>
 <5beb1c3fb26ef0b487be3aa0488ea31aabfcb311.1490024477.git.ego@linux.vnet.ibm.com>
 <20170321025946.3c0b68c5@roar.ozlabs.ibm.com>
 <20170322055846.GB8326@in.ibm.com>
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

On Wed, 22 Mar 2017 11:28:46 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> On Tue, Mar 21, 2017 at 02:59:46AM +1000, Nicholas Piggin wrote:
> > On Mon, 20 Mar 2017 21:24:18 +0530
> > "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
> >   
> > > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > > 
> > > POWER9 DD1.0 hardware has an issue due to which the SPRs of a thread
> > > waking up from stop 0,1,2 with ESL=1 can endup being misplaced in the
> > > core. Thus the HSPRG0 of a thread waking up from can contain the paca
> > > pointer of its sibling.
> > > 
> > > This patch implements a context recovery framework within threads of a
> > > core, by provisioning space in paca_struct for saving every sibling
> > > threads's paca pointers. Basically, we should be able to arrive at the
> > > right paca pointer from any of the thread's existing paca pointer.
> > > 
> > > At bootup, during powernv idle-init, we save the paca address of every
> > > CPU in each one its siblings paca_struct in the slot corresponding to
> > > this CPU's index in the core.
> > > 
> > > On wakeup from a stop, the thread will determine its index in the core
> > > from the lower 2 bits of the PIR register and recover its PACA pointer
> > > by indexing into the correct slot in the provisioned space in the
> > > current PACA.
> > > 
> > > Furthermore, ensure that the NVGPRs are restored from the stack on the
> > > way out by setting the NAPSTATELOST in paca.  
> > 
> > Thanks for expanding on this, it makes the patch easier to follow :)
> > 
> > As noted before, I think if we use PACA_EXNMI for system reset, then
> > *hopefully* there should be minimal races with the initial use of other
> > thread's PACA at the start of the exception. So I'll work on getting
> > that in, but it need not prevent this patch from being merged first
> > IMO.
> >   
> > > [Changelog written with inputs from svaidy@linux.vnet.ibm.com]
> > > 
> > > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > > ---
> > >  arch/powerpc/include/asm/paca.h       |  5 ++++
> > >  arch/powerpc/kernel/asm-offsets.c     |  1 +
> > >  arch/powerpc/kernel/idle_book3s.S     | 49 ++++++++++++++++++++++++++++++++++-
> > >  arch/powerpc/platforms/powernv/idle.c | 22 ++++++++++++++++
> > >  4 files changed, 76 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> > > index 708c3e5..4405630 100644
> > > --- a/arch/powerpc/include/asm/paca.h
> > > +++ b/arch/powerpc/include/asm/paca.h
> > > @@ -172,6 +172,11 @@ struct paca_struct {
> > >  	u8 thread_mask;
> > >  	/* Mask to denote subcore sibling threads */
> > >  	u8 subcore_sibling_mask;
> > > +	/*
> > > +	 * Pointer to an array which contains pointer
> > > +	 * to the sibling threads' paca.
> > > +	 */
> > > +	struct paca_struct *thread_sibling_pacas[8];  
> 
> > 
> > Is 8 the right number? I wonder if we have a define for it.  
> 
> Thats the maximum number of threads per core that we have had on POWER
> so far.
> 
> Perhaps, I can make this
> 
> 	 struct paca_struct **thread_sibling_pacas;
> 
> and allocate threads_per_core number of slots in
> pnv_init_idle_states. Sounds ok ?

I guess that would minimise PACA overhead for non-DD1 machines,
so if it's not too much trouble, that might be good.


> > > +power9_dd1_recover_paca:
> > > +	mfspr	r4, SPRN_PIR
> > > +	clrldi	r4, r4, 62  
> > 
> > Does SPRN_TIR work?  
> 
> I wasn't aware of SPRN_TIR!
> 
> I can check this. If my reading of the ISA is correct, TIR should
> contain the thread number which are in the range [0..3].

Yep.


> > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> >   
> 
> Thanks for reviewing the patch.

No problems. Don't worry about the machine check wakeup for the moment
either. It's more important to just get the normal wakeup fix in I think.
We can revisit what to do there after my machine check patches go in
(idle machine check does not really work right now for POWER9 anyway).

Thanks,
Nick
