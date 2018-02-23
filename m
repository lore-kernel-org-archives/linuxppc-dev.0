Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zng5P5Mt8zF1ky
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 16:39:21 +1100 (AEDT)
In-Reply-To: <2f428cf9-23f3-d1f1-1524-46d6faa17386@pobox.com>
To: Mark Lord <mlord@pobox.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: bpf, powerpc: fix jit for seccomp_data access
Message-Id: <3zng5P45Slz9sWj@ozlabs.org>
Date: Fri, 23 Feb 2018 16:39:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-02-20 at 19:49:20 UTC, Mark Lord wrote:
> I am using SECCOMP to filter syscalls on a ppc32 platform,
> and noticed that the JIT compiler was failing on the BPF
> even though the interpreter was working fine.
> 
> The issue was that the compiler was missing one of the instructions
> used by SECCOMP, so here is a patch to enable JIT for that instruction.
> 
> Signed-Off-By:  Mark Lord <mlord@pobox.com>
> 
> --- old/arch/powerpc/net/bpf_jit_comp.c 2018-02-16 14:07:01.000000000 -0500
> +++ linux/arch/powerpc/net/bpf_jit_comp.c       2018-02-20 14:41:20.805227494 -0500
> @@ -329,6 +329,9 @@ static int bpf_jit_build_body(struct bpf
>                         BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, len) != 4);
>                         PPC_LWZ_OFFS(r_A, r_skb, offsetof(struct sk_buff, len));
>                         break;
> +               case BPF_LDX | BPF_W | BPF_ABS: /* A = *((u32 *)(seccomp_data + K)); */
> +                       PPC_LWZ_OFFS(r_A, r_skb, K);
> +                       break;
>                 case BPF_LDX | BPF_W | BPF_LEN: /* X = skb->len; */
>                         PPC_LWZ_OFFS(r_X, r_skb, offsetof(struct sk_buff, len));
>                         break;

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/083b20907185b076f21c265b30fe5b

cheers
