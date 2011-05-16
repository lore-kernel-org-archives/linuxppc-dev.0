Return-Path: <paulus@ozlabs.org>
Date: Mon, 16 May 2011 15:58:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 10/13] kvm/powerpc: Add support for Book3S processors in
	hypervisor mode
Message-ID: <20110516055809.GA3590@drongo>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104456.GK2837@brick.ozlabs.ibm.com>
	<BDD550B2-02CA-4B1A-A05B-6CB3EF89B7B3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BDD550B2-02CA-4B1A-A05B-6CB3EF89B7B3@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, kvm-ppc@vger.kernel.org,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 15, 2011 at 11:58:12PM +0200, Alexander Graf wrote:
> 
> On 11.05.2011, at 12:44, Paul Mackerras wrote:

> > +#ifdef CONFIG_KVM_BOOK3S_NONHV
> 
> I really liked how you called the .c file _pr - why call it NONHV now?

I agree, CONFIG_KVM_BOOK3S_PR would be better, I'll change it.

> > diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> > index 7412676..8dba5f6 100644
> > --- a/arch/powerpc/include/asm/paca.h
> > +++ b/arch/powerpc/include/asm/paca.h
> > @@ -149,6 +149,16 @@ struct paca_struct {
> > #ifdef CONFIG_KVM_BOOK3S_HANDLER
> > 	/* We use this to store guest state in */
> > 	struct kvmppc_book3s_shadow_vcpu shadow_vcpu;
> > +#ifdef CONFIG_KVM_BOOK3S_64_HV
> > +	struct kvm_vcpu *kvm_vcpu;
> > +	u64 dabr;
> > +	u64 host_mmcr[3];
> > +	u32 host_pmc[6];
> > +	u64 host_purr;
> > +	u64 host_spurr;
> > +	u64 host_dscr;
> > +	u64 dec_expires;
> 
> Hrm. I'd say either push those into shadow_vcpu for HV mode or get
> rid of the shadow_vcpu reference. I'd probably prefer the former.

These are fields that are pieces of host state that we need to save
and restore across execution of a guest; they don't apply to any
specific guest or vcpu.  That's why I didn't put them in shadow_vcpu,
which is specifically for one vcpu in one guest.  

Given that book3s_pr copies the shadow_vcpu into and out of the paca,
I thought it best not to add fields to it that are only live while we
are in the guest.  True, these fields only exist for book3s_hv, but if
we later on make it possible to select book3s_pr vs. book3s_hv at
runtime, we won't want to be copying these fields into and out of the
paca when book3s_pr is active.

Maybe we need another struct, kvm_host_state or something like that,
to save this sort of state.

> > @@ -65,6 +98,7 @@ config KVM_440
> > 	bool "KVM support for PowerPC 440 processors"
> > 	depends on EXPERIMENTAL && 44x
> > 	select KVM
> > +	select KVM_MMIO
> 
> e500 should also select MMIO, no?

Good point, I'll fix that.

> > +long kvmppc_alloc_hpt(struct kvm *kvm)
> > +{
> > +	unsigned long hpt;
> > +	unsigned long lpid;
> > +
> > +	hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|__GFP_NOWARN,
> > +			       HPT_ORDER - PAGE_SHIFT);
> 
> This would end up failing quite often, no?

In practice it seems to be OK, possibly because the machines we're
testing this on have plenty of memory.  Maybe we should get qemu to
allocate the HPT using hugetlbfs so the memory will come from the
reserved page pool.  It does need to be physically contiguous and
aligned on a multiple of its size -- that's a hardware requirement.

> > +	kvm->arch.sdr1 = __pa(hpt) | (HPT_ORDER - 18);
> > +	kvm->arch.lpid = lpid;
> > +	kvm->arch.host_sdr1 = mfspr(SPRN_SDR1);
> > +	kvm->arch.host_lpid = mfspr(SPRN_LPID);
> > +	kvm->arch.host_lpcr = mfspr(SPRN_LPCR);
> 
> How do these correlate with the guest's hv mmu? I'd like to keep the
> code clean enough so we can potentially use it for PR mode as well :). 

The host SDR1 and LPID are different from the guest's.  That is, the
guest has its own HPT which is quite separate from the host's.  The
host values could be saved in global variables, though; there's no
real need for each VM to have its own copy, except that doing it this
way simplifies the low-level assembly code a little.

