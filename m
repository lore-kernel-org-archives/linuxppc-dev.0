Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF6C2DE349
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 15:03:30 +1000 (EST)
Message-Id: <FA9AA92E-8F05-4C34-A73E-CB2211B1852E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080519210452.28e8805c@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v3 3/3] [POWERPC] 40x/Book-E: Save/restore volatile
	exception registers
Date: Tue, 20 May 2008 00:03:12 -0500
References: <Pine.LNX.4.64.0805161404410.6286@blarg.am.freescale.net>
	<Pine.LNX.4.64.0805161406100.6286@blarg.am.freescale.net>
	<Pine.LNX.4.64.0805161407440.6286@blarg.am.freescale.net>
	<20080519210452.28e8805c@zod.rchland.ibm.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> <snip>
>
>> --- a/arch/powerpc/kernel/entry_32.S
>> +++ b/arch/powerpc/kernel/entry_32.S
>
> <snip>
>
>> +#ifdef CONFIG_40x
>> 	.globl	ret_from_crit_exc
>> ret_from_crit_exc:
>> +	mfspr	r9,SPRN_SPRG3
> 	lis 	r10,saved_ksp_limit@ha;
> 	lwz	r10,saved_ksp_limit@l(r10);
> 	tovirt(r9,r9);
>> +	stw	r10,KSP_LIMIT(r9)
> 	lis	r9, crit_srr0@ha;
> 	lwz	r9, crit_srr0@l(r9);
> 	lis	r10, crit_srr1@ha;
> 	lwz	r10, crit_srr1@l(r10);
>> +	mtspr	SPRN_SRR0,r9;
>> +	mtspr	SPRN_SRR1,r10;
>> 	RET_FROM_EXC_LEVEL(SPRN_CSRR0, SPRN_CSRR1, RFCI)
>> +#endif /* CONFIG_40x */
>
> With the above changes, I no longer get kernel panics on returning  
> from
> critical exceptions.  Breakpoints and single stepping worked on my
> 405GP board.
>
> Again, not stress tested but it's looking much better.
>
> josh

Thanks.  I've just posted v5 with the various fixes for 40x.  Can you  
test those out to make sure they still work.

- k
