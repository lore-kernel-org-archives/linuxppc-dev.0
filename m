Return-Path: <jakub.kicinski@netronome.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r5W65b8CzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 05:36:50 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id m5-v6so25031100qti.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 12:36:50 -0700 (PDT)
Date: Tue, 22 May 2018 12:36:43 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH bpf-next v3 06/10] tools: bpftool: resolve calls without
 using imm field
Message-ID: <20180522123643.5ed1e391@cakuba>
In-Reply-To: <02b16a573269b492d4449c0e587ccc0020973e8c.1527008647.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
 <02b16a573269b492d4449c0e587ccc0020973e8c.1527008647.git.sandipan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 22 May 2018 22:46:09 +0530, Sandipan Das wrote:
> Currently, we resolve the callee's address for a JITed function
> call by using the imm field of the call instruction as an offset
> from __bpf_call_base. If bpf_jit_kallsyms is enabled, we further
> use this address to get the callee's kernel symbol's name.
> 
> For some architectures, such as powerpc64, the imm field is not
> large enough to hold this offset. So, instead of assigning this
> offset to the imm field, the verifier now assigns the subprog
> id. Also, a list of kernel symbol addresses for all the JITed
> functions is provided in the program info. We now use the imm
> field as an index for this list to lookup a callee's symbol's
> address and resolve its name.
> 
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