> > +	/* First see what page size we have */
> > +	psize = user_page_size(mem->userspace_addr);
> > +	/* For now, only allow 16MB pages */
> 
> The reason to go for 16MB pages is because of the host mmu code, not
> the guest hv mmu. So please at least #ifdef the code to HV so we
> document that correlation. 

I'm not sure what you mean by that.  The reason for going for 16MB
pages initially is for performance (this way the guest can use 16MB
pages for its linear mapping) and to avoid having to deal with the
pages being paged or swapped on the host side.  Could you explain the
"because of the host mmu code" part of your comment further?

What would adding #ifdef CONFIG_KVM_BOOK3S_64_HV achieve in a file
whose name ends in _hv.c and which only gets compiled when
CONFIG_KVM_BOOK3S_64_HV=y?

> > +int kvmppc_mmu_hv_init(void)
> > +{
> > +	if (!cpu_has_feature(CPU_FTR_HVMODE_206))
> > +		return 0;
> 
> Return 0 for "it doesn't work" might not be the right exit code ;).

Good point, I'll make it -ENXIO or something.

> > +static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
> > +				struct kvmppc_pte *gpte, bool data)
> > +{
> > +	return -ENOENT;
> 
> Can't you just call the normal book3s_64 mmu code here? Without
> xlate, doing ppc_ld doesn't work, which means that reading out the
> faulting guest instruction breaks. We'd also need it for PR mode :). 

With book3s_hv we currently have no situations where we need to read
out the faulting guest instruction.  

We could use the normal code here if we had the guest HPT mapped into
the qemu address space, which it currently isn't -- but should be.  It
hasn't been a priority to fix because with book3s_hv we currently have
no situations where we need to read out the faulting guest
instruction.

> > +void kvmppc_set_pvr(struct kvm_vcpu *vcpu, u32 pvr)
> > +{
> > +	vcpu->arch.pvr = pvr;
> > +	kvmppc_mmu_book3s_hv_init(vcpu);
> 
> No need for you to do it depending on pvr. You can just do the mmu
> initialization on normal init :).

OK, I'll do that.

> > +	case BOOK3S_INTERRUPT_PROGRAM:
> > +	{
> > +		ulong flags;
> > +		/*
> > +		 * Normally program interrupts are delivered directly
> > +		 * to the guest by the hardware, but we can get here
> > +		 * as a result of a hypervisor emulation interrupt
> > +		 * (e40) getting turned into a 700 by BML RTAS.
> 
> Not sure I fully understand what's going on there. Mind to explain? :)

Recent versions of the architecture don't actually deliver a 0x700
interrupt to the OS on an illegal instruction; instead they generate
an 0xe40 interrupt to the hypervisor in case the hypervisor wants to
emulate the instruction.  If the hypervisor doesn't want to do that
it's supposed to synthesize a 0x700 interrupt to the OS.

When we're running this stuff under our BML (Bare Metal Linux)
framework in the lab, we use a small RTAS implementation that gets
loaded by the BML loader, and one of the things that this RTAS does is
to patch the 0xe40 vector to make the 0xe40 interrupt come in via the
0x700 vector, in case the kernel you're running under BML hasn't been
updated to have an 0xe40 handler.

I could just remove that case, in fact.

> > +	case BOOK3S_INTERRUPT_SYSCALL:
> > +	{
> > +		/* hcall - punt to userspace */
> > +		int i;
> > +
> 
> Do we really want to accept sc from pr=1? I'd just reject them straight away.

Good idea, I'll do that.

> > +	case BOOK3S_INTERRUPT_H_DATA_STORAGE:
> > +		vcpu->arch.dsisr = vcpu->arch.fault_dsisr;
> > +		vcpu->arch.dear = vcpu->arch.fault_dar;
> > +		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_DATA_STORAGE, 0);
> > +		r = RESUME_GUEST;
> > +		break;
> > +	case BOOK3S_INTERRUPT_H_INST_STORAGE:
> > +		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_INST_STORAGE,
> > +					0x08000000);
> 
> What do these do? I thought the guest gets DSI and ISI directly?

