Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 32221B6F8E
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2011 18:55:28 +1000 (EST)
Subject: Re: [PATCH 09/15] KVM: PPC: Add support for Book3S processors in
	hypervisor mode
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110618083558.GJ28413@bloggs.ozlabs.ibm.com>
Date: Tue, 21 Jun 2011 10:55:24 +0200
Message-Id: <A7549F27-6A64-412E-81AA-EEE24AEEB7A7@suse.de>
References: <20110618082705.GA28413@bloggs.ozlabs.ibm.com>
	<20110618083558.GJ28413@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 18.06.2011, at 10:35, Paul Mackerras wrote:

> This adds support for KVM running on 64-bit Book 3S processors,
> specifically POWER7, in hypervisor mode.  Using hypervisor mode means
> that the guest can use the processor's supervisor mode.  That means
> that the guest can execute privileged instructions and access =
privileged
> registers itself without trapping to the host.  This gives excellent
> performance, but does mean that KVM cannot emulate a processor
> architecture other than the one that the hardware implements.
>=20
> This code assumes that the guest is running paravirtualized using the
> PAPR (Power Architecture Platform Requirements) interface, which is =
the
> interface that IBM's PowerVM hypervisor uses.  That means that =
existing
> Linux distributions that run on IBM pSeries machines will also run
> under KVM without modification.  In order to communicate the PAPR
> hypercalls to qemu, this adds a new KVM_EXIT_PAPR_HCALL exit code
> to include/linux/kvm.h.
>=20
> Currently the choice between book3s_hv support and book3s_pr support
> (i.e. the existing code, which runs the guest in user mode) has to be
> made at kernel configuration time, so a given kernel binary can only
> do one or the other.
>=20
> This new book3s_hv code doesn't support MMIO emulation at present.
> Since we are running paravirtualized guests, this isn't a serious
> restriction.
>=20
> With the guest running in supervisor mode, most exceptions go straight
> to the guest.  We will never get data or instruction storage or =
segment
> interrupts, alignment interrupts, decrementer interrupts, program
> interrupts, single-step interrupts, etc., coming to the hypervisor =
from
> the guest.  Therefore this introduces a new KVMTEST_NONHV macro for =
the
> exception entry path so that we don't have to do the KVM test on entry
> to those exception handlers.
>=20
> We do however get hypervisor decrementer, hypervisor data storage,
> hypervisor instruction storage, and hypervisor emulation assist
> interrupts, so we have to handle those.
>=20
> In hypervisor mode, real-mode accesses can access all of RAM, not just
> a limited amount.  Therefore we put all the guest state in the =
vcpu.arch
> and use the shadow_vcpu in the PACA only for temporary scratch space.
> We allocate the vcpu with kzalloc rather than vzalloc, and we don't =
use
> anything in the kvmppc_vcpu_book3s struct, so we don't allocate it.
> We don't have a shared page with the guest, but we still need a
> kvm_vcpu_arch_shared struct to store the values of various registers,
> so we include one in the vcpu_arch struct.
>=20
> The POWER7 processor has a restriction that all threads in a core have
> to be in the same partition.  MMU-on kernel code counts as a partition
> (partition 0), so we have to do a partition switch on every entry to =
and
> exit from the guest.  At present we require the host and guest to run
> in single-thread mode because of this hardware restriction.
>=20
> This code allocates a hashed page table for the guest and initializes
> it with HPTEs for the guest's Virtual Real Memory Area (VRMA).  We
> require that the guest memory is allocated using 16MB huge pages, in
> order to simplify the low-level memory management.  This also means =
that
> we can get away without tracking paging activity in the host for now,
> since huge pages can't be paged or swapped.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>
>=20


> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index b7baff7..3662ecc 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -20,7 +20,6 @@ config KVM
> 	bool
> 	select PREEMPT_NOTIFIERS
> 	select ANON_INODES
> -	select KVM_MMIO
>=20
> config KVM_BOOK3S_HANDLER
> 	bool
> @@ -28,16 +27,22 @@ config KVM_BOOK3S_HANDLER
> config KVM_BOOK3S_32_HANDLER
> 	bool
> 	select KVM_BOOK3S_HANDLER
> +	select KVM_MMIO
>=20
> config KVM_BOOK3S_64_HANDLER
> 	bool
> 	select KVM_BOOK3S_HANDLER
>=20
> +config KVM_BOOK3S_PR
> +	bool
> +	select KVM_MMIO
> +
> config KVM_BOOK3S_32
> 	tristate "KVM support for PowerPC book3s_32 processors"
> 	depends on EXPERIMENTAL && PPC_BOOK3S_32 && !SMP && !PTE_64BIT
> 	select KVM
> 	select KVM_BOOK3S_32_HANDLER
> +	select KVM_BOOK3S_PR

KVM_BOOK3S_32 is the equivalent to KVM_BOOK3S_64_PR, right? We should =
rename both or none to stay consistent.

> 	---help---
> 	  Support running unmodified book3s_32 guest kernels
> 	  in virtual machines on book3s_32 host processors.
> @@ -48,10 +53,38 @@ config KVM_BOOK3S_32
> 	  If unsure, say N.
>=20
> config KVM_BOOK3S_64
> -	tristate "KVM support for PowerPC book3s_64 processors"
> +	bool

This means that if a user has selected KVM in his config before, it's =
unset after. Is there any good way to keep users from doing that? Maybe =
we could define KVM_BOOK3S_64 to be the PR type and introduce a new =
option that fulfills the role of KVM_BOOK3S_64 as you intended it here?


Alex
