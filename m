Return-Path: <eric.dumazet@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EF798B6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 15:00:28 +1000 (EST)
Received: by wwj40 with SMTP id 40so693324wwj.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 22:00:23 -0700 (PDT)
Subject: Re: [PATCH v3] net: filter: BPF 'JIT' compiler for PPC64
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Matt Evans <matt@ozlabs.org>
In-Reply-To: <4E278604.5080605@ozlabs.org>
References: <4E23E5C3.1070209@ozlabs.org> <4E24E867.9050909@ozlabs.org>
	<4E278604.5080605@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 21 Jul 2011 07:00:19 +0200
Message-ID: <1311224419.2570.6.camel@edumazet-laptop>
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

Le jeudi 21 juillet 2011 à 11:51 +1000, Matt Evans a écrit :
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
> V3: Added BUILD_BUG_ON to assert PACA CPU ID is 16bits, made a comment (in
>     LD_MSH) a bit clearer, ratelimited "Unknown opcode" error and moved
>     bpf_jit.S to bpf_jit_64.S (it doesn't make sense to rename bpf_jit_comp.c as
>     small portions will eventually get split out into _32/_64.c files when we do
>     32bit support).
> 
>  arch/powerpc/Kconfig                  |    1 +
>  arch/powerpc/Makefile                 |    3 +-
>  arch/powerpc/include/asm/ppc-opcode.h |   40 ++
>  arch/powerpc/net/Makefile             |    4 +
>  arch/powerpc/net/bpf_jit.h            |  227 +++++++++++
>  arch/powerpc/net/bpf_jit_64.S         |  138 +++++++
>  arch/powerpc/net/bpf_jit_comp.c       |  694 +++++++++++++++++++++++++++++++++
>  7 files changed, 1106 insertions(+), 1 deletions(-)

Nice work Matt ;)

Acked-by: Eric Dumazet <eric.dumazet@gmail.com>

Thanks