It does for accesses with relocation (IR/DR) on, but because we have
enabled VRMA mode (Virtualized Real Mode Area) in the LPCR, we get
these interrupts to the hypervisor if the guest does a bad real-mode
access.  If we also turned on Virtualized Partition Memory (VPM) mode
in the LPCR, then all ISI/DSI in the guest come through to the
hypervisor using these vectors in case the hypervisor wants to do any
paging/swapping of guest memory.  I plan to do that later when we
support using 4k/64k pages for guest memory.

> > +	/* default to book3s_64 (power7) */
> > +	vcpu->arch.pvr = 0x3f0200;
> 
> Wouldn't it make sense to simply default to the host pvr? Not sure -
> maybe it's not :).

Sounds sensible, actually.  In fact the hypervisor can't spoof the PVR
for the guest, that is, the guest can read the real PVR value and
there's no way the hypervisor can stop it.

> > +	flush_fp_to_thread(current);
> 
> Do those with fine with preemption enabled?

Yes.  If a preemption happens, it will flush the FP/VMX/VSX registers
out to the thread_struct, and then any of these explicit calls that
happen after the preemption will do nothing.

> > +	/*
> > +	 * Put whatever is in the decrementer into the
> > +	 * hypervisor decrementer.
> > +	 */
> > +	mfspr	r8,SPRN_DEC
> > +	mftb	r7
> > +	mtspr	SPRN_HDEC,r8
> 
> Can't we just always use HDEC on the host? That's save us from all
> the swapping here.

The problem is that there is only one HDEC per core, so using it would
become complicated when the host is running in SMT4 or SMT2 mode.

> > +	extsw	r8,r8
> > +	add	r8,r8,r7
> > +	std	r8,PACA_KVM_DECEXP(r13)
> 
> Why is dec+hdec on vcpu_run decexp? What exactly does this store?

R7 here is the current (or very recent, anyway) timebase value, so
this stores the timebase value at which the host decrementer would get
to zero.

> > +	lwz	r3, PACA_HOST_PMC(r13)
> > +	lwz	r4, PACA_HOST_PMC + 4(r13)
> > +	lwz	r5, PACA_HOST_PMC + 4(r13)
> 
> copy&paste error?

Yes, thanks.

> > +.global kvmppc_handler_lowmem_trampoline
> > +kvmppc_handler_lowmem_trampoline:
> > +	cmpwi	r12,0x500
> > +	beq	1f
> > +	cmpwi	r12,0x980
> > +	beq	1f
> 
> What?
> 
> 1) use the macros please

OK

> 2) why?

The external interrupt and hypervisor decrementer interrupt handlers
expect the interrupted PC and MSR to be in HSRR0/1 rather than
SRR0/1.  I could remove the case for 0x980 since we don't call the
linux handler for HDEC interrupts any more.

> > +	/* Check if HDEC expires soon */
> > +	mfspr	r3,SPRN_HDEC
> > +	cmpwi	r3,10
> > +	li	r12,0x980
> 
> define

OK.

> > +	mr	r9,r4
> > +	blt	hdec_soon
> 
> Is it faster to do the check than to save the check and take the
> odds? Also, maybe we should rather do the check in preemptible
> code that could just directly pass the time slice on.

I do the check there because I was having problems where, if the HDEC
goes negative before we do the partition switch, we would occasionally
not get the HDEC interrupt at all until the next time HDEC went
negative, ~ 8.4 seconds later.

> > +	/* See if this is a leftover HDEC interrupt */
> > +	cmpwi	r12,0x980
> 
> define

OK.

> > +	bne	2f
> > +	mfspr	r3,SPRN_HDEC
> > +	cmpwi	r3,0
> > +	bge	ignore_hdec
> > +2:
> > +
> > +	/* Check for mediated interrupts (could be done earlier really ...) */
> > +	cmpwi	r12,0x500
> 
> define

OK.

> > +	bne+	1f
> > +	ld	r5,VCPU_LPCR(r9)
> > +	andi.	r0,r11,MSR_EE
> > +	beq	1f
> > +	andi.	r0,r5,LPCR_MER
> > +	bne	bounce_ext_interrupt
> 
> So there's no need for the external check that directly goes into
> the Linux handler code on full-fledged exits?

No, we still need that; ordinary external interrupts come to the
hypervisor regardless of the guest's MSR.EE setting.

