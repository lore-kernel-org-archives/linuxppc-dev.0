Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id DA3B31007D7
	for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2011 19:07:23 +1000 (EST)
Message-ID: <4DCBA345.6090006@redhat.com>
Date: Thu, 12 May 2011 12:07:17 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 10/13] kvm/powerpc: Add support for Book3S processors
	in hypervisor mode
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104456.GK2837@brick.ozlabs.ibm.com>
In-Reply-To: <20110511104456.GK2837@brick.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
	kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/2011 01:44 PM, Paul Mackerras wrote:
> This adds support for KVM running on 64-bit Book 3S processors,
> specifically POWER7, in hypervisor mode.  Using hypervisor mode means
> that the guest can use the processor's supervisor mode.  That means
> that the guest can execute privileged instructions and access privileged
> registers itself without trapping to the host.  This gives excellent
> performance, but does mean that KVM cannot emulate a processor
> architecture other than the one that the hardware implements.
>
> This code assumes that the guest is running paravirtualized using the
> PAPR (Power Architecture Platform Requirements) interface, which is the
> interface that IBM's PowerVM hypervisor uses.  That means that existing
> Linux distributions that run on IBM pSeries machines will also run
> under KVM without modification.  In order to communicate the PAPR
> hypercalls to qemu, this adds a new KVM_EXIT_PAPR_HCALL exit code
> to include/linux/kvm.h.
>
> Currently the choice between book3s_hv support and book3s_pr support
> (i.e. the existing code, which runs the guest in user mode) has to be
> made at kernel configuration time, so a given kernel binary can only
> do one or the other.
>
> This new book3s_hv code doesn't support MMIO emulation at present.
> Since we are running paravirtualized guests, this isn't a serious
> restriction.
>
> With the guest running in supervisor mode, most exceptions go straight
> to the guest.  We will never get data or instruction storage or segment
> interrupts, alignment interrupts, decrementer interrupts, program
> interrupts, single-step interrupts, etc., coming to the hypervisor from
> the guest.  Therefore this introduces a new KVMTEST_NONHV macro for the
> exception entry path so that we don't have to do the KVM test on entry
> to those exception handlers.
>
> We do however get hypervisor decrementer, hypervisor data storage,
> hypervisor instruction storage, and hypervisor emulation assist
> interrupts, so we have to handle those.
>
> In hypervisor mode, real-mode accesses can access all of RAM, not just
> a limited amount.  Therefore we put all the guest state in the vcpu.arch
> and use the shadow_vcpu in the PACA only for temporary scratch space.
> We allocate the vcpu with kzalloc rather than vzalloc, and we don't use
> anything in the kvmppc_vcpu_book3s struct, so we don't allocate it.
>
> The POWER7 processor has a restriction that all threads in a core have
> to be in the same partition.  MMU-on kernel code counts as a partition
> (partition 0), so we have to do a partition switch on every entry to and
> exit from the guest.  At present we require the host and guest to run
> in single-thread mode because of this hardware restriction.
>
> This code allocates a hashed page table for the guest and initializes
> it with HPTEs for the guest's Virtual Real Memory Area (VRMA).  We
> require that the guest memory is allocated using 16MB huge pages, in
> order to simplify the low-level memory management.  This also means that
> we can get away without tracking paging activity in the host for now,
> since huge pages can't be paged or swapped.
>
> diff --git a/include/linux/kvm.h b/include/linux/kvm.h
> index ea2dc1a..a4447ce 100644
> --- a/include/linux/kvm.h
> +++ b/include/linux/kvm.h
> @@ -161,6 +161,7 @@ struct kvm_pit_config {
>   #define KVM_EXIT_NMI              16
>   #define KVM_EXIT_INTERNAL_ERROR   17
>   #define KVM_EXIT_OSI              18
> +#define KVM_EXIT_PAPR_HCALL	  19
>
>   /* For KVM_EXIT_INTERNAL_ERROR */
>   #define KVM_INTERNAL_ERROR_EMULATION 1
> @@ -264,6 +265,11 @@ struct kvm_run {
>   		struct {
>   			__u64 gprs[32];
>   		} osi;
> +		struct {
> +			__u64 nr;
> +			__u64 ret;
> +			__u64 args[9];
> +		} papr_hcall;
>   		/* Fix the size of the union. */
>   		char padding[256];
>   	};

Please document this in Documentation/kvm/api.txt.

-- 
error compiling committee.c: too many arguments to function
