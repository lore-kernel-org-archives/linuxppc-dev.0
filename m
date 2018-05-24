Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s1K81myTzF0mP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 17:31:23 +1000 (AEST)
Subject: Re: [PATCH bpf-next v4 00/10] bpf: enhancements for multi-function
 programs
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, ast@kernel.org
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, naveen.n.rao@linux.vnet.ibm.com,
 jakub.kicinski@netronome.com
References: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2204b5c1-5653-4fa3-2eaf-4b0af206d32d@iogearbox.net>
Date: Thu, 24 May 2018 09:31:12 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/24/2018 08:56 AM, Sandipan Das wrote:
> [1] Support for bpf-to-bpf function calls in the powerpc64 JIT compiler.
> 
> [2] Provide a way for resolving function calls because of the way JITed
>     images are allocated in powerpc64.
> 
> [3] Fix to get JITed instruction dumps for multi-function programs from
>     the bpf system call.
> 
> [4] Fix for bpftool to show delimited multi-function JITed image dumps.
> 
> v4:
>  - Incorporate review comments from Jakub.
>  - Fix JSON output for bpftool.
> 
> v3:
>  - Change base tree tag to bpf-next.
>  - Incorporate review comments from Alexei, Daniel and Jakub.
>  - Make sure that the JITed image does not grow or shrink after
>    the last pass due to the way the instruction sequence used
>    to load a callee's address maybe optimized.
>  - Make additional changes to the bpf system call and bpftool to
>    make multi-function JITed dumps easier to correlate.
> 
> v2:
>  - Incorporate review comments from Jakub.
> 
> Sandipan Das (10):
>   bpf: support 64-bit offsets for bpf function calls
>   bpf: powerpc64: pad function address loads with NOPs
>   bpf: powerpc64: add JIT support for multi-function programs
>   bpf: get kernel symbol addresses via syscall
>   tools: bpf: sync bpf uapi header
>   tools: bpftool: resolve calls without using imm field
>   bpf: fix multi-function JITed dump obtained via syscall
>   bpf: get JITed image lengths of functions via syscall
>   tools: bpf: sync bpf uapi header
>   tools: bpftool: add delimiters to multi-function JITed dumps
> 
>  arch/powerpc/net/bpf_jit_comp64.c | 110 ++++++++++++++++++++++++++++++--------
>  include/uapi/linux/bpf.h          |   4 ++
>  kernel/bpf/syscall.c              |  82 ++++++++++++++++++++++++++--
>  kernel/bpf/verifier.c             |  22 +++++---
>  tools/bpf/bpftool/prog.c          |  97 ++++++++++++++++++++++++++++++++-
>  tools/bpf/bpftool/xlated_dumper.c |  14 +++--
>  tools/bpf/bpftool/xlated_dumper.h |   3 ++
>  tools/include/uapi/linux/bpf.h    |   4 ++
>  8 files changed, 301 insertions(+), 35 deletions(-)

Applied to bpf-next, thanks a lot Sandipan!
