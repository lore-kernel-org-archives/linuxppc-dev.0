Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C6CB32C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 22:56:16 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 Sep 2013 22:56:15 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6A4D82BB0056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 22:56:12 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8UCtx6Y10879306
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 22:56:01 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8UCuAwS007953
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 22:56:10 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 06/11] kvm: powerpc: book3s: Add is_hv_enabled to
 kvmppc_ops
In-Reply-To: <F87036DE-6077-4B79-965F-C52F84DD994D@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <9BAA779D-FE0C-4971-992B-57D80F945906@suse.de>
 <87zjqya025.fsf@linux.vnet.ibm.com>
 <F87036DE-6077-4B79-965F-C52F84DD994D@suse.de>
Date: Mon, 30 Sep 2013 18:26:05 +0530
Message-ID: <87pprqbh96.fsf@linux.vnet.ibm.com>
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

> On 27.09.2013, at 15:03, Aneesh Kumar K.V wrote:
>
>> Alexander Graf <agraf@suse.de> writes:
>> 
>> 
>>>> diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
>>>> index 1abe478..e0229dd 100644
>>>> --- a/arch/powerpc/kvm/book3s_segment.S
>>>> +++ b/arch/powerpc/kvm/book3s_segment.S
>>>> @@ -161,9 +161,14 @@ kvmppc_handler_trampoline_enter_end:
>>>> .global kvmppc_handler_trampoline_exit
>>>> kvmppc_handler_trampoline_exit:
>>>> 
>>>> +#if defined(CONFIG_KVM_BOOK3S_HV)
>>>> +.global kvmppc_interrupt_pr
>>>> +kvmppc_interrupt_pr:
>>>> +	ld	r9, HSTATE_SCRATCH2(r13)
>>>> +#else
>>>> .global kvmppc_interrupt
>>>> kvmppc_interrupt:
>>> 
>>> Just always call it kvmppc_interrupt_pr and thus share at least that
>>> part of the code :).
>> 
>> But if i don't have HV enabled, we don't compile book3s_hv_rmhandlers.S
>> Hence don't have the kvmppc_interrupt symbol defined.
>
> Ah, because we're always jumping to kvmppc_interrupt. Can we make this
> slightly less magical? How about we always call kvmppc_interrupt_hv
> when CONFIG_KVM_BOOK3S_HV_POSSIBLE and always kvmppc_interrupt_pr when
> CONFIG_KVM_BOOK3S_PR_POSSIBLE and then branch to kvmppc_interrupt_pr
> from kvmppc_interrupt_hv?
>
> IMHO that would make the code flow more obvious.


To make sure I understand you correctly, what you are suggesting is
to update __KVM_HANDLER to call kvmppc_interupt_pr when HV is not
enabled ?

-aneesh
