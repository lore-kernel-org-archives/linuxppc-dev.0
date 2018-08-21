Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vgpq0h4pzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 16:33:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v2 1/4] powerpc/tm: Remove msr_tm_active()
In-Reply-To: <7433b095-ce67-5097-8dd7-0f47ab797914@debian.org>
References: <201806160346.lDndh49W%fengguang.wu@intel.com>
 <1529362784-14194-1-git-send-email-leitao@debian.org>
 <e2f169e3ce57e5b092642088127f67a52da2bf93.camel@neuling.org>
 <87tvntakb6.fsf@concordia.ellerman.id.au>
 <7433b095-ce67-5097-8dd7-0f47ab797914@debian.org>
Date: Tue, 21 Aug 2018 16:33:06 +1000
Message-ID: <874lfomdp9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Breno Leitao <leitao@debian.org> writes:
> On 08/16/2018 09:49 PM, Michael Ellerman wrote:
>> Michael Neuling <mikey@neuling.org> writes:
>> 
>>> On Mon, 2018-06-18 at 19:59 -0300, Breno Leitao wrote:
>>>> Currently msr_tm_active() is a wrapper around MSR_TM_ACTIVE() if
>>>> CONFIG_PPC_TRANSACTIONAL_MEM is set, or it is just a function that
>>>> returns false if CONFIG_PPC_TRANSACTIONAL_MEM is not set.
>>>>
>>>> This function is not necessary, since MSR_TM_ACTIVE() just do the same,
>>>> checking for the TS bits and does not require any TM facility.
>>>>
>>>> This patchset remove every instance of msr_tm_active() and replaced it
>>>> by MSR_TM_ACTIVE().
>>>>
>>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>>>
>>>
>>> Patch looks good... one minor nit below...
>>>
>>>>  
>>>> -	if (!msr_tm_active(regs->msr) &&
>>>> -		!current->thread.load_fp && !loadvec(current->thread))
>>>> +	if (!current->thread.load_fp && !loadvec(current->thread)) {
>>>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>>>> +		if (!MSR_TM_ACTIVE(regs->msr))
>>>> +			return;
>>>
>>> Can you make a MSR_TM_ACTIVE() that returns false when
>>> !CONFIG_PPC_TRANSACTIONAL_MEM. Then you don't need this inline #ifdef.
>> 
>> Is that safe?
>> 
>> I see ~50 callers of MSR_TM_ACTIVE(), are they all inside #ifdef TM ?
>
> I checked all of them, and the only two that are not called inside a #ifdef
> are at kvm/book3s_hv_tm.c. They are:
>
>   kvm/book3s_hv_tm.c:		if (!MSR_TM_ACTIVE(msr)) {
>   kvm/book3s_hv_tm.c:		if (MSR_TM_ACTIVE(msr) || !(vcpu->arch.texasr & TEXASR_FS)) {

That whole file is only built if TM=y:

kvm-hv-$(CONFIG_PPC_TRANSACTIONAL_MEM) += \
	book3s_hv_tm.o

> All the others are being called inside the #ifdef
>
> Other than that, I do not see why it would be a problem in the way I
> implemented it, since it will return false for the two cases above, which
> seems correct. Take a look on how the definition became:
>
>   #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>   #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
>   #else
>   #define MSR_TM_ACTIVE(x) 0
>   #endif


Imagine we had some code somewhere that checked for TM being active in a
non-TM aware kernel, that would break with this change, because now the
MSR check does nothing when TM=n.

eg. we might check at boot time that we're not transactional, eg. in
case we came from a kdump kernel that was in a transaction.

So if all the call-sites are already inside an #ifdef I'd be inclined to
not add the #ifdef around the MSR_TM_ACTIVE macro.

That way the macro can always be used to check the MSR value, whether TM
is compiled in or out.

cheers
