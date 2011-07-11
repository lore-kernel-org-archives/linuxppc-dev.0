Return-Path: <matt@ozlabs.org>
Message-ID: <4E1A97CF.80509@ozlabs.org>
Date: Mon, 11 Jul 2011 16:27:27 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [RFC PATCH 1/1] BPF JIT for PPC64
References: <4E04288F.4090201@ozlabs.org> <m2boxmxt45.fsf@igel.home>
In-Reply-To: <m2boxmxt45.fsf@igel.home>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25/06/11 17:33, Andreas Schwab wrote:
> Matt Evans <matt@ozlabs.org> writes:
> 
>> +	stdu	r1, -128(r1);					\
> 
>> +	addi	r5, r1, 128+BPF_PPC_STACK_BASIC+(2*8);		\
> 
>> +	addi	r1, r1, 128;					\
> 
>> +					PPC_STD(r_M + i, 1, -128 + (8*i));
> 
>> +					PPC_LD(r_M + i, 1, -128 + (8*i));
> 
> s/128/BPF_PPC_STACK_SAVE/?

Actually, that's a different 128, but that nicely illustrates that I should've
#defined something more recognisable :-) The second set, with -128, is actually
in the save area for non-volatile regs, whereas the first is just a stackframe
size.

Cheers,


Matt
