Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nXDy0jV1zF2C4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 01:30:41 +1000 (AEST)
Subject: Re: [PATCH bpf v2 2/6] bpf: powerpc64: add JIT support for
 multi-function programs
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, ast@kernel.org
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 naveen.n.rao@linux.vnet.ibm.com, mpe@ellerman.id.au,
 jakub.kicinski@netronome.com
References: <20180518125039.6500-1-sandipan@linux.vnet.ibm.com>
 <20180518125039.6500-3-sandipan@linux.vnet.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c3b23da2-0781-a1ee-0d49-71e9efb52e66@iogearbox.net>
Date: Fri, 18 May 2018 17:30:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180518125039.6500-3-sandipan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/18/2018 02:50 PM, Sandipan Das wrote:
> This adds support for bpf-to-bpf function calls in the powerpc64
> JIT compiler. The JIT compiler converts the bpf call instructions
> to native branch instructions. After a round of the usual passes,
> the start addresses of the JITed images for the callee functions
> are known. Finally, to fixup the branch target addresses, we need
> to perform an extra pass.
> 
> Because of the address range in which JITed images are allocated
> on powerpc64, the offsets of the start addresses of these images
> from __bpf_call_base are as large as 64 bits. So, for a function
> call, we cannot use the imm field of the instruction to determine
> the callee's address. Instead, we use the alternative method of
> getting it from the list of function addresses in the auxillary
> data of the caller by using the off field as an index.
> 
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/net/bpf_jit_comp64.c | 79 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 69 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 1bdb1aff0619..25939892d8f7 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -256,7 +256,7 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
>  /* Assemble the body code between the prologue & epilogue */
>  static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
>  			      struct codegen_context *ctx,
> -			      u32 *addrs)
> +			      u32 *addrs, bool extra_pass)
>  {
>  	const struct bpf_insn *insn = fp->insnsi;
>  	int flen = fp->len;
> @@ -712,11 +712,23 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
>  			break;
>  
>  		/*
> -		 * Call kernel helper
> +		 * Call kernel helper or bpf function
>  		 */
>  		case BPF_JMP | BPF_CALL:
>  			ctx->seen |= SEEN_FUNC;
> -			func = (u8 *) __bpf_call_base + imm;
> +
> +			/* bpf function call */
> +			if (insn[i].src_reg == BPF_PSEUDO_CALL && extra_pass)

Perhaps it might make sense here for !extra_pass to set func to some dummy
address as otherwise the 'kernel helper call' branch used for this is a bit
misleading in that sense. The PPC_LI64() used in bpf_jit_emit_func_call()
optimizes the immediate addr, I presume the JIT can handle situations where
in the final extra_pass the image needs to grow/shrink again (due to different
final address for the call)?

> +				if (fp->aux->func && off < fp->aux->func_cnt)
> +					/* use the subprog id from the off
> +					 * field to lookup the callee address
> +					 */
> +					func = (u8 *) fp->aux->func[off]->bpf_func;
> +				else
> +					return -EINVAL;
> +			/* kernel helper call */
> +			else
> +				func = (u8 *) __bpf_call_base + imm;
>  
>  			bpf_jit_emit_func_call(image, ctx, (u64)func);
>  
> @@ -864,6 +876,14 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
>  	return 0;
>  }
>  
> +struct powerpc64_jit_data {
> +	struct bpf_binary_header *header;
> +	u32 *addrs;
> +	u8 *image;
> +	u32 proglen;
> +	struct codegen_context ctx;
> +};
> +
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  {
>  	u32 proglen;
> @@ -871,6 +891,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	u8 *image = NULL;
>  	u32 *code_base;
>  	u32 *addrs;
> +	struct powerpc64_jit_data *jit_data;
>  	struct codegen_context cgctx;
>  	int pass;
>  	int flen;
> @@ -878,6 +899,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	struct bpf_prog *org_fp = fp;
>  	struct bpf_prog *tmp_fp;
>  	bool bpf_blinded = false;
> +	bool extra_pass = false;
>  
>  	if (!fp->jit_requested)
>  		return org_fp;
> @@ -891,7 +913,28 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  		fp = tmp_fp;
>  	}
>  
> +	jit_data = fp->aux->jit_data;
> +	if (!jit_data) {
> +		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
> +		if (!jit_data) {
> +			fp = org_fp;
> +			goto out;
> +		}
> +		fp->aux->jit_data = jit_data;
> +	}
> +
>  	flen = fp->len;
> +	addrs = jit_data->addrs;
> +	if (addrs) {
> +		cgctx = jit_data->ctx;
> +		image = jit_data->image;
> +		bpf_hdr = jit_data->header;
> +		proglen = jit_data->proglen;
> +		alloclen = proglen + FUNCTION_DESCR_SIZE;
> +		extra_pass = true;
> +		goto skip_init_ctx;
> +	}
> +
>  	addrs = kzalloc((flen+1) * sizeof(*addrs), GFP_KERNEL);
>  	if (addrs == NULL) {
>  		fp = org_fp;

In this case of !addrs, we leak the just allocated jit_data here!

> @@ -904,10 +947,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
>  
>  	/* Scouting faux-generate pass 0 */
> -	if (bpf_jit_build_body(fp, 0, &cgctx, addrs)) {
> +	if (bpf_jit_build_body(fp, 0, &cgctx, addrs, false)) {
>  		/* We hit something illegal or unsupported. */
>  		fp = org_fp;
> -		goto out;
> +		goto out_addrs;
>  	}
>  
>  	/*
> @@ -925,9 +968,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  			bpf_jit_fill_ill_insns);
>  	if (!bpf_hdr) {
>  		fp = org_fp;
> -		goto out;
> +		goto out_addrs;
>  	}
>  
> +skip_init_ctx:
>  	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
>  
>  	/* Code generation passes 1-2 */
> @@ -935,7 +979,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  		/* Now build the prologue, body code & epilogue for real. */
>  		cgctx.idx = 0;
>  		bpf_jit_build_prologue(code_base, &cgctx);
> -		bpf_jit_build_body(fp, code_base, &cgctx, addrs);
> +		bpf_jit_build_body(fp, code_base, &cgctx, addrs, extra_pass);
>  		bpf_jit_build_epilogue(code_base, &cgctx);
>  
>  		if (bpf_jit_enable > 1)
> @@ -956,15 +1000,30 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	((u64 *)image)[1] = local_paca->kernel_toc;
>  #endif
>  
> +	bpf_flush_icache(bpf_hdr, (u8 *)bpf_hdr + (bpf_hdr->pages * PAGE_SIZE));
> +
> +	if (!fp->is_func || extra_pass) {
> +		bpf_jit_binary_lock_ro(bpf_hdr);

powerpc doesn't implement set_memory_ro(). Generally this is not a problem since
set_memory_ro() defaults to 'return 0' in this case, but since the bpf_jit_free()
destructor is overridden here, there's no bpf_jit_binary_unlock_ro() and in case
powerpc would get set_memory_*() support one day this will then crash in random
places once the mem gets back to the allocator, thus hard to debug. Two options:
either you remove the bpf_jit_free() override or you remove the bpf_jit_binary_lock_ro().

> +	} else {
> +		jit_data->addrs = addrs;
> +		jit_data->ctx = cgctx;
> +		jit_data->proglen = proglen;
> +		jit_data->image = image;
> +		jit_data->header = bpf_hdr;
> +	}
> +
>  	fp->bpf_func = (void *)image;
>  	fp->jited = 1;
>  	fp->jited_len = alloclen;
>  
> -	bpf_flush_icache(bpf_hdr, (u8 *)bpf_hdr + (bpf_hdr->pages * PAGE_SIZE));
> +	if (!fp->is_func || extra_pass) {
> +out_addrs:
> +		kfree(addrs);
> +		kfree(jit_data);
> +		fp->aux->jit_data = NULL;
> +	}
>  
>  out:
> -	kfree(addrs);
> -
>  	if (bpf_blinded)
>  		bpf_jit_prog_release_other(fp, fp == org_fp ? tmp_fp : org_fp);
>  
> 
