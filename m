Return-Path: <matt@ozlabs.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix =?UTF-8?Q?BPF=5FJIT=20code=20to=20link?=
 =?UTF-8?Q?=20with=20multiple=20TOCs?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 22 Jun 2012 10:01:23 +0100
From: matt <matt@ozlabs.org>
In-Reply-To: <1340337027-22110-1-git-send-email-michael@ellerman.id.au>
References: <1340337027-22110-1-git-send-email-michael@ellerman.id.au>
Message-ID: <6122e5d280ca5d20a71a1e661cd39d29@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, amodra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Whee!  Let's try that again with MUA configured better...

On 2012-06-22 04:50, Michael Ellerman wrote:
> If the kernel is big enough (eg. allyesconfig), the linker may need 
> to
> switch TOCs when calling from the BPF JIT code out to the external
> helpers (skb_copy_bits() & bpf_internal_load_pointer_neg_helper()).
>
> In order to do that we need to leave space after the bl for the 
> linker
> to insert a reload of our TOC pointer.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Oops, x2, and

Acked-by: Matt Evans <matt@ozlabs.org>

:-)


> ---
>  arch/powerpc/net/bpf_jit_64.S |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/net/bpf_jit_64.S 
> b/arch/powerpc/net/bpf_jit_64.S
> index 55ba385..7d3a3b5 100644
> --- a/arch/powerpc/net/bpf_jit_64.S
> +++ b/arch/powerpc/net/bpf_jit_64.S
> @@ -105,6 +105,7 @@ sk_load_byte_msh_positive_offset:
>  	mr	r4, r_addr;					\
>  	li	r6, SIZE;					\
>  	bl	skb_copy_bits;					\
> +	nop;							\
>  	/* R3 = 0 on success */					\
>  	addi	r1, r1, BPF_PPC_SLOWPATH_FRAME;			\
>  	ld	r0, 16(r1);					\
> @@ -156,6 +157,7 @@ bpf_slow_path_byte_msh:
>  	mr	r4, r_addr;					\
>  	li	r5, SIZE;					\
>  	bl	bpf_internal_load_pointer_neg_helper;		\
> +	nop;							\
>  	/* R3 != 0 on success */				\
>  	addi	r1, r1, BPF_PPC_SLOWPATH_FRAME;			\
>  	ld	r0, 16(r1);					\
