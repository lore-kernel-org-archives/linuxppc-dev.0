Return-Path: <matt@ozlabs.org>
Message-ID: <4E1AA082.2040703@ozlabs.org>
Date: Mon, 11 Jul 2011 17:04:34 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [RFC PATCH 1/1] BPF JIT for PPC64
References: <4E04288F.4090201@ozlabs.org> <m2boxmxt45.fsf@igel.home>
	<1308988180.2532.27.camel@edumazet-laptop>
In-Reply-To: <1308988180.2532.27.camel@edumazet-laptop>
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Eric,

On 25/06/11 17:49, Eric Dumazet wrote:
> Le samedi 25 juin 2011 à 09:33 +0200, Andreas Schwab a écrit :
>> Matt Evans <matt@ozlabs.org> writes:
>>
>>> +	stdu	r1, -128(r1);					\
>>
>>> +	addi	r5, r1, 128+BPF_PPC_STACK_BASIC+(2*8);		\
>>
>>> +	addi	r1, r1, 128;					\
>>
>>> +					PPC_STD(r_M + i, 1, -128 + (8*i));
>>
>>> +					PPC_LD(r_M + i, 1, -128 + (8*i));
>>
>> s/128/BPF_PPC_STACK_SAVE/?
>>
> 
> I am not sure using registers to hold MEM[] is a win if MEM[idx] is used
> once in the filter
> 
> # tcpdump "tcp[20]+tcp[21]=0" -d
> (000) ldh      [12]
> (001) jeq      #0x800           jt 2	jf 15
> (002) ldb      [23]
> (003) jeq      #0x6             jt 4	jf 15
> (004) ldh      [20]
> (005) jset     #0x1fff          jt 15	jf 6
> (006) ldxb     4*([14]&0xf)
> (007) ldb      [x + 34]
> (008) st       M[1]
> (009) ldb      [x + 35]
> (010) tax      
> (011) ld       M[1]
> (012) add      x
> (013) jeq      #0x0             jt 14	jf 15
> (014) ret      #65535
> (015) ret      #0
> 
> In this sample, we use M[1] once ( one store, one load)
> 
> So saving previous register content on stack in prologue, and restoring
> it in epilogue actually slow down the code, and adds two instructions in
> filter asm code.

The x86 version generates all accesses of M[x] as a load or store to the
stackframe, so your example would result in one store + one load to/from the
stack.  More than one access would result in N stores/loads.  By having M[] live
in r16-31 on PPC, there is a one-off cost of saving/restoring the (non-volatile)
register to the stack plus a per-use cost of a register-register move (MR, which
is pretty cheap compared to loads/stores!).

You are correct in that, for a single store/load of M[1] above, I'll generate
a STD, MR, MR, LD, but this extra cost of the two MRs is pretty small.  With the
current implementation the gains seen when accessing M[x] /more/ than once will
IMHO more than justify this.  (For several M[x] accesses, x86 would have several
mem ops, PPC would have several reg-reg moves and one load+store.)

An obvious alternative would be to use some of the three free volatile registers
first (in the hope that "most" filters won't use >3 M[] locations), with a
simple register allocator.  This would save the (non-volatile reg) spill/fill to
stack, too.  In the interest of simplicity I didn't want to do that on a first
pass.

> This also makes epilogue code not easy (not possible as a matter of fact)
> to unwind in helper function
> 
> In x86_64 implementation, I chose bpf_error be able to force
> an exception, not returning to JIT code but directly to bpf_func() caller
> 
> bpf_error:
> # force a return 0 from jit handler
>         xor             %eax,%eax
>         mov             -8(%rbp),%rbx
>         leaveq
>         ret

Yep, if I use non-volatile regs a return isn't just a simple stack "pop".
Currently, I've an extra branch in the return path to hit the common epilogue.
This could be optimised such that the out of line error path jumps directly to
the common epilogue to return (rather than back to the callsite, checking a flag
and /then/ to the epilogue) to speed up the non-error case.  However, it's just
a question of getting to the (existing) epilogue code to clean up; it doesn't
need to be unwound in the helper function.  I don't think this issue is a
strong argument against having M[] exist in registers, though.

>From the current position, I think going in the direction of using volatile regs
(without backup/restore cost) is better than going in the direction of making
all M[] references stack accesses.  Do you think it's bearable to continue as it
is and then perform that optimisation later?

Also, thanks for reading/commenting on the patch!



Cheers,


Matt
