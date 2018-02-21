Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmJkL0G5WzF1Bg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 11:48:09 +1100 (AEDT)
Subject: Re: [PATCH] bpf, powerpc: fix jit for seccomp_data access
To: Michael Ellerman <mpe@ellerman.id.au>, Mark Lord <mlord@pobox.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>
Cc: linuxppc-dev@lists.ozlabs.org
References: <d79074fe-2ee1-c132-ef2d-f6bb618b53bb@pobox.com>
 <2a91fe0c-ea85-dd79-6682-66b1301d7e49@iogearbox.net>
 <53a6b85c-8cb7-d4d0-8234-7ecfb1a709b2@pobox.com>
 <1519154571.d9vaokens9.naveen@linux.ibm.com>
 <2f428cf9-23f3-d1f1-1524-46d6faa17386@pobox.com>
 <87fu5vrxjp.fsf@concordia.ellerman.id.au>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <03bbd3d6-3f67-795a-afa3-2feee367991a@iogearbox.net>
Date: Wed, 21 Feb 2018 01:47:35 +0100
MIME-Version: 1.0
In-Reply-To: <87fu5vrxjp.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2018 01:33 AM, Michael Ellerman wrote:
> Mark Lord <mlord@pobox.com> writes:
> 
>> I am using SECCOMP to filter syscalls on a ppc32 platform,
>> and noticed that the JIT compiler was failing on the BPF
>> even though the interpreter was working fine.
>>
>> The issue was that the compiler was missing one of the instructions
>> used by SECCOMP, so here is a patch to enable JIT for that instruction.
>>
>> Signed-Off-By:  Mark Lord <mlord@pobox.com>
> 
> Thanks.
> 
> What is the failure mode without this patch? I assume when you have the
> JIT enabled the seccomp filter fails to load entirely? Or do we have
> logic to fall back to the interpreter?

The logic for all JITs is that once a BPF insn cannot be JITed then it falls
back to BPF interpreter. Here, since ppc32 is cBPF the path is: cBPF insn ->
cBPF JIT -> fail -> migrate cBPF to eBPF -> run in eBPF interpreter. In the
case where interpreter is compiled out (CONFIG_BPF_JIT_ALWAYS_ON), then the
filter is rejected.

> Either way we should probably back port to stable. I assume this has
> been broken since we originally added 32-bit support, so:

Note that arm32 before it was converted to be an eBPF JIT (eBPF JITs do handle
seccomp BPF in any case) was the only cBPF JIT that had it 'JIT-able', so
currently, other cBPF ones like sparc32 or mips32 don't translate it either.
Meaning, it would be nice to have as feature; I wouldn't necessarily frame
it as a bug though (or at least a stable-urgent one, imho, but I leave that
to you, of course).

> Fixes: eb84bab0fb38 ("ppc: Kconfig: Enable BPF JIT on ppc32")
> Cc: stable@vger.kernel.org # v4.1+
> 
> cheers
> 
> 
>> --- old/arch/powerpc/net/bpf_jit_comp.c 2018-02-16 14:07:01.000000000 -0500
>> +++ linux/arch/powerpc/net/bpf_jit_comp.c       2018-02-20 14:41:20.805227494 -0500
>> @@ -329,6 +329,9 @@ static int bpf_jit_build_body(struct bpf
>>                         BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, len) != 4);
>>                         PPC_LWZ_OFFS(r_A, r_skb, offsetof(struct sk_buff, len));
>>                         break;
>> +               case BPF_LDX | BPF_W | BPF_ABS: /* A = *((u32 *)(seccomp_data + K)); */
>> +                       PPC_LWZ_OFFS(r_A, r_skb, K);
>> +                       break;
>>                 case BPF_LDX | BPF_W | BPF_LEN: /* X = skb->len; */
>>                         PPC_LWZ_OFFS(r_X, r_skb, offsetof(struct sk_buff, len));
>>                         break;
>> -- 
>> Mark Lord
>> Real-Time Remedies Inc.
>> mlord@pobox.com
