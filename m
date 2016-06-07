Return-Path: <alexei.starovoitov@gmail.com>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
 [209.85.220.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPRlx6zj1zDqJd
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 08:57:17 +1000 (AEST)
Received: by mail-pa0-f68.google.com with SMTP id di3so15064509pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jun 2016 15:57:17 -0700 (PDT)
Date: Tue, 7 Jun 2016 15:56:11 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, mpe@ellerman.id.au, Matt Evans <matt@ozlabs.org>,
 Denis Kirjanov <kda@linux-powerpc.org>,
 Paul Mackerras <paulus@samba.org>, Alexei Starovoitov <ast@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH 6/6] ppc: ebpf/jit: Implement JIT compiler for extended BPF
Message-ID: <20160607225609.GA40706@ast-mbp.thefacebook.com>
References: <cover.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
 <908d3552b5eb240b28f70aee7c4c86e2b600aa02.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <908d3552b5eb240b28f70aee7c4c86e2b600aa02.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 07, 2016 at 07:02:23PM +0530, Naveen N. Rao wrote:
> PPC64 eBPF JIT compiler.
> 
> Enable with:
> echo 1 > /proc/sys/net/core/bpf_jit_enable
> or
> echo 2 > /proc/sys/net/core/bpf_jit_enable
> 
> ... to see the generated JIT code. This can further be processed with
> tools/net/bpf_jit_disasm.
> 
> With CONFIG_TEST_BPF=m and 'modprobe test_bpf':
> test_bpf: Summary: 305 PASSED, 0 FAILED, [297/297 JIT'ed]
> 
> ... on both ppc64 BE and LE.

Nice. That's even better than on x64 which cannot jit one test:
test_bpf: #262 BPF_MAXINSNS: Jump, gap, jump, ... jited:0 168 PASS
which was designed specifically to hit x64 jit pass limit.
ppc jit has predicatble number of passes and doesn't have this problem
as expected. Great.

> The details of the approach are documented through various comments in
> the code.
> 
> Cc: Matt Evans <matt@ozlabs.org>
> Cc: Denis Kirjanov <kda@linux-powerpc.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Kconfig                  |   3 +-
>  arch/powerpc/include/asm/asm-compat.h |   2 +
>  arch/powerpc/include/asm/ppc-opcode.h |  20 +-
>  arch/powerpc/net/Makefile             |   4 +
>  arch/powerpc/net/bpf_jit.h            |  53 +-
>  arch/powerpc/net/bpf_jit64.h          | 102 ++++
>  arch/powerpc/net/bpf_jit_asm64.S      | 180 +++++++
>  arch/powerpc/net/bpf_jit_comp64.c     | 956 ++++++++++++++++++++++++++++++++++
>  8 files changed, 1317 insertions(+), 3 deletions(-)
>  create mode 100644 arch/powerpc/net/bpf_jit64.h
>  create mode 100644 arch/powerpc/net/bpf_jit_asm64.S
>  create mode 100644 arch/powerpc/net/bpf_jit_comp64.c

don't see any issues with the code.
Thank you for working on this.

Acked-by: Alexei Starovoitov <ast@kernel.org>
