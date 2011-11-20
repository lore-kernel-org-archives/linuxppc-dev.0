Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 14387B7219
 for <linuxppc-dev@ozlabs.org>; Sun, 20 Nov 2011 23:38:21 +1100 (EST)
Message-ID: <4EC8F4B9.9020100@redhat.com>
Date: Sun, 20 Nov 2011 14:38:17 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 10/11] KVM: PPC: Implement MMU notifiers
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
 <20111116235220.GK26985@bloggs.ozlabs.ibm.com>
In-Reply-To: <20111116235220.GK26985@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2011 01:52 AM, Paul Mackerras wrote:
> This implements the low-level functions called by the MMU notifiers in
> the generic KVM code, and defines KVM_ARCH_WANT_MMU_NOTIFIER if
> CONFIG_KVM_BOOK3S_64_HV so that the generic KVM MMU notifiers get
> included.
>
> That means we also have to take notice of when PTE invalidations are
> in progress, as indicated by mmu_notifier_retry().  In kvmppc_h_enter,
> if any invalidation is in progress we just install a non-present HPTE.
> In kvmppc_book3s_hv_page_fault, if an invalidation is in progress we
> just return without resolving the guest, causing it to encounter another
> page fault immediately.  This is better than spinning inside
> kvmppc_book3s_hv_page_fault because this way the guest can get preempted
> by a hypervisor decrementer interrupt without us having to do any
> special checks.
>
> We currently maintain a referenced bit in the rmap array, and when we
> clear it, we make all the HPTEs that map the corresponding page be
> non-present, as if the page were invalidated.  In future we could use
> the hardware reference bit in the guest HPT instead.
>
> The kvm_set_spte_hva function is implemented as kvm_unmap_hva.  The
> former appears to be unused anyway.

This is mostly used for COW (after ksm, not fork).  So if you want to
use ksm, this avoids an exit.

> This all means that on processors that support virtual partition
> memory (POWER7), we can claim support for the KVM_CAP_SYNC_MMU
> capability, and we no longer have to pin all the guest memory.



-- 
error compiling committee.c: too many arguments to function
