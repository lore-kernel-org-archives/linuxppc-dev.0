Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DFD071A0174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 18:28:06 +1100 (AEDT)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3516D140BE0
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2016 18:28:06 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 27 Jan 2016 12:58:01 +0530
Subject: Re: [PATCH v3 2/2] KVM: PPC: Exit guest upon MCE when FWNMI
 capability is enabled
To: Paul Mackerras <paulus@ozlabs.org>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>
References: <20160113070759.20248.86252.stgit@aravindap>
 <20160113070809.20248.80811.stgit@aravindap>
 <20160123102847.GB11916@fergus.ozlabs.ibm.com>
 <56A377CF.8040706@linux.vnet.ibm.com>
 <20160123212448.GC11916@fergus.ozlabs.ibm.com>
Cc: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev@ozlabs.org, pbonzini@redhat.com,
 david@gibson.dropbear.id.au, kvm@vger.kernel.org, mpe@ellerman.id.au
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Message-ID: <56A84F67.8050109@linux.vnet.ibm.com>
Date: Wed, 27 Jan 2016 10:32:31 +0530
MIME-Version: 1.0
In-Reply-To: <20160123212448.GC11916@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/24/2016 02:54 AM, Paul Mackerras wrote:
> On Sat, Jan 23, 2016 at 06:23:35PM +0530, Aravinda Prasad wrote:
>>
>>
>> On Saturday 23 January 2016 03:58 PM, Paul Mackerras wrote:
>>> On Wed, Jan 13, 2016 at 12:38:09PM +0530, Aravinda Prasad wrote:
>>>> Enhance KVM to cause a guest exit with KVM_EXIT_NMI
>>>> exit reasons upon a machine check exception (MCE) in
>>>> the guest address space if the KVM_CAP_PPC_FWNMI
>>>> capability is enabled (instead of delivering 0x200
>>>> interrupt to guest). This enables QEMU to build error
>>>> log and deliver machine check exception to guest via
>>>> guest registered machine check handler.
>>>>
>>>> This approach simplifies the delivering of machine
>>>> check exception to guest OS compared to the earlier
>>>> approach of KVM directly invoking 0x200 guest interrupt
>>>> vector. In the earlier approach QEMU was enhanced to
>>>> patch the 0x200 interrupt vector during boot. The
>>>> patched code at 0x200 issued a private hcall to pass
>>>> the control to QEMU to build the error log.
>>>>
>>>> This design/approach is based on the feedback for the
>>>> QEMU patches to handle machine check exception. Details
>>>> of earlier approach of handling machine check exception
>>>> in QEMU and related discussions can be found at:
>>>
>>> [snip]
>>>
>>>> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>>>> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>>>> @@ -133,21 +133,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>>>>  	stb	r0, HSTATE_HWTHREAD_REQ(r13)
>>>>  
>>>>  	/*
>>>> -	 * For external and machine check interrupts, we need
>>>> -	 * to call the Linux handler to process the interrupt.
>>>> -	 * We do that by jumping to absolute address 0x500 for
>>>> -	 * external interrupts, or the machine_check_fwnmi label
>>>> -	 * for machine checks (since firmware might have patched
>>>> -	 * the vector area at 0x200).  The [h]rfid at the end of the
>>>> -	 * handler will return to the book3s_hv_interrupts.S code.
>>>> -	 * For other interrupts we do the rfid to get back
>>>> -	 * to the book3s_hv_interrupts.S code here.
>>>> +	 * For external interrupts we need to call the Linux
>>>> +	 * handler to process the interrupt. We do that by jumping
>>>> +	 * to absolute address 0x500 for external interrupts.
>>>> +	 * The [h]rfid at the end of the handler will return to
>>>> +	 * the book3s_hv_interrupts.S code. For other interrupts
>>>> +	 * we do the rfid to get back to the book3s_hv_interrupts.S
>>>> +	 * code here.
>>>>  	 */
>>>>  	ld	r8, 112+PPC_LR_STKOFF(r1)
>>>>  	addi	r1, r1, 112
>>>>  	ld	r7, HSTATE_HOST_MSR(r13)
>>>>  
>>>> -	cmpwi	cr1, r12, BOOK3S_INTERRUPT_MACHINE_CHECK
>>>>  	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
>>>>  	beq	11f
>>>>  	cmpwi	r12, BOOK3S_INTERRUPT_H_DOORBELL
>>>> @@ -162,7 +159,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>>>>  	mtmsrd	r6, 1			/* Clear RI in MSR */
>>>>  	mtsrr0	r8
>>>>  	mtsrr1	r7
>>>> -	beq	cr1, 13f		/* machine check */
>>>>  	RFI
>>>>  
>>>>  	/* On POWER7, we have external interrupts set to use HSRR0/1 */
>>>> @@ -170,8 +166,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>>>>  	mtspr	SPRN_HSRR1, r7
>>>>  	ba	0x500
>>>>  
>>>> -13:	b	machine_check_fwnmi
>>>> -
>>>
>>> So, what you're disabling here is the host-side handling of the
>>> machine check after completing the guest->host switch.  This has
>>> nothing to do with how the machine check gets communicated to the
>>> guest.
>>>
>>> Now, part of the host-side machine check handling has already
>>> happened, but I thought there was more that was done in host kernel
>>> virtual mode.  If this change really is needed then I would want an
>>> ack from Mahesh that this is correct, and it will need to be explained
>>> in detail in the patch description.
>>
>> If we don't do that we will end up running into
>> panic() in opal_machine_check() if UE belonged to guest.
>>
>> Details in this link:
>> http://marc.info/?l=kvm-ppc&m=144730552720044&w=2
> 
> Well maybe the panic call needs to be changed.  But the way you have
> it, we *never* get to opal_machine_check for any machine check
> interrupt, and I have a hard time believing that is correct.

We do still go to opal_machine_check for MCE in host kernel/user space.
The host virtual mode prints the event and then checks whether MCE is in
kernel or user space context and acts accordingly.

For machine check while in guest, when we fall through
machine_check_fwnmi, the register context points to host kernel module
(__kvmppc_vcore_entry [kvm_hv]). And opal_machine_check thinks that
memory UE is in host kernel rather than in guest and goes down the panic
path. It becomes bit difficult to figure out whether MCE happened in
guest OR in host kernel by looking at the register set received by
opal_machine_check in this case.

Aravinda's implementation requires him to go back to KVM kernel module
which would end up in NMI exit inside QEMU and then he can handle Memory
error for guest inside QEMU and deliver it to guest. Hence he needs to
bypass machine_check_fwnmi. But by this time we would have already
hooked the mce event to work queue for console logging.

The other approach could be to add additional field into machine check
event that can help opal_machine_check to identify that MCE is from
guest and then just return from interrupt after printing event instead
of going down to panic path. But this could be bit messy.

Thanks,
-Mahesh.

> 
> Paul.
> 
