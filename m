Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nXV43sQ8zF2CB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 01:42:04 +1000 (AEST)
Subject: Re: [PATCH bpf v2 1/6] bpf: support 64-bit offsets for bpf function
 calls
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, ast@kernel.org
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 naveen.n.rao@linux.vnet.ibm.com, mpe@ellerman.id.au,
 jakub.kicinski@netronome.com
References: <20180518125039.6500-1-sandipan@linux.vnet.ibm.com>
 <20180518125039.6500-2-sandipan@linux.vnet.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <242592f3-c2b4-04bb-7a6c-2394ae4fee98@iogearbox.net>
Date: Fri, 18 May 2018 17:15:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180518125039.6500-2-sandipan@linux.vnet.ibm.com>
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
> The imm field of a bpf instruction is a signed 32-bit integer.
> For JIT bpf-to-bpf function calls, it stores the offset of the
> start address of the callee's JITed image from __bpf_call_base.
> 
> For some architectures, such as powerpc64, this offset may be
> as large as 64 bits and cannot be accomodated in the imm field
> without truncation.
> 
> We resolve this by:
> 
> [1] Additionally using the auxillary data of each function to
>     keep a list of start addresses of the JITed images for all
>     functions determined by the verifier.
> 
> [2] Retaining the subprog id inside the off field of the call
>     instructions and using it to index into the list mentioned
>     above and lookup the callee's address.
> 
> To make sure that the existing JIT compilers continue to work
> without requiring changes, we keep the imm field as it is.
> 
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
>  kernel/bpf/verifier.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a9e4b1372da6..6c56cce9c4e3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5383,11 +5383,24 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  			    insn->src_reg != BPF_PSEUDO_CALL)
>  				continue;
>  			subprog = insn->off;
> -			insn->off = 0;
>  			insn->imm = (u64 (*)(u64, u64, u64, u64, u64))
>  				func[subprog]->bpf_func -
>  				__bpf_call_base;
>  		}
> +
> +		/* we use the aux data to keep a list of the start addresses
> +		 * of the JITed images for each function in the program
> +		 *
> +		 * for some architectures, such as powerpc64, the imm field
> +		 * might not be large enough to hold the offset of the start
> +		 * address of the callee's JITed image from __bpf_call_base
> +		 *
> +		 * in such cases, we can lookup the start address of a callee
> +		 * by using its subprog id, available from the off field of
> +		 * the call instruction, as an index for this list
> +		 */
> +		func[i]->aux->func = func;
> +		func[i]->aux->func_cnt = env->subprog_cnt + 1;

The target tree you have here is infact bpf, since in bpf-next there was a
cleanup where the + 1 is removed. Just for the record that we need to keep
this in mind for bpf into bpf-next merge since this would otherwise subtly
break.

>  	}
>  	for (i = 0; i < env->subprog_cnt; i++) {
>  		old_bpf_func = func[i]->bpf_func;
> 
