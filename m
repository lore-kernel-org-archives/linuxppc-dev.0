Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 27FD52C00E9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 11:53:23 +1000 (EST)
Message-ID: <5179DE12.1050609@windriver.com>
Date: Fri, 26 Apr 2013 09:53:22 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Subject: Re: [PATCH 1/1] kvm:book3e: Fix a build error
References: <1366890336-4282-1-git-send-email-tiejun.chen@windriver.com>
 <300B73AA675FCE4A93EB4FC1D42459FF3D9C33@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF3D9C33@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/25/2013 08:11 PM, Caraman Mihai Claudiu-B02008 wrote:
>> -----Original Message-----
>> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-
>> owner@vger.kernel.org] On Behalf Of Tiejun Chen
>> Sent: Thursday, April 25, 2013 2:46 PM
>> To: galak@kernel.crashing.org
>> Cc: linuxppc-dev@lists.ozlabs.org; kvm-ppc@vger.kernel.org;
>> kvm@vger.kernel.org
>> Subject: [PATCH 1/1] kvm:book3e: Fix a build error
>>
>> Commit cd66cc2e, "powerpc/85xx: Add AltiVec support for e6500", adds
>> support for AltiVec on a Book-E class processor, but while compiling
>> in the CONFIG_PPC_BOOK3E_64 and CONFIG_VIRTUALIZATION case, this
>> introduce the following error:
>>
>> arch/powerpc/kernel/exceptions-64e.S:402: undefined reference to
>> `kvmppc_handler_42_0x01B'
>> arch/powerpc/kernel/built-in.o: In function `exc_altivec_assist_book3e':
>> arch/powerpc/kernel/exceptions-64e.S:424: undefined reference to
>> `kvmppc_handler_43_0x01B'
>> make: *** [vmlinux] Error 1
>>
>> Looks we should add these altivec kvm handlers.
>>
>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---
>>   arch/powerpc/kvm/bookehv_interrupts.S |    5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/powerpc/kvm/bookehv_interrupts.S
>> b/arch/powerpc/kvm/bookehv_interrupts.S
>> index e8ed7d6..fa9c78a 100644
>> --- a/arch/powerpc/kvm/bookehv_interrupts.S
>> +++ b/arch/powerpc/kvm/bookehv_interrupts.S
>> @@ -319,6 +319,11 @@ kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(DBG), \
>>   	SPRN_DSRR0, SPRN_DSRR1, 0
>>   kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(CRIT), \
>>   	SPRN_CSRR0, SPRN_CSRR1, 0
>> +/* altivec */
>> +kvm_handler BOOKE_INTERRUPT_ALTIVEC_UNAVAIL, EX_PARAMS(GEN), \
>> +	SPRN_SRR0, SPRN_SRR1, 0
>> +kvm_handler BOOKE_INTERRUPT_ALTIVEC_ASSIST, EX_PARAMS(GEN), \
>> +	SPRN_SRR0, SPRN_SRR1, 0
>>   #else
>>   /*
>>    * For input register values, see
>> arch/powerpc/include/asm/kvm_booke_hv_asm.h
>> --
>
> It seems that you are not using kvm-ppc-queue branch.

This is just used to fix a build error in powerpc.git when introduce commit 
cd66cc2e, "powerpc/85xx: Add AltiVec support for e6500", in *powerpc.git* as I 
mentioned in this patch head.

>
> I already have a patch ready for this (and AltiVec support is work

This change don't block your AltiVec support for kvm unless you think this 
change is wrong. And especially, we always can reproduce this error with/without 
enabling AltiVec, so I also don't think this should be suspended until support 
e6500 in kvm since kvm based on e5500 should work.

Tiejun

> in progress) but we need first to pull e6500 kernel patches from
> Linux tree into agraf.git.
>
> -Mike
>
>
>
>
>
>
>
>
