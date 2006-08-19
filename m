Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6407F67B6A
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Aug 2006 04:56:46 +1000 (EST)
From: segher@gate.crashing.org
Message-ID: <50880.84.105.60.119.1156014547.squirrel@gate.crashing.org>
Date: Sat, 19 Aug 2006 14:09:07 -0500 (CDT)
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
To: <galak@kernel.crashing.org>
In-Reply-To: <FE1A4DBD-9AAB-434A-B487-06B68AC61CC0@kernel.crashing.org>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<36A1A5C6-5269-4BDA-9F3E-A632B3A627DB@kernel.crashing.org>
	<1155924687.9659.25.camel@farscape.rchland.ibm.com>
	<FE1A4DBD-9AAB-434A-B487-06B68AC61CC0@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +static int emulate_popcntb_inst(struct pt_regs *regs, u32 instword)
>> +{
>> +	u32 ra,rs;
>> +	unsigned long tmp;
>> +
>> +	ra = (instword >> 16) & 0x1f;
>> +	rs = (instword >> 21) & 0x1f;
>> +
>> +	tmp = regs->gpr[rs];
>> +	tmp = tmp - ((tmp >> 1) & 0x5555555555555555);
>> +	tmp = (tmp & 0x3333333333333333) + ((tmp >> 2) &
>> 0x3333333333333333);
>> +	tmp = (tmp + (tmp >> 4)) & 0x0f0f0f0f0f0f0f0f;
>> +	regs->gpr[ra] = tmp;
>> +
>> +	return 0;
>> +}
>
> This is going to give warnings on ppc32 kernel compiles, maybe
> something like:
>
> (unsigned long) 0x5555555555555555ull

Nah, just make "tmp" an u64.  And/or don't do this emulation on
32-bit machines at all.

And if the compiler warns about the non-qualified constants --
well, we should compile with -std=gnu99 anyway, eh?


Segher
