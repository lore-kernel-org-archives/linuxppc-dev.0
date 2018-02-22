Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zn0MN6Tc0zF18m
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 14:34:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Mark Lord <mlord@pobox.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] bpf, powerpc: fix jit for seccomp_data access
In-Reply-To: <03bbd3d6-3f67-795a-afa3-2feee367991a@iogearbox.net>
References: <d79074fe-2ee1-c132-ef2d-f6bb618b53bb@pobox.com>
 <2a91fe0c-ea85-dd79-6682-66b1301d7e49@iogearbox.net>
 <53a6b85c-8cb7-d4d0-8234-7ecfb1a709b2@pobox.com>
 <1519154571.d9vaokens9.naveen@linux.ibm.com>
 <2f428cf9-23f3-d1f1-1524-46d6faa17386@pobox.com>
 <87fu5vrxjp.fsf@concordia.ellerman.id.au>
 <03bbd3d6-3f67-795a-afa3-2feee367991a@iogearbox.net>
Date: Thu, 22 Feb 2018 14:34:08 +1100
Message-ID: <87bmghr93j.fsf@concordia.ellerman.id.au>
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

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 02/21/2018 01:33 AM, Michael Ellerman wrote:
>> Mark Lord <mlord@pobox.com> writes:
>> 
>>> I am using SECCOMP to filter syscalls on a ppc32 platform,
>>> and noticed that the JIT compiler was failing on the BPF
>>> even though the interpreter was working fine.
>>>
>>> The issue was that the compiler was missing one of the instructions
>>> used by SECCOMP, so here is a patch to enable JIT for that instruction.
>>>
>>> Signed-Off-By:  Mark Lord <mlord@pobox.com>
>> 
>> Thanks.
>> 
>> What is the failure mode without this patch? I assume when you have the
>> JIT enabled the seccomp filter fails to load entirely? Or do we have
>> logic to fall back to the interpreter?
>
> The logic for all JITs is that once a BPF insn cannot be JITed then it falls
> back to BPF interpreter. Here, since ppc32 is cBPF the path is: cBPF insn ->
> cBPF JIT -> fail -> migrate cBPF to eBPF -> run in eBPF interpreter. In the
> case where interpreter is compiled out (CONFIG_BPF_JIT_ALWAYS_ON), then the
> filter is rejected.

OK thanks.

>> Either way we should probably back port to stable. I assume this has
>> been broken since we originally added 32-bit support, so:
>
> Note that arm32 before it was converted to be an eBPF JIT (eBPF JITs do handle
> seccomp BPF in any case) was the only cBPF JIT that had it 'JIT-able', so
> currently, other cBPF ones like sparc32 or mips32 don't translate it either.
> Meaning, it would be nice to have as feature; I wouldn't necessarily frame
> it as a bug though (or at least a stable-urgent one, imho, but I leave that
> to you, of course).

OK, I'll just add the Fixes tag for our reference and we can always back
port it to stable later if we want to.

cheers
