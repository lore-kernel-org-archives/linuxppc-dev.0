Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zj2YF6Sh2zF1GF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 03:58:57 +1100 (AEDT)
Subject: Re: [RFC][PATCH bpf v2 1/2] bpf: allow 64-bit offsets for bpf
 function calls
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, ast@fb.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, naveen.n.rao@linux.vnet.ibm.com
References: <20180213040600.5821-1-sandipan@linux.vnet.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d39a3902-39bc-df56-71bf-0e6f9869ce14@iogearbox.net>
Date: Thu, 15 Feb 2018 17:25:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180213040600.5821-1-sandipan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/13/2018 05:05 AM, Sandipan Das wrote:
> The imm field of a bpf_insn is a signed 32-bit integer. For
> JIT-ed bpf-to-bpf function calls, it stores the offset from
> __bpf_call_base to the start of the callee function.
> 
> For some architectures, such as powerpc64, it was found that
> this offset may be as large as 64 bits because of which this
> cannot be accomodated in the imm field without truncation.
> 
> To resolve this, we additionally make aux->func within each
> bpf_prog associated with the functions to point to the list
> of all function addresses determined by the verifier.
> 
> We keep the value assigned to the off field of the bpf_insn
> as a way to index into aux->func and also set aux->func_cnt
> so that this can be used for performing basic upper bound
> checks for the off field.
> 
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
> v2: Make aux->func point to the list of functions determined
>     by the verifier rather than allocating a separate callee
>     list for each function.

Approach looks good to me; do you know whether s390x JIT would
have similar requirement? I think one limitation that would still
need to be addressed later with such approach would be regarding the
xlated prog dump in bpftool, see 'BPF calls via JIT' in 7105e828c087
("bpf: allow for correlation of maps and helpers in dump"). Any
ideas for this (potentially if we could use off + imm for calls,
we'd get to 48 bits, but that seems still not be enough as you say)?

Thanks,
Daniel
