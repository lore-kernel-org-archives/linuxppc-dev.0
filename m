Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 7DF02B6FE2
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Dec 2011 04:21:50 +1100 (EST)
Message-ID: <4EEF72A8.6010308@redhat.com>
Date: Mon, 19 Dec 2011 19:21:44 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v3 12/14] KVM: Add barriers to allow mmu_notifier_retry
 to be used locklessly
References: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
 <20111212223720.GM18868@bloggs.ozlabs.ibm.com>
 <29064998-0526-435B-A8BA-DB6BF9CDED46@suse.de>
In-Reply-To: <29064998-0526-435B-A8BA-DB6BF9CDED46@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/19/2011 07:18 PM, Alexander Graf wrote:
> On 12.12.2011, at 23:37, Paul Mackerras wrote:
>
> > This adds an smp_wmb in kvm_mmu_notifier_invalidate_range_end() and an
> > smp_rmb in mmu_notifier_retry() so that mmu_notifier_retry() will give
> > the correct answer when called without kvm->mmu_lock being held.
> > PowerPC Book3S HV KVM wants to use a bitlock per guest page rather than
> > a single global spinlock in order to improve the scalability of updates
> > to the guest MMU hashed page table, and so needs this.
> > 
> > Signed-off-by: Paul Mackerras <paulus@samba.org>
>
> Avi, mind to ack?
>

Acked-by: Avi Kivity <avi@redhat.com>

-- 
error compiling committee.c: too many arguments to function
