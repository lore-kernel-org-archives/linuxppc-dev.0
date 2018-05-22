Return-Path: <jakub.kicinski@netronome.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r5lD6BS8zDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 05:47:20 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id f1-v6so25066971qtj.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 12:47:20 -0700 (PDT)
Date: Tue, 22 May 2018 12:47:14 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH bpf-next v3 07/10] bpf: fix multi-function JITed dump
 obtained via syscall
Message-ID: <20180522124714.7a50ada8@cakuba>
In-Reply-To: <6f245a366d5a2957e2256f4bd89ab56ade6508d5.1527008647.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
 <6f245a366d5a2957e2256f4bd89ab56ade6508d5.1527008647.git.sandipan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 22 May 2018 22:46:10 +0530, Sandipan Das wrote:
> Currently, for multi-function programs, we cannot get the JITed
> instructions using the bpf system call's BPF_OBJ_GET_INFO_BY_FD
> command. Because of this, userspace tools such as bpftool fail
> to identify a multi-function program as being JITed or not.
> 
> With the JIT enabled and the test program running, this can be
> verified as follows:
> 
>   # cat /proc/sys/net/core/bpf_jit_enable
>   1
> 
> Before applying this patch:
> 
>   # bpftool prog list
>   1: kprobe  name foo  tag b811aab41a39ad3d  gpl
>           loaded_at 2018-05-16T11:43:38+0530  uid 0
>           xlated 216B  not jited  memlock 65536B
>   ...
> 
>   # bpftool prog dump jited id 1
>   no instructions returned
> 
> After applying this patch:
> 
>   # bpftool prog list
>   1: kprobe  name foo  tag b811aab41a39ad3d  gpl
>           loaded_at 2018-05-16T12:13:01+0530  uid 0
>           xlated 216B  jited 308B  memlock 65536B
>   ...
> 
>   # bpftool prog dump jited id 1
>      0:   nop
>      4:   nop
>      8:   mflr    r0
>      c:   std     r0,16(r1)
>     10:   stdu    r1,-112(r1)
>     14:   std     r31,104(r1)
>     18:   addi    r31,r1,48
>     1c:   li      r3,10
>   ...
> 
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
>  kernel/bpf/syscall.c | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index f0ad4b5f0224..1c4cba91e523 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1970,13 +1970,43 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
>  	 * for offload.
>  	 */
>  	ulen = info.jited_prog_len;
> -	info.jited_prog_len = prog->jited_len;
> +	if (prog->aux->func_cnt) {
> +		u32 i;
> +
> +		info.jited_prog_len = 0;
> +		for (i = 0; i < prog->aux->func_cnt; i++)
> +			info.jited_prog_len += prog->aux->func[i]->jited_len;
> +	} else {
> +		info.jited_prog_len = prog->jited_len;
> +	}
> +
>  	if (info.jited_prog_len && ulen) {
>  		if (bpf_dump_raw_ok()) {
>  			uinsns = u64_to_user_ptr(info.jited_prog_insns);
>  			ulen = min_t(u32, info.jited_prog_len, ulen);
> -			if (copy_to_user(uinsns, prog->bpf_func, ulen))
> -				return -EFAULT;
> +
> +			/* for multi-function programs, copy the JITed
> +			 * instructions for all the functions
> +			 */
> +			if (prog->aux->func_cnt) {
> +				u32 len, free, i;
> +				u8 *img;
> +
> +				free = ulen;
> +				for (i = 0; i < prog->aux->func_cnt; i++) {
> +					len = prog->aux->func[i]->jited_len;
> +					img = (u8 *) prog->aux->func[i]->bpf_func;
> +					if (len > free)
> +						break;

nit: interesting, the previous code used to fill up the space
completely, I would personally vote to keep that behaviour and do:

    len = min(len, free);
    copy();
    free -= len;
    if (!free)
        break;

otherwise the user space doesn't know when to stop disassembling
truncated output.  But that's really a corner case, so not sure we care.

> +					if (copy_to_user(uinsns, img, len))
> +						return -EFAULT;
> +					uinsns += len;
> +					free -= len;
> +				}
> +			} else {
> +				if (copy_to_user(uinsns, prog->bpf_func, ulen))
> +					return -EFAULT;
> +			}
>  		} else {
>  			info.jited_prog_insns = 0;
>  		}
