Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6A3602C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 02:21:03 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Oct 2013 02:21:02 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 24DCF357805D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 02:20:59 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8UGKlAX9306568
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Oct 2013 02:20:47 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8UGKnX3026944
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Oct 2013 02:20:49 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 06/11] kvm: powerpc: book3s: Add is_hv_enabled to
 kvmppc_ops
In-Reply-To: <52498FD9.6060809@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <9BAA779D-FE0C-4971-992B-57D80F945906@suse.de>
 <87zjqya025.fsf@linux.vnet.ibm.com>
 <F87036DE-6077-4B79-965F-C52F84DD994D@suse.de>
 <87pprqbh96.fsf@linux.vnet.ibm.com> <52498FD9.6060809@suse.de>
Date: Mon, 30 Sep 2013 21:50:43 +0530
Message-ID: <878uyeb7s4.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 09/30/2013 02:56 PM, Aneesh Kumar K.V wrote:
>> Alexander Graf<agraf@suse.de>  writes:
>>
>>> On 27.09.2013, at 15:03, Aneesh Kumar K.V wrote:
>>>
>>>> Alexander Graf<agraf@suse.de>  writes:
>>>>
>>>>
>>>>>> diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
>>>>>> index 1abe478..e0229dd 100644
>>>>>> --- a/arch/powerpc/kvm/book3s_segment.S
>>>>>> +++ b/arch/powerpc/kvm/book3s_segment.S
>>>>>> @@ -161,9 +161,14 @@ kvmppc_handler_trampoline_enter_end:
>>>>>> .global kvmppc_handler_trampoline_exit
>>>>>> kvmppc_handler_trampoline_exit:
>>>>>>
>>>>>> +#if defined(CONFIG_KVM_BOOK3S_HV)
>>>>>> +.global kvmppc_interrupt_pr
>>>>>> +kvmppc_interrupt_pr:
>>>>>> +	ld	r9, HSTATE_SCRATCH2(r13)
>>>>>> +#else
>>>>>> .global kvmppc_interrupt
>>>>>> kvmppc_interrupt:
>>>>> Just always call it kvmppc_interrupt_pr and thus share at least that
>>>>> part of the code :).
>>>> But if i don't have HV enabled, we don't compile book3s_hv_rmhandlers.S
>>>> Hence don't have the kvmppc_interrupt symbol defined.
>>> Ah, because we're always jumping to kvmppc_interrupt. Can we make this
>>> slightly less magical? How about we always call kvmppc_interrupt_hv
>>> when CONFIG_KVM_BOOK3S_HV_POSSIBLE and always kvmppc_interrupt_pr when
>>> CONFIG_KVM_BOOK3S_PR_POSSIBLE and then branch to kvmppc_interrupt_pr
>>> from kvmppc_interrupt_hv?
>>>
>>> IMHO that would make the code flow more obvious.
>>
>> To make sure I understand you correctly, what you are suggesting is
>> to update __KVM_HANDLER to call kvmppc_interupt_pr when HV is not
>> enabled ?
>
> Yes, I think that makes the code flow more obvious. Every function 
> always has the same name regardless of config options then.
>

Something like this ( btw non tested )

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index cca12f0..0b798d4 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -198,6 +198,17 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	cmpwi	r10,0;							\
 	bne	do_kvm_##n
 
+#ifdef CONFIG_KVM_BOOK3S_HV
+/*
+ * If hv is possible, interrupts come into to the hv version
+ * of the kvmppc_interrupt code, which then jumps to the PR handler,
+ * kvmppc_interrupt_pr, if the guest is a PR guest.
+ */
+#define kvmppc_interrupt kvmppc_interrupt_hv
+#else
+#define kvmppc_interrupt kvmppc_interrupt_pr
+#endif
+
 #define __KVM_HANDLER(area, h, n)					\
 do_kvm_##n:								\
 	BEGIN_FTR_SECTION_NESTED(947)					\
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 5ede7fc..2eb6622 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -563,8 +563,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 /*
  * We come here from the first-level interrupt handlers.
  */
-	.globl	kvmppc_interrupt
-kvmppc_interrupt:
+	.globl	kvmppc_interrupt_hv
+kvmppc_interrupt_hv:
 	/*
 	 * Register contents:
 	 * R12		= interrupt vector
@@ -577,6 +577,11 @@ kvmppc_interrupt:
 	lbz	r9, HSTATE_IN_GUEST(r13)
 	cmpwi	r9, KVM_GUEST_MODE_HOST_HV
 	beq	kvmppc_bad_host_intr
+#ifdef CONFIG_KVM_BOOK3S_PR
+	cmpwi	r9, KVM_GUEST_MODE_GUEST
+	ld	r9, HSTATE_SCRATCH2(r13)
+	beq	kvmppc_interrupt_pr
+#endif
 	/* We're now back in the host but in guest MMU context */
 	li	r9, KVM_GUEST_MODE_HOST_HV
 	stb	r9, HSTATE_IN_GUEST(r13)
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index 1abe478..bc50c97 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -161,8 +161,8 @@ kvmppc_handler_trampoline_enter_end:
 .global kvmppc_handler_trampoline_exit
 kvmppc_handler_trampoline_exit:
 
-.global kvmppc_interrupt
-kvmppc_interrupt:
+.global kvmppc_interrupt_pr
+kvmppc_interrupt_pr:
 
 	/* Register usage at this point:
 	 *
