Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0dmM1gPDzDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 10:16:19 +1100 (AEDT)
Message-ID: <58795AC4.2070302@iogearbox.net>
Date: Fri, 13 Jan 2017 23:55:00 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
MIME-Version: 1.0
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 mpe@ellerman.id.au
CC: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ast@fb.com,
 davem@davemloft.net
Subject: Re: [PATCH 2/3] powerpc: bpf: flush the entire JIT buffer
References: <e73efe6facf6c06932b4a87707e5978172ee773e.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
 <897d01cca8cd61a42493a4f6ba6bfca056419686.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <897d01cca8cd61a42493a4f6ba6bfca056419686.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/13/2017 06:10 PM, Naveen N. Rao wrote:
> With bpf_jit_binary_alloc(), we allocate at a page granularity and fill
> the rest of the space with illegal instructions to mitigate BPF spraying
> attacks, while having the actual JIT'ed BPF program at a random location
> within the allocated space. Under this scenario, it would be better to
> flush the entire allocated buffer rather than just the part containing
> the actual program. We already flush the buffer from start to the end of
> the BPF program. Extend this to include the illegal instructions after
> the BPF program.
>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
