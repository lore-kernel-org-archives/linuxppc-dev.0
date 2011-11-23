Return-Path: <mtosatti@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 1C31FB70B1
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 10:56:03 +1100 (EST)
Date: Wed, 23 Nov 2011 21:54:09 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 11/11] KVM: PPC: Eliminate global spinlock in
 kvmppc_h_enter
Message-ID: <20111123235409.GB8125@amt.cnet>
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
 <20111116235549.GL26985@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111116235549.GL26985@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 10:55:49AM +1100, Paul Mackerras wrote:
> >From dfd5bcfac841f8a36593edf60d9fb15e0d633287 Mon Sep 17 00:00:00 2001
> From: Paul Mackerras <paulus@samba.org>
> Date: Mon, 14 Nov 2011 13:30:38 +1100
> Subject: 
> 
> Currently, kvmppc_h_enter takes a spinlock that is global to the guest,
> kvm->mmu_lock, in order to check for pending PTE invalidations safely.
> On some workloads, kvmppc_h_enter is called heavily and the use of a
> global spinlock could compromise scalability.  We already use a per-
> guest page spinlock in the form of the bit spinlock on the rmap chain,
> and this gives us synchronization with the PTE invalidation side, which
> also takes the bit spinlock on the rmap chain for each page being
> invalidated.  Thus it is sufficient to check for pending invalidations
> while the rmap chain bit spinlock is held.  However, now we require
> barriers in mmu_notifier_retry() and in the places where
> mmu_notifier_count and mmu_notifier_seq are updated, since we can now
> call mmu_notifier_retry() concurrently with updates to those fields.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> Cc'd to kvm@vger.kernel.org for review of the generic kvm changes.

Looks good to me.
