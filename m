Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZCXz0p6NzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 15:18:11 +1000 (AEST)
Message-ID: <1466572690.19785.4.camel@ellerman.id.au>
Subject: Re: [PATCH] ppc: Fix BPF JIT for ABIv2
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Matt Evans <matt@ozlabs.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@fb.com>, Denis Kirjanov
 <kda@linux-powerpc.org>, Paul Mackerras <paulus@samba.org>, "David S.
 Miller" <davem@davemloft.net>, Ananth N Mavinakayanahalli
 <ananth@in.ibm.com>
Date: Wed, 22 Jun 2016 15:18:10 +1000
In-Reply-To: <20160617130042.GO3516@indiana.gru.redhat.com>
References: <908d3552b5eb240b28f70aee7c4c86e2b600aa02.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
 <3rWKtT2tSrz9t2G@ozlabs.org> <20160617130042.GO3516@indiana.gru.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-06-17 at 10:00 -0300, Thadeu Lima de Souza Cascardo wrote:
> From a984dc02b6317a1d3a3c2302385adba5227be5bd Mon Sep 17 00:00:00 2001
> From: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
> Date: Wed, 15 Jun 2016 13:22:12 -0300
> Subject: [PATCH] ppc: Fix BPF JIT for ABIv2
> 
> ABIv2 used for ppc64le does not use function descriptors. Without this patch,
> whenever BPF JIT is enabled, we get a crash as below.
> 
...

> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 889fd19..28b89ed 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -70,7 +70,7 @@ DECLARE_LOAD_FUNC(sk_load_half);
>  DECLARE_LOAD_FUNC(sk_load_byte);
>  DECLARE_LOAD_FUNC(sk_load_byte_msh);
>  
> -#ifdef CONFIG_PPC64
> +#if defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF != 2)
>  #define FUNCTION_DESCR_SIZE	24
>  #else
>  #define FUNCTION_DESCR_SIZE	0
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 2d66a84..035b887 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -664,7 +664,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
>  
>  	if (image) {
>  		bpf_flush_icache(code_base, code_base + (proglen/4));
> -#ifdef CONFIG_PPC64
> +#if defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF != 2)
>  		/* Function descriptor nastiness: Address + TOC */
>  		((u64 *)image)[0] = (u64)code_base;
>  		((u64 *)image)[1] = local_paca->kernel_toc;


Confirmed that even with this patch we still crash:

  # echo 1 > /proc/sys/net/core/bpf_jit_enable
  # modprobe test_bpf
  BPF filter opcode 0020 (@3) unsupported
  BPF filter opcode 0020 (@2) unsupported
  BPF filter opcode 0020 (@0) unsupported
  Unable to handle kernel paging request for data at address 0xd0000000054f65e8
  Faulting instruction address: 0xc0000000008765f8
  cpu 0x0: Vector: 300 (Data Access) at [c0000000034f3480]
      pc: c0000000008765f8: skb_copy_bits+0x158/0x330
      lr: c00000000008fb7c: bpf_slow_path_byte+0x28/0x54
      sp: c0000000034f3700
     msr: 800000010280b033
     dar: d0000000054f65e8
   dsisr: 40000000
    current = 0xc0000001f857d8d0
    paca    = 0xc000000007b80000	 softe: 0	 irq_happened: 0x01
      pid   = 2993, comm = modprobe
  Linux version 4.7.0-rc3-00055-g9497a1c1c5b4-dirty (michael@ka3.ozlabs.ibm.com) () #30 SMP Wed Jun 22 15:06:58 AEST 2016
  enter ? for help
  [c0000000034f3770] c00000000008fb7c bpf_slow_path_byte+0x28/0x54
  [c0000000034f37e0] d000000007bb004c
  [c0000000034f3900] d000000005331668 test_bpf_init+0x5fc/0x7f8 [test_bpf]
  [c0000000034f3a30] c00000000000b628 do_one_initcall+0x68/0x1d0
  [c0000000034f3af0] c0000000009beb24 do_init_module+0x90/0x240
  [c0000000034f3b80] c0000000001642bc load_module+0x206c/0x22f0
  [c0000000034f3d30] c0000000001648b0 SyS_finit_module+0x120/0x180
  [c0000000034f3e30] c000000000009260 system_call+0x38/0x108
  --- Exception: c01 (System Call) at 00003fff7ffa2db4


cheers
