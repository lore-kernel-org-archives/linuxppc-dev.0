Return-Path: <eric.dumazet@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8BB60B6FD7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 18:39:48 +1000 (EST)
Received: by wyh21 with SMTP id 21so1068838wyh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 01:39:44 -0700 (PDT)
Subject: Re: [PATCH] net: filter: BPF 'JIT' compiler for PPC64
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Matt Evans <matt@ozlabs.org>
In-Reply-To: <4E23E5C3.1070209@ozlabs.org>
References: <4E23E5C3.1070209@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Jul 2011 10:39:35 +0200
Message-ID: <1310978375.5756.7.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le lundi 18 juillet 2011 à 17:50 +1000, Matt Evans a écrit :
> An implementation of a code generator for BPF programs to speed up packet
> filtering on PPC64, inspired by Eric Dumazet's x86-64 version.
> 
> Filter code is generated as an ABI-compliant function in module_alloc()'d mem
> with stackframe & prologue/epilogue generated if required (simple filters don't
> need anything more than an li/blr).  The filter's local variables, M[], live in
> registers.  Supports all BPF opcodes, although "complicated" loads from negative
> packet offsets (e.g. SKF_LL_OFF) are not yet supported.
> 
> There are a couple of further optimisations left for future work; many-pass
> assembly with branch-reach reduction and a register allocator to push M[]
> variables into volatile registers would improve the code quality further.
> 
> This currently supports big-endian 64-bit PowerPC only (but is fairly simple
> to port to PPC32 or LE!).
> 
> Enabled in the same way as x86-64:
> 
> 	echo 1 > /proc/sys/net/core/bpf_jit_enable
> 
> Or, enabled with extra debug output:
> 
> 	echo 2 > /proc/sys/net/core/bpf_jit_enable
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
> 
> Since the RFC post, this has incorporated the bugfixes/tidies from review plus a
> couple more found in further testing, plus some general/comment tidies.

Hi Matt

A small note about SEEN_XREG usage in PPC against x86_64 :

In x86_64, XREG is stored in EBX : I had to save/restore it in function
prologue epilogue. And set it to zero in prologue to avoid leak of
kernel information.

In PPC, you chose a scratch register, so you only have to zero it in
function prologue, if X is ever read.

So in PPC SEEN_XREG only is to be set of X is read, not if written.

So you dont have to set SEEN_XREG bit in this part :

> +		case BPF_S_MISC_TAX: /* X = A */
> +			ctx->seen |= SEEN_XREG;
> +			PPC_MR(r_X, r_A);
> +			break;

and in this part :

> +		case BPF_S_LDX_IMM: /* X = K */
> +			ctx->seen |= SEEN_XREG;
> +			PPC_LI32(r_X, K);
> +			break;

and :

> +		case BPF_S_LDX_MEM: /* X = mem[K] */
> +			PPC_MR(r_X, r_M + (K & 0xf));
> +			ctx->seen |= SEEN_XREG | SEEN_MEM | (1<<(K & 0xf));
> +			break;

and :

> +		case BPF_S_LDX_W_LEN: /* X = skb->len; */
> +			ctx->seen |= SEEN_XREG;
> +			PPC_LWZ_OFFS(r_X, r_skb, offsetof(struct sk_buff, len));
> +			break;
> +