The MER bit (Mediated External Request) is a way for the hypervisor to
know when the guest sets its MSR.EE bit.  If an event happens that
means the host wants to give a guest vcpu an external interrupt, but
the guest vcpu has MSR.EE = 0, then the host can't deliver the
simulated external interrupt.  Instead it sets LPCR.MER, which has the
effect that the hardware will deliver an external interrupt (to the
hypervisor) when running in the guest and it has MSR.EE = 1.

So, when we get an external interrupt, LPCR.MER = 1 and MSR.EE = 1,
we need to synthesize an external interrupt in the guest.  Doing it
here means that we don't need to do the full partition switch out to
the host and back again.

> > +	/* Read the guest SLB and save it away */
> > +	li	r6,0
> > +	addi	r7,r9,VCPU_SLB
> > +	li	r5,0
> > +1:	slbmfee	r8,r6
> > +	andis.	r0,r8,SLB_ESID_V@h
> > +	beq	2f
> > +	add	r8,r8,r6		/* put index in */
> > +	slbmfev	r3,r6
> > +	std	r8,VCPU_SLB_E(r7)
> > +	std	r3,VCPU_SLB_V(r7)
> > +	addi	r7,r7,VCPU_SLB_SIZE
> > +	addi	r5,r5,1
> > +2:	addi	r6,r6,1
> > +	cmpwi	r6,32
> 
> I don't like how the 32 is hardcoded here. Better create a define
> for it and use the same in the init code.

Sure.  In fact I probably should use vcpu->arch.slb_nr here.

> > +hdec_soon:
> > +	/* Switch back to host partition */
> > +	ld	r4,VCPU_KVM(r9)		/* pointer to struct kvm */
> > +	ld	r6,KVM_HOST_SDR1(r4)
> > +	lwz	r7,KVM_HOST_LPID(r4)
> > +	li	r8,0x3ff		/* switch to reserved LPID */
> 
> is it reserved by ISA? Either way, hard-coding the constant without
> a name is not nice :).

Actually, it just has to be an LPID value that isn't ever used for
running a real guest (or the host).  I'll make a name for it.

> > +	lis	r8,0x7fff
> 
> INT_MAX@h might be more readable.

OK.

> > int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
> > {
> > -	return !(v->arch.shared->msr & MSR_WE) ||
> > +#ifndef CONFIG_KVM_BOOK3S_64_HV
> > +	return !(kvmppc_get_msr(v) & MSR_WE) ||
> > 	       !!(v->arch.pending_exceptions);
> > +#else
> > +	return 1;
> 
> So what happens if the guest sets MSR_WE? It just stays in guest
> context idling? That'd be pretty bad for scheduling on the host.

The MSR_WE bit doesn't exist on POWER7 (or any of POWER[4567], in
fact).  If the guest wants to idle it calls the H_CEDE hcall.

> > @@ -184,12 +188,14 @@ int kvm_dev_ioctl_check_extension(long ext)
> > 	case KVM_CAP_PPC_IRQ_LEVEL:
> > 	case KVM_CAP_ENABLE_CAP:
> > 	case KVM_CAP_PPC_OSI:
> > +#ifndef CONFIG_KVM_BOOK3S_64_HV
> 
> You also don't do OSI on HV :).

Good point, I'll fix that.

> > @@ -496,8 +510,11 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
> > 	if (waitqueue_active(&vcpu->wq)) {
> > 		wake_up_interruptible(&vcpu->wq);
> > 		vcpu->stat.halt_wakeup++;
> > +#ifdef CONFIG_KVM_BOOK3S_64_HV
> > +	} else if (vcpu->cpu != -1) {
> > +		smp_send_reschedule(vcpu->cpu);
> 
> Shouldn't this be done for non-HV too? The only reason we don't do
> it yet is because we don't do SMP, no?

I didn't know why you didn't do it for non-HV, so I didn't change it
for that case.  If you say it's OK, I'll change it (we'll need to set
vcpu->cpu in the vcpu_load/unload code for book3s_pr too, then).

> > +#endif
> > 	}
> > -
> 
> eh... :)

OK. :)

> > +		struct {
> > +			__u64 nr;
> > +			__u64 ret;
> > +			__u64 args[9];
> > +		} papr_hcall;
> 
> This needs some information in the documentation.

Yes, Avi commented on that too.

> PS: I CC'ed kvm-ppc@vger. Please make sure to CC that mailing list,
> so people interested in kvm on ppc get your patches as well :).

Sure, will do.

Thanks,
Paul.
