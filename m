Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41s4NZ1cttzDr4h
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 10:49:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/4] powerpc/tm: Remove msr_tm_active()
In-Reply-To: <e2f169e3ce57e5b092642088127f67a52da2bf93.camel@neuling.org>
References: <201806160346.lDndh49W%fengguang.wu@intel.com>
 <1529362784-14194-1-git-send-email-leitao@debian.org>
 <e2f169e3ce57e5b092642088127f67a52da2bf93.camel@neuling.org>
Date: Fri, 17 Aug 2018 10:49:49 +1000
Message-ID: <87tvntakb6.fsf@concordia.ellerman.id.au>
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

Michael Neuling <mikey@neuling.org> writes:

> On Mon, 2018-06-18 at 19:59 -0300, Breno Leitao wrote:
>> Currently msr_tm_active() is a wrapper around MSR_TM_ACTIVE() if
>> CONFIG_PPC_TRANSACTIONAL_MEM is set, or it is just a function that
>> returns false if CONFIG_PPC_TRANSACTIONAL_MEM is not set.
>> 
>> This function is not necessary, since MSR_TM_ACTIVE() just do the same,
>> checking for the TS bits and does not require any TM facility.
>> 
>> This patchset remove every instance of msr_tm_active() and replaced it
>> by MSR_TM_ACTIVE().
>> 
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> 
>
> Patch looks good... one minor nit below...
>
>>  
>> -	if (!msr_tm_active(regs->msr) &&
>> -		!current->thread.load_fp && !loadvec(current->thread))
>> +	if (!current->thread.load_fp && !loadvec(current->thread)) {
>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>> +		if (!MSR_TM_ACTIVE(regs->msr))
>> +			return;
>
> Can you make a MSR_TM_ACTIVE() that returns false when
> !CONFIG_PPC_TRANSACTIONAL_MEM. Then you don't need this inline #ifdef.

Is that safe?

I see ~50 callers of MSR_TM_ACTIVE(), are they all inside #ifdef TM ?

cheers
