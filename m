Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 831DCB705B
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Dec 2011 04:19:05 +1100 (EST)
Subject: Re: [PATCH v3 12/14] KVM: Add barriers to allow mmu_notifier_retry to
 be used locklessly
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111212223720.GM18868@bloggs.ozlabs.ibm.com>
Date: Mon, 19 Dec 2011 18:18:58 +0100
Message-Id: <29064998-0526-435B-A8BA-DB6BF9CDED46@suse.de>
References: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
 <20111212223720.GM18868@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm list <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org, Avi Kivity <avi@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 12.12.2011, at 23:37, Paul Mackerras wrote:

> This adds an smp_wmb in kvm_mmu_notifier_invalidate_range_end() and an
> smp_rmb in mmu_notifier_retry() so that mmu_notifier_retry() will give
> the correct answer when called without kvm->mmu_lock being held.
> PowerPC Book3S HV KVM wants to use a bitlock per guest page rather =
than
> a single global spinlock in order to improve the scalability of =
updates
> to the guest MMU hashed page table, and so needs this.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Avi, mind to ack?


Alex

> ---
> include/linux/kvm_host.h |   14 +++++++++-----
> virt/kvm/kvm_main.c      |    6 +++---
> 2 files changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 8c5c303..ec79a45 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -700,12 +700,16 @@ static inline int mmu_notifier_retry(struct =
kvm_vcpu *vcpu, unsigned long mmu_se
> 	if (unlikely(vcpu->kvm->mmu_notifier_count))
> 		return 1;
> 	/*
> -	 * Both reads happen under the mmu_lock and both values are
> -	 * modified under mmu_lock, so there's no need of smb_rmb()
> -	 * here in between, otherwise mmu_notifier_count should be
> -	 * read before mmu_notifier_seq, see
> -	 * mmu_notifier_invalidate_range_end write side.
> +	 * Ensure the read of mmu_notifier_count happens before the read
> +	 * of mmu_notifier_seq.  This interacts with the smp_wmb() in
> +	 * mmu_notifier_invalidate_range_end to make sure that the =
caller
> +	 * either sees the old (non-zero) value of mmu_notifier_count or
> +	 * the new (incremented) value of mmu_notifier_seq.
> +	 * PowerPC Book3s HV KVM calls this under a per-page lock
> +	 * rather than under kvm->mmu_lock, for scalability, so
> +	 * can't rely on kvm->mmu_lock to keep things ordered.
> 	 */
> +	smp_rmb();
> 	if (vcpu->kvm->mmu_notifier_seq !=3D mmu_seq)
> 		return 1;
> 	return 0;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e289486..c144132 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -357,11 +357,11 @@ static void =
kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
> 	 * been freed.
> 	 */
> 	kvm->mmu_notifier_seq++;
> +	smp_wmb();
> 	/*
> 	 * The above sequence increase must be visible before the
> -	 * below count decrease but both values are read by the kvm
> -	 * page fault under mmu_lock spinlock so we don't need to add
> -	 * a smb_wmb() here in between the two.
> +	 * below count decrease, which is ensured by the smp_wmb above
> +	 * in conjunction with the smp_rmb in mmu_notifier_retry().
> 	 */
> 	kvm->mmu_notifier_count--;
> 	spin_unlock(&kvm->mmu_lock);
> --=20
> 1.7.7.3
>=20
