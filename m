Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7817F1A1173
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 22:16:51 +1100 (AEDT)
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C5299140291
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2015 22:16:50 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 16 Dec 2015 04:16:49 -0700
Message-ID: <56714817.30005@linux.vnet.ibm.com>
Date: Wed, 16 Dec 2015 16:46:39 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>
CC: paulus@ozlabs.org, linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org,
 mahesh@linux.vnet.ibm.com, david@gibson.dropbear.id.au, agraf@suse.de,
 mpe@ellerman.id.au, kvm@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Exit guest upon fatal machine check exception
References: <20151216055612.10203.28496.stgit@aravindap>
 <5671318C.5040001@redhat.com>
In-Reply-To: <5671318C.5040001@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 16 December 2015 03:10 PM, Thomas Huth wrote:
> On 16/12/15 06:56, Aravinda Prasad wrote:
>> This patch modifies KVM to cause a guest exit with
>> KVM_EXIT_NMI instead of immediately delivering a 0x200
>> interrupt to guest upon machine check exception in
>> guest address. Exiting the guest enables QEMU to build
>> error log and deliver machine check exception to guest
>> OS (either via guest OS registered machine check
>> handler or via 0x200 guest OS interrupt vector).
>>
>> This approach simplifies the delivering of machine
>> check exception to guest OS compared to the earlier approach
>> of KVM directly invoking 0x200 guest interrupt vector.
>> In the earlier approach QEMU patched the 0x200 interrupt
>> vector during boot. The patched code at 0x200 issued a
>> private hcall to pass the control to QEMU to build the
>> error log.
>>
>> This design/approach is based on the feedback for the
>> QEMU patches to handle machine check exception. Details
>> of earlier approach of handling machine check exception
>> in QEMU and related discussions can be found at:
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.html
>>
>> This patch also introduces a new KVM capability to
>> control how KVM behaves on machine check exception.
>> Without this capability, KVM redirects machine check
>> exceptions to guest's 0x200 vector if the address in
>> error belongs to guest. With this capability KVM
>> causes a guest exit with NMI exit reason.
>>
>> This is required to avoid problems if a new kernel/KVM
>> is used with an old QEMU for guests that don't issue
>> "ibm,nmi-register". As old QEMU does not understand the
>> NMI exit type, it treats it as a fatal error. However,
>> the guest could have handled the machine check error
>> if the exception was delivered to guest's 0x200 interrupt
>> vector instead of NMI exit in case of old QEMU.
>>
>> Change Log v2:
>>   - Added KVM capability
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/kvm_host.h     |    1 +
>>  arch/powerpc/kernel/asm-offsets.c       |    1 +
>>  arch/powerpc/kvm/book3s_hv.c            |   12 +++-------
>>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |   37 +++++++++++++++----------------
>>  arch/powerpc/kvm/powerpc.c              |    7 ++++++
>>  include/uapi/linux/kvm.h                |    1 +
>>  6 files changed, 31 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>> index 827a38d..8a652ba 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -243,6 +243,7 @@ struct kvm_arch {
>>  	int hpt_cma_alloc;
>>  	struct dentry *debugfs_dir;
>>  	struct dentry *htab_dentry;
>> +	u8 fwnmi_enabled;
> 
> Here you declare the variable as 8-bits ...
> 
>>  #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>>  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
>>  	struct mutex hpt_mutex;
>> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
>> index 221d584..6a4e81a 100644
>> --- a/arch/powerpc/kernel/asm-offsets.c
>> +++ b/arch/powerpc/kernel/asm-offsets.c
>> @@ -506,6 +506,7 @@ int main(void)
>>  	DEFINE(KVM_ENABLED_HCALLS, offsetof(struct kvm, arch.enabled_hcalls));
>>  	DEFINE(KVM_LPCR, offsetof(struct kvm, arch.lpcr));
>>  	DEFINE(KVM_VRMA_SLB_V, offsetof(struct kvm, arch.vrma_slb_v));
>> +	DEFINE(KVM_FWNMI, offsetof(struct kvm, arch.fwnmi_enabled));
> 
> ... then define an asm-offset for it ...
> 
>>  	DEFINE(VCPU_DSISR, offsetof(struct kvm_vcpu, arch.shregs.dsisr));
>>  	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
>>  	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa.pinned_addr));
>> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> index b98889e..f43c124 100644
>> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> [...]
>> @@ -2381,24 +2377,27 @@ machine_check_realmode:
>>  	ld	r9, HSTATE_KVM_VCPU(r13)
>>  	li	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
>>  	/*
>> -	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest through
>> -	 * machine check interrupt (set HSRR0 to 0x200). And for handled
>> -	 * errors (no-fatal), just go back to guest execution with current
>> -	 * HSRR0 instead of exiting guest. This new approach will inject
>> -	 * machine check to guest for fatal error causing guest to crash.
>> -	 *
>> -	 * The old code used to return to host for unhandled errors which
>> -	 * was causing guest to hang with soft lockups inside guest and
>> -	 * makes it difficult to recover guest instance.
>> +	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest
>> +	 * by exiting the guest with KVM_EXIT_NMI exit reason (exit
>> +	 * reason set later based on trap). For handled errors
>> +	 * (no-fatal), go back to guest execution with current HSRR0
>> +	 * instead of exiting the guest. This approach will cause
>> +	 * the guest to exit in case of fatal machine check error.
>>  	 */
>> -	ld	r10, VCPU_PC(r9)
>> -	ld	r11, VCPU_MSR(r9)
>> -	bne	2f	/* Continue guest execution. */
>> -	/* If not, deliver a machine check.  SRR0/1 are already set */
>> -	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
>> +	bne	2f	/* Continue guest execution? */
>> +	/* If not, check if guest is capable of handling NMI exit */
>> +	ld	r3, VCPU_KVM(r9)
>> +	ld	r3, KVM_FWNMI(r3)
>> +	cmpdi	r3, 1		/* FWNMI capable? */
> 
> ... and here you're accessing the 8-bit variable with "ld" and "cmpdi"!
> Is this really working as expected? Or did I miss something? Did you
> check your code on both, little and big endian hosts?

Ah... I should have used lbz

Regards,
Aravinda

> 
>  Thomas
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

-- 
Regards,
Aravinda
