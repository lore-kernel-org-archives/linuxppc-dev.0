Return-Path: <srs0=xiin=a5=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2nNX6TzPzDsPp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 18:07:24 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3y2nNX4pZ0z8v5B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 18:07:24 +1000 (AEST)
Message-ID: <1506586033.25626.9.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] KVM: PPC: Book3S: Fix server always zero from
 kvmppc_xive_get_xive()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff
 <sam.bobroff@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, paulus@samba.org,
 pbonzini@redhat.com
Date: Thu, 28 Sep 2017 10:07:13 +0200
In-Reply-To: <20170928014505.GW12504@umbus>
References: <4585437e86d14900985c7e16bfd4afef672b26c7.1506408341.git.sam.bobroff@au1.ibm.com>
 <20170928014505.GW12504@umbus>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-28 at 11:45 +1000, David Gibson wrote:
> On Tue, Sep 26, 2017 at 04:47:04PM +1000, Sam Bobroff wrote:
> > In KVM's XICS-on-XIVE emulation, kvmppc_xive_get_xive() returns the
> > value of state->guest_server as "server". However, this value is not
> > set by it's counterpart kvmppc_xive_set_xive(). When the guest uses
> > this interface to migrate interrupts away from a CPU that is going
> > offline, it sees all interrupts as belonging to CPU 0, so they are
> > left assigned to (now) offline CPUs.
> > 
> > This patch removes the guest_server field from the state, and returns
> > act_server in it's place (that is, the CPU actually handling the
> > interrupt, which may differ from the one requested).
> > 
> > Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE
> > interrupt controller")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > ---
> > The other obvious way to patch this would be to set state->guest_server in
> > kvmppc_xive_set_xive() and that does also work because act_server is usually
> > equal to guest_server.
> > 
> > However, in the cases where guest_server differed from act_server, the guest
> > would only move IRQs correctly if it got act_server (the CPU actually handling
> > the interrupt) here. So, that approach seemed better.
> 
> Paolo, again this is a pretty urgent fix for KVM on Power and Paulus
> is away.  We're hoping BenH will ack shortly (he's the logical
> technical reviewer), after which can you merge this direct into the
> KVM staging tree?  (RHBZ 1477391, and we suspect several more are
> related).

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

As a subsequent cleanup we should probably rename act_server to server.

Note: We know of a remaining theorical race that isn't fixed yet with
CPU unplug. If an interrupt is already in the queue of the CPU calling
xics_migrate_irqs_away (guest), then that irq never gets pulled out of
that queue and thus the bug this patch is fixing will re-occur.

Fix isn't trivial, I'm working on it, though I'm tempted to make some
assumptions about how linux does things to keep it (much) simpler.

I'll elaborate later (at Kernel Recipes right now)

Cheers,
Ben.

> >  arch/powerpc/kvm/book3s_xive.c | 5 ++---
> >  arch/powerpc/kvm/book3s_xive.h | 1 -
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
> > index 13304622ab1c..bf457843e032 100644
> > --- a/arch/powerpc/kvm/book3s_xive.c
> > +++ b/arch/powerpc/kvm/book3s_xive.c
> > @@ -622,7 +622,7 @@ int kvmppc_xive_get_xive(struct kvm *kvm, u32 irq, u32 *server,
> >  		return -EINVAL;
> >  	state = &sb->irq_state[idx];
> >  	arch_spin_lock(&sb->lock);
> > -	*server = state->guest_server;
> > +	*server = state->act_server;
> >  	*priority = state->guest_priority;
> >  	arch_spin_unlock(&sb->lock);
> >  
> > @@ -1331,7 +1331,7 @@ static int xive_get_source(struct kvmppc_xive *xive, long irq, u64 addr)
> >  	xive->saved_src_count++;
> >  
> >  	/* Convert saved state into something compatible with xics */
> > -	val = state->guest_server;
> > +	val = state->act_server;
> >  	prio = state->saved_scan_prio;
> >  
> >  	if (prio == MASKED) {
> > @@ -1507,7 +1507,6 @@ static int xive_set_source(struct kvmppc_xive *xive, long irq, u64 addr)
> >  	/* First convert prio and mark interrupt as untargetted */
> >  	act_prio = xive_prio_from_guest(guest_prio);
> >  	state->act_priority = MASKED;
> > -	state->guest_server = server;
> >  
> >  	/*
> >  	 * We need to drop the lock due to the mutex below. Hopefully
> > diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
> > index 5938f7644dc1..6ba63f8e8a61 100644
> > --- a/arch/powerpc/kvm/book3s_xive.h
> > +++ b/arch/powerpc/kvm/book3s_xive.h
> > @@ -35,7 +35,6 @@ struct kvmppc_xive_irq_state {
> >  	struct xive_irq_data *pt_data;	/* XIVE Pass-through associated data */
> >  
> >  	/* Targetting as set by guest */
> > -	u32 guest_server;		/* Current guest selected target */
> >  	u8 guest_priority;		/* Guest set priority */
> >  	u8 saved_priority;		/* Saved priority when masking */
> >  
> 
> 
