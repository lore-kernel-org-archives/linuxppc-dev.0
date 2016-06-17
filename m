Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWKtT4H61zDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 22:53:21 +1000 (AEST)
In-Reply-To: <908d3552b5eb240b28f70aee7c4c86e2b600aa02.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Matt Evans <matt@ozlabs.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@fb.com>, Denis Kirjanov <kda@linux-powerpc.org>,
 Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [6/6] ppc: ebpf/jit: Implement JIT compiler for extended BPF
Message-Id: <3rWKtT2tSrz9t2G@ozlabs.org>
Date: Fri, 17 Jun 2016 22:53:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-07-06 at 13:32:23 UTC, "Naveen N. Rao" wrote:
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> new file mode 100644
> index 0000000..954ff53
> --- /dev/null
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -0,0 +1,956 @@
...
> +
> +static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
> +{
> +	int *p = area;
> +
> +	/* Fill whole space with trap instructions */
> +	while (p < (int *)((char *)area + size))
> +		*p++ = BREAKPOINT_INSTRUCTION;
> +}

This breaks the build for some configs, presumably you're missing a header:

  arch/powerpc/net/bpf_jit_comp64.c:30:10: error: 'BREAKPOINT_INSTRUCTION' undeclared (first use in this function)

http://kisskb.ellerman.id.au/kisskb/buildresult/12720611/

cheers
