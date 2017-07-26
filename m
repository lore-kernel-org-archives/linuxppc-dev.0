Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHW033R08zDqmr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 20:03:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Matt Brown <matthew.brown.dev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/5] powerpc/lib/sstep: Add prty instruction emulation
In-Reply-To: <20170725153033.GH13471@gate.crashing.org>
References: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
 <20170725033320.17893-4-matthew.brown.dev@gmail.com>
 <20170725153033.GH13471@gate.crashing.org>
Date: Wed, 26 Jul 2017 20:03:30 +1000
Message-ID: <87tw1z5xcd.fsf@concordia.ellerman.id.au>
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

Segher Boessenkool <segher@kernel.crashing.org> writes:

> On Tue, Jul 25, 2017 at 01:33:19PM +1000, Matt Brown wrote:
>> +static nokprobe_inline void do_prty(struct pt_regs *regs, unsigned long v,
>> +				int size, int ra)
>> +{
>> +	unsigned long long res = v;
>> +
>> +	res = (0x0001000100010001 & res) + (0x0001000100010001 & (res >> 8));
>> +	res = (0x0000000700000007 & res) + (0x0000000700000007 & (res >> 16));
>> +	if (size == 32) {		/* prtyw */
>> +		regs->gpr[ra] = (0x0000000100000001 & res);
>> +		return;
>> +	}
>> +
>> +	res = (0x000000000000000f & res) + (0x000000000000000f & (res >> 32));
>> +	regs->gpr[ra] = res & 1;	/*prtyd */
>> +}
>
> Does 7's and 0xf look strange (since the top bit in the values there
> is always 0).  You always "and" the values with 1 later, you could do
> that immediately (and change + to ^).
>
> A general question about these patches: some things are inside #ifdef
> __powerpc64__, some are not.  It seems it is the wrong macro, and it
> should be used (or not used) consistently?

Why is it the wrong macro? Because we tend to use CONFIG_PPC64 you mean?

I thought the reason some are #ifdef'ed is that some are 64-bit only.
ie. bpermd is 64-bit only ?

cheers
