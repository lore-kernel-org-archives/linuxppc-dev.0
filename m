Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5600D1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 12:05:58 +1100 (AEDT)
Date: Tue, 16 Feb 2016 12:05:56 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 7/7] KVM: PPC: Add support for multiple-TCE
 hcalls
Message-ID: <20160216010555.GA23111@oak.ozlabs.ibm.com>
References: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
 <1455501309-47200-8-git-send-email-aik@ozlabs.ru>
 <20160216004058.GB2269@voom.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160216004058.GB2269@voom.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2016 at 11:40:58AM +1100, David Gibson wrote:
> On Mon, Feb 15, 2016 at 12:55:09PM +1100, Alexey Kardashevskiy wrote:
> > This adds real and virtual mode handlers for the H_PUT_TCE_INDIRECT and
> > H_STUFF_TCE hypercalls for user space emulated devices such as IBMVIO
> > devices or emulated PCI. These calls allow adding multiple entries
> > (up to 512) into the TCE table in one call which saves time on
> > transition between kernel and user space.
> > 
> > The current implementation of kvmppc_h_stuff_tce() allows it to be
> > executed in both real and virtual modes so there is one helper.
> > The kvmppc_rm_h_put_tce_indirect() needs to translate the guest address
> > to the host address and since the translation is different, there are
> > 2 helpers - one for each mode.
> > 
> > This implements the KVM_CAP_PPC_MULTITCE capability. When present,
> > the kernel will try handling H_PUT_TCE_INDIRECT and H_STUFF_TCE if these
> > are enabled by the userspace via KVM_CAP_PPC_ENABLE_HCALL.
> > If they can not be handled by the kernel, they are passed on to
> > the user space. The user space still has to have an implementation
> > for these.
> > 
> > Both HV and PR-syle KVM are supported.
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

[snip]

> > +	idx = srcu_read_lock(&vcpu->kvm->srcu);
> > +	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL)) {
> > +		ret = H_TOO_HARD;
> > +		goto unlock_exit;
> > +	}
> > +	tces = (u64 __user *) ua;
> > +
> > +	for (i = 0; i < npages; ++i) {
> > +		if (get_user(tce, tces + i)) {
> > +			ret = H_PARAMETER;
> 
> I'm trying to work out if H_PARAMETER is really the right thing here.
> 
> If the guest has actually supplied a bad address, I'd expect
> kvmppc_gpa_to_ua() to have picked that up.  So I see two cases here:
> 1) this shouldn't ever happen, in which case a WARN_ON() and
> H_HARDWARE would be better or 2) this can happen because of something
> concurrently unmapping / swapping out the userspace memory, in whih
> case it's not the guest's fault and should probably be H_TOO_HARD.
> 
> Or am I missing something?

The only situations I can see that would cause this to fail here are
an out-of-memory condition or userspace concurrently unmapping the
memory.  If it's just a swapout then the get_user should bring it back
in.

[snip]

> > +	rmap = (void *) vmalloc_to_phys(rmap);
> > +
> > +	/*
> > +	 * Synchronize with the MMU notifier callbacks in
> > +	 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
> > +	 * While we have the rmap lock, code running on other CPUs
> > +	 * cannot finish unmapping the host real page that backs
> > +	 * this guest real page, so we are OK to access the host
> > +	 * real page.
> > +	 */
> > +	lock_rmap(rmap);
> 
> You don't appear to actually use rmap between the lock and unlock..

No, he doesn't need to.  The effect of taking the lock is to stop the
page getting unmapped, by stopping other code from running.  That's
what we are trying to explain with the comment just above the
lock_rmap call.  Is the comment not clear enough?  How would you word
it?

Paul.
