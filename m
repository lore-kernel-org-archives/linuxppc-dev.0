Return-Path: <prvs=55778a2bae=ast@fb.com>
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zclgG2bJNzF15k
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 04:34:17 +1100 (AEDT)
Subject: Re: [RFC][PATCH bpf 1/2] bpf: allow 64-bit offsets for bpf function
 calls
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, <daniel@iogearbox.net>
References: <20180208120306.2568-1-sandipan@linux.vnet.ibm.com>
CC: <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <mpe@ellerman.id.au>, <naveen.n.rao@linux.vnet.ibm.com>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <4ce54c76-f8d5-e739-d9c2-e3318e398417@fb.com>
Date: Thu, 8 Feb 2018 09:08:45 -0800
MIME-Version: 1.0
In-Reply-To: <20180208120306.2568-1-sandipan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/8/18 4:03 AM, Sandipan Das wrote:
> The imm field of a bpf_insn is a signed 32-bit integer. For
> JIT-ed bpf-to-bpf function calls, it stores the offset from
> __bpf_call_base to the start of the callee function.
>
> For some architectures, such as powerpc64, it was found that
> this offset may be as large as 64 bits because of which this
> cannot be accomodated in the imm field without truncation.
>
> To resolve this, we additionally use the aux data within each
> bpf_prog associated with the caller functions to store the
> addresses of their respective callees.
>
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
>  kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5fb69a85d967..52088b4ca02f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5282,6 +5282,19 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  	 * run last pass of JIT
>  	 */
>  	for (i = 0; i <= env->subprog_cnt; i++) {
> +		u32 flen = func[i]->len, callee_cnt = 0;
> +		struct bpf_prog **callee;
> +
> +		/* for now assume that the maximum number of bpf function
> +		 * calls that can be made by a caller must be at most the
> +		 * number of bpf instructions in that function
> +		 */
> +		callee = kzalloc(sizeof(func[i]) * flen, GFP_KERNEL);
> +		if (!callee) {
> +			err = -ENOMEM;
> +			goto out_free;
> +		}
> +
>  		insn = func[i]->insnsi;
>  		for (j = 0; j < func[i]->len; j++, insn++) {
>  			if (insn->code != (BPF_JMP | BPF_CALL) ||
> @@ -5292,6 +5305,26 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  			insn->imm = (u64 (*)(u64, u64, u64, u64, u64))
>  				func[subprog]->bpf_func -
>  				__bpf_call_base;
> +
> +			/* the offset to the callee from __bpf_call_base
> +			 * may be larger than what the 32 bit integer imm
> +			 * can accomodate which will truncate the higher
> +			 * order bits
> +			 *
> +			 * to avoid this, we additionally utilize the aux
> +			 * data of each caller function for storing the
> +			 * addresses of every callee associated with it
> +			 */
> +			callee[callee_cnt++] = func[subprog];

can you share typical /proc/kallsyms ?
Are you saying that kernel and kernel modules are allocated from
address spaces that are always more than 32-bit apart?
That would mean that all kernel calls into modules are far calls
and the other way around form .ko into kernel?
Performance is probably suffering because every call needs to be built
with full 64-bit offset. No ?
