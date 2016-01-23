Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C44991A0B6B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jan 2016 23:53:47 +1100 (AEDT)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0F8E1140BA4
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Jan 2016 23:53:46 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Sat, 23 Jan 2016 05:53:44 -0700
Message-ID: <56A377CF.8040706@linux.vnet.ibm.com>
Date: Sat, 23 Jan 2016 18:23:35 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@ozlabs.org>
CC: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev@ozlabs.org, pbonzini@redhat.com,
 mahesh@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 kvm@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH v3 2/2] KVM: PPC: Exit guest upon MCE when FWNMI capability
 is enabled
References: <20160113070759.20248.86252.stgit@aravindap>
 <20160113070809.20248.80811.stgit@aravindap>
 <20160123102847.GB11916@fergus.ozlabs.ibm.com>
In-Reply-To: <20160123102847.GB11916@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Saturday 23 January 2016 03:58 PM, Paul Mackerras wrote:
> On Wed, Jan 13, 2016 at 12:38:09PM +0530, Aravinda Prasad wrote:
>> Enhance KVM to cause a guest exit with KVM_EXIT_NMI
>> exit reasons upon a machine check exception (MCE) in
>> the guest address space if the KVM_CAP_PPC_FWNMI
>> capability is enabled (instead of delivering 0x200
>> interrupt to guest). This enables QEMU to build error
>> log and deliver machine check exception to guest via
>> guest registered machine check handler.
>>
>> This approach simplifies the delivering of machine
>> check exception to guest OS compared to the earlier
>> approach of KVM directly invoking 0x200 guest interrupt
>> vector. In the earlier approach QEMU was enhanced to
>> patch the 0x200 interrupt vector during boot. The
>> patched code at 0x200 issued a private hcall to pass
>> the control to QEMU to build the error log.
>>
>> This design/approach is based on the feedback for the
>> QEMU patches to handle machine check exception. Details
>> of earlier approach of handling machine check exception
>> in QEMU and related discussions can be found at:
> 
> [snip]
> 
>> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> @@ -133,21 +133,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>>  	stb	r0, HSTATE_HWTHREAD_REQ(r13)
>>  
>>  	/*
>> -	 * For external and machine check interrupts, we need
>> -	 * to call the Linux handler to process the interrupt.
>> -	 * We do that by jumping to absolute address 0x500 for
>> -	 * external interrupts, or the machine_check_fwnmi label
>> -	 * for machine checks (since firmware might have patched
>> -	 * the vector area at 0x200).  The [h]rfid at the end of the
>> -	 * handler will return to the book3s_hv_interrupts.S code.
>> -	 * For other interrupts we do the rfid to get back
>> -	 * to the book3s_hv_interrupts.S code here.
>> +	 * For external interrupts we need to call the Linux
>> +	 * handler to process the interrupt. We do that by jumping
>> +	 * to absolute address 0x500 for external interrupts.
>> +	 * The [h]rfid at the end of the handler will return to
>> +	 * the book3s_hv_interrupts.S code. For other interrupts
>> +	 * we do the rfid to get back to the book3s_hv_interrupts.S
>> +	 * code here.
>>  	 */
>>  	ld	r8, 112+PPC_LR_STKOFF(r1)
>>  	addi	r1, r1, 112
>>  	ld	r7, HSTATE_HOST_MSR(r13)
>>  
>> -	cmpwi	cr1, r12, BOOK3S_INTERRUPT_MACHINE_CHECK
>>  	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
>>  	beq	11f
>>  	cmpwi	r12, BOOK3S_INTERRUPT_H_DOORBELL
>> @@ -162,7 +159,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>>  	mtmsrd	r6, 1			/* Clear RI in MSR */
>>  	mtsrr0	r8
>>  	mtsrr1	r7
>> -	beq	cr1, 13f		/* machine check */
>>  	RFI
>>  
>>  	/* On POWER7, we have external interrupts set to use HSRR0/1 */
>> @@ -170,8 +166,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>>  	mtspr	SPRN_HSRR1, r7
>>  	ba	0x500
>>  
>> -13:	b	machine_check_fwnmi
>> -
> 
> So, what you're disabling here is the host-side handling of the
> machine check after completing the guest->host switch.  This has
> nothing to do with how the machine check gets communicated to the
> guest.
> 
> Now, part of the host-side machine check handling has already
> happened, but I thought there was more that was done in host kernel
> virtual mode.  If this change really is needed then I would want an
> ack from Mahesh that this is correct, and it will need to be explained
> in detail in the patch description.

If we don't do that we will end up running into
panic() in opal_machine_check() if UE belonged to guest.

Details in this link:
http://marc.info/?l=kvm-ppc&m=144730552720044&w=2


> 
>>  14:	mtspr	SPRN_HSRR0, r8
>>  	mtspr	SPRN_HSRR1, r7
>>  	b	hmi_exception_after_realmode
>> @@ -2390,15 +2384,13 @@ machine_check_realmode:
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
>> +	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest either
>> +	 * through machine check interrupt (set HSRR0 to 0x200) or by
>> +	 * exiting the guest with KVM_EXIT_NMI exit reason if guest is
>> +	 * FWNMI capable. For handled errors (no-fatal), just go back
>> +	 * to guest execution with current HSRR0. This new approach
>> +	 * injects machine check errors in guest address space to guest
>> +	 * enabling guest kernel to suitably handle such errors.
>>  	 *
>>  	 * if we receive machine check with MSR(RI=0) then deliver it to
>>  	 * guest as machine check causing guest to crash.
>> @@ -2408,11 +2400,17 @@ machine_check_realmode:
>>  	beq	1f			/* Deliver a machine check to guest */
>>  	ld	r10, VCPU_PC(r9)
>>  	cmpdi	r3, 0		/* Did we handle MCE ? */
>> -	bne	2f	/* Continue guest execution. */
>> +	bne	3f	/* Continue guest execution. */
>>  	/* If not, deliver a machine check.  SRR0/1 are already set */
>> -1:	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
>> +1:  /* Check if guest is capable of handling NMI exit */
>> +	ld  r3, VCPU_KVM(r9)
> 
> Tab between opcode and first operand please, and also in the following
> lines.

ah.. missed it.

> 
>> +	lbz  r3, KVM_FWNMI(r3)
>> +	cmpdi   r3, 1       /* FWNMI capable? */
>> +	bne 2f
>> +	b   mc_cont
> 
> Why not just beq mc_cont rather than the bne 2f; b mc_cont?

Yes, beq mc_count is enough.

Regards,
Aravinda

> 
>> +2:	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
>>  	bl	kvmppc_msr_interrupt
>> -2:	b	fast_interrupt_c_return
>> +3:	b	fast_interrupt_c_return
> 
> Paul.
> 

-- 
Regards,
Aravinda
