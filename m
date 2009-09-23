Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 99EC9B7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 08:35:51 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8NMXUIx026807
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 18:33:30 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8NMZgD2254654
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 18:35:43 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8NMZgM7015285
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 18:35:42 -0400
Date: Wed, 23 Sep 2009 18:35:39 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/44x: Fix xmon single step on PowerPC 44x
Message-ID: <20090923223539.GJ14261@zod.rchland.ibm.com>
References: <20090923134844.GF14261@zod.rchland.ibm.com>
	<20090923135156.GH14261@zod.rchland.ibm.com>
	<1253741674.7103.327.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253741674.7103.327.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 24, 2009 at 07:34:34AM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2009-09-23 at 09:51 -0400, Josh Boyer wrote:
>> Prior to the arch/ppc -> arch/powerpc transition, xmon had support for single
>> stepping on 4xx boards.  The functionality was lost when arch/ppc was removed.
>> This patch restores single step support for 44x boards.
>> 
>> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/xmon/xmon.c |   20 +++++++++++++++++++-
>>  1 files changed, 19 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>> index c6f0a71..fe2ad71 100644
>> --- a/arch/powerpc/xmon/xmon.c
>> +++ b/arch/powerpc/xmon/xmon.c
>> @@ -517,6 +517,15 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
>>  	in_xmon = 0;
>>  #endif
>>  
>> +#ifdef CONFIG_4xx
>> +	if ((regs->msr & (MSR_DE)) == (MSR_DE)) {
>
>Why not just if (regs->msr & MSR_DE) ?

Blind duplication of existing if case.  Will fix.

>> +		bp = at_breakpoint(regs->nip);
>> +		if (bp != NULL) {
>> +			regs->nip = (unsigned long) &bp->instr[0];
>> +			atomic_inc(&bp->ref_count);
>> +		}
>> +	}
>> +#else
>
>Any reason why that couldn't be in CONFIG_BOOKE ?

Off the top of my head, no.  I haven't tested on 40x yet though.  Will try
and do that and revise.

>>  	if ((regs->msr & (MSR_IR|MSR_PR|MSR_SF)) == (MSR_IR|MSR_SF)) {
>>  		bp = at_breakpoint(regs->nip);
>>  		if (bp != NULL) {
>> @@ -530,7 +539,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
>>  			}
>>  		}
>>  	}
>> -
>> +#endif
>>  	insert_cpu_bpts();
>>  
>>  	local_irq_restore(flags);
>> @@ -894,6 +903,14 @@ cmds(struct pt_regs *excp)
>>  	}
>>  }
>>  
>> +#ifdef CONFIG_44x
>
>Same comment about BOOKE intead of 44x

Nod.

>> +static int do_step(struct pt_regs *regs)
>> +{
>> +	regs->msr |= MSR_DE;
>> +	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
>
>I'm not sure about setting IDM... Won't that be a problem if you have
>an external debugger connected ?

It could be.  I have no external debugger, thus no way to check it.  You don't
get an exception without IDM set though, so it won't trap back into xmon like
it should.  This is how we did it in arch/ppc (which isn't always a great
thing) as well.

I don't see how you could get it working without IDM, unless you inserted a
trap (aka breakpoint) every time.  That seems sort of suboptimal when we have
the IC event we can use.

josh
