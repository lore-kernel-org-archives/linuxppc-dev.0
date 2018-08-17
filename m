Return-Path: <breno.debian@gmail.com>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sMrR0fDxzDr5p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 22:26:30 +1000 (AEST)
Received: by mail-qt0-f193.google.com with SMTP id y5-v6so8448565qti.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 05:26:30 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] powerpc/tm: Remove msr_tm_active()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <201806160346.lDndh49W%fengguang.wu@intel.com>
 <1529362784-14194-1-git-send-email-leitao@debian.org>
 <e2f169e3ce57e5b092642088127f67a52da2bf93.camel@neuling.org>
 <87tvntakb6.fsf@concordia.ellerman.id.au>
From: Breno Leitao <leitao@debian.org>
Cc: Michael Neuling <mikey@neuling.org>
Message-ID: <7433b095-ce67-5097-8dd7-0f47ab797914@debian.org>
Date: Fri, 17 Aug 2018 09:26:22 -0300
MIME-Version: 1.0
In-Reply-To: <87tvntakb6.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 08/16/2018 09:49 PM, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
> 
>> On Mon, 2018-06-18 at 19:59 -0300, Breno Leitao wrote:
>>> Currently msr_tm_active() is a wrapper around MSR_TM_ACTIVE() if
>>> CONFIG_PPC_TRANSACTIONAL_MEM is set, or it is just a function that
>>> returns false if CONFIG_PPC_TRANSACTIONAL_MEM is not set.
>>>
>>> This function is not necessary, since MSR_TM_ACTIVE() just do the same,
>>> checking for the TS bits and does not require any TM facility.
>>>
>>> This patchset remove every instance of msr_tm_active() and replaced it
>>> by MSR_TM_ACTIVE().
>>>
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>>
>>
>> Patch looks good... one minor nit below...
>>
>>>  
>>> -	if (!msr_tm_active(regs->msr) &&
>>> -		!current->thread.load_fp && !loadvec(current->thread))
>>> +	if (!current->thread.load_fp && !loadvec(current->thread)) {
>>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>>> +		if (!MSR_TM_ACTIVE(regs->msr))
>>> +			return;
>>
>> Can you make a MSR_TM_ACTIVE() that returns false when
>> !CONFIG_PPC_TRANSACTIONAL_MEM. Then you don't need this inline #ifdef.
> 
> Is that safe?
> 
> I see ~50 callers of MSR_TM_ACTIVE(), are they all inside #ifdef TM ?

I checked all of them, and the only two that are not called inside a #ifdef
are at kvm/book3s_hv_tm.c. They are:

  kvm/book3s_hv_tm.c:		if (!MSR_TM_ACTIVE(msr)) {
  kvm/book3s_hv_tm.c:		if (MSR_TM_ACTIVE(msr) || !(vcpu->arch.texasr & TEXASR_FS)) {

All the others are being called inside the #ifdef

Other than that, I do not see why it would be a problem in the way I
implemented it, since it will return false for the two cases above, which
seems correct. Take a look on how the definition became:

  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
  #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
  #else
  #define MSR_TM_ACTIVE(x) 0
  #endif

I also tested it with different config files, and I didn't see any complain.
These are the platforms I built for.

* powernv_defconfig
* pseries_le_defconfig
* pseries_defconfig
* ppc64_defconfig
* ppc64e_defconfig
* pmac32_defconfig
* ppc44x_defconfig
* mpc85xx_smp_defconfig
* mpc85xx_defconfig
* ps3_defconfig

Anyway, if you have any other suggestion I can follow in order to guarantee
that I am not causing any regression, I would be happy. Touching these core
kernel macros is scary!

Thanks!
