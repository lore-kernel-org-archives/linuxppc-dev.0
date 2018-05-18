Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nY5B1GTdzF1PV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 02:09:02 +1000 (AEST)
Subject: Re: [PATCH bpf v2 2/6] bpf: powerpc64: add JIT support for
 multi-function programs
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, ast@kernel.org,
 Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: jakub.kicinski@netronome.com, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, netdev@vger.kernel.org
References: <20180518125039.6500-1-sandipan@linux.vnet.ibm.com>
 <20180518125039.6500-3-sandipan@linux.vnet.ibm.com>
 <c3b23da2-0781-a1ee-0d49-71e9efb52e66@iogearbox.net>
 <1526658936.9wk22hv49g.naveen@linux.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2772018b-6c0b-5ddc-7dc8-60ac0cb867a3@iogearbox.net>
Date: Fri, 18 May 2018 18:08:55 +0200
MIME-Version: 1.0
In-Reply-To: <1526658936.9wk22hv49g.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/18/2018 06:05 PM, Naveen N. Rao wrote:
> Daniel Borkmann wrote:
>> On 05/18/2018 02:50 PM, Sandipan Das wrote:
>>> This adds support for bpf-to-bpf function calls in the powerpc64
>>> JIT compiler. The JIT compiler converts the bpf call instructions
>>> to native branch instructions. After a round of the usual passes,
>>> the start addresses of the JITed images for the callee functions
>>> are known. Finally, to fixup the branch target addresses, we need
>>> to perform an extra pass.
>>>
>>> Because of the address range in which JITed images are allocated
>>> on powerpc64, the offsets of the start addresses of these images
>>> from __bpf_call_base are as large as 64 bits. So, for a function
>>> call, we cannot use the imm field of the instruction to determine
>>> the callee's address. Instead, we use the alternative method of
>>> getting it from the list of function addresses in the auxillary
>>> data of the caller by using the off field as an index.
>>>
>>> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/net/bpf_jit_comp64.c | 79 ++++++++++++++++++++++++++++++++++-----
>>>  1 file changed, 69 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
>>> index 1bdb1aff0619..25939892d8f7 100644
>>> --- a/arch/powerpc/net/bpf_jit_comp64.c
>>> +++ b/arch/powerpc/net/bpf_jit_comp64.c
>>> @@ -256,7 +256,7 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
>>>  /* Assemble the body code between the prologue & epilogue */
>>>  static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
>>>                    struct codegen_context *ctx,
>>> -                  u32 *addrs)
>>> +                  u32 *addrs, bool extra_pass)
>>>  {
>>>      const struct bpf_insn *insn = fp->insnsi;
>>>      int flen = fp->len;
>>> @@ -712,11 +712,23 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
>>>              break;
>>>  
>>>          /*
>>> -         * Call kernel helper
>>> +         * Call kernel helper or bpf function
>>>           */
>>>          case BPF_JMP | BPF_CALL:
>>>              ctx->seen |= SEEN_FUNC;
>>> -            func = (u8 *) __bpf_call_base + imm;
>>> +
>>> +            /* bpf function call */
>>> +            if (insn[i].src_reg == BPF_PSEUDO_CALL && extra_pass)
>>
>> Perhaps it might make sense here for !extra_pass to set func to some dummy
>> address as otherwise the 'kernel helper call' branch used for this is a bit
>> misleading in that sense. The PPC_LI64() used in bpf_jit_emit_func_call()
>> optimizes the immediate addr, I presume the JIT can handle situations where
>> in the final extra_pass the image needs to grow/shrink again (due to different
>> final address for the call)?
> 
> That's a good catch. We don't handle that -- we expect to get the size right on first pass. We could probably have PPC_FUNC_ADDR() pad the result with nops to make it a constant 5-instruction sequence.

Yeah, arm64 does something similar by not optimizing the imm in order to always
emit 4 insns for it.

Thanks,
Daniel
