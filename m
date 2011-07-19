Return-Path: <eric.dumazet@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E560B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 16:51:09 +1000 (EST)
Received: by wyh21 with SMTP id 21so1763263wyh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 23:51:05 -0700 (PDT)
Subject: Re: [PATCH v2] net: filter: BPF 'JIT' compiler for PPC64
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Matt Evans <matt@ozlabs.org>
In-Reply-To: <4E24E867.9050909@ozlabs.org>
References: <4E23E5C3.1070209@ozlabs.org>  <4E24E867.9050909@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jul 2011 08:51:00 +0200
Message-ID: <1311058260.16961.12.camel@edumazet-laptop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le mardi 19 juillet 2011 à 12:13 +1000, Matt Evans a écrit :
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
> V2: Removed some cut/paste woe in setting SEEN_X even on writes.
>     Merci for le review, Eric!
> 
>  arch/powerpc/Kconfig                  |    1 +
>  arch/powerpc/Makefile                 |    3 +-
>  arch/powerpc/include/asm/ppc-opcode.h |   40 ++
>  arch/powerpc/net/Makefile             |    4 +
>  arch/powerpc/net/bpf_jit.S            |  138 +++++++
>  arch/powerpc/net/bpf_jit.h            |  227 +++++++++++
>  arch/powerpc/net/bpf_jit_comp.c       |  690 +++++++++++++++++++++++++++++++++
>  7 files changed, 1102 insertions(+), 1 deletions(-)
> 

> +		case BPF_S_ANC_CPU:
> +#ifdef CONFIG_SMP
> +			/*
> +			 * PACA ptr is r13:
> +			 * raw_smp_processor_id() = local_paca->paca_index
> +			 */

This could break if one day linux supports more than 65536 cpus :)

> +			PPC_LHZ_OFFS(r_A, 13,
> +				     offsetof(struct paca_struct, paca_index));
> +#else
> +			PPC_LI(r_A, 0);
> +#endif
> +			break;
> +
> +
> +		case BPF_S_LDX_B_MSH:
> +			/*
> +			 * x86 version drops packet (RET 0) when K<0, whereas
> +			 * interpreter does allow K<0 (__load_pointer, special
> +			 * ancillary data).
> +			 */

Hmm, thanks I'll take a look at this.

> +			func = sk_load_byte_msh;
> +			goto common_load;
> +			break;
> +
> +			/*** Jump and branches ***/

> +		default:
> +			/* The filter contains something cruel & unusual.
> +			 * We don't handle it, but also there shouldn't be
> +			 * anything missing from our list.
> +			 */
> +			pr_err("BPF filter opcode %04x (@%d) unsupported\n",
> +			       filter[i].code, i);

You should at least ratelimit this message ?

On x86_64 I chose to silently fall back to interpretor for a "complex
filter" or "unsupported opcode".

> +			return -ENOTSUPP;
> +		}
> +
> +	}
> +	/* Set end-of-body-code address for exit. */
> +	addrs[i] = ctx->idx * 4;
> +
> +	return 0;
> +}
> +
