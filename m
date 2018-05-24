Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s1NW560szF0mP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 17:34:19 +1000 (AEST)
Subject: Re: [PATCH bpf-next v4 02/10] bpf: powerpc64: pad function address
 loads with NOPs
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, ast@kernel.org
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, naveen.n.rao@linux.vnet.ibm.com,
 jakub.kicinski@netronome.com
References: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
 <d0db970711596827ba88209e545c686d77c22b7d.1527143877.git.sandipan@linux.vnet.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <43081c8c-d8a8-254a-69f0-7941acab90a3@iogearbox.net>
Date: Thu, 24 May 2018 09:34:12 +0200
MIME-Version: 1.0
In-Reply-To: <d0db970711596827ba88209e545c686d77c22b7d.1527143877.git.sandipan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/24/2018 08:56 AM, Sandipan Das wrote:
> For multi-function programs, loading the address of a callee
> function to a register requires emitting instructions whose
> count varies from one to five depending on the nature of the
> address.
> 
> Since we come to know of the callee's address only before the
> extra pass, the number of instructions required to load this
> address may vary from what was previously generated. This can
> make the JITed image grow or shrink.
> 
> To avoid this, we should generate a constant five-instruction
> when loading function addresses by padding the optimized load
> sequence with NOPs.
> 
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/net/bpf_jit_comp64.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 1bdb1aff0619..e4582744a31d 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -167,25 +167,37 @@ static void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
>  
>  static void bpf_jit_emit_func_call(u32 *image, struct codegen_context *ctx, u64 func)
>  {
> +	unsigned int i, ctx_idx = ctx->idx;
> +
> +	/* Load function address into r12 */
> +	PPC_LI64(12, func);
> +
> +	/* For bpf-to-bpf function calls, the callee's address is unknown
> +	 * until the last extra pass. As seen above, we use PPC_LI64() to
> +	 * load the callee's address, but this may optimize the number of
> +	 * instructions required based on the nature of the address.
> +	 *
> +	 * Since we don't want the number of instructions emitted to change,
> +	 * we pad the optimized PPC_LI64() call with NOPs to guarantee that
> +	 * we always have a five-instruction sequence, which is the maximum
> +	 * that PPC_LI64() can emit.
> +	 */
> +	for (i = ctx->idx - ctx_idx; i < 5; i++)
> +		PPC_NOP();

By the way, I think you can still optimize this. The nops are not really
needed in case of insn->src_reg != BPF_PSEUDO_CALL since the address of
a normal BPF helper call will always be at a fixed location and known a
priori.

>  #ifdef PPC64_ELF_ABI_v1
> -	/* func points to the function descriptor */
> -	PPC_LI64(b2p[TMP_REG_2], func);
> -	/* Load actual entry point from function descriptor */
> -	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_2], 0);
> -	/* ... and move it to LR */
> -	PPC_MTLR(b2p[TMP_REG_1]);
>  	/*
>  	 * Load TOC from function descriptor at offset 8.
>  	 * We can clobber r2 since we get called through a
>  	 * function pointer (so caller will save/restore r2)
>  	 * and since we don't use a TOC ourself.
>  	 */
> -	PPC_BPF_LL(2, b2p[TMP_REG_2], 8);
> -#else
> -	/* We can clobber r12 */
> -	PPC_FUNC_ADDR(12, func);
> -	PPC_MTLR(12);
> +	PPC_BPF_LL(2, 12, 8);
> +	/* Load actual entry point from function descriptor */
> +	PPC_BPF_LL(12, 12, 0);
>  #endif
> +
> +	PPC_MTLR(12);
>  	PPC_BLRL();
>  }
>  
> 
