Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nXWv65ZBzF2D0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 01:43:39 +1000 (AEST)
Subject: Re: [PATCH bpf v2 3/6] bpf: get kernel symbol addresses via syscall
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, ast@kernel.org
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 naveen.n.rao@linux.vnet.ibm.com, mpe@ellerman.id.au,
 jakub.kicinski@netronome.com
References: <20180518125039.6500-1-sandipan@linux.vnet.ibm.com>
 <20180518125039.6500-4-sandipan@linux.vnet.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <47a84b99-b93a-23e4-8797-0736530c52eb@iogearbox.net>
Date: Fri, 18 May 2018 17:43:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180518125039.6500-4-sandipan@linux.vnet.ibm.com>
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
> This adds new two new fields to struct bpf_prog_info. For
> multi-function programs, these fields can be used to pass
> a list of kernel symbol addresses for all functions in a
> given program and to userspace using the bpf system call
> with the BPF_OBJ_GET_INFO_BY_FD command.
> 
> When bpf_jit_kallsyms is enabled, we can get the address
> of the corresponding kernel symbol for a callee function
> and resolve the symbol's name. The address is determined
> by adding the value of the call instruction's imm field
> to __bpf_call_base. This offset gets assigned to the imm
> field by the verifier.
> 
> For some architectures, such as powerpc64, the imm field
> is not large enough to hold this offset.
> 
> We resolve this by:
> 
> [1] Assigning the subprog id to the imm field of a call
>     instruction in the verifier instead of the offset of
>     the callee's symbol's address from __bpf_call_base.
> 
> [2] Determining the address of a callee's corresponding
>     symbol by using the imm field as an index for the
>     list of kernel symbol addresses now available from
>     the program info.
> 
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
>  include/uapi/linux/bpf.h |  2 ++
>  kernel/bpf/syscall.c     | 20 ++++++++++++++++++++
>  kernel/bpf/verifier.c    |  7 +------
>  3 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d94d333a8225..040c9cac7303 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2188,6 +2188,8 @@ struct bpf_prog_info {
>  	__u32 xlated_prog_len;
>  	__aligned_u64 jited_prog_insns;
>  	__aligned_u64 xlated_prog_insns;
> +	__aligned_u64 jited_ksyms;
> +	__u32 nr_jited_ksyms;
>  	__u64 load_time;	/* ns since boottime */
>  	__u32 created_by_uid;
>  	__u32 nr_map_ids;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index bfcde949c7f8..54a72fafe57c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1933,6 +1933,7 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
>  	if (!capable(CAP_SYS_ADMIN)) {
>  		info.jited_prog_len = 0;
>  		info.xlated_prog_len = 0;
> +		info.nr_jited_ksyms = 0;
>  		goto done;
>  	}
>  
> @@ -1981,6 +1982,25 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
>  		}
>  	}
>  
> +	ulen = info.nr_jited_ksyms;
> +	info.nr_jited_ksyms = prog->aux->func_cnt;
> +	if (info.nr_jited_ksyms && ulen) {

Since this exposes addresses (though masked one which is correct), this
definitely needs to be guarded with bpf_dump_raw_ok() like we do in other
places here (see JIT dump for example).

> +		u64 __user *user_jited_ksyms = u64_to_user_ptr(info.jited_ksyms);
> +		ulong ksym_addr;
> +		u32 i;
> +
> +		/* copy the address of the kernel symbol corresponding to
> +		 * each function
> +		 */
> +		ulen = min_t(u32, info.nr_jited_ksyms, ulen);
> +		for (i = 0; i < ulen; i++) {
> +			ksym_addr = (ulong) prog->aux->func[i]->bpf_func;
> +			ksym_addr &= PAGE_MASK;
> +			if (put_user((u64) ksym_addr, &user_jited_ksyms[i]))
> +				return -EFAULT;
> +		}
> +	}
> +
>  done:
>  	if (copy_to_user(uinfo, &info, info_len) ||
>  	    put_user(info_len, &uattr->info.info_len))
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c56cce9c4e3..e826c396aba2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5426,17 +5426,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  	 * later look the same as if they were interpreted only.
>  	 */
>  	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
> -		unsigned long addr;
> -
>  		if (insn->code != (BPF_JMP | BPF_CALL) ||
>  		    insn->src_reg != BPF_PSEUDO_CALL)
>  			continue;
>  		insn->off = env->insn_aux_data[i].call_imm;
>  		subprog = find_subprog(env, i + insn->off + 1);
> -		addr  = (unsigned long)func[subprog]->bpf_func;

Hmm, in current bpf tree this says 'subprog + 1' here, so this is not
rebased against bpf tree but bpf-next (unlike what subject says)?

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/kernel/bpf/verifier.c#n5351

> -		addr &= PAGE_MASK;
> -		insn->imm = (u64 (*)(u64, u64, u64, u64, u64))
> -			    addr - __bpf_call_base;
> +		insn->imm = subprog;
>  	}
>  
>  	prog->jited = 1;
> 
