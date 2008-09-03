Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83DD6DDEF8
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 05:38:17 +1000 (EST)
Message-Id: <8B2F4CD4-8DDF-4A88-825E-3C3D9C8396CA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080903161251.GA10877@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2 1/4] powerpc: Introduce local (non-broadcast) forms of
	tlb invalidates
Date: Wed, 3 Sep 2008 13:51:48 -0500
References: <1220018213-12959-1-git-send-email-galak@kernel.crashing.org>
	<20080903161251.GA10877@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 3, 2008, at 11:12 AM, Scott Wood wrote:

> On Fri, Aug 29, 2008 at 08:56:50AM -0500, Kumar Gala wrote:
>> +_GLOBAL(_tlbil_all)
>> +#define MMUCSR0_TLBFI	(MMUCSR0_TLB0FI | MMUCSR0_TLB1FI | \
>> +			 MMUCSR0_TLB2FI | MMUCSR0_TLB3FI)
>> +	li	r3,(MMUCSR0_TLBFI)@l
>> +	mtspr	SPRN_MMUCSR0, r3
>> +1:
>> +	mfspr	r3,SPRN_MMUCSR0
>> +	andi.	r3,r3,MMUCSR0_TLBFI@l
>> +	bne	1b
>> +	blr
>> +
>> +/*
>> + * Flush MMU TLB for a particular process id, but only on the  
>> local processor
>> + * (no broadcast)
>> + */
>> +_GLOBAL(_tlbil_pid)
>> +	li	r3,(MMUCSR0_TLBFI)@l
>> +	mtspr	SPRN_MMUCSR0, r3
>> +1:
>> +	mfspr	r3,SPRN_MMUCSR0
>> +	andi.	r1,r2,MMUCSR0_TLBFI@l
>> +	bne	1b
>> +	blr
>
> I'm guessing _tlbil_pid is never called, as it will clobber the stack
> pointer.
>
> Should probably just point both function names at the same  
> implementation,
> since PID-specific invalidation isn't supported on non-tlbilx cores.

I'd prefer not to go down that path as it makes it a compile time  
issue and not runtime one in the future.  I plan on changing this for  
tlbilx cores to be a CPU feature.

I've fixed the code to just use r3 always.

- k
